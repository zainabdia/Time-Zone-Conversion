import 'package:flutter/material.dart';

void main() {
  runApp(const TimeZoneConverterApp());
}

class TimeZoneConverterApp extends StatelessWidget {
  const TimeZoneConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TimeZoneConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimeZoneConverterPage extends StatefulWidget {
  const TimeZoneConverterPage({super.key});

  @override
  _TimeZoneConverterPageState createState() => _TimeZoneConverterPageState();
}

class _TimeZoneConverterPageState extends State<TimeZoneConverterPage> {
  String _fromCountry = 'Lebanon';
  String _toCountry = 'USA';
  DateTime _currentTime = DateTime.now();
  String _convertedTime = '';

  final Map<String, int> countryTimeZones = {
    'Lebanon': 2,
    'USA': -5,
    'Canada': -5,
    'Australia': 10,
    'France': 1,
    'Italy': 1,
    'Saudia': 3,
    'UAE': 4,
  };

  void _convertTime() {
    DateTime utcTime = DateTime.now().toUtc();
    int fromOffset = countryTimeZones[_fromCountry] ?? 0;
    int toOffset = countryTimeZones[_toCountry] ?? 0;
    int timeDifference = toOffset - fromOffset;

    DateTime convertedTime = utcTime.add(Duration(hours: timeDifference));

    String amPm = convertedTime.hour >= 12 ? 'PM' : 'AM';
    int hour = convertedTime.hour % 12;
    hour = hour == 0 ? 12 : hour;

    setState(() {
      _convertedTime =
      '${hour.toString().padLeft(2, '0')}:${convertedTime.minute.toString().padLeft(2, '0')} $amPm';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Zone Converter"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Select first country, then second country:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCountry = newValue!;
                      });
                    },
                    items: countryTimeZones.keys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: DropdownButton<String>(
                    value: _toCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCountry = newValue!;
                      });
                    },
                    items: countryTimeZones.keys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _convertTime,
              child: const Text("Convert Time"),
            ),

            const SizedBox(height: 20),

            Text(
              _convertedTime.isEmpty
                  ? 'Converted time will appear here.'
                  : 'Converted Time: $_convertedTime',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

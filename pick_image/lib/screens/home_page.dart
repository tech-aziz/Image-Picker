import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? images;
  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => images = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
     var screenSize = MediaQuery.of(context).size;
     return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            images != null
                ? Container(
                    height: 200,
                    width: screenSize.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: Colors.green.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(25)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.file(
                        images!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(
                    height: 200,
                    width: screenSize.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                      // border: Border.all(width: 2, color: Colors.green)
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Now image found',
                        style: TextStyle(
                            color: Colors.blue.withOpacity(0.5), fontSize: 20),
                      ),
                    ))),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: const Text(
                      'Gallery',
                      style: TextStyle(fontSize: 18),
                    )),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    child: const Text('Camera', style: TextStyle(fontSize: 18)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
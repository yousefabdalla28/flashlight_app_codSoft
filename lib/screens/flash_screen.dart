import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  var isActive = false;
  var controller = TorchController();
  var hasFlash = false;

  @override
  void initState() {
    super.initState();
    checkFlashAvailability();
  }

  Future<void> checkFlashAvailability() async {
    final available = await controller.hasTorch;
    setState(() {
      hasFlash = available!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "FlashLight",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(isActive
                        ? "assets/images/on.jpg"
                        : "assets/images/off.jpg",
                    height: size.height*0.65,
                   ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 20,
                    child: IconButton(
                      onPressed: hasFlash
                          ? () {
                        controller.toggle();
                        isActive = !isActive;
                        setState(() {});
                      }
                          : null,
                      icon: const Icon(Icons.power_settings_new_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
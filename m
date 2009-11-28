Return-Path: <albert_herranz@yahoo.es>
Received: from smtp141.mail.ukl.yahoo.com (smtp141.mail.ukl.yahoo.com
	[77.238.184.72]) by ozlabs.org (Postfix) with SMTP id 39A9BB6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Nov 2009 07:44:08 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 02/11] powerpc: gamecube: device tree
Date: Sat, 28 Nov 2009 21:43:48 +0100
Message-Id: <1259441037-15725-3-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a device tree source file for the Nintendo GameCube video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
v1 -> v2
- Document new bindings in Documentation/powerpc/dts-bindings.
  Suggestion by Grant Likely.
- Use same form for model property and compatible properties on the root
  node.  Suggestion by Grant Likely.
- Drop the model property in the soc node.  Suggestion by Grant Likely.
- Move interrupt-parent to the soc node instead of explicitly adding it to
  each child node.  Suggestion by Grant Likely.
- Declare all available memory and deal with the fb area in the platform
  code. Suggestion by Segher Boessenkool.
- Transform the "auxram" node into the "dsp" node, create an "auxram" node
  within the "dsp" node. Suggestion by Segher Boessenkool.
- Rename the "soc" node to "flipper". Suggestion by Benjamin Herrenschmidt.
- Remove the usbgecko node from the device tree and autodetect it in
  platform code. Suggestion by Segher Boessenkool.
- Remove clock-frequency property from the soc node.
  Suggestion by Segher Boessenkool.
- Create a flipper-processor-interface node and place flipper-pic into it.
  Suggestion by Segher Boessenkool.
- Remove #interrupt-cells from the flipper node.
  Suggestion by Segher Boessenkool.
- Massive cleanups. Suggestions by Segher Boessenkool.

 .../powerpc/dts-bindings/nintendo/gamecube.txt     |  109 +++++++++++++++++++
 arch/powerpc/boot/dts/gamecube.dts                 |  114 ++++++++++++++++++++
 2 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/nintendo/gamecube.txt
 create mode 100644 arch/powerpc/boot/dts/gamecube.dts

diff --git a/Documentation/powerpc/dts-bindings/nintendo/gamecube.txt b/Documentation/powerpc/dts-bindings/nintendo/gamecube.txt
new file mode 100644
index 0000000..b558585
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/nintendo/gamecube.txt
@@ -0,0 +1,109 @@
+
+Nintendo GameCube device tree
+=============================
+
+1) The "flipper" node
+
+  This node represents the multi-function "Flipper" chip, which packages
+  many of the devices found in the Nintendo GameCube.
+
+  Required properties:
+
+   - compatible : Should be "nintendo,flipper"
+
+1.a) The Video Interface (VI) node
+
+  Represents the interface between the graphics processor and a external
+  video encoder.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-vi"
+   - reg : should contain the VI registers location and length
+   - interrupts : should contain the VI interrupt
+
+1.b) The Processor Interface (PI) node
+
+  Represents the data and control interface between the main processor
+  and graphics and audio processor.
+
+  Required properties:
+
+  - compatible : should be "nintendo,flipper-pi"
+  - reg : should contain the PI registers location and length
+
+1.b.i) The "Flipper" interrupt controller node
+
+  Represents the interrupt controller within the "Flipper" chip.
+  The node for the "Flipper" interrupt controller must be placed under
+  the PI node.
+
+  Required properties:
+
+  - compatible : should be "nintendo,flipper-pic"
+
+1.c) The Digital Signal Procesor (DSP) node
+
+  Represents the digital signal processor interface, designed to offload
+  audio related tasks.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-dsp"
+   - reg : should contain the DSP registers location and length
+   - interrupts : should contain the DSP interrupt
+
+1.c.i) The Auxiliary RAM (ARAM) node
+
+  Represents the non cpu-addressable ram designed mainly to store audio
+  related information.
+  The ARAM node must be placed under the DSP node.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-aram"
+   - reg : should contain the ARAM start (zero-based) and length
+
+1.d) The Disk Interface (DI) node
+
+  Represents the interface used to communicate with mass storage devices.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-di"
+   - reg : should contain the DI registers location and length
+   - interrupts : should contain the DI interrupt
+
+1.e) The Audio Interface (AI) node
+
+  Represents the interface to the external 16-bit stereo digital-to-analog
+  converter.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-ai"
+   - reg : should contain the AI registers location and length
+   - interrupts : should contain the AI interrupt
+
+1.f) The Serial Interface (SI) node
+
+  Represents the interface to the four single bit serial interfaces.
+  The SI is a proprietary serial interface used normally to control gamepads.
+  It's NOT a RS232-type interface.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-si"
+   - reg : should contain the SI registers location and length
+   - interrupts : should contain the SI interrupt
+
+1.g) The External Interface (EXI) node
+
+  Represents the multi-channel SPI-like interface.
+
+  Required properties:
+
+   - compatible : should be "nintendo,flipper-exi"
+   - reg : should contain the EXI registers location and length
+   - interrupts : should contain the EXI interrupt
+
diff --git a/arch/powerpc/boot/dts/gamecube.dts b/arch/powerpc/boot/dts/gamecube.dts
new file mode 100644
index 0000000..ef3be0e
--- /dev/null
+++ b/arch/powerpc/boot/dts/gamecube.dts
@@ -0,0 +1,114 @@
+/*
+ * arch/powerpc/boot/dts/gamecube.dts
+ *
+ * Nintendo GameCube platform device tree source
+ * Copyright (C) 2007-2009 The GameCube Linux Team
+ * Copyright (C) 2007,2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	model = "nintendo,gamecube";
+	compatible = "nintendo,gamecube";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs = "root=/dev/gcnsda2 rootwait udbg-immortal";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x01800000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,gekko@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <486000000>; /* 486MHz */
+			bus-frequency = <162000000>; /* 162MHz core-to-bus 3x */
+			timebase-frequency = <40500000>; /* 162MHz / 4 */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+		};
+	};
+
+	/* devices contained int the flipper chipset */
+	flipper {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "nintendo,flipper";
+		ranges = <0x0c000000 0x0c000000 0x00010000>;
+		interrupt-parent = <&PIC>;
+
+		video@0c002000 {
+			compatible = "nintendo,flipper-vi";
+			reg = <0x0c002000 0x100>;
+			interrupts = <8>;
+		};
+
+		processor-interface@0c003000 {
+			compatible = "nintendo,flipper-pi";
+			reg = <0x0c003000 0x100>;
+
+			PIC: pic {
+				#interrupt-cells = <1>;
+				compatible = "nintendo,flipper-pic";
+				interrupt-controller;
+			};
+		};
+
+		dsp@0c005000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "nintendo,flipper-dsp";
+			reg = <0x0c005000 0x200>;
+			interrupts = <6>;
+
+			memory@0 {
+				compatible = "nintendo,flipper-aram";
+				reg = <0 0x1000000>;	/* 16MB */
+			};
+		};
+
+		disk@0c006000 {
+			compatible = "nintendo,flipper-di";
+			reg = <0x0c006000 0x40>;
+			interrupts = <2>;
+		};
+
+		audio@0c006c00 {
+			compatible = "nintendo,flipper-ai";
+			reg = <0x0c006c00 0x20>;
+			interrupts = <6>;
+		};
+
+		gamepad-controller@0c006400 {
+			compatible = "nintendo,flipper-si";
+			reg = <0x0c006400 0x100>;
+			interrupts = <3>;
+		};
+
+		/* External Interface bus */
+		exi@0c006800 {
+			compatible = "nintendo,flipper-exi";
+			reg = <0x0c006800 0x40>;
+			virtual-reg = <0x0c006800>;
+			interrupts = <4>;
+		};
+        };
+};
+
-- 
1.6.3.3

Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id AD3441007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:04 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Sun, 22 Nov 2009 23:01:33 +0100
Message-Id: <1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
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
 arch/powerpc/boot/dts/gamecube.dts |  135 ++++++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/gamecube.dts

diff --git a/arch/powerpc/boot/dts/gamecube.dts b/arch/powerpc/boot/dts/gamecube.dts
new file mode 100644
index 0000000..941a2c4
--- /dev/null
+++ b/arch/powerpc/boot/dts/gamecube.dts
@@ -0,0 +1,135 @@
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
+	model = "NintendoGameCube";
+	compatible = "nintendo,gamecube";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs = "root=/dev/gcnsda2 rootwait udbg-immortal";
+		linux,stdout-path = &USBGECKO0;
+	};
+
+	aliases {
+		ugecon = &USBGECKO0;
+	};
+
+	memory {
+		device_type = "memory";
+		/* 24M minus framebuffer memory area (640*576*2*2) */
+		reg = <0x00000000 0x01698000>;
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
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		model = "flipper";
+		compatible = "nintendo,flipper";
+		clock-frequency = <162000000>; /* 162MHz */
+		ranges = <0x0c000000 0x0c000000 0x00010000>;
+
+		video@0c002000 {
+			compatible = "nintendo,flipper-video";
+			reg = <0x0c002000 0x100>;
+			interrupts = <8>;
+			interrupt-parent = <&pic>;
+			/* XFB is the eXternal FrameBuffer */
+			xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
+			xfb-size = <0x168000>;
+		};
+
+		pic: pic@0c003000 {
+			#interrupt-cells = <1>;
+			compatible = "nintendo,flipper-pic";
+			reg = <0x0c003000 0x8>;
+			interrupt-controller;
+		};
+
+		resetswitch@0c003000 {
+			compatible = "nintendo,flipper-resetswitch";
+			reg = <0x0c003000 0x4>;
+			interrupts = <1>;
+			interrupt-parent = <&pic>;
+		};
+
+		auxram@0c005000 {
+			compatible = "nintendo,flipper-auxram";
+			reg = <0x0c005000 0x200>;	/* DSP */
+			interrupts = <6>;
+			interrupt-parent = <&pic>;
+		};
+
+		audio@0c005000 {
+			compatible = "nintendo,flipper-audio";
+			reg = <0x0c005000 0x200		/* DSP */
+			       0x0c006c00 0x20>;	/* AI */
+			interrupts = <6>;
+			interrupt-parent = <&pic>;
+		};
+
+		disk@0c006000 {
+			compatible = "nintendo,flipper-disk";
+			reg = <0x0c006000 0x40>;
+			interrupts = <2>;
+			interrupt-parent = <&pic>;
+		};
+
+		serial@0c006400 {
+			compatible = "nintendo,flipper-serial";
+			reg = <0x0c006400 0x100>;
+			interrupts = <3>;
+			interrupt-parent = <&pic>;
+		};
+
+		/* External Interface bus */
+		exi@0c006800 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "nintendo,flipper-exi";
+			reg = <0x0c006800 0x40>;
+			interrupts = <4>;
+			interrupt-parent = <&pic>;
+
+			USBGECKO0: usbgecko@0c006814 {
+				compatible = "usbgecko,usbgecko";
+				reg = <0x0c006814 0x14>;
+				virtual-reg = <0xcc006814>;
+			};
+		};
+        };
+};
+
-- 
1.6.3.3

Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 43C65B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:05 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Sun, 22 Nov 2009 23:01:35 +0100
Message-Id: <1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a device tree source file for the Nintendo Wii video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/dts/wii.dts |  244 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/wii.dts

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
new file mode 100644
index 0000000..a30a804
--- /dev/null
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -0,0 +1,244 @@
+/*
+ * arch/powerpc/boot/dts/wii.dts
+ *
+ * Nintendo Wii platform device tree source
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
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
+/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O area) */
+/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */
+
+/ {
+	model = "NintendoWii";
+	compatible = "nintendo,wii";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		/* root filesystem on 2nd partition of SD card */
+		bootargs = "nobats root=/dev/mmcblk0p2 rootwait udbg-immortal";
+		linux,stdout-path = &USBGECKO0;
+	};
+
+	aliases {
+		ugecon = &USBGECKO0;
+		hw_gpio = &gpio1;
+	};
+
+	/*
+	 * The Nintendo Wii has two discontiguous RAM memory areas called
+	 * MEM1 and MEM2.
+	 * MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
+	 * MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
+	 * Between both memory address ranges there is an address space
+	 * where memory-mapped I/O registers are found.
+	 *
+	 * Currently, Linux 32-bit PowerPC does not support RAM in
+	 * discontiguous memory address spaces. Thus, in order to use
+	 * both RAM areas, we declare as RAM the range from the start of
+	 * MEM1 to the end of useable MEM2 and exclude the needed parts
+	 * with /memreserve/ statements, at the expense of wasting a bit
+	 * of memory.
+	 */
+	memory {
+		device_type = "memory";
+		/* MEM1 + memory hole + MEM2 - firmware/buffers area */
+		reg = <0x00000000 0x133e0000>;
+	};
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,broadway@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <729000000>; /* 729MHz */
+			bus-frequency = <243000000>; /* 243MHz core-to-bus 3x */
+			timebase-frequency = <60750000>; /* 243MHz / 4 */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+		};
+	};
+
+	/* devices contained in the hollywood chipset */
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		model = "hollywood";
+		compatible = "nintendo,hollywood";
+		clock-frequency = <243000000>; /* 243MHz */
+		ranges = <0x0c000000 0x0c000000 0x00010000
+			  0x0d000000 0x0d000000 0x00010000
+			  0x0d040000 0x0d040000 0x00050000
+			  0x0d800000 0x0d800000 0x00001000
+			  0x133e0000 0x133e0000 0x00c20000>;
+
+		video@0c002000 {
+			compatible = "nintendo,hollywood-video";
+			reg = <0x0c002000 0x100>;
+			interrupts = <8>;
+			interrupt-parent = <&PIC0>;
+		};
+
+		PIC0: pic0@0c003000 {
+			#interrupt-cells = <1>;
+			compatible = "nintendo,flipper-pic";
+			reg = <0x0c003000 0x8>;
+			interrupt-controller;
+		};
+
+		resetswitch@0c003000 {
+			compatible = "nintendo,hollywood-resetswitch";
+			reg = <0x0c003000 0x4>;
+			interrupts = <1>;
+			interrupt-parent = <&PIC0>;
+		};
+
+		audio@0c005000 {
+			compatible = "nintendo,hollywood-audio";
+			reg = <0x0c005000 0x200		/* DSP */
+			       0x0d006c00 0x20>;	/* AI */
+			interrupts = <6>;
+			interrupt-parent = <&PIC0>;
+		};
+
+		/* Team Twiizers' 'mini' firmware IPC */
+		mini@0d000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <1>;
+			compatible = "twiizers,starlet-mini-ipc";
+			reg = <0x0d000000 0x40	/* IPC */
+			       0x13fffffc 0x4>;	/* mini header pointer */
+		};
+
+		serial@0d006400 {
+			compatible = "nintendo,hollywood-serial";
+			reg = <0x0d006400 0x100>;
+			interrupts = <3>;
+			interrupt-parent = <&PIC0>;
+		};
+
+		/* External Interface bus */
+		exi@0d006800 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "nintendo,hollywood-exi";
+			reg = <0x0d006800 0x40>;
+			interrupts = <4>;
+			interrupt-parent = <&PIC0>;
+
+			USBGECKO0: usbgecko@0d006814 {
+				compatible = "usbgecko,usbgecko";
+				reg = <0x0d006814 0x14>;
+				virtual-reg = <0xcd006814>;
+			};
+		};
+
+		ehci@0d040000 {
+			compatible = "nintendo,hollywood-ehci";
+			reg = <0x0d040000 0x100
+			       0x133e0000 0x80000>; /* 512 KB */
+			interrupts = <4>;
+			interrupt-parent = <&PIC1>;
+		};
+
+		ohci0@0d050000 {
+			compatible = "nintendo,hollywood-ohci";
+			reg = <0x0d050000 0x100
+			       0x13460000 0x80000>; /* 512 KB */
+			interrupts = <5>;
+			interrupt-parent = <&PIC1>;
+		};
+
+		ohci1@0d060000 {
+			compatible = "nintendo,hollywood-ohci";
+			reg = <0x0d060000 0x100
+			       0x134e0000 0x80000>; /* 512 KB */
+			interrupts = <6>;
+			interrupt-parent = <&PIC1>;
+		};
+
+		sdhc0@0d070000 {
+			compatible = "nintendo,hollywood-sdhci";
+			reg = <0x0d070000 0x200>;
+			interrupts = <7>;
+			interrupt-parent = <&PIC1>;
+		};
+
+		sdhc1@0d080000 {
+			compatible = "nintendo,hollywood-sdhci";
+			reg = <0x0d080000 0x200>;
+			interrupts = <8>;
+			interrupt-parent = <&PIC1>;
+		};
+
+		PIC1: pic1@0d800030 {
+			#interrupt-cells = <1>;
+			compatible = "nintendo,hollywood-pic";
+			reg = <0x0d800030 0x8>;
+			interrupt-controller;
+			interrupts = <14>;
+			interrupt-parent = <&PIC0>;
+		};
+
+		hollywood-ahbprot@0d800064 {
+			compatible = "nintendo,hollywood-ahbprot";
+			reg = <0x0d800064 0x4>;
+		};
+
+		gpio0: hollywood-gpio@0d8000c0 {
+			compatible = "nintendo,hollywood-gpio";
+			reg = <0x0d8000c0 0x20>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio1: hollywood-gpio@0d8000e0 {
+			compatible = "nintendo,hollywood-gpio";
+			reg = <0x0d8000e0 0x20>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		hollywood-resets@0d800194 {
+			compatible = "nintendo,hollywood-resets";
+			reg = <0x0d800194 0x4>;
+		};
+
+		i2c-video {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		        compatible = "virtual,i2c-gpio";
+
+		        gpios = <&gpio0  16 0 /* 31-15 */
+		                 &gpio0  17 0 /* 31-14 */
+				>;
+		        sda-is-open-drain = <1>;
+		        sda-enforce-dir = <1>;
+		        scl-is-open-drain = <1>;
+		        scl-is-output-only = <1>;
+		        udelay = <2>;
+
+		        audio-video-encoder {
+		                compatible = "nintendo,wii-ave-rvl";
+		                reg = <0x70>;
+		        };
+		};
+	};
+};
+
-- 
1.6.3.3

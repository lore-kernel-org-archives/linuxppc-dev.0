Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3FB13DE185
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 08:14:28 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l27LEP5l013336
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 14:14:25 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l27LEPAt001489
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 15:14:25 -0600 (CST)
Subject: [RFC 2/3] MPC8544 DTS file
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173302064.23776.185.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 15:14:24 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
new file mode 100644
index 0000000..7eb7ccc
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -0,0 +1,352 @@
+/*
+ * MPC8544 DS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "MPC8544DS";
+	compatible = "mpc85xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8544@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;	// 512M at 0x0
+	};
+
+	soc8544@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4a 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1f 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		pci@8000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x11 J17 Slot 1 */
+				8800 0 0 1 &mpic 42 1
+				8800 0 0 2 &mpic 43 1
+				8800 0 0 3 &mpic 44 1
+				8800 0 0 4 &mpic 41 1
+
+				/* IDSEL 0x12 J16 Slot 2 */
+
+				9000 0 0 1 &mpic 43 1
+				9000 0 0 2 &mpic 44 1
+				9000 0 0 3 &mpic 42 1
+				9000 0 0 4 &mpic 41 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pci@a000 {
+			compatible = "85xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			bus-range = <3 ff>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e3000000 0 00080000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 40 1
+				0000 0 0 2 &mpic 41 1
+				0000 0 0 3 &mpic 42 1
+				0000 0 0 4 &mpic 43 1
+				>;
+		};
+
+		pci@9000 {
+			compatible = "85xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <4 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00080000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 44 1
+				0000 0 0 2 &mpic 45 1
+				0000 0 0 3 &mpic 46 1
+				0000 0 0 4 &mpic 47 1
+				>;
+		};
+
+		pci@b000 {
+			compatible = "85xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <b000 1000>;
+			bus-range = <5 ff>;
+			ranges = <02000000 0 b0000000 b0000000 0 10000000
+				  01000000 0 00000000 e3800000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1b 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				// IDSEL 0x11
+				8800 0 0 1 &i8259 3 2
+				8800 0 0 2 &i8259 4 2
+				8800 0 0 3 &i8259 5 2
+				8800 0 0 4 &i8259 6 2
+
+				// IDSEL 0x12
+				9000 0 0 1 &i8259 4 2
+				9000 0 0 2 &i8259 5 2
+				9000 0 0 3 &i8259 6 2
+				9000 0 0 4 &i8259 3 2
+
+				// IDSEL 0x13
+				9800 0 0 1 &i8259 0 0
+				9800 0 0 2 &i8259 0 0
+				9800 0 0 3 &i8259 0 0
+				9800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x14
+				a000 0 0 1 &i8259 0 0
+				a000 0 0 2 &i8259 0 0
+				a000 0 0 3 &i8259 0 0
+				a000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x15
+				a800 0 0 1 &i8259 0 0
+				a800 0 0 2 &i8259 0 0
+				a800 0 0 3 &i8259 0 0
+				a800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x16
+				b000 0 0 1 &i8259 0 0
+				b000 0 0 2 &i8259 0 0
+				b000 0 0 3 &i8259 0 0
+				b000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x17
+				b800 0 0 1 &i8259 0 0
+				b800 0 0 2 &i8259 0 0
+				b800 0 0 3 &i8259 0 0
+				b800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x18
+				c000 0 0 1 &i8259 0 0
+				c000 0 0 2 &i8259 0 0
+				c000 0 0 3 &i8259 0 0
+				c000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x19
+				c800 0 0 1 &i8259 0 0
+				c800 0 0 2 &i8259 0 0
+				c800 0 0 3 &i8259 0 0
+				c800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1a
+				d000 0 0 1 &i8259 6 2
+				d000 0 0 2 &i8259 3 2
+				d000 0 0 3 &i8259 4 2
+				d000 0 0 4 &i8259 5 2
+
+				// IDSEL 0x1b
+				d800 0 0 1 &i8259 5 2
+				d800 0 0 2 &i8259 0 0
+				d800 0 0 3 &i8259 0 0
+				d800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1c  USB
+				e000 0 0 1 &i8259 9 2
+				e000 0 0 2 &i8259 a 2
+				e000 0 0 3 &i8259 c 2
+				e000 0 0 4 &i8259 7 2
+
+				// IDSEL 0x1d  Audio
+				e800 0 0 1 &i8259 9 2
+				e800 0 0 2 &i8259 a 2
+				e800 0 0 3 &i8259 b 2
+				e800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1e Legacy
+				f000 0 0 1 &i8259 c 2
+				f000 0 0 2 &i8259 0 0
+				f000 0 0 3 &i8259 0 0
+				f000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1f IDE/SATA
+				f800 0 0 1 &i8259 6 2
+				f800 0 0 2 &i8259 0 0
+				f800 0 0 3 &i8259 0 0
+				f800 0 0 4 &i8259 0 0
+			>;
+
+			i8259: i8259@4d0 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+				big-endian;
+				interrupts = <49 2>;
+				interrupt-parent = <&mpic>;
+			};
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+
+			interrupts = <
+				10 2 11 2 12 2 13 2
+				14 2 15 2 16 2 17 2
+				18 2 19 2 1a 2 1b 2
+				1c 2 1d 2 1e 2 1f 2
+				20 2 21 2 22 2 23 2
+				24 2 25 2 26 2 27 2
+				28 2 29 2 2a 2 2b 2
+				2c 2 2d 2 2e 2 2f 2
+				30 2 31 2 32 2 33 2
+				34 2 35 2 36 2 37 2
+				38 2 39 2 2a 2 3b 2
+				3c 2 3d 2 3e 2 3f 2
+				48 1 49 2 4a 1
+			>;
+
+			interrupt-parent = <&mpic>;
+		};
+	};
+};

Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3445467C91
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 17:17:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	kA86HlSt008289
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2006 23:17:47 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kA86HkQR014777
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 00:17:46 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32 [10.82.19.125])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	kA863FFV025540
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 00:03:16 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0175-tx32.am.freescale.net (Postfix) with ESMTP id 4C723AB028
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 00:17:45 -0600 (CST)
Received: from localhost (afleming@localhost)
	by ld0175-tx32.am.freescale.net (8.12.11/8.12.11/Submit) with ESMTP id
	kA86Hirp000432
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 00:17:44 -0600
Date: Wed, 8 Nov 2006 00:17:44 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add support for the new version of the CDS with rev2 8548
	silicon
Message-ID: <Pine.LNX.4.61.0611080016430.363@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Basically, just a copy of the old CDS dts with the now working
eTSEC 3 & 4 enabled and set to RGMII.

Requires the new PHY Lib interface changes to work

Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
Whoops, mistyped and accidentally sent this to a non-existent address 
instead of the list.

 arch/powerpc/boot/dts/mpc8548v2cds.dts |  341 ++++++++++++++++++++++++++++++++
 1 files changed, 341 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548v2cds.dts b/arch/powerpc/boot/dts/mpc8548v2cds.dts
new file mode 100644
index 0000000..7c66863
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548v2cds.dts
@@ -0,0 +1,341 @@
+/*
+ * MPC8548 CDS Device Tree Source
+ * This is for the 1.3 CDS board, which has working eTSECs 3 & 4
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8548CDS";
+	compatible = "MPC85xxCDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	//  33 MHz, from uboot
+			bus-frequency = <0>;	// 166 MHz
+			clock-frequency = <0>;	// 825 MHz, from uboot
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				flags = <0>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				flags = <0>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				flags = <1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				flags = <1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan-insertion;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+			interface = "GMII";
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan-insertion;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+			interface = "GMII";
+		};
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan-insertion;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			mac-address = [ 00 E0 0C 00 73 02 ];
+			interrupts = <f 2 10 2 11 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452002>;
+			interface = "RGMII";
+		};
+
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			gigabit;
+			coalescing;
+			rmon;
+			checksumming;
+			vlan-insertion;
+			extended-hash;
+			padding;
+			filer;
+			parseL4;
+			parseL3;
+			parseL2;
+			multi-queue;
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			mac-address = [ 00 E0 0C 00 73 03 ];
+			interrupts = <15 2 16 2 17 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452003>;
+			interface = "RGMII";
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <1f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x10 */
+				08000 0 0 1 40000 30 1
+				08000 0 0 2 40000 31 1
+				08000 0 0 3 40000 32 1
+				08000 0 0 4 40000 33 1
+
+				/* IDSEL 0x11 */
+				08800 0 0 1 40000 30 1
+				08800 0 0 2 40000 31 1
+				08800 0 0 3 40000 32 1
+				08800 0 0 4 40000 33 1
+
+				/* IDSEL 0x12 (Slot 1) */
+				09000 0 0 1 40000 30 1
+				09000 0 0 2 40000 31 1
+				09000 0 0 3 40000 32 1
+				09000 0 0 4 40000 33 1
+
+				/* IDSEL 0x13 (Slot 2) */
+				09800 0 0 1 40000 31 1
+				09800 0 0 2 40000 32 1
+				09800 0 0 3 40000 33 1
+				09800 0 0 4 40000 30 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				0a000 0 0 1 40000 32 1
+				0a000 0 0 2 40000 33 1
+				0a000 0 0 3 40000 30 1
+				0a000 0 0 4 40000 31 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				0a800 0 0 1 40000 33 1
+				0a800 0 0 2 40000 30 1
+				0a800 0 0 3 40000 31 1
+				0a800 0 0 4 40000 32 1
+
+				/* Bus 1 (Tundra Bridge) */
+				/* IDSEL 0x12 (ISA bridge) */
+				19000 0 0 1 40000 30 1
+				19000 0 0 2 40000 31 1
+				19000 0 0 3 40000 32 1
+				19000 0 0 4 40000 33 1>;
+			interrupt-parent = <40000>;
+			interrupts = <08 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+
+			i8259@19000 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				reg = <19000 0 0 0 1>;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+				big-endian;
+				interrupts = <1>;
+				interrupt-parent = <8000>;
+			};
+		};
+
+		pci@9000 {
+			linux,phandle = <9000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 40000 3b 1
+				a800 0 0 2 40000 3b 1
+				a800 0 0 3 40000 3b 1
+				a800 0 0 4 40000 3b 1>;
+			interrupt-parent = <40000>;
+			interrupts = <09 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+};
-- 
1.4.2.3

Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7343DDDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:47:21 +1100 (EST)
Date: Thu, 15 Feb 2007 20:46:44 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 6/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152046040.9034@ld0175-tx32.am.freescale.net>
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

Add PEX support for mpc8548CDS (Arcadia 3.0) board

CDC Rev.2.0 with MPC8548 CPU Rev.1.x +
Carrier Card Rev.1.2 + the Arcadia X3.0

Hardware need to be revised to support PEX due to errata. If
the hardware modification is made, only PEX is support on the board.
PCI will not function. They have negative irq polarity.

CPU Rev1.x PEX controller will return extra device when scan the
secondary bus, if there is a PEX device on the bus. so they have to
be excluded.

mpc8548cds_legacy.dts should be used as device tree.

Also changed the i8259 node and the VIA section of the interrupt map
to match reality.  The VIA is at IDsel 4 on Bus 1, but the i8259
was still claiming to be at IDsel 0x12 on Bus 1.  This resulted
in no mapping for i8259 interrupts.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts        |   25 +-
 arch/powerpc/boot/dts/mpc8548cds_legacy.dts |  315 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pcie.c              |    8 +-
 3 files changed, 333 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index d59a28a..1c8b17f 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -230,23 +230,24 @@
 				0c000 0 0 3 40000 32 1
 				0c000 0 0 4 40000 33 1
 
-				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */
-				11000 0 0 1 40000 32 1
-				11000 0 0 2 40000 33 1
-				11000 0 0 3 40000 30 1
-				11000 0 0 4 40000 31 1
-
 				/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
 				0E000 0 0 1 40000 30 1
 				0E000 0 0 2 40000 31 1
 				0E000 0 0 3 40000 32 1
 				0E000 0 0 4 40000 33 1
 
+				/* Bus 1 */
+				/* IDSEL 0x2 Tsi310 bridge secondary */
+				11000 0 0 1 40000 32 1
+				11000 0 0 2 40000 33 1
+				11000 0 0 3 40000 30 1
+				11000 0 0 4 40000 31 1
+
 				/* VIA chip */
-				12000 0 0 1 19000 30 1
-				12000 0 0 2 19000 31 1
-				12000 0 0 3 19000 32 1
-				12000 0 0 4 19000 33 1>;
+				12000 0 0 1 40000 30 1
+				12000 0 0 2 40000 31 1
+				12000 0 0 3 40000 32 1
+				12000 0 0 4 40000 33 1>;
 
 			interrupt-parent = <40000>;
 			interrupts = <08 2>;
@@ -261,11 +262,11 @@
 			compatible = "85xx";
 			device_type = "pci";
 
-			i8259@19000 {
+			i8259@12000 {
 				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "interrupt-controller";
-				reg = <19000 0 0 0 1>;
+				reg = <12000 0 0 0 1>;
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				built-in;
diff --git a/arch/powerpc/boot/dts/mpc8548cds_legacy.dts b/arch/powerpc/boot/dts/mpc8548cds_legacy.dts
new file mode 100644
index 0000000..41c5bb0
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds_legacy.dts
@@ -0,0 +1,315 @@
+/*
+ * MPC8548 CDS with Arcadia 3.0 Device Tree Source
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
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
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
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			interrupts = <f 2 10 2 11 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+/* eTSEC 4 is currently broken
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 03 ];
+			interrupts = <15 2 16 2 17 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+ */
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <1f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x2 (PCIX Tsi310 bridge) */
+				01000 0 0 1 40000 30 1
+				01000 0 0 2 40000 31 1
+				01000 0 0 3 40000 32 1
+				01000 0 0 4 40000 33 1
+
+				/* IDSEL 0x3 (PCIX Slot 2) */
+				01800 0 0 1 40000 30 1
+				01800 0 0 2 40000 31 1
+				01800 0 0 3 40000 32 1
+				01800 0 0 4 40000 33 1
+
+				/* IDSEL 0x4 (PCIX Slot 3) */
+				02000 0 0 1 40000 30 1
+				02000 0 0 2 40000 31 1
+				02000 0 0 3 40000 32 1
+				02000 0 0 4 40000 33 1
+
+				/* IDSEL 0x5 (PCIX Slot 4) */
+				02800 0 0 1 40000 30 1
+				02800 0 0 2 40000 31 1
+				02800 0 0 3 40000 32 1
+				02800 0 0 4 40000 33 1
+
+				/* IDSEL 0x6 (PCIX Slot 5) */
+				03000 0 0 1 40000 30 1
+				03000 0 0 2 40000 31 1
+				03000 0 0 3 40000 32 1
+				03000 0 0 4 40000 33 1
+
+				/* IDSEL 0x12 (Tsi310 bridge) */
+				09000 0 0 1 40000 30 1
+				09000 0 0 2 40000 31 1
+				09000 0 0 3 40000 32 1
+				09000 0 0 4 40000 33 1
+
+				/* IDSEL 0x13 (Slot 2) */
+				09800 0 0 1 40000 30 1
+				09800 0 0 2 40000 31 1
+				09800 0 0 3 40000 32 1
+				09800 0 0 4 40000 33 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				0a000 0 0 1 40000 30 1
+				0a000 0 0 2 40000 31 1
+				0a000 0 0 3 40000 32 1
+				0a000 0 0 4 40000 33 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				0a800 0 0 1 40000 30 1
+				0a800 0 0 2 40000 31 1
+				0a800 0 0 3 40000 32 1
+				0a800 0 0 4 40000 33 1
+
+				/* IDSEL 0x16 (Slot 5) */
+				0b000 0 0 1 40000 30 1
+				0b000 0 0 2 40000 31 1
+				0b000 0 0 3 40000 32 1
+				0b000 0 0 4 40000 33 1>;
+
+			interrupt-parent = <40000>;
+			interrupts = <08 2>;
+			bus-range = <0 0>;
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
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		/* PCI Express */
+		pci@a000 {
+			linux,phandle = <a000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x0 (PEX) */
+				00000 0 0 1 40000 30 2
+				00000 0 0 2 40000 31 0
+				00000 0 0 3 40000 32 0
+				00000 0 0 4 40000 32 0>;
+			interrupt-parent = <40000>;
+			interrupts = <0a 2>;
+			bus-range = <2 255>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 01000000>;
+			clock-frequency = <1fca055>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
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
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
index 469ded9..9b8436f 100644
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -1,8 +1,10 @@
 /*
- * Support for indirect PCI bridges.
+ * PCIe Indirect Support
  *
  * Copyright (C) 1998 Gabriel Paubert.
  *
+ * Copyright (C) 2007 Freescale Semiconductor, Inc
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -44,7 +46,7 @@ indirect_read_config_pcie(struct pci_bus
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
+	if (devfn != 0x0 && (bus->number == 0xff || bus->number == 0x3))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
@@ -102,7 +104,7 @@ indirect_write_config_pcie(struct pci_bu
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Possible artifact of CDCpp50937 needs further investigation */
-	if (devfn != 0x0 && bus->number == 0xff)
+	if (devfn != 0x0 && (bus->number == 0xff || bus->number == 0x3))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
-- 
1.4.4

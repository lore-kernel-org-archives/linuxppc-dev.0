Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6948CDDDE9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:45:52 +1100 (EST)
Date: Thu, 15 Feb 2007 20:45:17 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 4/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152044460.9034@ld0175-tx32.am.freescale.net>
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

Updated 8548 CDS DTS file to support PCIe and Arcadia 3.1

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |  145 +++++++++++++++++++++++-----------
 1 files changed, 99 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 893d795..3bb83a3 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -1,5 +1,5 @@
 /*
- * MPC8555 CDS Device Tree Source
+ * MPC8548 CDS Device Tree Source
  *
  * Copyright 2006 Freescale Semiconductor Inc.
  *
@@ -157,8 +157,8 @@
 		serial@4500 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>; 	// reg base, size
-			clock-frequency = <0>; 	// should we fill in in uboot?
+			reg = <4500 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <1a 2>;
 			interrupt-parent = <40000>;
 		};
@@ -167,7 +167,7 @@
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
-			clock-frequency = <0>; 	// should we fill in in uboot?
+			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <1a 2>;
 			interrupt-parent = <40000>;
 		};
@@ -176,54 +176,83 @@
 			linux,phandle = <8000>;
 			interrupt-map-mask = <1f800 0 0 7>;
 			interrupt-map = <
+				/* IDSEL 0x4 (PCIX Slot 2) */
+				02000 0 0 1 40000 30 1
+				02000 0 0 2 40000 31 1
+				02000 0 0 3 40000 32 1
+				02000 0 0 4 40000 33 1
 
-				/* IDSEL 0x10 */
-				08000 0 0 1 40000 30 1
-				08000 0 0 2 40000 31 1
-				08000 0 0 3 40000 32 1
-				08000 0 0 4 40000 33 1
+				/* IDSEL 0x5 (PCIX Slot 3) */
+				02800 0 0 1 40000 31 1
+				02800 0 0 2 40000 32 1
+				02800 0 0 3 40000 33 1
+				02800 0 0 4 40000 30 1
+				
+				/* IDSEL 0x6 (PCIX Slot 4) */
+				03000 0 0 1 40000 32 1
+				03000 0 0 2 40000 33 1
+				03000 0 0 3 40000 30 1
+				03000 0 0 4 40000 31 1
+				
+				/* IDSEL 0x8 (PCIX Slot 5) */
+				04000 0 0 1 40000 30 1
+				04000 0 0 2 40000 31 1
+				04000 0 0 3 40000 32 1
+				04000 0 0 4 40000 33 1
+				
+				/* IDSEL 0xC (Tsi310 bridge) */
+				06000 0 0 1 40000 30 1
+				06000 0 0 2 40000 31 1
+				06000 0 0 3 40000 32 1
+				06000 0 0 4 40000 33 1
 
-				/* IDSEL 0x11 */
-				08800 0 0 1 40000 30 1
-				08800 0 0 2 40000 31 1
-				08800 0 0 3 40000 32 1
-				08800 0 0 4 40000 33 1
+				/* IDSEL 0x14 (Slot 2) */
+				0a000 0 0 1 40000 30 1
+				0a000 0 0 2 40000 31 1
+				0a000 0 0 3 40000 32 1
+				0a000 0 0 4 40000 33 1
 
-				/* IDSEL 0x12 (Slot 1) */
-				09000 0 0 1 40000 30 1
-				09000 0 0 2 40000 31 1
-				09000 0 0 3 40000 32 1
-				09000 0 0 4 40000 33 1
+				/* IDSEL 0x15 (Slot 3) */
+				0a800 0 0 1 40000 31 1
+				0a800 0 0 2 40000 32 1
+				0a800 0 0 3 40000 33 1
+				0a800 0 0 4 40000 30 1
 
-				/* IDSEL 0x13 (Slot 2) */
-				09800 0 0 1 40000 31 1
-				09800 0 0 2 40000 32 1
-				09800 0 0 3 40000 33 1
-				09800 0 0 4 40000 30 1
+				/* IDSEL 0x16 (Slot 4) */
+				0b000 0 0 1 40000 32 1
+				0b000 0 0 2 40000 33 1
+				0b000 0 0 3 40000 30 1
+				0b000 0 0 4 40000 31 1
+				
+				/* IDSEL 0x18 (Slot 5) */
+				0c000 0 0 1 40000 30 1
+				0c000 0 0 2 40000 31 1
+				0c000 0 0 3 40000 32 1
+				0c000 0 0 4 40000 33 1
+				
+				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */
+				11000 0 0 1 40000 32 1
+				11000 0 0 2 40000 33 1
+				11000 0 0 3 40000 30 1
+				11000 0 0 4 40000 31 1
+				
+				/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
+				0E000 0 0 1 40000 30 1
+				0E000 0 0 2 40000 31 1
+				0E000 0 0 3 40000 32 1
+				0E000 0 0 4 40000 33 1
 
-				/* IDSEL 0x14 (Slot 3) */
-				0a000 0 0 1 40000 32 1
-				0a000 0 0 2 40000 33 1
-				0a000 0 0 3 40000 30 1
-				0a000 0 0 4 40000 31 1
-
-				/* IDSEL 0x15 (Slot 4) */
-				0a800 0 0 1 40000 33 1
-				0a800 0 0 2 40000 30 1
-				0a800 0 0 3 40000 31 1
-				0a800 0 0 4 40000 32 1
-
-				/* Bus 1 (Tundra Bridge) */
-				/* IDSEL 0x12 (ISA bridge) */
-				19000 0 0 1 40000 30 1
-				19000 0 0 2 40000 31 1
-				19000 0 0 3 40000 32 1
-				19000 0 0 4 40000 33 1>;
+				/* VIA chip */
+				12000 0 0 1 19000 30 1
+				12000 0 0 2 19000 31 1
+				12000 0 0 3 19000 32 1
+				12000 0 0 4 19000 33 1>;
+				
 			interrupt-parent = <40000>;
 			interrupts = <08 2>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -260,8 +289,8 @@
 			interrupt-parent = <40000>;
 			interrupts = <09 2>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 00100000>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -270,6 +299,30 @@
 			compatible = "85xx";
 			device_type = "pci";
 		};
+		/* PCI Express */
+		pci@a000 {
+			linux,phandle = <a000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x0 (PEX) */
+				00000 0 0 1 40000 30 1
+				00000 0 0 2 40000 31 0
+				00000 0 0 3 40000 32 0
+				00000 0 0 4 40000 33 0>;
+			interrupt-parent = <40000>;
+			interrupts = <0a 2>;
+			bus-range = <2 ff>;
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
 
 		pic@40000 {
 			linux,phandle = <40000>;
-- 
1.4.4

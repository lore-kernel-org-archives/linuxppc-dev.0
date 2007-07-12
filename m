Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 076F1DDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 18:28:12 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6C8S7ag009759
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:28:07 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6C8S54R001411
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:28:06 -0500 (CDT)
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
	<7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184228873.27622.11.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 12 Jul 2007 16:27:54 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Add 8548 CDS PCI express controller node and PCI-X device node.
The current  dts file is suitable for 8548 Rev 2.0 board with
Arcadia 3.1.
This kind of board combination is the most popular.

Indentify pci, pcie host by compatible property "fsl,mpc85xx-pci"
and "fsl, mpc85xx-pciex".

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Fix the PCI Express b,c,d, irq sense.

 arch/powerpc/boot/dts/mpc8548cds.dts |  156 +++++++++++++++++++++++-----------
 1 files changed, 105 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 9d0b84b..d60821b 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -1,5 +1,5 @@
 /*
- * MPC8555 CDS Device Tree Source
+ * MPC8548 CDS Device Tree Source
  *
  * Copyright 2006 Freescale Semiconductor Inc.
  *
@@ -186,67 +186,96 @@
 		pci1: pci@8000 {
 			interrupt-map-mask = <1f800 0 0 7>;
 			interrupt-map = <
+				/* IDSEL 0x4 (PCIX Slot 2) */
+				02000 0 0 1 &mpic 0 1
+				02000 0 0 2 &mpic 1 1
+				02000 0 0 3 &mpic 2 1
+				02000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x5 (PCIX Slot 3) */
+				02800 0 0 1 &mpic 1 1
+				02800 0 0 2 &mpic 2 1
+				02800 0 0 3 &mpic 3 1
+				02800 0 0 4 &mpic 0 1
+
+				/* IDSEL 0x6 (PCIX Slot 4) */
+				03000 0 0 1 &mpic 2 1
+				03000 0 0 2 &mpic 3 1
+				03000 0 0 3 &mpic 0 1
+				03000 0 0 4 &mpic 1 1
+
+				/* IDSEL 0x8 (PCIX Slot 5) */
+				04000 0 0 1 &mpic 0 1
+				04000 0 0 2 &mpic 1 1
+				04000 0 0 3 &mpic 2 1
+				04000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0xC (Tsi310 bridge) */
+				06000 0 0 1 &mpic 0 1
+				06000 0 0 2 &mpic 1 1
+				06000 0 0 3 &mpic 2 1
+				06000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x14 (Slot 2) */
+				0a000 0 0 1 &mpic 0 1
+				0a000 0 0 2 &mpic 1 1
+				0a000 0 0 3 &mpic 2 1
+				0a000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x15 (Slot 3) */
+				0a800 0 0 1 &mpic 1 1
+				0a800 0 0 2 &mpic 2 1
+				0a800 0 0 3 &mpic 3 1
+				0a800 0 0 4 &mpic 0 1
+
+				/* IDSEL 0x16 (Slot 4) */
+				0b000 0 0 1 &mpic 2 1
+				0b000 0 0 2 &mpic 3 1
+				0b000 0 0 3 &mpic 0 1
+				0b000 0 0 4 &mpic 1 1
+
+				/* IDSEL 0x18 (Slot 5) */
+				0c000 0 0 1 &mpic 0 1
+				0c000 0 0 2 &mpic 1 1
+				0c000 0 0 3 &mpic 2 1
+				0c000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
+				0E000 0 0 1 &mpic 0 1
+				0E000 0 0 2 &mpic 1 1
+				0E000 0 0 3 &mpic 2 1
+				0E000 0 0 4 &mpic 3 1
+
+				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */
+				11000 0 0 1 &mpic 2 1
+				11000 0 0 2 &mpic 3 1
+				11000 0 0 3 &mpic 0 1
+				11000 0 0 4 &mpic 1 1
+
+				/* VIA chip */
+				12000 0 0 1 &mpic 0 1
+				12000 0 0 2 &mpic 1 1
+				12000 0 0 3 &mpic 2 1
+				12000 0 0 4 &mpic 3 1>;
 
-				/* IDSEL 0x10 */
-				08000 0 0 1 &mpic 0 1
-				08000 0 0 2 &mpic 1 1
-				08000 0 0 3 &mpic 2 1
-				08000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x11 */
-				08800 0 0 1 &mpic 0 1
-				08800 0 0 2 &mpic 1 1
-				08800 0 0 3 &mpic 2 1
-				08800 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x12 (Slot 1) */
-				09000 0 0 1 &mpic 0 1
-				09000 0 0 2 &mpic 1 1
-				09000 0 0 3 &mpic 2 1
-				09000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x13 (Slot 2) */
-				09800 0 0 1 &mpic 1 1
-				09800 0 0 2 &mpic 2 1
-				09800 0 0 3 &mpic 3 1
-				09800 0 0 4 &mpic 0 1
-
-				/* IDSEL 0x14 (Slot 3) */
-				0a000 0 0 1 &mpic 2 1
-				0a000 0 0 2 &mpic 3 1
-				0a000 0 0 3 &mpic 0 1
-				0a000 0 0 4 &mpic 1 1
-
-				/* IDSEL 0x15 (Slot 4) */
-				0a800 0 0 1 &mpic 3 1
-				0a800 0 0 2 &mpic 0 1
-				0a800 0 0 3 &mpic 1 1
-				0a800 0 0 4 &mpic 2 1
-
-				/* Bus 1 (Tundra Bridge) */
-				/* IDSEL 0x12 (ISA bridge) */
-				19000 0 0 1 &mpic 0 1
-				19000 0 0 2 &mpic 1 1
-				19000 0 0 3 &mpic 2 1
-				19000 0 0 4 &mpic 3 1>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 
-			i8259@19000 {
+			i8259@4 {
 				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "interrupt-controller";
-				reg = <19000 0 0 0 1>;
+				reg = <12000 0 0 0 1>;
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				built-in;
@@ -266,17 +295,42 @@
 				a800 0 0 2 &mpic b 1
 				a800 0 0 3 &mpic b 1
 				a800 0 0 4 &mpic b 1>;
+
 			interrupt-parent = <&mpic>;
 			interrupts = <19 2>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 00100000>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
+			device_type = "pci";
+		};
+		/* PCI Express */
+		pci@a000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x0 (PEX) */
+				00000 0 0 1 &mpic 0 1
+				00000 0 0 2 &mpic 1 1
+				00000 0 0 3 &mpic 2 1
+				00000 0 0 4 &mpic 3 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 08000000>;
+			clock-frequency = <1fca055>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			compatible = "fsl,mpc86xx-pciex","86xx";
 			device_type = "pci";
 		};
 
-- 
1.5.1

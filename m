Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id B51DCDDF79
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:57:07 +1000 (EST)
Message-ID: <46A10582.7020709@mvista.com>
Date: Fri, 20 Jul 2007 11:57:06 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 6/6] 85xxCDS: MPC8548 DTS cleanup.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 5d2f1e916b0a88538370f93e8c58691ba3a57d92 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Tue, 17 Jul 2007 16:37:12 -0700
Subject: [PATCH] 85xxCDS: MPC8548 DTS cleanup.

Added the P2P bridge present on the Arcadia base board and moved the VIA
Southbridge behind the bridge to reflect its actual position in the bus
organization. Added the RTC that's in the VIA Southbridge and expanded
the ranges array for the SOC node to allow proper address translation of
the RTC registers.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |  120 ++++++++++++++++++++++++---------
 1 files changed, 87 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index c241e4f..2c6fd63 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -44,8 +44,14 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		ranges = <00001000 e0001000 000ff000
+			  80000000 80000000 10000000
+			  e2000000 e2000000 00800000
+			  90000000 90000000 10000000
+			  e2800000 e2800000 00800000
+			  a0000000 a0000000 20000000
+		          e3000000 e3000000 01000000>;
+		reg = <e0000000 00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		memory-controller@2000 {
@@ -183,8 +189,8 @@
 			fsl,has-rstcr;
 		};
 
-		pci1: pci@8000 {
-			interrupt-map-mask = <1f800 0 0 7>;
+		pci@8000 {
+			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x4 (PCIX Slot 2) */
 				02000 0 0 1 &mpic 0 1
@@ -244,19 +250,7 @@
 				0E000 0 0 1 &mpic 0 1
 				0E000 0 0 2 &mpic 1 1
 				0E000 0 0 3 &mpic 2 1
-				0E000 0 0 4 &mpic 3 1
-
-				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */
-				11000 0 0 1 &mpic 2 1
-				11000 0 0 2 &mpic 3 1
-				11000 0 0 3 &mpic 0 1
-				11000 0 0 4 &mpic 1 1
-
-				/* VIA chip */
-				12000 0 0 1 &mpic 0 1
-				12000 0 0 2 &mpic 1 1
-				12000 0 0 3 &mpic 2 1
-				12000 0 0 4 &mpic 3 1>;
+				0E000 0 0 4 &mpic 3 1>;
 
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
@@ -271,18 +265,78 @@
 			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
 			device_type = "pci";
 
-			i8259@4 {
-				clock-frequency = <0>;
-				interrupt-controller;
-				device_type = "interrupt-controller";
-				reg = <12000 0 0 0 1>;
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
-				built-in;
-				compatible = "chrp,iic";
-				big-endian;
-				interrupts = <1>;
-				interrupt-parent = <&pci1>;
+			pci_bridge@1c {
+				interrupt-map-mask = <f800 0 0 7>;
+				interrupt-map = <
+
+					/* IDSEL 0x00 (PrPMC Site) */
+					0000 0 0 1 &mpic 0 1
+					0000 0 0 2 &mpic 1 1
+					0000 0 0 3 &mpic 2 1
+					0000 0 0 4 &mpic 3 1
+
+					/* IDSEL 0x04 (VIA chip) */
+  					2000 0 0 1 &mpic 0 1
+  					2000 0 0 2 &mpic 1 1
+  					2000 0 0 3 &mpic 2 1
+					2000 0 0 4 &mpic 3 1
+
+					/* IDSEL 0x05 (8139) */
+					2800 0 0 1 &mpic 1 1
+
+					/* IDSEL 0x06 (Slot 6) */
+					3000 0 0 1 &mpic 2 1
+					3000 0 0 2 &mpic 3 1
+					3000 0 0 3 &mpic 0 1
+					3000 0 0 4 &mpic 1 1
+
+					/* IDESL 0x07 (Slot 7) */
+					3800 0 0 1 &mpic 3 1
+					3800 0 0 2 &mpic 0 1
+					3800 0 0 3 &mpic 1 1
+					3800 0 0 4 &mpic 2 1>;
+
+				reg = <e000 0 0 0 0>;
+				#interrupt-cells = <1>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <02000000 0 80000000
+					  02000000 0 80000000
+					  0 20000000
+					  01000000 0 00000000
+					  01000000 0 00000000
+					  0 00080000>;
+				clock-frequency = <1fca055>;
+
+				isa@4 {
+					device_type = "isa";
+					#interrupt-cells = <2>;
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <2000 0 0 0 0>;
+					ranges = <1 0 01000000 0 0 00001000>;
+					interrupt-parent = <&i8259>;
+
+					i8259: interrupt-controller@20 {
+						clock-frequency = <0>;
+						interrupt-controller;
+						device_type = "interrupt-controller";
+						reg = <1 20 2
+						       1 a0 2
+						       1 4d0 2>;
+						#address-cells = <0>;
+						#interrupt-cells = <2>;
+						built-in;
+						compatible = "chrp,iic";
+						interrupts = <0 1>;
+						interrupt-parent = <&mpic>;
+					};
+
+					rtc@70 {
+						compatible = "pnpPNP,b00";
+						reg = <1 70 2>;
+					};
+				};
 			};
 		};
 
@@ -292,9 +346,9 @@
 
 				/* IDSEL 0x15 */
 				a800 0 0 1 &mpic b 1
-				a800 0 0 2 &mpic b 1
-				a800 0 0 3 &mpic b 1
-				a800 0 0 4 &mpic b 1>;
+				a800 0 0 2 &mpic 1 1
+				a800 0 0 3 &mpic 2 1
+				a800 0 0 4 &mpic 3 1>;
 
 			interrupt-parent = <&mpic>;
 			interrupts = <19 2>;
@@ -310,7 +364,7 @@
 			device_type = "pci";
 		};
 		/* PCI Express */
-		pci@a000 {
+		pcie@a000 {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 
-- 
1.5.2.2.549.gaeb59

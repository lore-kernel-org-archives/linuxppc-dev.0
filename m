Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EEF5DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:22 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 23/25] [POWERPC] 85xxCDS: MPC8548 DTS cleanup.
Date: Mon, 23 Jul 2007 15:50:10 -0500
Message-Id: <11852238472931-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238452609-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
	<11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
	<11852238411823-git-send-email-galak@kernel.crashing.org>
	<11852238421611-git-send-email-galak@kernel.crashing.org>
	<11852238432011-git-send-email-galak@kernel.crashing.org>
	<11852238452609-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Vinson <rvinson@mvista.com>

Added the P2P bridge present on the Arcadia base board and moved the VIA
Southbridge behind the bridge to reflect its actual position in the bus
organization. Added the RTC that's in the VIA Southbridge and expanded
the ranges array for the SOC node to allow proper address translation of
the RTC registers.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |  124 ++++++++++++++++++++++++----------
 1 files changed, 89 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 4770a5b..d215d21 100644
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
@@ -162,8 +168,8 @@
 		serial@4500 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>; 	// reg base, size
-			clock-frequency = <0>; 	// should we fill in in uboot?
+			reg = <4500 100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <2a 2>;
 			interrupt-parent = <&mpic>;
 		};
@@ -172,7 +178,7 @@
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;	// reg base, size
-			clock-frequency = <0>; 	// should we fill in in uboot?
+			clock-frequency = <0>;	// should we fill in in uboot?
 			interrupts = <2a 2>;
 			interrupt-parent = <&mpic>;
 		};
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
+					2000 0 0 1 &mpic 0 1
+					2000 0 0 2 &mpic 1 1
+					2000 0 0 3 &mpic 2 1
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
-- 
1.5.2.2

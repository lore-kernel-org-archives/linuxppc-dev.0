Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27955DE206
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:48:36 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l51HmWAM003470
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:48:33 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51HmW4A021361
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:48:32 -0500 (CDT)
Subject: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720112.14219.62.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:48:32 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wade Farnsworth <wfarnsworth@mvista.com>

This adds device nodes for the PCI bridges as well as the ISA devices on
the newer revision MPC8641HPCN.  It also adds the PCI ranges to the soc
node so that address translation for the ISA devices works properly.

Includes ULI node originally from Zhang Wei <wei.zhang@freescale.com>.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   89 +++++++++++++++++++++++++++----
 1 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 260b264..b2a4734 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -56,7 +56,11 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 f8000000 00100000>;
+		ranges = <00000000 f8000000 00100000
+			  80000000 80000000 20000000
+			  e2000000 e2000000 00100000
+			  a0000000 a0000000 20000000
+			  e3000000 e3000000 00100000>;
 		reg = <f8000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
@@ -285,17 +289,78 @@
 				f800 0 0 3 &i8259 0 0
 				f800 0 0 4 &i8259 0 0
 				>;
-			i8259: i8259@4d0 {
-				clock-frequency = <0>;
-				interrupt-controller;
-				device_type = "interrupt-controller";
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
-				built-in;
-				compatible = "chrp,iic";
-                	        big-endian;
-				interrupts = <49 2>;
-				interrupt-parent = <&mpic>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <02000000 0 80000000
+					  02000000 0 80000000
+					  0 20000000
+					  01000000 0 00000000
+					  01000000 0 00000000
+					  0 00100000>;
+
+				pci_bridge@0 {
+					reg = <0 0 0 0 0>;
+					#size-cells = <2>;
+					#address-cells = <3>;
+					ranges = <02000000 0 80000000
+						  02000000 0 80000000
+						  0 20000000
+						  01000000 0 00000000
+						  01000000 0 00000000
+						  0 00100000>;
+
+					isa@1e {
+						device_type = "isa";
+						#interrupt-cells = <2>;
+						#size-cells = <1>;
+						#address-cells = <2>;
+						reg = <f000 0 0 0 0>;
+						ranges = <1 0 01000000 0 0
+							  00001000>;
+						interrupt-parent = <&i8259>;
+
+						i8042@60 {
+							reg = <1 60 1 1 64 1>;
+							interrupts = <1 3 c 3>;
+							interrupt-parent =
+								<&i8259>;
+
+							keyboard@0 {
+								compatible = "pnpPNP,303";
+							};
+
+							mouse@1 {
+								compatible = "pnpPNP,f03";
+							};
+						};
+
+						rtc@70 {
+							compatible =
+								"pnpPNP,b00";
+							reg = <1 70 2>;
+						};
+
+						gpio@400 {
+							reg = <1 400 80>;
+						};
+
+						i8259: i8259@4d0 {
+							clock-frequency = <0>;
+							interrupt-controller;
+							device_type = "interrupt-controller";
+							#address-cells = <0>;
+							#interrupt-cells = <2>;
+							built-in;
+							compatible = "chrp,iic";
+							big-endian;
+							interrupts = <49 2>;
+							interrupt-parent =
+								<&mpic>;
+						};
+					};
+				};
 			};
 
 		};
-- 
1.5.0.3

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3CCCDE29C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:38 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Date: Tue, 26 Jun 2007 20:16:39 -0500
Message-Id: <11829070192461-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1182907015126-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
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

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   97 +++++++++++++++++++++++++++----
 1 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 748f7b9..393cfdf 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -56,8 +56,12 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 f8000000 00100000>;
-		reg = <f8000000 00100000>;	// CCSRBAR 1M
+		ranges = <00001000 f8001000 000ff000
+			  80000000 80000000 20000000
+			  e2000000 e2000000 00100000
+			  a0000000 a0000000 20000000
+			  e3000000 e3000000 00100000>;
+		reg = <f8000000 00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		i2c@3000 {
@@ -285,17 +289,84 @@
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
+						i8259: interrupt-controller@20 {
+							reg = <1 20 2
+							       1 a0 2
+							       1 4d0 2>;
+							clock-frequency = <0>;
+							interrupt-controller;
+							device_type = "interrupt-controller";
+							#address-cells = <0>;
+							#interrupt-cells = <2>;
+							built-in;
+							compatible = "chrp,iic";
+							interrupts = <49 2>;
+							interrupt-parent =
+								<&mpic>;
+						};
+
+						i8042@60 {
+							#size-cells = <0>;
+							#address-cells = <1>;
+							reg = <1 60 1 1 64 1>;
+							interrupts = <1 3 c 3>;
+							interrupt-parent =
+								<&i8259>;
+
+							keyboard@0 {
+								reg = <0>;
+								compatible = "pnpPNP,303";
+							};
+
+							mouse@1 {
+								reg = <1>;
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
+					};
+				};
 			};
 
 		};
-- 
1.5.2.1

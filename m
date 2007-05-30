Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 21D91DDFBB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 08:26:29 +1000 (EST)
Subject: Re: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <17B6534B-3C1C-433D-8875-1C2255E79D98@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<17B6534B-3C1C-433D-8875-1C2255E79D98@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 15:26:15 -0700
Message-Id: <1180563975.5715.15.camel@rhino>
Mime-Version: 1.0
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

This adds device nodes for the PCI bridges as well as the ISA devices on
the newer revision MPC8641HPCN.  It also adds the PCI ranges to the soc
node so that address translation for the ISA devices works properly.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
Here's the merged patch.

I've updated the ISA nodes somewhat according to the comments the
original patch received.

I also took the liberty of fixing the addresses of the pci bridges and
removing the unused "uli1575:" label.

 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   89 +++++++++++++++++++----
 1 file changed, 77 insertions(+), 12 deletions(-)

Index: linux-2.6-powerpc-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-powerpc-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
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
+ 				#size-cells = <2>;
+ 				#address-cells = <3>;
+ 				ranges = <02000000 0 80000000
+ 					  02000000 0 80000000
+ 					  0 20000000
+ 					  01000000 0 00000000
+ 					  01000000 0 00000000
+ 					  0 00100000>;
+
+				pci_bridge@0 {
+					reg = <0 0 0 0 0>;
+ 					#size-cells = <2>;
+ 					#address-cells = <3>;
+ 					ranges = <02000000 0 80000000
+ 						  02000000 0 80000000
+ 						  0 20000000
+ 						  01000000 0 00000000
+ 						  01000000 0 00000000
+ 						  0 00100000>;
+
+ 					isa@1e {
+ 						device_type = "isa";
+ 						#interrupt-cells = <2>;
+ 						#size-cells = <1>;
+ 						#address-cells = <2>;
+ 						reg = <f000 0 0 0 0>;
+ 						ranges = <1 0 01000000 0 0
+ 							  00001000>;
+ 						interrupt-parent = <&i8259>;
+
+ 						i8042@60 {
+ 							reg = <1 60 1 1 64 1>;
+ 							interrupts = <1 3 c 3>;
+ 							interrupt-parent =
+ 								<&i8259>;
+
+ 							keyboard@0 {
+ 								compatible = "pnpPNP,303";
+ 	 						};
+
+ 							mouse@1 {
+ 								compatible = "pnpPNP,f03";
+ 							};
+ 						};
+
+ 						rtc@70 {
+ 							compatible =
+ 								"pnpPNP,b00";
+ 							reg = <1 70 2>;
+ 						};
+
+ 						gpio@400 {
+ 							reg = <1 400 80>;
+ 						};
+
+ 						i8259: i8259@4d0 {
+ 							clock-frequency = <0>;
+ 							interrupt-controller;
+ 							device_type = "interrupt-controller";
+ 							#address-cells = <0>;
+ 							#interrupt-cells = <2>;
+ 							built-in;
+ 							compatible = "chrp,iic";
+ 							big-endian;
+ 							interrupts = <49 2>;
+ 							interrupt-parent =
+ 								<&mpic>;
+ 						};
+					};
+				};
 			};
 
 		};

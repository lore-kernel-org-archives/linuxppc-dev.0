Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8A4FDDDE4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:19:53 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l93FJn5i025994
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 10:19:50 -0500
Date: Wed, 3 Oct 2007 10:19:23 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fixup MPC8568 dts
Message-ID: <Pine.LNX.4.64.0710031018380.20394@blarg.am.freescale.net>
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

The PCI nodes on the MPC8568 dts didn't get moved up to be sibilings of the
SOC node when we did that clean up for some reason.  Fix that up and some
minor whitespace and adjusting the size of the soc reg property.

---
 arch/powerpc/boot/dts/mpc8568mds.dts |  125 +++++++++++++++++++---------------
 1 files changed, 70 insertions(+), 55 deletions(-)

in my git tree, just posted here so everyone can see it.

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 6923e42..6ac134a 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -52,7 +52,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00100000>;
+		reg = <e0000000 00001000>;
 		bus-frequency = <0>;

 		memory-controller@2000 {
@@ -183,60 +183,6 @@
 			fsl,has-rstcr;
 		};

-		pci@8000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x12 AD18 */
-				9000 0 0 1 &mpic 5 1
-				9000 0 0 2 &mpic 6 1
-				9000 0 0 3 &mpic 7 1
-				9000 0 0 4 &mpic 4 1
-
-				/* IDSEL 0x13 AD19 */
-				9800 0 0 1 &mpic 6 1
-				9800 0 0 2 &mpic 7 1
-				9800 0 0 3 &mpic 4 1
-				9800 0 0 4 &mpic 5 1>;
-
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00800000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-		};
-
-		/* PCI Express */
-		pcie@a000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x0 (PEX) */
-				00000 0 0 1 &mpic 0 1
-				00000 0 0 2 &mpic 1 1
-				00000 0 0 3 &mpic 2 1
-				00000 0 0 4 &mpic 3 1>;
-
-			interrupt-parent = <&mpic>;
-			interrupts = <1a 2>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 a0000000 a0000000 0 10000000
-				  01000000 0 00000000 e2800000 0 00800000>;
-			clock-frequency = <1fca055>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <a000 1000>;
-			compatible = "fsl,mpc8548-pcie";
-			device_type = "pci";
-		};
-
 		serial@4600 {
 			device_type = "serial";
 			compatible = "ns16550";
@@ -269,6 +215,7 @@
 			device_type = "open-pic";
                         big-endian;
 		};
+
 		par_io@e0100 {
 			reg = <e0100 100>;
 			device_type = "par_io";
@@ -301,6 +248,7 @@
 					4  13  1  0  2  0 	/* GTX_CLK */
 					1  1f  2  0  3  0>;	/* GTX125 */
 			};
+
 			pio2: ucc_pin@02 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
@@ -461,4 +409,71 @@
 		};

 	};
+
+	pci@8000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x12 AD18 */
+			9000 0 0 1 &mpic 5 1
+			9000 0 0 2 &mpic 6 1
+			9000 0 0 3 &mpic 7 1
+			9000 0 0 4 &mpic 4 1
+
+			/* IDSEL 0x13 AD19 */
+			9800 0 0 1 &mpic 6 1
+			9800 0 0 2 &mpic 7 1
+			9800 0 0 3 &mpic 4 1
+			9800 0 0 4 &mpic 5 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 00800000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <8000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
+
+	/* PCI Express */
+	pcie@a000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0 (PEX) */
+			00000 0 0 1 &mpic 0 1
+			00000 0 0 2 &mpic 1 1
+			00000 0 0 3 &mpic 2 1
+			00000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <1a 2>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 e2800000 0 00800000>;
+		clock-frequency = <1fca055>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <a000 1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <02000000 0 a0000000
+				  02000000 0 a0000000
+				  0 10000000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00800000>;
+		};
+	};
 };
-- 
1.5.2.4

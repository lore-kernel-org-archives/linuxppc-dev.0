Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CC5FDDEFE
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 09:05:32 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Update 8641hpcn dts file to match latest u-boot
Date: Fri, 19 Dec 2008 16:05:12 -0600
Message-Id: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The newest revision of uboot reworks the memory map for this
board to look more like the 85xx boards.  Also, some regions
which were far larger than the actual hardware have been scaled
back to match the board, and the imaginary second flash bank has
been removed. Rapidio and PCI are mutually exclusive in the hardware,
and they now are occupying the same space in the address map.
The Rapidio node is commented out of the .dts since PCI is the
common use case.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   56 ++++++++++++++++++-------------
 1 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index d665e76..e79af90 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -26,7 +26,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
-		rapidio0 = &rapidio0;
+		/* rapidio0 = &rapidio0; */
 	};
 
 	cpus {
@@ -62,18 +62,17 @@
 		reg = <0x00000000 0x40000000>;	// 1G at 0x0
 	};
 
-	localbus@f8005000 {
+	localbus@ffe05000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xf8005000 0x1000>;
+		reg = <0xffe05000 0x1000>;
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
-		ranges = <0 0 0xff800000 0x00800000
-			  1 0 0xfe000000 0x01000000
-			  2 0 0xf8200000 0x00100000
-			  3 0 0xf8100000 0x00100000>;
+		ranges = <0 0 0xef800000 0x00800000
+			  2 0 0xffdf8000 0x00008000
+			  3 0 0xffdf0000 0x00008000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -103,13 +102,13 @@
 		};
 	};
 
-	soc8641@f8000000 {
+	soc8641@ffe00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <0x00000000 0xf8000000 0x00100000>;
-		reg = <0xf8000000 0x00001000>;	// CCSRBAR
+		ranges = <0x00000000 0xffe00000 0x00100000>;
+		reg = <0xffe00000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		i2c@3000 {
@@ -295,17 +294,17 @@
 		};
 	};
 
-	pci0: pcie@f8008000 {
+	pci0: pcie@ffe08000 {
 		cell-index = <0>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xf8008000 0x1000>;
+		reg = <0xffe08000 0x1000>;
 		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
@@ -436,7 +435,7 @@
 
 				  0x01000000 0x0 0x00000000
 				  0x01000000 0x0 0x00000000
-				  0x0 0x00100000>;
+				  0x0 0x00010000>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
@@ -446,7 +445,7 @@
 					  0x0 0x20000000
 					  0x01000000 0x0 0x00000000
 					  0x01000000 0x0 0x00000000
-					  0x0 0x00100000>;
+					  0x0 0x00010000>;
 				isa@1e {
 					device_type = "isa";
 					#interrupt-cells = <2>;
@@ -504,17 +503,17 @@
 
 	};
 
-	pci1: pcie@f8009000 {
+	pci1: pcie@ffe09000 {
 		cell-index = <1>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xf8009000 0x1000>;
+		reg = <0xffe09000 0x1000>;
 		bus-range = <0 0xff>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
+			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
@@ -537,18 +536,27 @@
 
 				  0x01000000 0x0 0x00000000
 				  0x01000000 0x0 0x00000000
-				  0x0 0x00100000>;
+				  0x0 0x00010000>;
 		};
 	};
-	rapidio0: rapidio@f80c0000 {
+/*
+ * Only one of Rapid IO or PCI can be present due to HW limitations and
+ * due to the fact that the 2 now share address space in the new memory
+ * map.  The most likely case is that we have PCI, so comment out the
+ * rapidio node.  Leave it here for reference.
+ */
+/*
+	rapidio0: rapidio@ffec0000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "fsl,rapidio-delta";
-		reg = <0xf80c0000 0x20000>;
-		ranges = <0 0 0xc0000000 0 0x20000000>;
+		reg = <0xffec0000 0x20000>;
+		ranges = <0 0 0x80000000 0 0x20000000>;
 		interrupt-parent = <&mpic>;
-		/* err_irq bell_outb_irq bell_inb_irq
-			msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq */
+		// err_irq bell_outb_irq bell_inb_irq
+		//	msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq
 		interrupts = <48 2 49 2 50 2 53 2 54 2 55 2 56 2>;
 	};
+*/
+
 };
-- 
1.5.6.5

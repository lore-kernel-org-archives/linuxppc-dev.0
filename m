Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0B6A0B7182
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2011 08:59:59 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9MLKv6O009805
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2011 16:20:57 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/11] powerpc/85xx: p1020si.dtsi update interrupt handling
Date: Sat, 22 Oct 2011 16:20:48 -0500
Message-Id: <1319318452-27036-7-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-4-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-5-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-6-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* set interrupt-parent at root so its not duplicate in every node
* Add mpic timers
* Move to 4-prop cells for mpic timer

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020si.dtsi |  117 +++++++++++++++++-------------------
 1 files changed, 56 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 14dff69..b08c848 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -14,6 +14,7 @@
 	compatible = "fsl,P1020";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -37,8 +38,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
 		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
+		interrupts = <19 2 0 0>;
 	};
 
 	soc@ffe00000 {
@@ -58,15 +58,13 @@
 		ecm@1000 {
 			compatible = "fsl,p1020-ecm", "fsl,ecm";
 			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <16 2 0 0>;
 		};
 
 		memory-controller@2000 {
 			compatible = "fsl,p1020-memory-controller";
 			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -75,8 +73,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -86,8 +83,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -97,8 +93,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -107,8 +102,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <42 2 0 0>;
 		};
 
 		spi@7000 {
@@ -116,8 +110,7 @@
 			#size-cells = <0>;
 			compatible = "fsl,p1020-espi", "fsl,mpc8536-espi";
 			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <59 0x2 0 0>;
 			fsl,espi-num-chipselects = <4>;
 		};
 
@@ -125,8 +118,7 @@
 			#gpio-cells = <2>;
 			compatible = "fsl,mpc8572-gpio";
 			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <47 0x2 0 0>;
 			gpio-controller;
 		};
 
@@ -135,8 +127,7 @@
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>; // L2,256K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		dma@21300 {
@@ -150,29 +141,25 @@
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -202,20 +189,19 @@
 			fsl,num_tx_queues = <0x8>;
 			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 
 			queue-group@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb0000 0x1000>;
-				interrupts = <29 2 30 2 34 2>;
+				interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 			};
 
 			queue-group@1 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb4000 0x1000>;
-				interrupts = <17 2 18 2 24 2>;
+				interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
 			};
 		};
 
@@ -229,20 +215,19 @@
 			fsl,num_tx_queues = <0x8>;
 			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 
 			queue-group@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb1000 0x1000>;
-				interrupts = <35 2 36 2 40 2>;
+				interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			};
 
 			queue-group@1 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb5000 0x1000>;
-				interrupts = <51 2 52 2 67 2>;
+				interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
 			};
 		};
 
@@ -256,20 +241,19 @@
 			fsl,num_tx_queues = <0x8>;
 			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupt-parent = <&mpic>;
 
 			queue-group@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb2000 0x1000>;
-				interrupts = <31 2 32 2 33 2>;
+				interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			};
 
 			queue-group@1 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xb6000 0x1000>;
-				interrupts = <25 2 26 2 27 2>;
+				interrupts = <25 2 0 0 26 2 0 0 27 2 0 0>;
 			};
 		};
 
@@ -278,8 +262,7 @@
 			#size-cells = <0>;
 			compatible = "fsl-usb2-dr";
 			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
+			interrupts = <28 0x2 0 0>;
 		};
 
 		/* USB2 is shared with localbus, so it must be disabled
@@ -292,8 +275,7 @@
 			#size-cells = <0>;
 			compatible = "fsl-usb2-dr";
 			reg = <0x23000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <46 0x2>;
+			interrupts = <46 0x2 0 0>;
 			phy_type = "ulpi";
 		};
 		*/
@@ -301,8 +283,7 @@
 		sdhci@2e000 {
 			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <72 0x2 0 0>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -312,8 +293,7 @@
 				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
 				     "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
+			interrupts = <45 2 0 0 58 2 0 0>;
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x97c>;
@@ -323,26 +303,43 @@
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
 
+		timer@41100 {
+			compatible = "fsl,mpic-global-timer";
+			reg = <0x41100 0x100 0x41300 4>;
+			interrupts = <0 0 3 0
+			              1 0 3 0
+			              2 0 3 0
+			              3 0 3 0>;
+		};
+
+		timer@42100 {
+			compatible = "fsl,mpic-global-timer";
+			reg = <0x42100 0x100 0x42300 4>;
+			interrupts = <4 0 3 0
+			              5 0 3 0
+			              6 0 3 0
+			              7 0 3 0>;
+		};
+
 		msi@41600 {
 			compatible = "fsl,p1020-msi", "fsl,mpic-msi";
 			reg = <0x41600 0x80>;
 			msi-available-ranges = <0 0x100>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
 		};
 
 		global-utilities@e0000 {	//global utilities block
@@ -359,8 +356,7 @@
 		#address-cells = <3>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
+		interrupts = <16 2 0 0>;
 
 		pcie@0 {
 			reg = <0 0 0 0 0>;
@@ -368,7 +364,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x0 */
@@ -388,8 +384,7 @@
 		#address-cells = <3>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <16 2>;
+		interrupts = <16 2 0 0>;
 
 		pcie@0 {
 			reg = <0 0 0 0 0>;
@@ -397,7 +392,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 			interrupt-map-mask = <0xf800 0 0 7>;
 
 			interrupt-map = <
-- 
1.7.3.4

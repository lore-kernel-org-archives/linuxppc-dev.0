Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B7631008E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 08:44:25 +1100 (EST)
Date: Thu, 24 Mar 2011 16:43:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc/p1022ds: fix broken mpic timer node
Message-ID: <20110324214352.GA9524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110324214315.GA9502@schlenkerla.am.freescale.net>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no hardware interrupt 0xf7.  But now we can express the timer
interrupt using 4-cell interrupts.  This requires converting all of the
other interrupt specifiers in the tree as well.

Also add the second timer group, and fix the reg property to only
describe the timer registers.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |  106 ++++++++++++++++++++----------------
 1 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 59ef405..4f685a7 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -52,7 +52,7 @@
 		#size-cells = <1>;
 		compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
 		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
+		interrupts = <19 2 0 0>;
 
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
 			  0x1 0x0 0xf 0xe0000000 0x08000000
@@ -157,7 +157,7 @@
 			 * IRQ8 is generated if the "EVENT" switch is pressed
 			 * and PX_CTL[EVESEL] is set to 00.
 			 */
-			interrupts = <8 8>;
+			interrupts = <8 8 0 0>;
 		};
 	};
 
@@ -178,13 +178,13 @@
 		ecm@1000 {
 			compatible = "fsl,p1022-ecm", "fsl,ecm";
 			reg = <0x1000 0x1000>;
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		memory-controller@2000 {
 			compatible = "fsl,p1022-memory-controller";
 			reg = <0x2000 0x1000>;
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		i2c@3000 {
@@ -193,7 +193,7 @@
 			cell-index = <0>;
 			compatible = "fsl-i2c";
 			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 		};
 
@@ -203,7 +203,7 @@
 			cell-index = <1>;
 			compatible = "fsl-i2c";
 			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
+			interrupts = <43 2 0 0>;
 			dfsrr;
 
 			wm8776:codec@1a {
@@ -220,7 +220,7 @@
 			compatible = "ns16550";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
+			interrupts = <42 2 0 0>;
 		};
 
 		serial1: serial@4600 {
@@ -229,7 +229,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <42 2>;
+			interrupts = <42 2 0 0>;
 		};
 
 		spi@7000 {
@@ -238,7 +238,7 @@
 			#size-cells = <0>;
 			compatible = "fsl,espi";
 			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
+			interrupts = <59 0x2 0 0>;
 			espi,num-ss-bits = <4>;
 			mode = "cpu";
 
@@ -275,7 +275,7 @@
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <0>;
 			reg = <0x15000 0x100>;
-			interrupts = <75 2>;
+			interrupts = <75 2 0 0>;
 			fsl,mode = "i2s-slave";
 			codec-handle = <&wm8776>;
 			fsl,playback-dma = <&dma00>;
@@ -294,25 +294,25 @@
 				compatible = "fsl,ssi-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupts = <76 2>;
+				interrupts = <76 2 0 0>;
 			};
 			dma01: dma-channel@80 {
 				compatible = "fsl,ssi-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupts = <77 2>;
+				interrupts = <77 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupts = <78 2>;
+				interrupts = <78 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupts = <79 2>;
+				interrupts = <79 2 0 0>;
 			};
 		};
 
@@ -320,7 +320,7 @@
 			#gpio-cells = <2>;
 			compatible = "fsl,mpc8572-gpio";
 			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
+			interrupts = <47 0x2 0 0>;
 			gpio-controller;
 		};
 
@@ -329,7 +329,7 @@
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>; // L2, 256K
-			interrupts = <16 2>;
+			interrupts = <16 2 0 0>;
 		};
 
 		dma@21300 {
@@ -343,25 +343,25 @@
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
-				interrupts = <20 2>;
+				interrupts = <20 2 0 0>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
-				interrupts = <21 2>;
+				interrupts = <21 2 0 0>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x100 0x80>;
 				cell-index = <2>;
-				interrupts = <22 2>;
+				interrupts = <22 2 0 0>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,eloplus-dma-channel";
 				reg = <0x180 0x80>;
 				cell-index = <3>;
-				interrupts = <23 2>;
+				interrupts = <23 2 0 0>;
 			};
 		};
 
@@ -370,7 +370,7 @@
 			#size-cells = <0>;
 			compatible = "fsl-usb2-dr";
 			reg = <0x22000 0x1000>;
-			interrupts = <28 0x2>;
+			interrupts = <28 0x2 0 0>;
 			phy_type = "ulpi";
 		};
 
@@ -381,11 +381,11 @@
 			reg = <0x24000 0x1000 0xb0030 0x4>;
 
 			phy0: ethernet-phy@0 {
-				interrupts = <3 1>;
+				interrupts = <3 1 0 0>;
 				reg = <0x1>;
 			};
 			phy1: ethernet-phy@1 {
-				interrupts = <9 1>;
+				interrupts = <9 1 0 0>;
 				reg = <0x2>;
 			};
 		};
@@ -416,13 +416,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xB0000 0x1000>;
-				interrupts = <29 2 30 2 34 2>;
+				interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 			};
 			queue-group@1{
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xB4000 0x1000>;
-				interrupts = <17 2 18 2 24 2>;
+				interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
 			};
 		};
 
@@ -443,20 +443,20 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xB1000 0x1000>;
-				interrupts = <35 2 36 2 40 2>;
+				interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			};
 			queue-group@1{
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0xB5000 0x1000>;
-				interrupts = <51 2 52 2 67 2>;
+				interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
 			};
 		};
 
 		sdhci@2e000 {
 			compatible = "fsl,p1022-esdhc", "fsl,esdhc";
 			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
+			interrupts = <72 0x2 0 0>;
 			fsl,sdhci-auto-cmd12;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
@@ -467,7 +467,7 @@
 				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
 				     "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
+			interrupts = <45 2 0 0 58 2 0 0>;
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x97c>;
@@ -478,14 +478,14 @@
 			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
-			interrupts = <74 0x2>;
+			interrupts = <74 0x2 0 0>;
 		};
 
 		sata@19000 {
 			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x19000 0x1000>;
 			cell-index = <2>;
-			interrupts = <41 0x2>;
+			interrupts = <41 0x2 0 0>;
 		};
 
 		power@e0070{
@@ -496,21 +496,33 @@
 		display@10000 {
 			compatible = "fsl,diu", "fsl,p1022-diu";
 			reg = <0x10000 1000>;
-			interrupts = <64 2>;
+			interrupts = <64 2 0 0>;
 		};
 
 		timer@41100 {
 			compatible = "fsl,mpic-global-timer";
-			reg = <0x41100 0x204>;
-			interrupts = <0xf7 0x2>;
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
 		};
 
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <4>;
 			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
+			compatible = "fsl,mpic";
 			device_type = "open-pic";
 		};
 
@@ -519,14 +531,14 @@
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
@@ -547,7 +559,7 @@
 		ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
-		interrupts = <16 2>;
+		interrupts = <16 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -582,7 +594,7 @@
 		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
 		clock-frequency = <33333333>;
-		interrupts = <16 2>;
+		interrupts = <16 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -618,7 +630,7 @@
 		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		clock-frequency = <33333333>;
-		interrupts = <16 2>;
+		interrupts = <16 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-- 
1.7.1

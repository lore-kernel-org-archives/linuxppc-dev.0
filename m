Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:37:57 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/8] powerpc: prpmc2800 - Add labels to dts file
Message-ID: <20071211003756.GC4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Add & use labels for dts nodes that are referenced in the prpmc2800.dts
file to improve readability.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |  104 +++++++++++++-------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 15247a4..1657ee6 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -94,18 +94,18 @@
 			#size-cells = <0>;
 			device_type = "mdio";
 			compatible = "marvell,mv64x60-mdio";
-			ethernet-phy@1 {
+			PHY0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
 				interrupts = <76>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupt-parent = <&PIC>;
 				reg = <1>;
 			};
-			ethernet-phy@3 {
+			PHY1: ethernet-phy@3 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
 				interrupts = <76>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupt-parent = <&PIC>;
 				reg = <3>;
 			};
 		};
@@ -117,8 +117,8 @@
 				compatible = "marvell,mv64x60-eth";
 				block-index = <0>;
 				interrupts = <32>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@1>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY0>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
 			eth1 {
@@ -126,33 +126,33 @@
 				compatible = "marvell,mv64x60-eth";
 				block-index = <1>;
 				interrupts = <33>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@3>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
 
-		sdma@4000 {
+		SDMA0: sdma@4000 {
 			device_type = "dma";
 			compatible = "marvell,mv64x60-sdma";
 			reg = <0x4000 0xc18>;
 			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
 			interrupts = <36>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
-		sdma@6000 {
+		SDMA1: sdma@6000 {
 			device_type = "dma";
 			compatible = "marvell,mv64x60-sdma";
 			reg = <0x6000 0xc18>;
 			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
 			interrupts = <38>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
-		brg@b200 {
+		BRG0: brg@b200 {
 			compatible = "marvell,mv64x60-brg";
 			reg = <0xb200 0x8>;
 			clock-src = <8>;
@@ -161,7 +161,7 @@
 			bcr = <0>;
 		};
 
-		brg@b208 {
+		BRG1: brg@b208 {
 			compatible = "marvell,mv64x60-brg";
 			reg = <0xb208 0x8>;
 			clock-src = <8>;
@@ -170,15 +170,15 @@
 			bcr = <0>;
 		};
 
-		cunit@f200 {
+		CUNIT: cunit@f200 {
 			reg = <0xf200 0x200>;
 		};
 
-		mpscrouting@b400 {
+		MPSCROUTING: mpscrouting@b400 {
 			reg = <0xb400 0xc>;
 		};
 
-		mpscintr@b800 {
+		MPSCINTR: mpscintr@b800 {
 			reg = <0xb800 0x100>;
 			virtual-reg = <0xf100b800>;
 		};
@@ -188,11 +188,11 @@
 			compatible = "marvell,mpsc";
 			reg = <0x8000 0x38>;
 			virtual-reg = <0xf1008000>;
-			sdma = <&/mv64x60/sdma@4000>;
-			brg = <&/mv64x60/brg@b200>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
+			sdma = <&SDMA0>;
+			brg = <&BRG0>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
 			block-index = <0>;
 			max_idle = <40>;
 			chr_1 = <0>;
@@ -200,7 +200,7 @@
 			chr_10 = <3>;
 			mpcr = <0>;
 			interrupts = <40>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
 		mpsc@9000 {
@@ -208,11 +208,11 @@
 			compatible = "marvell,mpsc";
 			reg = <0x9000 0x38>;
 			virtual-reg = <0xf1009000>;
-			sdma = <&/mv64x60/sdma@6000>;
-			brg = <&/mv64x60/brg@b208>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
+			sdma = <&SDMA1>;
+			brg = <&BRG1>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
 			block-index = <1>;
 			max_idle = <40>;
 			chr_1 = <0>;
@@ -220,7 +220,7 @@
 			chr_10 = <3>;
 			mpcr = <0>;
 			interrupts = <42>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
 		wdt@b410 {			/* watchdog timer */
@@ -239,10 +239,10 @@
 			timeout = <1000>;		/* 1000 = 1 second */
 			retries = <1>;
 			interrupts = <37>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
-		pic {
+		PIC: pic {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			compatible = "marvell,mv64x60-pic";
@@ -274,32 +274,32 @@
 			bus-range = <0x0 0xff>;
 			clock-frequency = <66000000>;
 			interrupt-pci-iack = <0x0c34>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 0x0a */
-				0x5000 0 0 1 &/mv64x60/pic 80
-				0x5000 0 0 2 &/mv64x60/pic 81
-				0x5000 0 0 3 &/mv64x60/pic 91
-				0x5000 0 0 4 &/mv64x60/pic 93
+				0x5000 0 0 1 &PIC 80
+				0x5000 0 0 2 &PIC 81
+				0x5000 0 0 3 &PIC 91
+				0x5000 0 0 4 &PIC 93
 
 				/* IDSEL 0x0b */
-				0x5800 0 0 1 &/mv64x60/pic 91
-				0x5800 0 0 2 &/mv64x60/pic 93
-				0x5800 0 0 3 &/mv64x60/pic 80
-				0x5800 0 0 4 &/mv64x60/pic 81
+				0x5800 0 0 1 &PIC 91
+				0x5800 0 0 2 &PIC 93
+				0x5800 0 0 3 &PIC 80
+				0x5800 0 0 4 &PIC 81
 
 				/* IDSEL 0x0c */
-				0x6000 0 0 1 &/mv64x60/pic 91
-				0x6000 0 0 2 &/mv64x60/pic 93
-				0x6000 0 0 3 &/mv64x60/pic 80
-				0x6000 0 0 4 &/mv64x60/pic 81
+				0x6000 0 0 1 &PIC 91
+				0x6000 0 0 2 &PIC 93
+				0x6000 0 0 3 &PIC 80
+				0x6000 0 0 4 &PIC 81
 
 				/* IDSEL 0x0d */
-				0x6800 0 0 1 &/mv64x60/pic 93
-				0x6800 0 0 2 &/mv64x60/pic 80
-				0x6800 0 0 3 &/mv64x60/pic 81
-				0x6800 0 0 4 &/mv64x60/pic 91
+				0x6800 0 0 1 &PIC 93
+				0x6800 0 0 2 &PIC 80
+				0x6800 0 0 3 &PIC 81
+				0x6800 0 0 4 &PIC 91
 			>;
 		};
 
@@ -307,28 +307,28 @@
 			compatible = "marvell,mv64x60-cpu-error";
 			reg = <0x0070 0x10 0x0128 0x28>;
 			interrupts = <3>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
 		sram-ctrl@0380 {
 			compatible = "marvell,mv64x60-sram-ctrl";
 			reg = <0x0380 0x80>;
 			interrupts = <13>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
 		pci-error@1d40 {
 			compatible = "marvell,mv64x60-pci-error";
 			reg = <0x1d40 0x40 0x0c28 0x4>;
 			interrupts = <12>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 
 		mem-ctrl@1400 {
 			compatible = "marvell,mv64x60-mem-ctrl";
 			reg = <0x1400 0x60>;
 			interrupts = <17>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 

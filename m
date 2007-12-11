Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:37:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/8] powerpc: prpmc2800 - Convert dts file to v1
Message-ID: <20071211003738.GB4995@mag.az.mvista.com>
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

Convert the prpmc2800.dts file to dts-v1.  Basically, this means
converting the numeric constants to be 'C'-like (e.g., hexadecimal
numbers start with '0x').

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |  188 +++++++++++++-------------
 1 file changed, 96 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 24944ca..15247a4 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -11,6 +11,8 @@
  * if it can determine the exact PrPMC type.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -25,64 +27,64 @@
 		PowerPC,7447 {
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <2bb0b140>;	/* Default (733 MHz) */
-			bus-frequency = <7f28155>;	/* 133.333333 MHz */
-			timebase-frequency = <1fca055>;	/* 33.333333 MHz */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			clock-frequency = <733333333>;	/* Default */
+			bus-frequency = <133333333>;
+			timebase-frequency = <33333333>;
+			i-cache-line-size = <0x20>;
+			d-cache-line-size = <0x20>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	/* Default (512MB) */
+		reg = <0x00000000 0x20000000>;	/* Default (512MB) */
 	};
 
 	mv64x60@f1000000 { /* Marvell Discovery */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
-		compatible = "marvell,mv64x60";
-		clock-frequency = <7f28155>;		/* 133.333333 MHz */
-		reg = <f1000000 00010000>;
-		virtual-reg = <f1000000>;
-		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
-			  80000000 80000000 08000000	/* PCI 0 MEM Space */
-			  a0000000 a0000000 04000000	/* User FLASH */
-			  00000000 f1000000 00010000	/* Bridge's regs */
-			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
+		compatible = "marvell,mv64360";
+		clock-frequency = <133333333>;
+		reg = <0xf1000000 0x00010000>;
+		virtual-reg = <0xf1000000>;
+		ranges = <0x88000000 0x88000000 0x01000000 /* PCI 0 I/O Space */
+			  0x80000000 0x80000000 0x08000000 /* PCI 0 MEM Space */
+			  0xa0000000 0xa0000000 0x04000000 /* User FLASH */
+			  0x00000000 0xf1000000 0x00010000 /* Bridge's regs */
+			  0xf2000000 0xf2000000 0x00040000>;/* Integrated SRAM*/
 
 		flash@a0000000 {
 			compatible = "cfi-flash";
-			reg = <a0000000 04000000>;
+			reg = <0xa0000000 0x04000000>;
 			bank-width = <4>;
 			device-width = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			fw@0 {
 				label = "FW Image A";
-				reg = <00000000 00100000>;
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
 			cfg@100000 {
 				label = "FW Config Data";	/* RW */
-				reg = <00100000 00040000>;
+				reg = <0x00100000 0x00040000>;
 			};
 			kernel@140000 {
 				label = "Kernel Image";
-				reg = <00140000 00400000>;
+				reg = <0x00140000 0x00400000>;
 				read-only;
 			};
 			fs@540000 {
 				label = "Filesystem";
-				reg = <00540000 039c0000>;
+				reg = <0x00540000 0x039c0000>;
 				read-only;
 			};
 			fw@3f00000 {
 				label = "FW Image B";
-				reg = <03f00000 00100000>;
+				reg = <0x03f00000 0x00100000>;
 				read-only;
 			};
 		};
@@ -95,26 +97,26 @@
 			ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
+				interrupts = <76>;	/* GPP 12 */
 				interrupt-parent = <&/mv64x60/pic>;
 				reg = <1>;
 			};
 			ethernet-phy@3 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
+				interrupts = <76>;	/* GPP 12 */
 				interrupt-parent = <&/mv64x60/pic>;
 				reg = <3>;
 			};
 		};
 
 		ethernet@2000 {
-			reg = <2000 2000>;
+			reg = <0x2000 0x2000>;
 			eth0 {
 				device_type = "network";
 				compatible = "marvell,mv64x60-eth";
 				block-index = <0>;
-				interrupts = <20>;
+				interrupts = <32>;
 				interrupt-parent = <&/mv64x60/pic>;
 				phy = <&/mv64x60/mdio/ethernet-phy@1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
@@ -123,7 +125,7 @@
 				device_type = "network";
 				compatible = "marvell,mv64x60-eth";
 				block-index = <1>;
-				interrupts = <21>;
+				interrupts = <33>;
 				interrupt-parent = <&/mv64x60/pic>;
 				phy = <&/mv64x60/mdio/ethernet-phy@3>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
@@ -133,110 +135,110 @@
 		sdma@4000 {
 			device_type = "dma";
 			compatible = "marvell,mv64x60-sdma";
-			reg = <4000 c18>;
-			virtual-reg = <f1004000>;
+			reg = <0x4000 0xc18>;
+			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
-			interrupts = <24>;
+			interrupts = <36>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		sdma@6000 {
 			device_type = "dma";
 			compatible = "marvell,mv64x60-sdma";
-			reg = <6000 c18>;
-			virtual-reg = <f1006000>;
+			reg = <0x6000 0xc18>;
+			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
-			interrupts = <26>;
+			interrupts = <38>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		brg@b200 {
 			compatible = "marvell,mv64x60-brg";
-			reg = <b200 8>;
+			reg = <0xb200 0x8>;
 			clock-src = <8>;
-			clock-frequency = <7ed6b40>;
-			current-speed = <2580>;
+			clock-frequency = <133000000>;
+			current-speed = <9600>;
 			bcr = <0>;
 		};
 
 		brg@b208 {
 			compatible = "marvell,mv64x60-brg";
-			reg = <b208 8>;
+			reg = <0xb208 0x8>;
 			clock-src = <8>;
-			clock-frequency = <7ed6b40>;
-			current-speed = <2580>;
+			clock-frequency = <133000000>;
+			current-speed = <9600>;
 			bcr = <0>;
 		};
 
 		cunit@f200 {
-			reg = <f200 200>;
+			reg = <0xf200 0x200>;
 		};
 
 		mpscrouting@b400 {
-			reg = <b400 c>;
+			reg = <0xb400 0xc>;
 		};
 
 		mpscintr@b800 {
-			reg = <b800 100>;
-			virtual-reg = <f100b800>;
+			reg = <0xb800 0x100>;
+			virtual-reg = <0xf100b800>;
 		};
 
 		mpsc@8000 {
 			device_type = "serial";
 			compatible = "marvell,mpsc";
-			reg = <8000 38>;
-			virtual-reg = <f1008000>;
+			reg = <0x8000 0x38>;
+			virtual-reg = <0xf1008000>;
 			sdma = <&/mv64x60/sdma@4000>;
 			brg = <&/mv64x60/brg@b200>;
 			cunit = <&/mv64x60/cunit@f200>;
 			mpscrouting = <&/mv64x60/mpscrouting@b400>;
 			mpscintr = <&/mv64x60/mpscintr@b800>;
 			block-index = <0>;
-			max_idle = <28>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <28>;
+			interrupts = <40>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		mpsc@9000 {
 			device_type = "serial";
 			compatible = "marvell,mpsc";
-			reg = <9000 38>;
-			virtual-reg = <f1009000>;
+			reg = <0x9000 0x38>;
+			virtual-reg = <0xf1009000>;
 			sdma = <&/mv64x60/sdma@6000>;
 			brg = <&/mv64x60/brg@b208>;
 			cunit = <&/mv64x60/cunit@f200>;
 			mpscrouting = <&/mv64x60/mpscrouting@b400>;
 			mpscintr = <&/mv64x60/mpscintr@b800>;
 			block-index = <1>;
-			max_idle = <28>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <2a>;
+			interrupts = <42>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		wdt@b410 {			/* watchdog timer */
 			compatible = "marvell,mv64x60-wdt";
-			reg = <b410 8>;
-			timeout = <a>;		/* wdt timeout in seconds */
+			reg = <0xb410 0x8>;
+			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
 			compatible = "marvell,mv64x60-i2c";
-			reg = <c000 20>;
-			virtual-reg = <f100c000>;
+			reg = <0xc000 0x20>;
+			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
 			freq_n = <3>;
-			timeout = <3e8>;		/* 1000 = 1 second */
+			timeout = <1000>;		/* 1000 = 1 second */
 			retries = <1>;
-			interrupts = <25>;
+			interrupts = <37>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
@@ -244,18 +246,18 @@
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			compatible = "marvell,mv64x60-pic";
-			reg = <0000 88>;
+			reg = <0x0000 0x88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
 			compatible = "marvell,mv64x60-mpp";
-			reg = <f000 10>;
+			reg = <0xf000 0x10>;
 		};
 
 		gpp@f100 {
 			compatible = "marvell,mv64x60-gpp";
-			reg = <f100 20>;
+			reg = <0xf100 0x20>;
 		};
 
 		pci@80000000 {
@@ -264,66 +266,68 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			compatible = "marvell,mv64x60-pci";
-			reg = <0cf8 8>;
-			ranges = <01000000 0        0 88000000 0 01000000
-				  02000000 0 80000000 80000000 0 08000000>;
-			bus-range = <0 ff>;
-			clock-frequency = <3EF1480>;
-			interrupt-pci-iack = <0c34>;
+			reg = <0x0cf8 0x8>;
+			ranges = <0x01000000 0x0 0x0
+					0x88000000 0x0 0x01000000
+				  0x02000000 0x0 0x80000000
+					0x80000000 0x0 0x08000000>;
+			bus-range = <0x0 0xff>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0x0c34>;
 			interrupt-parent = <&/mv64x60/pic>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 0x0a */
-				5000 0 0 1 &/mv64x60/pic 50
-				5000 0 0 2 &/mv64x60/pic 51
-				5000 0 0 3 &/mv64x60/pic 5b
-				5000 0 0 4 &/mv64x60/pic 5d
+				0x5000 0 0 1 &/mv64x60/pic 80
+				0x5000 0 0 2 &/mv64x60/pic 81
+				0x5000 0 0 3 &/mv64x60/pic 91
+				0x5000 0 0 4 &/mv64x60/pic 93
 
 				/* IDSEL 0x0b */
-				5800 0 0 1 &/mv64x60/pic 5b
-				5800 0 0 2 &/mv64x60/pic 5d
-				5800 0 0 3 &/mv64x60/pic 50
-				5800 0 0 4 &/mv64x60/pic 51
+				0x5800 0 0 1 &/mv64x60/pic 91
+				0x5800 0 0 2 &/mv64x60/pic 93
+				0x5800 0 0 3 &/mv64x60/pic 80
+				0x5800 0 0 4 &/mv64x60/pic 81
 
 				/* IDSEL 0x0c */
-				6000 0 0 1 &/mv64x60/pic 5b
-				6000 0 0 2 &/mv64x60/pic 5d
-				6000 0 0 3 &/mv64x60/pic 50
-				6000 0 0 4 &/mv64x60/pic 51
+				0x6000 0 0 1 &/mv64x60/pic 91
+				0x6000 0 0 2 &/mv64x60/pic 93
+				0x6000 0 0 3 &/mv64x60/pic 80
+				0x6000 0 0 4 &/mv64x60/pic 81
 
 				/* IDSEL 0x0d */
-				6800 0 0 1 &/mv64x60/pic 5d
-				6800 0 0 2 &/mv64x60/pic 50
-				6800 0 0 3 &/mv64x60/pic 51
-				6800 0 0 4 &/mv64x60/pic 5b
+				0x6800 0 0 1 &/mv64x60/pic 93
+				0x6800 0 0 2 &/mv64x60/pic 80
+				0x6800 0 0 3 &/mv64x60/pic 81
+				0x6800 0 0 4 &/mv64x60/pic 91
 			>;
 		};
 
 		cpu-error@0070 {
 			compatible = "marvell,mv64x60-cpu-error";
-			reg = <0070 10 0128 28>;
-			interrupts = <03>;
+			reg = <0x0070 0x10 0x0128 0x28>;
+			interrupts = <3>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		sram-ctrl@0380 {
 			compatible = "marvell,mv64x60-sram-ctrl";
-			reg = <0380 80>;
-			interrupts = <0d>;
+			reg = <0x0380 0x80>;
+			interrupts = <13>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		pci-error@1d40 {
 			compatible = "marvell,mv64x60-pci-error";
-			reg = <1d40 40 0c28 4>;
-			interrupts = <0c>;
+			reg = <0x1d40 0x40 0x0c28 0x4>;
+			interrupts = <12>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		mem-ctrl@1400 {
 			compatible = "marvell,mv64x60-mem-ctrl";
-			reg = <1400 60>;
-			interrupts = <11>;
+			reg = <0x1400 0x60>;
+			interrupts = <17>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 	};

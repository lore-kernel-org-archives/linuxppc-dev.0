Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4A595DDF3B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:37 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] sbc8560: Convert WRS SBC8560 device tree to v1 format
Date: Mon,  7 Jan 2008 09:25:30 -0500
Message-Id: <11997159361079-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1199715935439-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
	<1199715935439-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <51ce902057aacef795405f501ad482c744a2e1f2.1199715362.git.paul.gortmaker@windriver.com>
In-Reply-To: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch converts the device tree source for the Wind River
SBC8560 board to the new v1 format with C style literals.

You should be using a DTC with these DTC commits:
	91967acabdfbff8b44fd3a19f432bc6e690df8cc
	9138db565adeb2fbba3181fb589f1c9a3f818dde

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8560.dts |  131 +++++++++++++++++++------------------
 1 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 858e8bf..c30744c 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -11,6 +11,7 @@
  * option) any later version.
  */
 
+/dts-v1/;
 
 / {
 	model = "SBC8560";
@@ -35,10 +36,10 @@
 		PowerPC,8560@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
 			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;
 			clock-frequency = <0>;
@@ -47,31 +48,31 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;
+		reg = <0x00000000 0x20000000>;
 	};
 
 	soc@ff700000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 ff700000 00100000>;
-		reg = <ff700000 00100000>;
+		ranges = <0x0 0xff700000 0x00100000>;
+		reg = <0xff700000 0x00100000>;
 		clock-frequency = <0>;
 
 		memory-controller@2000 {
 			compatible = "fsl,8560-memory-controller";
-			reg = <2000 1000>;
+			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
-			interrupts = <12 2>;
+			interrupts = <0x12 0x2>;
 		};
 
 		l2-cache-controller@20000 {
 			compatible = "fsl,8560-l2-cache-controller";
-			reg = <20000 1000>;
-			cache-line-size = <20>;	// 32 bytes
-			cache-size = <40000>;	// L2, 256K
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;	// 32 bytes
+			cache-size = <0x40000>;	// L2, 256K
 			interrupt-parent = <&mpic>;
-			interrupts = <10 2>;
+			interrupts = <0x10 0x2>;
 		};
 
 		i2c@3000 {
@@ -79,8 +80,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <2b 2>;
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -90,8 +91,8 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <2b 2>;
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -100,29 +101,29 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 			phy0: ethernet-phy@19 {
 				interrupt-parent = <&mpic>;
-				interrupts = <6 1>;
-				reg = <19>;
+				interrupts = <0x6 0x1>;
+				reg = <0x19>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1a {
 				interrupt-parent = <&mpic>;
-				interrupts = <7 1>;
-				reg = <1a>;
+				interrupts = <0x7 0x1>;
+				reg = <0x1a>;
 				device_type = "ethernet-phy";
 			};
 			phy2: ethernet-phy@1b {
 				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1b>;
+				interrupts = <0x8 0x1>;
+				reg = <0x1b>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@1c {
 				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1c>;
+				interrupts = <0x8 0x1>;
+				reg = <0x1c>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -132,9 +133,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <1d 2 1e 2 22 2>;
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 		};
@@ -144,9 +145,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 2 24 2 28 2>;
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 		};
@@ -156,7 +157,7 @@
 			#address-cells = <0>;
 			#size-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <40000 40000>;
+			reg = <0x40000 0x40000>;
 			device_type = "open-pic";
 		};
 
@@ -164,17 +165,17 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
-			reg = <919c0 30>;
+			reg = <0x919c0 0x30>;
 			ranges;
 
 			muram@80000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 80000 10000>;
+				ranges = <0x0 0x80000 0x10000>;
 
 				data@0 {
 					compatible = "fsl,cpm-muram-data";
-					reg = <0 4000 9000 2000>;
+					reg = <0x0 0x4000 0x9000 0x2000>;
 				};
 			};
 
@@ -182,17 +183,17 @@
 				compatible = "fsl,mpc8560-brg",
 				             "fsl,cpm2-brg",
 				             "fsl,cpm-brg";
-				reg = <919f0 10 915f0 10>;
-				clock-frequency = <d#165000000>;
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <165000000>;
 			};
 
 			cpmpic: pic@90c00 {
 				interrupt-controller;
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
-				interrupts = <2e 2>;
+				interrupts = <0x2e 0x2>;
 				interrupt-parent = <&mpic>;
-				reg = <90c00 80>;
+				reg = <0x90c00 0x80>;
 				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
 			};
 
@@ -200,10 +201,10 @@
 				device_type = "network";
 				compatible = "fsl,mpc8560-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <91320 20 88500 100 913b0 1>;
+				reg = <0x91320 0x20 0x88500 0x100 0x913b0 0x1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				fsl,cpm-command = <16200300>;
-				interrupts = <21 8>;
+				fsl,cpm-command = <0x16200300>;
+				interrupts = <0x21 0x8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy2>;
 			};
@@ -212,10 +213,10 @@
 				device_type = "network";
 				compatible = "fsl,mpc8560-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-				reg = <91340 20 88600 100 913d0 1>;
+				reg = <0x91340 0x20 0x88600 0x100 0x913d0 0x1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				fsl,cpm-command = <1a400300>;
-				interrupts = <22 8>;
+				fsl,cpm-command = <0x1a400300>;
+				interrupts = <0x22 0x8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy3>;
 			};
@@ -223,7 +224,7 @@
 
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8560-guts";
-			reg = <e0000 1000>;
+			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
 		};
 	};
@@ -235,51 +236,51 @@
 		#address-cells = <3>;
 		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
 		device_type = "pci";
-		reg = <ff708000 1000>;
-		clock-frequency = <3f940aa>;
-		interrupt-map-mask = <f800 0 0 7>;
+		reg = <0xff708000 0x1000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 
-				/* IDSEL 0x02 */
-				1000 0 0 1 &mpic 2 1
-				1000 0 0 2 &mpic 3 1
-				1000 0 0 3 &mpic 4 1
-				1000 0 0 4 &mpic 5 1>;
+			/* IDSEL 0x02 */
+			0x1000 0x0 0x0 0x1 &mpic 0x2 0x1
+			0x1000 0x0 0x0 0x2 &mpic 0x3 0x1
+			0x1000 0x0 0x0 0x3 &mpic 0x4 0x1
+			0x1000 0x0 0x0 0x4 &mpic 0x5 0x1>;
 
 		interrupt-parent = <&mpic>;
-		interrupts = <18 2>;
-		bus-range = <0 0>;
-		ranges = <02000000 0 80000000 80000000 0 20000000
-			  01000000 0 00000000 e2000000 0 01000000>;
+		interrupts = <0x18 0x2>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
 	};
 
 	epld@fc000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "localbus";
-		ranges = <0 fc000000 00c00000>;
+		ranges = <0x0 0xfc000000 0x00c00000>;
 
 		serial0: serial@700000 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <700000 100>;
-			clock-frequency = <1C2000>;
-			interrupts = <9 2>;
+			reg = <0x700000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <0x9 0x2>;
 			interrupt-parent = <&mpic>;
 		};
 
 		serial1: serial@800000 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <800000 100>;
-			clock-frequency = <1C2000>;
-			interrupts = <a 2>;
+			reg = <0x800000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <0xa 0x2>;
 			interrupt-parent = <&mpic>;
 		};
 
 		rtc@900000 {
 			compatible = "m48t59";
-			reg = <900000 2000>;
+			reg = <0x900000 0x2000>;
 		};
 	};
 };
-- 
1.5.0.rc1.gf4b6c

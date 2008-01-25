Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 148F1DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 12:33:17 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0PMV3LT028471
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 15:31:08 -0700 (MST)
Received: from [10.214.72.96] (mvp-10-214-72-96.am.freescale.net
	[10.214.72.96])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0PMV2A5011525
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:31:02 -0600 (CST)
Message-ID: <479A6325.2030500@freescale.com>
Date: Fri, 25 Jan 2008 16:31:01 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Convert all 86xx DTS files to /dts-v1/ format.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Also fixed a few minor indent problems as well.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |  227 +++++++++++-----------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |  333 ++++++++++++++++----------------
 2 files changed, 281 insertions(+), 279 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index d98715c..16c947b 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -8,6 +8,7 @@
  * by the Free Software Foundation.
  */
 
+/dts-v1/;
 
 / {
 	model = "MPC8610HPCD";
@@ -29,11 +30,11 @@
 		PowerPC,8610@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <d# 32>;	// bytes
-			i-cache-line-size = <d# 32>;	// bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;		// L1
+			i-cache-size = <32768>;		// L1
+			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 		};
@@ -41,7 +42,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	// 512M at 0x0
+		reg = <0x00000000 0x20000000>;	// 512M at 0x0
 	};
 
 	soc@e0000000 {
@@ -50,8 +51,8 @@
 		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "fsl,mpc8610-immr", "simple-bus";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 1000>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
 		i2c@3000 {
@@ -59,17 +60,17 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <2b 2>;
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
-                        cs4270:codec@4f {
+			cs4270:codec@4f {
 				compatible = "cirrus,cs4270";
-                                reg = <4f>;
+				reg = <0x4f>;
 				/* MCLK source is a stand-alone oscillator */
-				clock-frequency = <bb8000>;
-                        };
+				clock-frequency = <12288000>;
+			};
 		};
 
 		i2c@3100 {
@@ -77,8 +78,8 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <2b 2>;
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -87,9 +88,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <2a 2>;
+			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -97,9 +98,9 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <1c 2>;
+			interrupts = <28 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -108,7 +109,7 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <40000 40000>;
+			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
@@ -116,16 +117,16 @@
 
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8610-guts";
-			reg = <e0000 1000>;
+			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
 		};
 
 		i2s@16000 {
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <0>;
-			reg = <16000 100>;
+			reg = <0x16000 0x100>;
 			interrupt-parent = <&mpic>;
-			interrupts = <3e 2>;
+			interrupts = <62 2>;
 			fsl,mode = "i2s-slave";
 			codec-handle = <&cs4270>;
 		};
@@ -133,94 +134,94 @@
 		ssi@16100 {
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <1>;
-			reg = <16100 100>;
+			reg = <0x16100 0x100>;
 			interrupt-parent = <&mpic>;
-			interrupts = <3f 2>;
+			interrupts = <63 2>;
 		};
 
-                dma@21300 {
-                        #address-cells = <1>;
-                        #size-cells = <1>;
-                        compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
-                        cell-index = <0>;
-                        reg = <21300 4>; /* DMA general status register */
-                        ranges = <0 21100 200>;
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
+			cell-index = <0>;
+			reg = <0x21300 0x4>; /* DMA general status register */
+			ranges = <0x0 0x21100 0x200>;
 
-                        dma-channel@0 {
+			dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <0>;
-				reg = <0 80>;
+				reg = <0x0 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <14 2>;
-                        };
-                        dma-channel@1 {
+				interrupts = <20 2>;
+			};
+			dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <1>;
-				reg = <80 80>;
+				reg = <0x80 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <15 2>;
-                        };
-                        dma-channel@2 {
+				interrupts = <21 2>;
+			};
+			dma-channel@2 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <2>;
-				reg = <100 80>;
+				reg = <0x100 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <16 2>;
-                        };
-                        dma-channel@3 {
+				interrupts = <22 2>;
+			};
+			dma-channel@3 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,eloplus-dma-channel";
 				cell-index = <3>;
-				reg = <180 80>;
+				reg = <0x180 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <17 2>;
-                        };
-                };
+				interrupts = <23 2>;
+			};
+		};
 
-                dma@c300 {
-                        #address-cells = <1>;
-                        #size-cells = <1>;
-                        compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
-                        cell-index = <1>;
-                        reg = <c300 4>; /* DMA general status register */
-                        ranges = <0 c100 200>;
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
+			cell-index = <1>;
+			reg = <0xc300 0x4>; /* DMA general status register */
+			ranges = <0x0 0xc100 0x200>;
 
-                        dma-channel@0 {
+			dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,mpc8540-dma-channel";
 				cell-index = <0>;
-				reg = <0 80>;
+				reg = <0x0 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <3c 2>;
-                        };
-                        dma-channel@1 {
+				interrupts = <60 2>;
+			};
+			dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,mpc8540-dma-channel";
 				cell-index = <1>;
-				reg = <80 80>;
+				reg = <0x80 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <3d 2>;
-                        };
-                        dma-channel@2 {
+				interrupts = <61 2>;
+			};
+			dma-channel@2 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,mpc8540-dma-channel";
 				cell-index = <2>;
-				reg = <100 80>;
+				reg = <0x100 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <3e 2>;
-                        };
-                        dma-channel@3 {
+				interrupts = <62 2>;
+			};
+			dma-channel@3 {
 				compatible = "fsl,mpc8610-dma-channel",
 					"fsl,mpc8540-dma-channel";
 				cell-index = <3>;
-				reg = <180 80>;
+				reg = <0x180 0x80>;
 				interrupt-parent = <&mpic>;
-				interrupts = <3f 2>;
-                        };
-                };
+				interrupts = <63 2>;
+			};
+		};
 
 	};
 
@@ -231,26 +232,26 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008000 1000>;
+		reg = <0xe0008000 0x1000>;
 		bus-range = <0 0>;
-		ranges = <02000000 0 80000000 80000000 0 10000000
-			  01000000 0 00000000 e1000000 0 00100000>;
-		clock-frequency = <1fca055>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe1000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <18 2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 */
-			8800 0 0 1 &mpic 4 1
-			8800 0 0 2 &mpic 5 1
-			8800 0 0 3 &mpic 6 1
-			8800 0 0 4 &mpic 7 1
+			0x8800 0 0 1 &mpic 4 1
+			0x8800 0 0 2 &mpic 5 1
+			0x8800 0 0 3 &mpic 6 1
+			0x8800 0 0 4 &mpic 7 1
 
 			/* IDSEL 0x12 */
-			9000 0 0 1 &mpic 5 1
-			9000 0 0 2 &mpic 6 1
-			9000 0 0 3 &mpic 7 1
-			9000 0 0 4 &mpic 4 1
+			0x9000 0 0 1 &mpic 5 1
+			0x9000 0 0 2 &mpic 6 1
+			0x9000 0 0 3 &mpic 7 1
+			0x9000 0 0 4 &mpic 4 1
 			>;
 	};
 
@@ -261,28 +262,28 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e000a000 1000>;
+		reg = <0xe000a000 0x1000>;
 		bus-range = <1 3>;
-		ranges = <02000000 0 a0000000 a0000000 0 10000000
-			  01000000 0 00000000 e3000000 0 00100000>;
-		clock-frequency = <1fca055>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <1a 2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupts = <26 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
 
 		interrupt-map = <
 			/* IDSEL 0x1b */
-			d800 0 0 1 &mpic 2 1
+			0xd800 0 0 1 &mpic 2 1
 
 			/* IDSEL 0x1c*/
-			e000 0 0 1 &mpic 1 1
-			e000 0 0 2 &mpic 1 1
-			e000 0 0 3 &mpic 1 1
-			e000 0 0 4 &mpic 1 1
+			0xe000 0 0 1 &mpic 1 1
+			0xe000 0 0 2 &mpic 1 1
+			0xe000 0 0 3 &mpic 1 1
+			0xe000 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x1f */
-			f800 0 0 1 &mpic 3 0
-			f800 0 0 2 &mpic 0 1
+			0xf800 0 0 1 &mpic 3 0
+			0xf800 0 0 2 &mpic 0 1
 		>;
 
 		pcie@0 {
@@ -290,22 +291,22 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <02000000 0 a0000000
-				  02000000 0 a0000000
-				  0 10000000
-				  01000000 0 00000000
-				  01000000 0 00000000
-				  0 00100000>;
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x10000000
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00100000>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
 				#address-cells = <3>;
-				ranges = <02000000 0 a0000000
-					  02000000 0 a0000000
-					  0 10000000
-					  01000000 0 00000000
-					  01000000 0 00000000
-					  0 00100000>;
+				ranges = <0x02000000 0x0 0xa0000000
+					  0x02000000 0x0 0xa0000000
+					  0x0 0x10000000
+					  0x01000000 0x0 0x00000000
+					  0x01000000 0x0 0x00000000
+					  0x0 0x00100000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 556a9ca..79385bc 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -9,6 +9,7 @@
  * option) any later version.
  */
 
+/dts-v1/;
 
 / {
 	model = "MPC8641HPCN";
@@ -34,22 +35,22 @@
 		PowerPC,8641@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;		// L1
+			i-cache-size = <32768>;		// L1
+			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 		};
 		PowerPC,8641@1 {
 			device_type = "cpu";
 			reg = <1>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <8000>;		// L1, 32K
-			i-cache-size = <8000>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
 		};
@@ -57,45 +58,45 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 40000000>;	// 1G at 0x0
+		reg = <0x00000000 0x40000000>;	// 1G at 0x0
 	};
 
 	localbus@f8005000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <f8005000 1000>;
-		interrupts = <13 2>;
+		reg = <0xf8005000 0x1000>;
+		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
-		ranges = <0 0 ff800000 00800000
-			  1 0 fe000000 01000000
-			  2 0 f8200000 00100000
-			  3 0 f8100000 00100000>;
+		ranges = <0 0 0xff800000 0x00800000
+			  1 0 0xfe000000 0x01000000
+			  2 0 0xf8200000 0x00100000
+			  3 0 0xf8100000 0x00100000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
-			reg = <0 0 00800000>;
+			reg = <0 0 0x00800000>;
 			bank-width = <2>;
 			device-width = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			partition@0 {
 				label = "kernel";
-				reg = <00000000 00300000>;
+				reg = <0x00000000 0x00300000>;
 			};
 			partition@300000 {
 				label = "firmware b";
-				reg = <00300000 00100000>;
+				reg = <0x00300000 0x00100000>;
 				read-only;
 			};
 			partition@400000 {
 				label = "fs";
-				reg = <00400000 00300000>;
+				reg = <0x00400000 0x00300000>;
 			};
 			partition@700000 {
 				label = "firmware a";
-				reg = <00700000 00100000>;
+				reg = <0x00700000 0x00100000>;
 				read-only;
 			};
 		};
@@ -106,8 +107,8 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		compatible = "simple-bus";
-		ranges = <00000000 f8000000 00100000>;
-		reg = <f8000000 00001000>;	// CCSRBAR
+		ranges = <0x00000000 0xf8000000 0x00100000>;
+		reg = <0xf8000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
 		i2c@3000 {
@@ -115,8 +116,8 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <2b 2>;
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -126,8 +127,8 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <2b 2>;
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
 		};
@@ -136,29 +137,29 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
-				interrupts = <a 1>;
+				interrupts = <10 1>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
 				interrupt-parent = <&mpic>;
-				interrupts = <a 1>;
+				interrupts = <10 1>;
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
 			phy2: ethernet-phy@2 {
 				interrupt-parent = <&mpic>;
-				interrupts = <a 1>;
+				interrupts = <10 1>;
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 			phy3: ethernet-phy@3 {
 				interrupt-parent = <&mpic>;
-				interrupts = <a 1>;
+				interrupts = <10 1>;
 				reg = <3>;
 				device_type = "ethernet-phy";
 			};
@@ -169,9 +170,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <1d 2 1e 2 22 2>;
+			interrupts = <29 2 30  2 34 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
@@ -182,9 +183,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 2 24 2 28 2>;
+			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
@@ -195,9 +196,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <26000 1000>;
+			reg = <0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <1F 2 20 2 21 2>;
+			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
@@ -208,9 +209,9 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <27000 1000>;
+			reg = <0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <25 2 26 2 27 2>;
+			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
@@ -220,9 +221,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
-			interrupts = <2a 2>;
+			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -230,9 +231,9 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <1c 2>;
+			interrupts = <28 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -241,7 +242,7 @@
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <40000 40000>;
+			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
@@ -249,7 +250,7 @@
 
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8641-guts";
-			reg = <e0000 1000>;
+			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
 		};
 	};
@@ -261,127 +262,127 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <f8008000 1000>;
-		bus-range = <0 ff>;
-		ranges = <02000000 0 80000000 80000000 0 20000000
-			  01000000 0 00000000 e2000000 0 00100000>;
-		clock-frequency = <1fca055>;
+		reg = <0xf8008000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <18 2>;
-		interrupt-map-mask = <ff00 0 0 7>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			8800 0 0 1 &mpic 2 1
-			8800 0 0 2 &mpic 3 1
-			8800 0 0 3 &mpic 4 1
-			8800 0 0 4 &mpic 1 1
+			0x8800 0 0 1 &mpic 2 1
+			0x8800 0 0 2 &mpic 3 1
+			0x8800 0 0 3 &mpic 4 1
+			0x8800 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			8900 0 0 1 &mpic 2 1
-			8900 0 0 2 &mpic 3 1
-			8900 0 0 3 &mpic 4 1
-			8900 0 0 4 &mpic 1 1
+			0x8900 0 0 1 &mpic 2 1
+			0x8900 0 0 2 &mpic 3 1
+			0x8900 0 0 3 &mpic 4 1
+			0x8900 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			8a00 0 0 1 &mpic 2 1
-			8a00 0 0 2 &mpic 3 1
-			8a00 0 0 3 &mpic 4 1
-			8a00 0 0 4 &mpic 1 1
+			0x8a00 0 0 1 &mpic 2 1
+			0x8a00 0 0 2 &mpic 3 1
+			0x8a00 0 0 3 &mpic 4 1
+			0x8a00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			8b00 0 0 1 &mpic 2 1
-			8b00 0 0 2 &mpic 3 1
-			8b00 0 0 3 &mpic 4 1
-			8b00 0 0 4 &mpic 1 1
+			0x8b00 0 0 1 &mpic 2 1
+			0x8b00 0 0 2 &mpic 3 1
+			0x8b00 0 0 3 &mpic 4 1
+			0x8b00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			8c00 0 0 1 &mpic 2 1
-			8c00 0 0 2 &mpic 3 1
-			8c00 0 0 3 &mpic 4 1
-			8c00 0 0 4 &mpic 1 1
+			0x8c00 0 0 1 &mpic 2 1
+			0x8c00 0 0 2 &mpic 3 1
+			0x8c00 0 0 3 &mpic 4 1
+			0x8c00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			8d00 0 0 1 &mpic 2 1
-			8d00 0 0 2 &mpic 3 1
-			8d00 0 0 3 &mpic 4 1
-			8d00 0 0 4 &mpic 1 1
+			0x8d00 0 0 1 &mpic 2 1
+			0x8d00 0 0 2 &mpic 3 1
+			0x8d00 0 0 3 &mpic 4 1
+			0x8d00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			8e00 0 0 1 &mpic 2 1
-			8e00 0 0 2 &mpic 3 1
-			8e00 0 0 3 &mpic 4 1
-			8e00 0 0 4 &mpic 1 1
+			0x8e00 0 0 1 &mpic 2 1
+			0x8e00 0 0 2 &mpic 3 1
+			0x8e00 0 0 3 &mpic 4 1
+			0x8e00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			8f00 0 0 1 &mpic 2 1
-			8f00 0 0 2 &mpic 3 1
-			8f00 0 0 3 &mpic 4 1
-			8f00 0 0 4 &mpic 1 1
+			0x8f00 0 0 1 &mpic 2 1
+			0x8f00 0 0 2 &mpic 3 1
+			0x8f00 0 0 3 &mpic 4 1
+			0x8f00 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			9000 0 0 1 &mpic 3 1
-			9000 0 0 2 &mpic 4 1
-			9000 0 0 3 &mpic 1 1
-			9000 0 0 4 &mpic 2 1
+			0x9000 0 0 1 &mpic 3 1
+			0x9000 0 0 2 &mpic 4 1
+			0x9000 0 0 3 &mpic 1 1
+			0x9000 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			9100 0 0 1 &mpic 3 1
-			9100 0 0 2 &mpic 4 1
-			9100 0 0 3 &mpic 1 1
-			9100 0 0 4 &mpic 2 1
+			0x9100 0 0 1 &mpic 3 1
+			0x9100 0 0 2 &mpic 4 1
+			0x9100 0 0 3 &mpic 1 1
+			0x9100 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			9200 0 0 1 &mpic 3 1
-			9200 0 0 2 &mpic 4 1
-			9200 0 0 3 &mpic 1 1
-			9200 0 0 4 &mpic 2 1
+			0x9200 0 0 1 &mpic 3 1
+			0x9200 0 0 2 &mpic 4 1
+			0x9200 0 0 3 &mpic 1 1
+			0x9200 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			9300 0 0 1 &mpic 3 1
-			9300 0 0 2 &mpic 4 1
-			9300 0 0 3 &mpic 1 1
-			9300 0 0 4 &mpic 2 1
+			0x9300 0 0 1 &mpic 3 1
+			0x9300 0 0 2 &mpic 4 1
+			0x9300 0 0 3 &mpic 1 1
+			0x9300 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			9400 0 0 1 &mpic 3 1
-			9400 0 0 2 &mpic 4 1
-			9400 0 0 3 &mpic 1 1
-			9400 0 0 4 &mpic 2 1
+			0x9400 0 0 1 &mpic 3 1
+			0x9400 0 0 2 &mpic 4 1
+			0x9400 0 0 3 &mpic 1 1
+			0x9400 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			9500 0 0 1 &mpic 3 1
-			9500 0 0 2 &mpic 4 1
-			9500 0 0 3 &mpic 1 1
-			9500 0 0 4 &mpic 2 1
+			0x9500 0 0 1 &mpic 3 1
+			0x9500 0 0 2 &mpic 4 1
+			0x9500 0 0 3 &mpic 1 1
+			0x9500 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			9600 0 0 1 &mpic 3 1
-			9600 0 0 2 &mpic 4 1
-			9600 0 0 3 &mpic 1 1
-			9600 0 0 4 &mpic 2 1
+			0x9600 0 0 1 &mpic 3 1
+			0x9600 0 0 2 &mpic 4 1
+			0x9600 0 0 3 &mpic 1 1
+			0x9600 0 0 4 &mpic 2 1
 
 			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			9700 0 0 1 &mpic 3 1
-			9700 0 0 2 &mpic 4 1
-			9700 0 0 3 &mpic 1 1
-			9700 0 0 4 &mpic 2 1
+			0x9700 0 0 1 &mpic 3 1
+			0x9700 0 0 2 &mpic 4 1
+			0x9700 0 0 3 &mpic 1 1
+			0x9700 0 0 4 &mpic 2 1
 
 			// IDSEL 0x1c  USB
-			e000 0 0 1 &i8259 c 2
-			e100 0 0 2 &i8259 9 2
-			e200 0 0 3 &i8259 a 2
-			e300 0 0 4 &i8259 b 2
+			0xe000 0 0 1 &i8259 12 2
+			0xe100 0 0 2 &i8259 9 2
+			0xe200 0 0 3 &i8259 10 2
+			0xe300 0 0 4 &i8259 112
 
 			// IDSEL 0x1d  Audio
-			e800 0 0 1 &i8259 6 2
+			0xe800 0 0 1 &i8259 6 2
 
 			// IDSEL 0x1e Legacy
-			f000 0 0 1 &i8259 7 2
-			f100 0 0 1 &i8259 7 2
+			0xf000 0 0 1 &i8259 7 2
+			0xf100 0 0 1 &i8259 7 2
 
 			// IDSEL 0x1f IDE/SATA
-			f800 0 0 1 &i8259 e 2
-			f900 0 0 1 &i8259 5 2
+			0xf800 0 0 1 &i8259 14 2
+			0xf900 0 0 1 &i8259 5 2
 			>;
 
 		pcie@0 {
@@ -389,37 +390,37 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <02000000 0 80000000
-				  02000000 0 80000000
-				  0 20000000
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x20000000
 
-				  01000000 0 00000000
-				  01000000 0 00000000
-				  0 00100000>;
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00100000>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
 				#address-cells = <3>;
-				ranges = <02000000 0 80000000
-					  02000000 0 80000000
-					  0 20000000
-					  01000000 0 00000000
-					  01000000 0 00000000
-					  0 00100000>;
+				ranges = <0x02000000 0x0 0x80000000
+					  0x02000000 0x0 0x80000000
+					  0x0 0x20000000
+					  0x01000000 0x0 0x00000000
+					  0x01000000 0x0 0x00000000
+					  0x0 0x00100000>;
 				isa@1e {
 					device_type = "isa";
 					#interrupt-cells = <2>;
 					#size-cells = <1>;
 					#address-cells = <2>;
-					reg = <f000 0 0 0 0>;
-					ranges = <1 0 01000000 0 0
-						  00001000>;
+					reg = <0xf000 0 0 0 0>;
+					ranges = <1 0 0x01000000 0 0
+						  0x00001000>;
 					interrupt-parent = <&i8259>;
 
 					i8259: interrupt-controller@20 {
-						reg = <1 20 2
-						       1 a0 2
-						       1 4d0 2>;
+						reg = <1 0x20 2
+						       1 0xa0 2
+						       1 0x4d0 2>;
 						interrupt-controller;
 						device_type = "interrupt-controller";
 						#address-cells = <0>;
@@ -432,8 +433,8 @@
 					i8042@60 {
 						#size-cells = <0>;
 						#address-cells = <1>;
-						reg = <1 60 1 1 64 1>;
-						interrupts = <1 3 c 3>;
+						reg = <1 0x60 1 1 0x64 1>;
+						interrupts = <1 3 12 3>;
 						interrupt-parent =
 							<&i8259>;
 
@@ -451,11 +452,11 @@
 					rtc@70 {
 						compatible =
 							"pnpPNP,b00";
-						reg = <1 70 2>;
+						reg = <1 0x70 2>;
 					};
 
 					gpio@400 {
-						reg = <1 400 80>;
+						reg = <1 0x400 0x80>;
 					};
 				};
 			};
@@ -470,33 +471,33 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <f8009000 1000>;
-		bus-range = <0 ff>;
-		ranges = <02000000 0 a0000000 a0000000 0 20000000
-			  01000000 0 00000000 e3000000 0 00100000>;
-		clock-frequency = <1fca055>;
+		reg = <0xf8009000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
-		interrupts = <19 2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-			0000 0 0 1 &mpic 4 1
-			0000 0 0 2 &mpic 5 1
-			0000 0 0 3 &mpic 6 1
-			0000 0 0 4 &mpic 7 1
+			0x0000 0 0 1 &mpic 4 1
+			0x0000 0 0 2 &mpic 5 1
+			0x0000 0 0 3 &mpic 6 1
+			0x0000 0 0 4 &mpic 7 1
 			>;
 		pcie@0 {
 			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <02000000 0 a0000000
-				  02000000 0 a0000000
-				  0 20000000
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x20000000
 
-				  01000000 0 00000000
-				  01000000 0 00000000
-				  0 00100000>;
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00100000>;
 		};
 	};
 };
-- 
1.5.2.1.126.g6abd0

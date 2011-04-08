Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: P2020 DTS: re-organize dts files
Date: Fri, 8 Apr 2011 17:57:05 +0530
Message-ID: <1302265625-10131-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Creates P2020si.dtsi, containing information for P2020 SoC. Modifies dts files
for P2020 based systems to use dtsi file.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 Please see mpc5200b.dtsi for reference.
 
 Tested on P2020RDB and P2020DS

 arch/powerpc/boot/dts/p2020ds.dts             |  374 ++----------------------
 arch/powerpc/boot/dts/p2020rdb.dts            |  362 ++---------------------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |  237 +++-------------
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  142 ++++++----
 arch/powerpc/boot/dts/p2020si.dtsi            |  382 +++++++++++++++++++++++++
 5 files changed, 564 insertions(+), 933 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p2020si.dtsi

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 1101914..2bcf368 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -1,7 +1,7 @@
 /*
  * P2020 DS Device Tree Source
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -9,12 +9,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "p2020si.dtsi"
+
 / {
-	model = "fsl,P2020";
+	model = "fsl,P2020DS";
 	compatible = "fsl,P2020DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -27,35 +26,13 @@
 		pci2 = &pci2;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P2020@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,P2020@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
-	};
 
 	memory {
 		device_type = "memory";
 	};
 
 	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
 		compatible = "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
 		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
 			  0x1 0x0 0x0 0xe0000000 0x08000000
 			  0x2 0x0 0x0 0xffa00000 0x00040000
@@ -158,352 +135,77 @@
 	};
 
 	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p2020-immr", "simple-bus";
-		ranges = <0x0 0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p2020-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p2020-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		spi@7000 {
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
+		usb@22000 {
+			phy_type = "ulpi";
 		};
 
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <1>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
+				interrupts = <3 1>;
+				reg = <0x0>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
+			phy1: ethernet-phy@1 {
 				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
+				interrupts = <3 1>;
+				reg = <0x1>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
+			phy2: ethernet-phy@2 {
 				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
+				interrupts = <3 1>;
+				reg = <0x2>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
-		};
 
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
 		};
 
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p2020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>; // L2, 512k
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
 
-		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
-			phy_type = "ulpi";
 		};
 
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <3 1>;
-					reg = <0x0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <3 1>;
-					reg = <0x1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <3 1>;
-					reg = <0x2>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xbfe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
 
 		msi@41600 {
 			compatible = "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p2020-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
 		};
 	};
 
 	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe08000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
@@ -528,18 +230,8 @@
 	};
 
 	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
 		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
 		interrupt-map = <
 
@@ -667,18 +359,8 @@
 	};
 
 	pci2: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index e2d48fd..60a0a8c 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -9,12 +9,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "p2020si.dtsi"
+
 / {
-	model = "fsl,P2020";
+	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		ethernet0 = &enet0;
@@ -26,34 +25,11 @@
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P2020@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
-		};
-
-		PowerPC,P2020@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
-		};
-	};
-
 	memory {
 		device_type = "memory";
 	};
 
 	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		/* NOR and NAND Flashes */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
@@ -165,90 +141,16 @@
 	};
 
 	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p2020-immr", "simple-bus";
-		ranges = <0x0  0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p2020-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p2020-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
-
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
+	spi@7000 {
 
-		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			mode = "cpu";
-
-			fsl_m25p80@0 {
+		fsl_m25p80@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,espi-flash";
@@ -294,254 +196,60 @@
 			};
 		};
 
-		dma@c300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0xc300 0x4>;
-			ranges = <0x0 0xc100 0x200>;
-			cell-index = <1>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <76 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <77 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <78 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <79 2>;
-			};
-		};
-
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p2020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>; // L2,512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+		usb@22000 {
+			phy_type = "ulpi";
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
+				interrupts = <3 1>;
+				reg = <0x0>;
+				};
+			phy1: ethernet-phy@1 {
 				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+				interrupts = <3 1>;
+				reg = <0x1>;
+				};
+		};
+
+		mdio@25520 {
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
-		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
-			phy_type = "ulpi";
+		mdio@26520 {
+			status = "disabled";
 		};
 
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <3 1>;
-					reg = <0x0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <3 1>;
-					reg = <0x1>;
-				};
-			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "sgmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 		};
 
-		sdhci@2e000 {
-			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xbfe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,p2020-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
+	};
 
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p2020-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
+	pci0: pcie@ffe08000 {
+		status = "disabled";
 	};
 
-	pci0: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
+	pci1: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		pcie@0 {
+			pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
@@ -556,19 +264,9 @@
 		};
 	};
 
-	pci1: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
+	pci2: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index b69c3a5..72c912f 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -14,12 +14,11 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "p2020si.dtsi"
+
 / {
-	model = "fsl,P2020";
+	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		ethernet1 = &enet1;
@@ -29,91 +28,33 @@
 	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P2020@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			next-level-cache = <&L2>;
+		PowerPC,P2020@1 {
+		status = "disabled";
 		};
+
 	};
 
 	memory {
 		device_type = "memory";
 	};
 
-	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p2020-immr", "simple-bus";
-		ranges = <0x0  0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <12>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,p2020-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p2020-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-		};
+	localbus@ffe05000 {
+		status = "disabled";
+	};
 
+	soc@ffe00000 {
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
+		serial1: serial@4600 {
+			status = "disabled";
 		};
 
 		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2>;
-			interrupt-parent = <&mpic>;
-			mode = "cpu";
 
 			fsl_m25p80@0 {
 				#address-cells = <1>;
@@ -161,76 +102,15 @@
 			};
 		};
 
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2>;
-			interrupt-parent = <&mpic>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p2020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>; // L2,512K
-			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
+		dma@c300 {
+			status = "disabled";
 		};
 
 		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <28 0x2>;
 			phy_type = "ulpi";
 		};
 
 		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
 
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
@@ -245,29 +125,21 @@
 		};
 
 		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
 			tbi0: tbi-phy@11 {
 				reg = <0x11>;
 				device_type = "tbi-phy";
 			};
 		};
 
+		mdio@26520 {
+			status = "disabled";
+		};
+
+		enet0: ethernet@24000 {
+			status = "disabled";
+		};
+
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "sgmii";
@@ -275,49 +147,12 @@
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 		};
 
-		sdhci@2e000 {
-			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2>;
-			interrupt-parent = <&mpic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 58 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xbfe>;
-			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
 
 		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
 			protected-sources = <
 			42 76 77 78 79 /* serial1 , dma2 */
 			29 30 34 26 /* enet0, pci1 */
@@ -326,26 +161,20 @@
 			>;
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,p2020-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		msi@41600 {
+			status = "disabled";
 		};
+
+
 	};
 
-	pci0: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
+	pci0: pcie@ffe08000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
@@ -360,4 +189,8 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	pci2: pcie@ffe0a000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
index 7a31d46c..eb572cc 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
@@ -15,27 +15,21 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "p2020si.dtsi"
+
 / {
-	model = "fsl,P2020";
+	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		ethernet0 = &enet0;
-		serial0 = &serial0;
+		serial0 = &serial1;
 		pci1 = &pci1;
 	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,P2020@1 {
-			device_type = "cpu";
-			reg = <0x1>;
-			next-level-cache = <&L2>;
+		PowerPC,P2020@0 {
+		status = "disabled";
 		};
 	};
 
@@ -43,20 +37,37 @@
 		device_type = "memory";
 	};
 
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
 	soc@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,p2020-immr", "simple-bus";
-		ranges = <0x0  0x0 0xffe00000 0x100000>;
-		bus-frequency = <0>;		// Filled out by uboot.
-
-		serial0: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
+		ecm-law@0 {
+			status = "disabled";
+		};
+
+		ecm@1000 {
+			status = "disabled";
+		};
+
+		memory-controller@2000 {
+			status = "disabled";
+		};
+
+		i2c@3000 {
+			status = "disabled";
+		};
+
+		i2c@3100 {
+			status = "disabled";
+		};
+
+		serial0: serial@4500 {
+			status = "disabled";
+		};
+
+		spi@7000 {
+			status = "disabled";
 		};
 
 		dma@c300 {
@@ -96,6 +107,10 @@
 			};
 		};
 
+		gpio: gpio-controller@f000 {
+			status = "disabled";
+		};
+
 		L2: l2-cache-controller@20000 {
 			compatible = "fsl,p2020-l2-cache-controller";
 			reg = <0x20000 0x1000>;
@@ -104,31 +119,49 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		dma@21300 {
+			status = "disabled";
+		};
+
+		usb@22000 {
+			status = "disabled";
+		};
+
+		mdio@24520 {
+			status = "disabled";
+		};
+
+		mdio@25520 {
+			status = "disabled";
+		};
+
+		mdio@26520 {
+			status = "disabled";
+		};
 
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
 
 		};
 
+		enet1: ethernet@25000 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@26000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		crypto@30000 {
+			status = "disabled";
+		};
+
 		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
 			protected-sources = <
 			17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
 			16 20 21 22 23 28 	/* L2, dma1, USB */
@@ -152,21 +185,24 @@
 				0xe7 0>;
 			interrupt-parent = <&mpic>;
 		};
+
+		global-utilities@e0000 {	//global utilities block
+			status = "disabled";
+		};
+
+	};
+
+	pci0: pcie@ffe08000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe09000 {
+		status = "disabled";
 	};
 
-	pci1: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
+	pci2: pcie@ffe0a000 {
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <26 2>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
 			#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/p2020si.dtsi b/arch/powerpc/boot/dts/p2020si.dtsi
new file mode 100644
index 0000000..6def17f
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020si.dtsi
@@ -0,0 +1,382 @@
+/*
+ * P2020 Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	compatible = "fsl,P2020";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P2020@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P2020@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	localbus@ffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xffe05000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+	};
+
+	soc@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,p2020-immr", "simple-bus";
+		ranges = <0x0  0x0 0xffe00000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,p2020-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,p2020-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		spi@7000 {
+			cell-index = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			mode = "cpu";
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		gpio: gpio-controller@f000 {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x100>;
+			interrupts = <47 0x2>;
+			interrupt-parent = <&mpic>;
+			gpio-controller;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,p2020-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x80000>; // L2,512K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		usb@22000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-usb2-dr";
+			reg = <0x22000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <28 0x2>;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+		};
+
+		mdio@25520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-tbi";
+			reg = <0x26520 0x20>;
+		};
+
+		mdio@26520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-tbi";
+			reg = <0x520 0x20>;
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+
+		};
+
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+
+		};
+
+		sdhci@2e000 {
+			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
+				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xbfe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi@41600 {
+			compatible = "fsl,p2020-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,p2020-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@ffe08000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe08000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+	};
+
+	pci1: pcie@ffe09000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe09000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+	};
+
+	pci2: pcie@ffe0a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe0a000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+	};
+};
-- 
1.7.3

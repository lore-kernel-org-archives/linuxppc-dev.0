Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02CE0B72B8
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:58 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7GsT9026824
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:55 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 24/29] powerpc/85xx: Rework P2020RDB device tree
Date: Thu, 17 Nov 2011 01:16:16 -0600
Message-Id: <1321514181-28897-24-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-23-git-send-email-galak@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-3-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-4-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-5-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-6-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-7-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-8-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-9-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-10-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-11-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-12-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-13-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-14-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-15-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-16-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-17-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-18-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-19-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-20-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-21-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-22-git-send-email-galak@kernel.crashing.org>
 <1321514181-28897-23-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Utilize new split between board & SoC, and new SoC device trees split
into pre & post utilizing 'template' includes for SoC IP blocks.

Other changes include:

* Moved to specifying interrupt-parent for mpic at root
* Moved to 4-cell mpic interrupt cells to support MPIC timers
* Reworked PCIe nodes to allow supportin IRQs for controller (errors) and
  moved PCI device IRQs down to virtual bridge level
* Updated spi node to new espi binding specification
* Renamed 'sdhci' node to 'sdhc'
* Changed GPIO compatiable from 'fsl,mpc8572-gpio' to 'fsl,pq3-gpio' as the
 'mpc8572' compatiable is to deal with a 'mpc8572' specific to an erratum
* Fixed wrong reg offsets for mdio nodes associated with etsec2 &
* etsec3
* Dropping "fsl,p2020-IP..." from compatibles for standard blocks

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p2020rdb.dts            |   63 ++---
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |  141 +----------
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  107 +--------
 arch/powerpc/boot/dts/p2020si.dtsi            |  355 -------------------------
 4 files changed, 22 insertions(+), 644 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/p2020si.dtsi

diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 1d7a05f..fd42712 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/include/ "p2020si.dtsi"
+/include/ "fsl/p2020si-pre.dtsi"
 
 / {
 	model = "fsl,P2020RDB";
@@ -29,7 +29,8 @@
 		device_type = "memory";
 	};
 
-	localbus@ffe05000 {
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
 
 		/* NOR and NAND Flashes */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
@@ -140,7 +141,9 @@
 
 	};
 
-	soc@ffe00000 {
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+
 		i2c@3000 {
 			rtc@68 {
 				compatible = "dallas,ds1339";
@@ -148,17 +151,13 @@
 			};
 		};
 
-	spi@7000 {
-
-		fsl_m25p80@0 {
+		spi@7000 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
-				modal = "s25sl128b";
 				spi-max-frequency = <50000000>;
-				mode = <0>;
 
 				partition@0 {
 					/* 512KB for u-boot Bootloader Image */
@@ -202,13 +201,11 @@
 
 		mdio@24520 {
 			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
+				interrupts = <3 1 0 0>;
 				reg = <0x0>;
 				};
 			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
+				interrupts = <3 1 0 0>;
 				reg = <0x1>;
 				};
 		};
@@ -224,11 +221,7 @@
 			status = "disabled";
 		};
 
-		ptp_clock@24E00 {
-			compatible = "fsl,etsec-ptp";
-			reg = <0x24E00 0xB0>;
-			interrupts = <68 2 69 2 70 2>;
-			interrupt-parent = < &mpic >;
+		ptp_clock@24e00 {
 			fsl,tclk-period = <5>;
 			fsl,tmr-prsc = <200>;
 			fsl,tmr-add = <0xCCCCCCCD>;
@@ -252,29 +245,18 @@
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 		};
-
 	};
 
 	pci0: pcie@ffe08000 {
+		reg = <0 0xffe08000 0 0x1000>;
 		status = "disabled";
 	};
 
 	pci1: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
-			pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
+		pcie@0 {
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -286,21 +268,10 @@
 	};
 
 	pci2: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -311,3 +282,5 @@
 		};
 	};
 };
+
+/include/ "fsl/p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index fc8dddd..66aac86 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -14,28 +14,16 @@
  * option) any later version.
  */
 
-/include/ "p2020si.dtsi"
+/include/ "p2020rdb.dts"
 
 / {
 	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
 
-	aliases {
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		serial0 = &serial0;
-		pci0 = &pci0;
-	};
-
 	cpus {
 		PowerPC,P2020@1 {
-		status = "disabled";
+			status = "disabled";
 		};
-
-	};
-
-	memory {
-		device_type = "memory";
 	};
 
 	localbus@ffe05000 {
@@ -43,115 +31,18 @@
 	};
 
 	soc@ffe00000 {
-		i2c@3000 {
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
-			};
-		};
-
 		serial1: serial@4600 {
 			status = "disabled";
 		};
 
-		spi@7000 {
-
-			fsl_m25p80@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
-				reg = <0>;
-				linux,modalias = "fsl_m25p80";
-				modal = "s25sl128b";
-				spi-max-frequency = <50000000>;
-				mode = <0>;
-
-				partition@0 {
-					/* 512KB for u-boot Bootloader Image */
-					reg = <0x0 0x00080000>;
-					label = "SPI (RO) U-Boot Image";
-					read-only;
-				};
-
-				partition@80000 {
-					/* 512KB for DTB Image */
-					reg = <0x00080000 0x00080000>;
-					label = "SPI (RO) DTB Image";
-					read-only;
-				};
-
-				partition@100000 {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00100000 0x00400000>;
-					label = "SPI (RO) Linux Kernel Image";
-					read-only;
-				};
-
-				partition@500000 {
-					/* 4MB for Compressed RFS Image */
-					reg = <0x00500000 0x00400000>;
-					label = "SPI (RO) Compressed RFS Image";
-					read-only;
-				};
-
-				partition@900000 {
-					/* 7MB for JFFS2 based RFS */
-					reg = <0x00900000 0x00700000>;
-					label = "SPI (RW) JFFS2 RFS";
-				};
-			};
-		};
-
 		dma@c300 {
 			status = "disabled";
 		};
 
-		usb@22000 {
-			phy_type = "ulpi";
-		};
-
-		mdio@24520 {
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x1>;
-			};
-		};
-
-		mdio@25520 {
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@26520 {
-			status = "disabled";
-		};
-
 		enet0: ethernet@24000 {
 			status = "disabled";
 		};
 
-		enet1: ethernet@25000 {
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "sgmii";
-
-		};
-
-		enet2: ethernet@26000 {
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-		};
-
-
 		mpic: pic@40000 {
 			protected-sources = <
 			42 76 77 78 79 /* serial1 , dma2 */
@@ -164,40 +55,12 @@
 		msi@41600 {
 			status = "disabled";
 		};
-
-
 	};
 
 	pci0: pcie@ffe08000 {
 		status = "disabled";
 	};
 
-	pci1: pcie@ffe09000 {
-		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
 	pci2: pcie@ffe0a000 {
 		status = "disabled";
 	};
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
index 261c34b..9bd8ef4 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
@@ -15,28 +15,18 @@
  * option) any later version.
  */
 
-/include/ "p2020si.dtsi"
+/include/ "p2020rdb.dts"
 
 / {
 	model = "fsl,P2020RDB";
 	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
 
-	aliases {
-		ethernet0 = &enet0;
-		serial0 = &serial1;
-		pci1 = &pci1;
-	};
-
 	cpus {
 		PowerPC,P2020@0 {
-		status = "disabled";
+			status = "disabled";
 		};
 	};
 
-	memory {
-		device_type = "memory";
-	};
-
 	localbus@ffe05000 {
 		status = "disabled";
 	};
@@ -70,55 +60,10 @@
 			status = "disabled";
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
 		gpio: gpio-controller@f000 {
 			status = "disabled";
 		};
 
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p2020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>; // L2,512K
-			interrupt-parent = <&mpic>;
-		};
-
 		dma@21300 {
 			status = "disabled";
 		};
@@ -139,12 +84,6 @@
 			status = "disabled";
 		};
 
-		enet0: ethernet@24000 {
-			fixed-link = <1 1 1000 0 0>;
-			phy-connection-type = "rgmii-id";
-
-		};
-
 		enet1: ethernet@25000 {
 			status = "disabled";
 		};
@@ -170,22 +109,6 @@
 			>;
 		};
 
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
-
 		global-utilities@e0000 {	//global utilities block
 			status = "disabled";
 		};
@@ -199,30 +122,4 @@
 	pci1: pcie@ffe09000 {
 		status = "disabled";
 	};
-
-	pci2: pcie@ffe0a000 {
-		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
 };
diff --git a/arch/powerpc/boot/dts/p2020si.dtsi b/arch/powerpc/boot/dts/p2020si.dtsi
deleted file mode 100644
index 37f7194..0000000
--- a/arch/powerpc/boot/dts/p2020si.dtsi
+++ /dev/null
@@ -1,355 +0,0 @@
-/*
- * P2020 Device Tree Source
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-/ {
-	compatible = "fsl,P2020";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
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
-	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
-		interrupts = <19 2 0 0>;
-	};
-
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
-			interrupts = <17 2 0 0>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,p2020-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupts = <18 2 0 0>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
-		spi@7000 {
-			cell-index = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,espi";
-			reg = <0x7000 0x1000>;
-			interrupts = <59 0x2 0 0>;
-			mode = "cpu";
-		};
-
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
-				interrupts = <76 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <77 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <78 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <79 2 0 0>;
-			};
-		};
-
-		gpio: gpio-controller@f000 {
-			#gpio-cells = <2>;
-			compatible = "fsl,mpc8572-gpio";
-			reg = <0xf000 0x100>;
-			interrupts = <47 0x2 0 0>;
-			gpio-controller;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,p2020-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <32>;	// 32 bytes
-			cache-size = <0x80000>; // L2,512K
-			interrupts = <16 2 0 0>;
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
-				interrupts = <20 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
-			};
-		};
-
-		usb@22000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-usb2-dr";
-			reg = <0x22000 0x1000>;
-			interrupts = <28 0x2 0 0>;
-		};
-
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-		};
-
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x520 0x20>;
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
-
-		};
-
-		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
-
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <72 0x2 0 0>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
-				     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2 0 0 58 2 0 0>;
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
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,p2020-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe08000 0 0x1000>;
-		bus-range = <0 255>;
-		clock-frequency = <33333333>;
-		interrupts = <24 2 0 0>;
-	};
-
-	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
-		bus-range = <0 255>;
-		clock-frequency = <33333333>;
-		interrupts = <25 2 0 0>;
-	};
-
-	pci2: pcie@ffe0a000 {
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
-		bus-range = <0 255>;
-		clock-frequency = <33333333>;
-		interrupts = <26 2 0 0>;
-	};
-};
-- 
1.7.3.4

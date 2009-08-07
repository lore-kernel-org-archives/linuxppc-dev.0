Return-Path: <b10812@lc1106.zin33.ap.freescale.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B28FBB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 01:35:41 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42D48DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 01:35:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n77FZKaJ015634
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2009 08:35:31 -0700 (MST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [v3][PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Fri,  7 Aug 2009 21:05:16 +0530
Message-Id: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds P2020RDB basic support in linux.
Overview of P2020RDB platform
	- DDR
	  DDR2 1G
	- NOR Flash
	  16MByte
	- NAND Flash
	  32MByte
	- 3 Ethernet interfaces
	  1) etSEC1
		- RGMII
		- connected to a 5 port Vitesse Switch(VSC7385)
		- Switch is memory mapped through eLBC interface(CS#2)
		- IRQ1
	  2) etSEC2
		- SGMII
		- connected to VSC8221
		- IRQ2
	  3) etSEC3
		- RGMII
		- connected to VSC8641
		- IRQ3
	- 2 1X PCIe interfaces
	- SD/MMC ,USB
	- SPI EEPROM
	- Serial I2C EEPROM

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
Incorporated more feedback from Felix
 arch/powerpc/boot/dts/p2020rdb.dts        |  586 +++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_defconfig    |    1 +
 arch/powerpc/platforms/85xx/Kconfig       |    9 +
 arch/powerpc/platforms/85xx/Makefile      |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
 5 files changed, 739 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p2020rdb.dts
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c

diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
new file mode 100644
index 0000000..da4cb0d
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -0,0 +1,586 @@
+/*
+ * P2020 RDB Device Tree Source
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "fsl,P2020";
+	compatible = "fsl,P2020RDB";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
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
+	memory {
+		device_type = "memory";
+	};
+
+	localbus@ffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xffe05000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		/* NOR and NAND Flashes */
+		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
+			  0x1 0x0 0x0 0xffa00000 0x00040000
+			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x1000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 256KB for Vitesse 7385 Switch firmware */
+				reg = <0x0 0x00040000>;
+				label = "NOR (RO) Vitesse-7385 Firmware";
+				read-only;
+			};
+
+			partition@40000 {
+				/* 256KB for DTB Image */
+				reg = <0x00040000 0x00040000>;
+				label = "NOR (RO) DTB Image";
+				read-only;
+			};
+
+			partition@80000 {
+				/* 3.5 MB for Linux Kernel Image */
+				reg = <0x00080000 0x00380000>;
+				label = "NOR (RO) Linux Kernel Image";
+				read-only;
+			};
+
+			partition@400000 {
+				/* 11MB for JFFS2 based Root file System */
+				reg = <0x00400000 0x00b00000>;
+				label = "NOR (RW) JFFS2 Root File System";
+			};
+
+			partition@f00000 {
+				/* This location must not be altered  */
+				/* 512KB for u-boot Bootloader Image */
+				/* 512KB for u-boot Environment Variables */
+				reg = <0x00f00000 0x00100000>;
+				label = "NOR (RO) U-Boot Image";
+				read-only;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p2020-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x40000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND (RO) U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+				label = "NAND (RO) DTB Image";
+				read-only;
+			};
+
+			partition@200000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00200000 0x00400000>;
+				label = "NAND (RO) Linux Kernel Image";
+				read-only;
+			};
+
+			partition@600000 {
+				/* 4MB for Compressed Root file System Image */
+				reg = <0x00600000 0x00400000>;
+				label = "NAND (RO) Compressed RFS Image";
+				read-only;
+			};
+
+			partition@a00000 {
+				/* 7MB for JFFS2 based Root file System */
+				reg = <0x00a00000 0x00700000>;
+				label = "NAND (RW) JFFS2 Root File System";
+			};
+
+			partition@1100000 {
+				/* 15MB for JFFS2 based Root file System */
+				reg = <0x01100000 0x00f00000>;
+				label = "NAND (RW) Writable User area";
+			};
+		};
+
+		L2switch@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "vitesse-7385";
+			reg = <0x2 0x0 0x20000>;
+		};
+
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
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
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
+
+			fsl_m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,espi-flash";
+				reg = <0>;
+				linux,modalias = "fsl_m25p80";
+				modal = "s25sl128b";
+				spi-max-frequency = <50000000>;
+				mode = <0>;
+
+				partition@0 {
+					/* 512KB for u-boot Bootloader Image */
+					reg = <0x0 0x00080000>;
+					label = "SPI (RO) U-Boot Image";
+					read-only;
+				};
+
+				partition@80000 {
+					/* 512KB for DTB Image */
+					reg = <0x00080000 0x00080000>;
+					label = "SPI (RO) DTB Image";
+					read-only;
+				};
+
+				partition@100000 {
+					/* 4MB for Linux Kernel Image */
+					reg = <0x00100000 0x00400000>;
+					label = "SPI (RO) Linux Kernel Image";
+					read-only;
+				};
+
+				partition@500000 {
+					/* 4MB for Compressed RFS Image */
+					reg = <0x00500000 0x00400000>;
+					label = "SPI (RO) Compressed RFS Image";
+					read-only;
+				};
+
+				partition@900000 {
+					/* 7MB for JFFS2 based RFS */
+					reg = <0x00900000 0x00700000>;
+					label = "SPI (RW) JFFS2 RFS";
+				};
+			};
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
+			phy_type = "ulpi";
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
+			fixed-link = <1 1 1000 0 0>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <3 1>;
+					reg = <0x0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <3 1>;
+					reg = <0x1>;
+				};
+			};
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
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
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
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
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
+	pci0: pcie@ffe09000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe09000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe0a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index c162724..dc4819c 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -189,6 +189,7 @@ CONFIG_MPC85xx_CDS=y
 CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
+CONFIG_MPC85xx_RDB=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_STX_GP3=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index a9b4166..d3a975e 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -55,6 +55,15 @@ config MPC85xx_DS
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
 
+config MPC85xx_RDB
+	bool "Freescale MPC85xx RDB"
+	select PPC_I8259
+	select DEFAULT_UIMAGE
+	select FSL_ULI1575
+	select SWIOTLB
+	help
+	  This option enables support for the MPC85xx RDB (P2020 RDB) board
+
 config SOCRATES
 	bool "Socrates"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 835733f..9098aea 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -9,10 +9,11 @@ obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
+obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
-obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
\ No newline at end of file
+obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
new file mode 100644
index 0000000..c8468de
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -0,0 +1,141 @@
+/*
+ * MPC85xx RDB Board Setup
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+
+void __init mpc85xx_rdb_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+		  MPIC_PRIMARY | MPIC_WANTS_RESET |
+		  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
+		  MPIC_SINGLE_DEST_CPU,
+		  0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+}
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_SMP
+extern void __init mpc85xx_smp_init(void);
+#endif
+static void __init mpc85xx_rdb_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8548-pcie"))
+			fsl_add_bridge(np, 0);
+	}
+
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
+	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
+}
+
+static struct of_device_id __initdata mpc85xxrdb_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{},
+};
+
+static int __init mpc85xxrdb_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
+}
+machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p2020_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
+		return 1;
+	return 0;
+}
+
+define_machine(p2020_rdb) {
+	.name			= "P2020 RDB",
+	.probe			= p2020_rdb_probe,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.6.5

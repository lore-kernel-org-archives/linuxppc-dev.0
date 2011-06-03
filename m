Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add P1010RDB board support
Date: Fri, 3 Jun 2011 11:58:08 +0530
Message-ID: <1307082488-4217-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 P1010RDB Overview
 -----------------
 1Gbyte DDR3 (on board DDR)
 32Mbyte 16bit NOR flash
 32Mbyte SLC NAND Flash
 256 Kbit M24256 I2C EEPROM
 128 Mbit SPI Flash memory
 I2C Board 128x8 bit memory
 SD/MMC connector to interface with the SD memory card
 2 SATA interface
         1 internal SATA connect to 2.5. 160G SATA2 HDD
         1 eSATA connector to rear panel
 USB 2.0
         x1 USB 2.0 port: connected via a UTMI PHY to Mini-AB interface.
         x1 USB 2.0 port: directly connected to Mini-AB interface Ethernet
 eTSEC1: Connected to RGMII PHY VSC8641XKO
 eTSEC2: Connected to SGMII PHY VSC8221
 eTSEC3: Connected to SGMII PHY VSC8221 eCAN
 Two DB-9 female connectors for Field bus interface UART
 DUART interface: supports two UARTs up to 115200 bps for console display

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)

 arch/powerpc/boot/dts/p1010rdb.dts     |  280 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010si.dtsi     |  376 ++++++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig    |   10 +
 arch/powerpc/platforms/85xx/Makefile   |    1 +
 arch/powerpc/platforms/85xx/p1010rdb.c |  122 +++++++++++
 6 files changed, 790 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010si.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/p1010rdb.c

diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
new file mode 100644
index 0000000..6b33b73
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -0,0 +1,280 @@
+/*
+ * P1010 RDB Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "p1010si.dtsi"
+
+/ {
+	model = "fsl,P1010RDB";
+	compatible = "fsl,P1010RDB";
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	ifc@ffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xff800000 0x00010000
+			  0x3 0x0 0x0 0xffb00000 0x00000020>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@40000 {
+				/* 256KB for DTB Image */
+				reg = <0x00040000 0x00040000>;
+				label = "NOR DTB Image";
+			};
+
+			partition@80000 {
+				/* 7 MB for Linux Kernel Image */
+				reg = <0x00080000 0x00700000>;
+				label = "NOR Linux Kernel Image";
+			};
+
+			partition@800000 {
+				/* 20MB for JFFS2 based Root file System */
+				reg = <0x00800000 0x01400000>;
+				label = "NOR JFFS2 Root File System";
+			};
+
+			partition@1f00000 {
+				/* This location must not be altered  */
+				/* 512KB for u-boot Bootloader Image */
+				/* 512KB for u-boot Environment Variables */
+				reg = <0x01f00000 0x00100000>;
+				label = "NOR U-Boot Image";
+				read-only;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x1 0x0 0x10000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+				label = "NAND DTB Image";
+			};
+
+			partition@200000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00200000 0x00400000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@600000 {
+				/* 4MB for Compressed Root file System Image */
+				reg = <0x00600000 0x00400000>;
+				label = "NAND Compressed RFS Image";
+			};
+
+			partition@a00000 {
+				/* 15MB for JFFS2 based Root file System */
+				reg = <0x00a00000 0x00f00000>;
+				label = "NAND JFFS2 Root File System";
+			};
+
+			partition@1900000 {
+				/* 7MB for User Area */
+				reg = <0x01900000 0x00700000>;
+				label = "NAND User area";
+			};
+		};
+
+		cpld@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1010rdb-cpld";
+			reg = <0x3 0x0 0x0000020>;
+			bank-width = <1>;
+			device-width = <1>;
+		};
+	};
+
+	soc@ffe00000 {
+		spi@7000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+
+				partition@0 {
+					/* 1MB for u-boot Bootloader Image */
+					/* 1MB for Environment */
+					reg = <0x0 0x00100000>;
+					label = "SPI Flash U-Boot Image";
+					read-only;
+				};
+
+				partition@100000 {
+					/* 512KB for DTB Image */
+					reg = <0x00100000 0x00080000>;
+					label = "SPI Flash DTB Image";
+				};
+
+				partition@180000 {
+					/* 4MB for Linux Kernel Image */
+					reg = <0x00180000 0x00400000>;
+					label = "SPI Flash Linux Kernel Image";
+				};
+
+				partition@580000 {
+					/* 4MB for Compressed RFS Image */
+					reg = <0x00580000 0x00400000>;
+					label = "SPI Flash Compressed RFSImage";
+				};
+
+				partition@980000 {
+					/* 6.5MB for JFFS2 based RFS */
+					reg = <0x00980000 0x00680000>;
+					label = "SPI Flash JFFS2 RFS";
+				};
+			};
+		};
+
+		can0@1c000 {
+			fsl,flexcan-clock-source = "platform";
+		};
+
+		can1@1d000 {
+			fsl,flexcan-clock-source = "platform";
+		};
+
+		usb@22000 {
+			phy_type = "utmi";
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <3 1>;
+				reg = <0x1>;
+			};
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <2 1>;
+				reg = <0x0>;
+			};
+
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <2 1>;
+				reg = <0x2>;
+			};
+		};
+
+		enet0: ethernet@b0000 {
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		enet1: ethernet@b1000 {
+			phy-handle = <&phy1>;
+			tbi-handle = <&tbi0>;
+			phy-connection-type = "sgmii";
+		};
+
+		enet2: ethernet@b2000 {
+			phy-handle = <&phy2>;
+			tbi-handle = <&tbi1>;
+			phy-connection-type = "sgmii";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+
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
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1010si.dtsi b/arch/powerpc/boot/dts/p1010si.dtsi
new file mode 100644
index 0000000..7f51104
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010si.dtsi
@@ -0,0 +1,376 @@
+/*
+ * P1010si Device Tree Source
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
+	compatible = "fsl,P1010";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1010@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	ifc@ffe1e000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,ifc", "simple-bus";
+		reg = <0x0 0xffe1e000 0 0x2000>;
+		interrupts = <16 2 19 2>;
+		interrupt-parent = <&mpic>;
+	};
+
+	soc@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,p1010-immr", "simple-bus";
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
+			compatible = "fsl,p1010-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <16 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,p1010-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
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
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc8536-espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,espi-num-chipselects = <1>;
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
+		sata@18000 {
+			compatible = "fsl,pq-sata-v2";
+			reg = <0x18000 0x1000>;
+			cell-index = <1>;
+			interrupts = <74 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		sata@19000 {
+			compatible = "fsl,pq-sata-v2";
+			reg = <0x19000 0x1000>;
+			cell-index = <2>;
+			interrupts = <41 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		can0@1c000 {
+			compatible = "fsl,flexcan-v1.0";
+			reg = <0x1c000 0x1000>;
+			interrupts = <48 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,flexcan-clock-divider = <2>;
+		};
+
+		can1@1d000 {
+			compatible = "fsl,flexcan-v1.0";
+			reg = <0x1d000 0x1000>;
+			interrupts = <61 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,flexcan-clock-divider = <2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,p1010-l2-cache-controller",
+					"fsl,p1014-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x40000>; // L2,256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1010-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p1010-dma-channel", "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		usb@22000 {
+			compatible = "fsl-usb2-dr";
+			reg = <0x22000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <28 0x2>;
+			dr_mode = "host";
+		};
+
+		mdio@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-mdio";
+			reg = <0x24000 0x1000 0xb0030 0x4>;
+		};
+
+		mdio@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-tbi";
+			reg = <0x25000 0x1000 0xb1030 0x4>;
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		mdio@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-tbi";
+			reg = <0x26000 0x1000 0xb1030 0x4>;
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		sdhci@2e000 {
+			compatible = "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x8>;
+			interrupt-parent = <&mpic>;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+			fsl,sdhci-auto-cmd12;
+		};
+
+		enet0: ethernet@b0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb0000 0x1000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <29 2 30 2 34 2>;
+			};
+
+		};
+
+		enet1: ethernet@b1000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb1000 0x1000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <35 2 36 2 40 2>;
+			};
+
+		};
+
+		enet2: ethernet@b2000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb2000 0x1000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <31 2 32 2 33 2>;
+			};
+
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
+			compatible = "fsl,p1010-msi", "fsl,mpic-msi";
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
+			compatible = "fsl,p1010-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe09000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+	};
+
+	pci1: pcie@ffe0a000 {
+		compatible = "fsl,p1010-pcie", "fsl,qoriq-pcie-v2.3", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xffe0a000 0 0x1000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+	};
+};
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 96b89df..306f4a0 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -25,6 +25,7 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
+CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index b6976e1..07a3d29 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -67,6 +67,16 @@ config MPC85xx_RDB
 	help
 	  This option enables support for the MPC85xx RDB (P2020 RDB) board
 
+config P1010_RDB
+	bool "Freescale P1010RDB"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC85xx RDB (P1010 RDB) board
+
+	  P1010RDB contains P1010Si, which provides CPU performance up to 800
+	  MHz and 1600 DMIPS, additional functionality and faster interfaces
+	  (DDR3/3L, SATA II, and PCI  Express).
+
 config P1022_DS
 	bool "Freescale P1022 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index dd70db7..07b40bf 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
+obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
new file mode 100644
index 0000000..d7387fa
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -0,0 +1,122 @@
+/*
+ * P1010RDB Board Setup
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+#include <linux/delay.h>
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
+void __init p1010_rdb_pic_init(void)
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
+	mpic = mpic_alloc(np, r.start, MPIC_PRIMARY | MPIC_WANTS_RESET |
+	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
+	  0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+}
+
+
+/*
+ * Setup the architecture
+ */
+static void __init p1010_rdb_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("p1010_rdb_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,p1010-pcie"))
+			fsl_add_bridge(np, 0);
+	}
+
+#endif
+
+	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
+}
+
+static struct of_device_id __initdata p1010rdb_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init p1010rdb_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, p1010rdb_ids, NULL);
+}
+machine_device_initcall(p1010_rdb, p1010rdb_publish_devices);
+machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p1010_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB"))
+		return 1;
+	return 0;
+}
+
+define_machine(p1010_rdb) {
+	.name			= "P1010 RDB",
+	.probe			= p1010_rdb_probe,
+	.setup_arch		= p1010_rdb_setup_arch,
+	.init_IRQ		= p1010_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.7.3

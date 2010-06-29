Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 212FEB6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 07:34:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TLYZp4002434
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 14:34:35 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: introduce basic support for the Freescale P1022DS
	reference board
Date: Tue, 29 Jun 2010 16:34:34 -0500
Message-Id: <1277847274-24648-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce basic support for the Freescale P1022DS reference board, based on the
Freescale BSP for this board.

Details: No DIU video or SSI audio support, no MMC/SD card support, 36-bit and
SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ disabled because it
causes performance problems on this kernel.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.36.

 arch/powerpc/boot/dts/p1022ds.dts            |  676 +++++++++++
 arch/powerpc/configs/85xx/p1022_ds_defconfig | 1620 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig          |    9 +
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/p1022_ds.c       |  148 +++
 5 files changed, 2454 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1022ds.dts
 create mode 100644 arch/powerpc/configs/85xx/p1022_ds_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/p1022_ds.c

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
new file mode 100644
index 0000000..3edeca7
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -0,0 +1,676 @@
+/*
+ * P1022 DS 36Bit Physical Address Map Device Tree Source
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/ {
+	model = "fsl,P1022";
+	compatible = "fsl,P1022DS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1022@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1022@1 {
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
+	localbus@fffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xffe05000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
+			  0x1 0x0 0xf 0xe0000000 0x08000000
+			  0x2 0x0 0x0 0xffa00000 0x00040000
+			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				reg = <0x0 0x03000000>;
+				label = "ramdisk-nor";
+				read-only;
+			};
+
+			partition@3000000 {
+				reg = <0x03000000 0x00e00000>;
+				label = "diagnostic-nor";
+				read-only;
+			};
+
+			partition@3e00000 {
+				reg = <0x03e00000 0x00200000>;
+				label = "dink-nor";
+				read-only;
+			};
+
+			partition@4000000 {
+				reg = <0x04000000 0x00400000>;
+				label = "kernel-nor";
+				read-only;
+			};
+
+			partition@4400000 {
+				reg = <0x04400000 0x03b00000>;
+				label = "jffs2-nor";
+			};
+
+			partition@7f00000 {
+				reg = <0x07f00000 0x00080000>;
+				label = "dtb-nor";
+				read-only;
+			};
+
+			partition@7f80000 {
+				reg = <0x07f80000 0x00080000>;
+				label = "u-boot-nor";
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x40000>;
+
+			partition@0 {
+				reg = <0x0 0x02000000>;
+				label = "u-boot-nand";
+				read-only;
+			};
+
+			partition@2000000 {
+				reg = <0x02000000 0x10000000>;
+				label = "jffs2-nand";
+			};
+
+			partition@12000000 {
+				reg = <0x12000000 0x10000000>;
+				label = "ramdisk-nand";
+				read-only;
+			};
+
+			partition@22000000 {
+				reg = <0x22000000 0x04000000>;
+				label = "kernel-nand";
+			};
+
+			partition@26000000 {
+				reg = <0x26000000 0x01000000>;
+				label = "dtb-nand";
+				read-only;
+			};
+
+			partition@27000000 {
+				reg = <0x27000000 0x19000000>;
+				label = "reserved-nand";
+			};
+		};
+	};
+
+	soc@fffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,p1022-immr", "simple-bus";
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,p1022-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <16 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,p1022-memory-controller";
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
+
+			wm8776:codec@1a {
+				compatible = "wlf,wm8776";
+				reg = <0x1a>;
+				/* MCLK source is a stand-alone oscillator */
+				clock-frequency = <12288000>;
+			};
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
+			espi,num-ss-bits = <4>;
+			mode = "cpu";
+
+			fsl_m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,espi-flash";
+				reg = <0>;
+				linux,modalias = "fsl_m25p80";
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@0 {
+					label = "u-boot-spi";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@100000 {
+					label = "kernel-spi";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@600000 {
+					label = "dtb-spi";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@700000 {
+					label = "file system-spi";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		ssi@15000 {
+			compatible = "fsl,mpc8610-ssi";
+			cell-index = <0>;
+			reg = <0x15000 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <62 2>;
+			fsl,mode = "i2s-slave";
+			codec-handle = <&wm8776>;
+			fsl,playback-dma = <&dma00>;
+			fsl,capture-dma = <&dma01>;
+			fsl,fifo-depth = <16>;
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma00: dma-channel@0 {
+				compatible = "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma01: dma-channel@80 {
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
+			compatible = "fsl,p1022-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x40000>; // L2, 256K
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
+		mdio@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-mdio";
+			reg = <0x24000 0x1000 0xb0030 0x4>;
+
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <3 1>;
+				reg = <0x1>;
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <9 1>;
+				reg = <0x2>;
+			};
+		};
+
+		mdio@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-mdio";
+			reg = <0x25000 0x1000 0xb1030 0x4>;
+		};
+
+		enet0: ethernet@B0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			fsl,magic-packet;
+			fsl,wake-on-filer;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+			fixed-link = <1 1 1000 0 0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+			queue-group@0{
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xB0000 0x1000>;
+				fsl,rx-err-int-map = <0xAA>;
+				fsl,tx-int-map = <0xAA>;
+				interrupts = <29 2 30 2 34 2>;
+			};
+			queue-group@1{
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xB4000 0x1000>;
+				fsl,rx-err-int-map = <0x55>;
+				fsl,tx-int-map = <0x55>;
+				interrupts = <17 2 18 2 24 2>;
+			};
+		};
+
+		enet1: ethernet@B1000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+			fixed-link = <1 1 1000 0 0>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+			queue-group@0{
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xB1000 0x1000>;
+				fsl,rx-err-int-map = <0xAA>;
+				fsl,tx-int-map = <0xAA>;
+				interrupts = <35 2 36 2 40 2>;
+			};
+			queue-group@1{
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xB5000 0x1000>;
+				fsl,rx-err-int-map = <0x55>;
+				fsl,tx-int-map = <0x55>;
+				interrupts = <51 2 52 2 67 2>;
+			};
+		};
+
+		sdhci@2e000 {
+			compatible = "fsl,p1022-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,sdhci-auto-cmd12;
+			/* Filled in by U-Boot */
+			clock-frequency = <0>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+				     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+				     "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x97c>;
+			fsl,descriptor-types-mask = <0x3a30abf>;
+			fsl,multi-host-mode = "dual";
+			fsl,channel-remap = <0x3>;
+		};
+
+		sata@18000 {
+			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			cell-index = <1>;
+			interrupts = <74 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		sata@19000 {
+			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			reg = <0x19000 0x1000>;
+			cell-index = <2>;
+			interrupts = <41 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		power@e0070{
+			compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+			reg = <0xe0070 0x20>;
+		};
+
+		display@10000 {
+			compatible = "fsl,diu", "fsl,p1022-diu";
+			reg = <0x10000 1000>;
+			interrupts = <64 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		timer@41100 {
+			compatible = "fsl,mpic-global-timer";
+			reg = <0x41100 0x204>;
+			interrupts = <0xf7 0x2>;
+			interrupt-parent = <&mpic>;
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
+			compatible = "fsl,mpic-msi";
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
+			compatible = "fsl,p1022-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fffe09000 {
+		compatible = "fsl,p1022-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xffe09000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 4 1
+			0000 0 0 2 &mpic 5 1
+			0000 0 0 3 &mpic 6 1
+			0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@fffe0a000 {
+		compatible = "fsl,p1022-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 0 1
+			0000 0 0 2 &mpic 1 1
+			0000 0 0 3 &mpic 2 1
+			0000 0 0 4 &mpic 3 1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+
+	pci2: pcie@fffe0b000 {
+		compatible = "fsl,p1022-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xffe0b000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 8 1
+			0000 0 0 2 &mpic 9 1
+			0000 0 0 3 &mpic 10 1
+			0000 0 0 4 &mpic 11 1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/configs/85xx/p1022_ds_defconfig b/arch/powerpc/configs/85xx/p1022_ds_defconfig
new file mode 100644
index 0000000..86518d7
--- /dev/null
+++ b/arch/powerpc/configs/85xx/p1022_ds_defconfig
@@ -0,0 +1,1620 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.35-rc3
+# Fri Jun 25 16:22:19 2010
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_PPC_BOOK3S_32 is not set
+CONFIG_PPC_85xx=y
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_E500=y
+# CONFIG_PPC_E500MC is not set
+CONFIG_FSL_EMB_PERFMON=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+CONFIG_PTE_64BIT=y
+CONFIG_PHYS_64BIT=y
+CONFIG_SPE=y
+CONFIG_PPC_MMU_NOHASH=y
+CONFIG_PPC_MMU_NOHASH_32=y
+CONFIG_PPC_BOOK3E_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_NR_IRQS=512
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_GPIO=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
+CONFIG_DEFAULT_UIMAGE=y
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
+CONFIG_PPC_ADV_DEBUG_REGS=y
+CONFIG_PPC_ADV_DEBUG_IACS=2
+CONFIG_PPC_ADV_DEBUG_DACS=2
+CONFIG_PPC_ADV_DEBUG_DVCS=0
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=32
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_RCU_FAST_NO_HZ is not set
+# CONFIG_TREE_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_HAVE_PERF_EVENTS=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+# CONFIG_PERF_COUNTERS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_USE_GENERIC_SMP_HELPERS=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_GCOV_KERNEL is not set
+CONFIG_SLOW_WORK=y
+# CONFIG_SLOW_WORK_DEBUG is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_STOP_MACHINE=y
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_BLK_DEV_INTEGRITY=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+CONFIG_INLINE_READ_UNLOCK=y
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+CONFIG_INLINE_WRITE_UNLOCK=y
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+CONFIG_MUTEX_SPIN_ON_OWNER=y
+# CONFIG_FREEZER is not set
+CONFIG_PPC_MSI_BITMAP=y
+
+#
+# Platform support
+#
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_FSL_SOC_BOOKE=y
+# CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8560_ADS is not set
+# CONFIG_MPC85xx_CDS is not set
+# CONFIG_MPC85xx_MDS is not set
+# CONFIG_MPC8536_DS is not set
+# CONFIG_MPC85xx_DS is not set
+# CONFIG_MPC85xx_RDB is not set
+CONFIG_P1022_DS=y
+# CONFIG_SOCRATES is not set
+# CONFIG_KSI8560 is not set
+# CONFIG_XES_MPC85xx is not set
+# CONFIG_STX_GP3 is not set
+# CONFIG_TQM8540 is not set
+# CONFIG_TQM8541 is not set
+# CONFIG_TQM8548 is not set
+# CONFIG_TQM8555 is not set
+# CONFIG_TQM8560 is not set
+# CONFIG_SBC8548 is not set
+# CONFIG_SBC8560 is not set
+# CONFIG_P4080_DS is not set
+# CONFIG_IPIC is not set
+CONFIG_MPIC=y
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_QUICC_ENGINE is not set
+# CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_MPC8xxx_GPIO=y
+# CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+CONFIG_HIGHMEM=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_SCHED_HRTICK=y
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+# CONFIG_HAVE_AOUT is not set
+CONFIG_BINFMT_MISC=y
+# CONFIG_MATH_EMULATION is not set
+CONFIG_IOMMU_HELPER=y
+CONFIG_SWIOTLB=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+CONFIG_IRQ_ALL_CPUS=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_MAX_ACTIVE_REGIONS=32
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_PPC_4K_PAGES=y
+# CONFIG_PPC_16K_PAGES is not set
+# CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
+CONFIG_FORCE_MAX_ZONEORDER=12
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_EXTRA_TARGETS=""
+# CONFIG_PM is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_FSL_PCI=y
+CONFIG_PPC_PCI_CHOICE=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+CONFIG_PCI_MSI=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_LOWMEM_CAM_NUM=3
+CONFIG_PAGE_OFFSET=0xc0000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_PHYSICAL_ALIGN=0x04000000
+CONFIG_TASK_SIZE=0xc0000000
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_XFRM_USER=y
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_MIGRATE=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_XFRM_IPCOMP=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+# CONFIG_IP_PNP is not set
+CONFIG_NET_IPIP=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_XFRM_TUNNEL=y
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_LRO=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_TCP_CONG_WESTWOOD=y
+CONFIG_TCP_CONG_HTCP=y
+CONFIG_TCP_CONG_HSTCP=y
+CONFIG_TCP_CONG_HYBLA=y
+CONFIG_TCP_CONG_VEGAS=y
+CONFIG_TCP_CONG_SCALABLE=y
+CONFIG_TCP_CONG_LP=y
+CONFIG_TCP_CONG_VENO=y
+CONFIG_TCP_CONG_YEAH=y
+CONFIG_TCP_CONG_ILLINOIS=y
+# CONFIG_DEFAULT_BIC is not set
+CONFIG_DEFAULT_CUBIC=y
+# CONFIG_DEFAULT_HTCP is not set
+# CONFIG_DEFAULT_HYBLA is not set
+# CONFIG_DEFAULT_VEGAS is not set
+# CONFIG_DEFAULT_VENO is not set
+# CONFIG_DEFAULT_WESTWOOD is not set
+# CONFIG_DEFAULT_RENO is not set
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_TCP_MD5SIG=y
+CONFIG_IPV6=y
+CONFIG_IPV6_PRIVACY=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_IPCOMP=y
+CONFIG_IPV6_MIP6=y
+CONFIG_INET6_XFRM_TUNNEL=y
+CONFIG_INET6_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_SIT_6RD=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+CONFIG_IPV6_TUNNEL=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETWORK_SECMARK=y
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+# CONFIG_SCTP_HMAC_MD5 is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+CONFIG_RPS=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_FIB_RULES=y
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH=""
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+CONFIG_DEBUG_DEVRES=y
+# CONFIG_SYS_HYPERVISOR is not set
+CONFIG_CONNECTOR=y
+CONFIG_PROC_EVENTS=y
+# CONFIG_MTD is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_DYNAMIC=y
+CONFIG_OF_DEVICE=y
+CONFIG_OF_GPIO=y
+CONFIG_OF_I2C=y
+CONFIG_OF_MDIO=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+# CONFIG_BLK_DEV_DRBD is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=131072
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_ATA_VERBOSE_ERROR=y
+# CONFIG_SATA_PMP is not set
+
+#
+# Controllers with non-SFF native interface
+#
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_AHCI_PLATFORM is not set
+CONFIG_SATA_FSL=y
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_ATA_SFF is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# The newer stack is recommended.
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_MICREL_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_CNIC is not set
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_GIANFAR=y
+# CONFIG_MV643XX_ETH is not set
+# CONFIG_XILINX_LL_TEMAC is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+# CONFIG_SERIAL_8250_MANY_PORTS is not set
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+# CONFIG_SERIAL_8250_DETECT_IRQ is not set
+CONFIG_SERIAL_8250_RSA=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_TIMERIOMEM=y
+# CONFIG_NVRAM is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+CONFIG_RAW_DRIVER=y
+CONFIG_MAX_RAW_DEVS=8192
+CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS=y
+CONFIG_TCG_NSC=y
+CONFIG_TCG_ATMEL=y
+CONFIG_DEVPORT=y
+# CONFIG_RAMOOPS is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_GPIO is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_IT8761E is not set
+# CONFIG_GPIO_XILINX is not set
+# CONFIG_GPIO_SCH is not set
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX7300 is not set
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_ADP5588 is not set
+
+#
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_CS5535 is not set
+# CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_LANGWELL is not set
+# CONFIG_GPIO_RDC321X is not set
+
+#
+# SPI GPIO expanders:
+#
+
+#
+# AC97 GPIO expanders:
+#
+
+#
+# MODULbus GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_GENERIC is not set
+# CONFIG_BACKLIGHT_ADP8860 is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+CONFIG_HIDRAW=y
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+CONFIG_HID_PID=y
+CONFIG_USB_HIDDEV=y
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_3M_PCT is not set
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CANDO is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EGALAX is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MOSART is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_ORTEK is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_QUANTA is not set
+# CONFIG_HID_ROCCAT is not set
+# CONFIG_HID_ROCCAT_KONE is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_STANTUM is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+CONFIG_USB_MON=y
+CONFIG_USB_WUSB=y
+CONFIG_USB_WUSB_CBAF=y
+# CONFIG_USB_WUSB_CBAF_DEBUG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_XPS_USB_HCD_XILINX is not set
+CONFIG_USB_EHCI_FSL=y
+# CONFIG_USB_EHCI_HCD_PPC_OF is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE_DEBUG=y
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+CONFIG_USB_OTG_UTILS=y
+# CONFIG_USB_GPIO_VBUS is not set
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_UWB=y
+CONFIG_UWB_HWA=y
+CONFIG_UWB_WHCI=y
+# CONFIG_UWB_WLP is not set
+# CONFIG_UWB_I1480U is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_EDAC=y
+
+#
+# Reporting subsystems
+#
+# CONFIG_EDAC_DEBUG is not set
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_RTC_DRV_GENERIC is not set
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+CONFIG_UIO=y
+CONFIG_UIO_CIF=y
+CONFIG_UIO_PDRV=y
+CONFIG_UIO_PDRV_GENIRQ=y
+CONFIG_UIO_AEC=y
+CONFIG_UIO_SERCOS3=y
+CONFIG_UIO_PCI_GENERIC=y
+# CONFIG_UIO_NETX is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT2_FS_XIP=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_XATTR=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_FS_XIP=y
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_JBD2=y
+# CONFIG_JBD2_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_QUOTA=y
+CONFIG_QUOTA_NETLINK_INTERFACE=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+# CONFIG_QUOTA_DEBUG is not set
+CONFIG_QUOTA_TREE=y
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=y
+CONFIG_QUOTACTL=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=y
+CONFIG_CUSE=y
+CONFIG_GENERIC_ACL=y
+
+#
+# Caches
+#
+CONFIG_FSCACHE=y
+CONFIG_FSCACHE_STATS=y
+# CONFIG_FSCACHE_HISTOGRAM is not set
+# CONFIG_FSCACHE_DEBUG is not set
+CONFIG_FSCACHE_OBJECT_LIST=y
+CONFIG_CACHEFILES=y
+# CONFIG_CACHEFILES_DEBUG is not set
+# CONFIG_CACHEFILES_HISTOGRAM is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_CONFIGFS_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_FSCACHE=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V2_ACL=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+CONFIG_RPCSEC_GSS_SPKM3=y
+# CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
+CONFIG_CIFS=y
+CONFIG_CIFS_STATS=y
+# CONFIG_CIFS_STATS2 is not set
+CONFIG_CIFS_WEAK_PW_HASH=y
+CONFIG_CIFS_XATTR=y
+CONFIG_CIFS_POSIX=y
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_EXPERIMENTAL is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_MINIX_SUBPARTITION=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_UNIXWARE_DISKLABEL=y
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+CONFIG_CRC7=y
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=2048
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+CONFIG_SCHED_DEBUG=y
+CONFIG_SCHEDSTATS=y
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+CONFIG_STACKTRACE=y
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_LIST=y
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_LKDTM is not set
+# CONFIG_FAULT_INJECTION is not set
+CONFIG_LATENCYTOP=y
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+CONFIG_DYNAMIC_DEBUG=y
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
+CONFIG_PRINT_STACK_DEPTH=64
+CONFIG_DEBUG_STACKOVERFLOW=y
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PER_CPU_MAPS is not set
+# CONFIG_PPC_EMULATED_STATS is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_VIRQ_DEBUG is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+CONFIG_SECURITYFS=y
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+CONFIG_CRYPTO_GF128MUL=y
+CONFIG_CRYPTO_NULL=y
+# CONFIG_CRYPTO_PCRYPT is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+CONFIG_CRYPTO_CRYPTD=y
+CONFIG_CRYPTO_AUTHENC=y
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_SEQIV=y
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=y
+CONFIG_CRYPTO_CTS=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_LRW=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_XTS=y
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_XCBC=y
+CONFIG_CRYPTO_VMAC=y
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+CONFIG_CRYPTO_GHASH=y
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+CONFIG_CRYPTO_RMD128=y
+CONFIG_CRYPTO_RMD160=y
+CONFIG_CRYPTO_RMD256=y
+CONFIG_CRYPTO_RMD320=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_TGR192=y
+CONFIG_CRYPTO_WP512=y
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_ANUBIS=y
+CONFIG_CRYPTO_ARC4=y
+CONFIG_CRYPTO_BLOWFISH=y
+CONFIG_CRYPTO_CAMELLIA=y
+CONFIG_CRYPTO_CAST5=y
+CONFIG_CRYPTO_CAST6=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_FCRYPT=y
+CONFIG_CRYPTO_KHAZAD=y
+# CONFIG_CRYPTO_SALSA20 is not set
+CONFIG_CRYPTO_SEED=y
+CONFIG_CRYPTO_SERPENT=y
+CONFIG_CRYPTO_TEA=y
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_ZLIB=y
+CONFIG_CRYPTO_LZO=y
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=y
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 3a2ade2..eacdfde 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -65,6 +65,15 @@ config MPC85xx_RDB
 	help
 	  This option enables support for the MPC85xx RDB (P2020 RDB) board
 
+config P1022_DS
+	bool "Freescale P1022 DS"
+	select DEFAULT_UIMAGE
+	select CONFIG_PHYS_64BIT	# The DTS has 36-bit addresses
+	select SWIOTLB
+	select GENERIC_ISA_DMA		# Prevents a bug in ALSA w.r.t. ISA
+	help
+	  This option enables support for the Freescale P1022DS reference board.
+
 config SOCRATES
 	bool "Socrates"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 387c128..a2ec3f8 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
+obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
new file mode 100644
index 0000000..86f41f6
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -0,0 +1,148 @@
+/*
+ * P1022DS board specific routines
+ *
+ * Authors: Travis Wheatley <travis.wheatley@freescale.com>
+ *          Dave Liu <daveliu@freescale.com>
+ *          Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This file is taken from the Freescale P1022DS BSP, with modifications:
+ * 1) No DIU support (pending rewrite of DIU code)
+ * 2) No AMP support
+ * 3) No PCI endpoint support
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+#include <linux/lmb.h>
+
+#include <asm/mpic.h>
+#include <asm/swiotlb.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+void __init p1022_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (!np) {
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
+		MPIC_PRIMARY | MPIC_WANTS_RESET |
+		MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
+		MPIC_SINGLE_DEST_CPU,
+		0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+#ifdef CONFIG_SMP
+void __init mpc85xx_smp_init(void);
+#endif
+
+/*
+ * Setup the architecture
+ */
+static void __init p1022_ds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+	dma_addr_t max = 0xffffffff;
+
+	if (ppc_md.progress)
+		ppc_md.progress("p1022_ds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,p1022-pcie") {
+		struct resource rsrc;
+		struct pci_controller *hose;
+
+		of_address_to_resource(np, 0, &rsrc);
+
+		if ((rsrc.start & 0xfffff) == 0x8000)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+
+		hose = pci_find_hose_for_OF_device(np);
+		max = min(max, hose->dma_window_base_cur +
+			  hose->dma_window_size);
+	}
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+
+	printk(KERN_INFO "Freescale P1022 DS reference board\n");
+}
+
+static struct of_device_id __initdata p1022_ds_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{},
+};
+
+static int __init p1022_ds_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
+}
+machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
+
+machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p1022_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,p1022ds");
+}
+
+define_machine(p1022_ds) {
+	.name			= "P1022 DS",
+	.probe			= p1022_ds_probe,
+	.setup_arch		= p1022_ds_setup_arch,
+	.init_IRQ		= p1022_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.7.0.1

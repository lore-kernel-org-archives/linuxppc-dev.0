Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:Add PSC9131 RDB Support
Date: Tue, 14 Feb 2012 14:07:20 +0530
Message-ID: <1329208640-32209-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Rajan Srivastava <rajan.srivastava@freescale.com>,
 Akhil Goyal <Akhil.Goyal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PSC9131RDB is a Freescale reference design board for PSC9131 SoC.The PSC9131 is
integrated SoC that targets Femto base station market. It combines Power
Architecture e500v2 and DSP StarCore SC3850 core technologies with MAPLE-B2F
baseband acceleration processing elements.

    -The PSC9131 SoC includes the following function and features:
    . Power Architecture subsystem including a e500 processor with 256-Kbyte shared
      L2 cache
    . StarCore SC3850 DSP subsystem with a 512-Kbyte private L2 cache
    . The Multi Accelerator Platform Engine for Femto BaseStation Baseband
      Processing (MAPLE-B2F)
    . A multi-standard baseband algorithm accelerator for Channel Decoding/Encoding,
      Fourier Transforms, UMTS chip rate processing, LTE UP/DL Channel processing,
      and CRC algorithms
    . Consists of accelerators for Convolution, Filtering, Turbo Encoding,
      Turbo Decoding, Viterbi decoding, Chiprate processing, and Matrix Inversion
      operations
    . DDR3/3L memory interface with 32-bit data width without ECC and 16-bit with
      ECC, up to 400-MHz clock/800 MHz data rate
    . Dedicated security engine featuring trusted boot
    . DMA controller
    . OCNDMA with four bidirectional channels
    . Interfaces
    . Two triple-speed Gigabit Ethernet controllers featuring network acceleration
      including IEEE 1588. v2 hardware support and virtualization (eTSEC)
    . eTSEC 1 supports RGMII/RMII
    . eTSEC 2 supports RGMII
    . High-speed USB 2.0 host and device controller with ULPI interface
    . Enhanced secure digital (SD/MMC) host controller (eSDHC)
    . Antenna interface controller (AIC), supporting three industry standard
      JESD207/three custom ADI RF interfaces (two dual port and one single port)
      and three MAXIM's MaxPHY serial interfaces
    . ADI lanes support both full duplex FDD support and half duplex TDD support
    . Universal Subscriber Identity Module (USIM) interface that facilitates
      communication to SIM cards or Eurochip pre-paid phone cards
    . TDM with one TDM port
    . Two DUART, four eSPI, and two I2C controllers
    . Integrated Flash memory controller (IFC)
    . TDM with 256 channels
    . GPIO
    . Sixteen 32-bit timers

The DSP portion of the SoC consists of DSP core (SC3850) and various
accelerators pertaining to DSP operations.

 PSC9131RDB Overview
 ----------------------
     PSC9131 SoC
     1Gbyte DDR3 (on board DDR)
     128Mbyte 2K page size NAND Flash
     256 Kbit M24256 I2C EEPROM
     128 Mbit SPI Flash memory
     USB-ULPI
     eTSEC1: Connected to RGMII PHY
     eTSEC2: Connected to RGMII PHY
     DUART interface: supports one UARTs up to 115200 bps for console display

 Linux runs on e500v2 core and access some DSP peripherals like AIC

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Akhil Goyal <Akhil.Goyal@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Rajan Srivastava <rajan.srivastava@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Applied on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git branch next

 arch/powerpc/boot/dts/fsl/psc9131si-post.dtsi |  220 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/psc9131si-pre.dtsi  |   59 +++++++
 arch/powerpc/boot/dts/psc9131rdb.dts          |   34 ++++
 arch/powerpc/boot/dts/psc9131rdb.dtsi         |  187 +++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   13 ++
 arch/powerpc/platforms/85xx/Makefile          |    1 +
 arch/powerpc/platforms/85xx/psc913x_board.c   |   99 +++++++++++
 7 files changed, 613 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/psc9131si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/psc9131si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/psc9131rdb.dts
 create mode 100644 arch/powerpc/boot/dts/psc9131rdb.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/psc913x_board.c

diff --git a/arch/powerpc/boot/dts/fsl/psc9131si-post.dtsi b/arch/powerpc/boot/dts/fsl/psc9131si-post.dtsi
new file mode 100644
index 0000000..878126e
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/psc9131si-post.dtsi
@@ -0,0 +1,220 @@
+/*
+ * PSC9131 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,ifc", "simple-bus";
+	interrupts = <16 2 20 2>;
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,psc9131-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,psc9131-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,psc9131-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+	i2c@3000 {
+		interrupts = <17 2 0 0>;
+		dfsrr;
+	};
+
+/include/ "pq3-i2c-1.dtsi"
+	i2c@3100 {
+		interrupts = <17 2 0 0>;
+		dfsrr;
+	};
+
+/include/ "pq3-duart-0.dtsi"
+	serial0: serial@4500 {
+		interrupts = <18 2 0 0>;
+	};
+
+	serial1: serial@4600 {
+		interrupts = <18 2 0 0 >;
+	};
+/include/ "pq3-espi-0.dtsi"
+	spi0: spi@7000 {
+		fsl,espi-num-chipselects = <1>;
+		interrupts = <22 0x2 0 0>;
+	};
+
+/include/ "pq3-gpio-0.dtsi"
+	gpio-controller@f000 {
+		interrupts = <19 0x2 0 0>;
+		};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,psc9131-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+dma@21300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0x21300 0x4>;
+	ranges = <0x0 0x21100 0x200>;
+	cell-index = <0>;
+
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <63 2>;
+	};
+
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupt-parent = <&mpic>;
+		interrupts = <64 2>;
+	};
+
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupt-parent = <&mpic>;
+		interrupts = <65 2>;
+	};
+};
+
+/include/ "pq3-usb2-dr-0.dtsi"
+usb@22000 {
+	compatible = "fsl-usb2-dr","fsl-usb2-dr-v2.2";
+	interrupts = <40 0x2 0 0>;
+};
+
+/include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		fsl,sdhci-auto-cmd12;
+		interrupts = <41 0x2 0 0>;
+	};
+
+/include/ "pq3-mpic.dtsi"
+mpic: pic@40000 {
+	#interrupt-cells = <2>;
+	compatible = "chrp,open-pic";
+	device_type = "open-pic";
+};
+
+timer@41100 {
+	compatible = "fsl,mpic-v1.2-msgr", "fsl,mpic-msg";
+	reg = <0x41400 0x200>;
+	interrupts = <
+		0xb0 2
+		0xb1 2
+		0xb2 2
+		0xb3 2>;
+};
+
+mdio@24000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x24000 0x1000 0xb0030 0x4>;
+	compatible = "fsl,etsec2-mdio";
+};
+
+enet0: ethernet@b0000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb0000 0x1000>;
+		rx-bit-map = <0xFF>;
+		tx-bit-map = <0xFF>;
+		interrupts = <26 2 0 0 27 2 0 0 28 2 0 0>;
+	};
+};
+
+enet1: ethernet@b1000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb1000 0x1000>;
+		rx-bit-map = <0xFF>;
+		tx-bit-map = <0xFF>;
+		interrupts = <33 2 0 0 34 2 0 0 35 2 0 0>;
+	};
+};
+
+global-utilities@e0000 {
+		compatible = "fsl,psc9131-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/psc9131si-pre.dtsi b/arch/powerpc/boot/dts/fsl/psc9131si-pre.dtsi
new file mode 100644
index 0000000..43c29cf
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/psc9131si-pre.dtsi
@@ -0,0 +1,59 @@
+/*
+ * PSC9131 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+/ {
+	compatible = "fsl,PSC9131";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,PSC9131@0 {
+			device_type = "cpu";
+			compatible = "fsl,e500v2";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/psc9131rdb.dts b/arch/powerpc/boot/dts/psc9131rdb.dts
new file mode 100644
index 0000000..23a35ed
--- /dev/null
+++ b/arch/powerpc/boot/dts/psc9131rdb.dts
@@ -0,0 +1,34 @@
+/*
+ * PSC9131 RDB Device Tree Source
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/psc9131si-pre.dtsi"
+
+/ {
+	model = "fsl,psc9131rdb";
+	compatible = "fsl,psc9131rdb";
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@ff71e000 {
+		/* NAND Flash on board */
+		ranges = <0x0 0x0 0x0 0xff800000 0x00010000>;
+		reg = <0x0 0xff71e000 0x0 0x2000>;
+	};
+
+	board_soc: soc: soc@ff700000 {
+		ranges = <0x0 0x0 0xff700000 0x100000>;
+	};
+};
+
+/include/ "psc9131rdb.dtsi"
+/include/ "fsl/psc9131si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/psc9131rdb.dtsi b/arch/powerpc/boot/dts/psc9131rdb.dtsi
new file mode 100644
index 0000000..6c08437
--- /dev/null
+++ b/arch/powerpc/boot/dts/psc9131rdb.dtsi
@@ -0,0 +1,187 @@
+/*
+ * PSC9131 RDB Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&board_ifc {
+
+	nand@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,ifc-nand";
+		reg = <0x0 0x0 0x10000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 3MB for u-boot Bootloader Image */
+				reg = <0x0 0x00300000>;
+				label = "NAND U-Boot Image";
+				read-only;
+			};
+
+			partition@300000 {
+				/* 1MB for DTB Image */
+				reg = <0x00300000 0x00100000>;
+				label = "NAND DTB Image";
+			};
+
+			partition@400000 {
+				/* 8MB for Linux Kernel Image */
+				reg = <0x00400000 0x00800000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@c00000 {
+				/* Rest space for Root file System Image */
+				reg = <0x00c00000 0x07400000>;
+				label = " NAND RFS Image";
+			};
+	};
+};
+
+&board_soc {
+	i2c@3000 {
+		gpio3: gpio@21 {
+			compatible = "nxp,pca9555";
+			reg = <0x21>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			polarity = <0x00>;
+		};
+		gpio4: gpio@23 {
+			compatible = "nxp,pca9555";
+			reg = <0x23>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			polarity = <0x00>;
+		};
+		gpio5: gpio@27 {
+			compatible = "nxp,pca9555";
+			reg = <0x27>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			polarity = <0x00>;
+		};
+		hwmon@4c {
+			compatible = "adi,adt7461";
+			reg = <0x4c>;
+		};
+		eeprom@52 {
+			compatible = "st-micro,24c02";
+			reg = <0x52>;
+		};
+	};
+
+	i2c@3100 {
+		status = "disabled";
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+
+			/* 512KB for u-boot Bootloader Image */
+			partition@0 {
+				reg = <0x0 0x00080000>;
+				label = "SPI (RO) U-Boot Image";
+				read-only;
+			};
+
+			/* 512KB for DTB Image */
+			partition@80000 {
+				reg = <0x00080000 0x00080000>;
+				label = "SPI DTB Image";
+				read-only;
+			};
+
+			/* 4MB for Linux Kernel Image */
+			partition@100000 {
+				reg = <0x00100000 0x00400000>;
+				label = "SPI Kernel Image";
+				read-only;
+			};
+
+			/* 4MB for Compressed RFS Image */
+			partition@500000 {
+				reg = <0x00500000 0x00400000>;
+				label = "SPI RFS";
+				read-only;
+			};
+
+			/* 7MB for RFS */
+			partition@900000 {
+				reg = <0x00900000 0x00700000>;
+				label = "SPI RFS";
+			};
+		};
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupt-parent = <&mpic>;
+			interrupts = <3 1 0 0>;
+			reg = <0x0>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupt-parent = <&mpic>;
+			interrupts = <2 1 0 0>;
+			reg = <0x3>;
+		};
+	};
+
+	sdhci@2e000 {
+		status = "disabled";
+	};
+
+	crypto: crypto@30000 {
+		status = "ok";
+	};
+
+	enet0: ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii";
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii";
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d7946be..f35b79b 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -91,6 +91,19 @@ config P1023_RDS
 	help
 	  This option enables support for the P1023 RDS board
 
+config PSC9131_RDB
+	bool "Freescale PSC9131RDB"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the PSC9131 RDB board
+	  Board has hetrogeneous SoC PSC9131. It combines Power Architecture
+	  e500v2 and DSP StarCore SC3850 core technologies. Power Architecture
+	  subsystem includes 1GByte DDR, 128MB NAND flash, 256Kbit EEPROM,
+	  128MB spi flash, USB-ULPI, eTSEC1, eTSEC2 connected on RGMII PHY,
+	  UART. The DSP portion of the chip consists of DSP core (SC3850) and
+	  various accelerators pertaining to DSP operations.
+	  PSC9131 is integrated device that targets Femto base station market.
+	  Manufacturer : Freescale Semiconductor, Inc
 config SOCRATES
 	bool "Socrates"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 9cb2d43..d1ffdca 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P3060_QDS)   += p3060_qds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
+obj-$(CONFIG_PSC9131_RDB) += psc913x_board.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/psc913x_board.c b/arch/powerpc/platforms/85xx/psc913x_board.c
new file mode 100644
index 0000000..b5d2626
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/psc913x_board.c
@@ -0,0 +1,99 @@
+/*
+ * PSC9131RDB Board Setup
+ *
+ * Author: Priyanka Jain <Priyanka.Jain@freescale.com>
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <asm/mpic.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/udbg.h>
+
+void __init psc913x_board_pic_init(void)
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
+	mpic = mpic_alloc(np, r.start, MPIC_WANTS_RESET |
+	  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
+	  0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	if (mpic != NULL)
+		mpic_init(mpic);
+	else
+		printk(KERN_ERR "Failed to allocate MPIC structure\n");
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init psc913x_board_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("psc913x_board_setup_arch()", 0);
+
+	printk(KERN_INFO "psc913x board from Freescale Semiconductor\n");
+}
+
+static struct of_device_id __initdata psc913x_board_ids[] = {
+	{ .type = "soc", },
+	{ .type = "dsp", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{},
+};
+
+static int __init psc913x_board_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, psc913x_board_ids, NULL);
+}
+machine_device_initcall(psc9131_rdb, psc913x_board_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+
+static int __init psc9131_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,psc9131rdb"))
+		return 1;
+	return 0;
+}
+
+define_machine(psc9131_rdb) {
+	.name			= "PSC9131 RDB",
+	.probe			= psc9131_rdb_probe,
+	.setup_arch		= psc913x_board_setup_arch,
+	.init_IRQ		= psc913x_board_pic_init,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.7.5.4

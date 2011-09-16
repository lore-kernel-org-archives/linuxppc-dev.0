Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07F41B70BF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2011 01:35:14 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/p3060qds: Add support for P3060QDS board
Date: Fri, 16 Sep 2011 10:35:07 -0500
Message-Id: <1316187307-2788-1-git-send-email-galak@kernel.crashing.org>
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shengzhou Liu <Shengzhou.Liu@freescale.com>

The P3060QDS is a Freescale reference board that hosts the six-core P3060 SOC.
The P3060 Processor combines six e500mc Power Architecture processor cores with
high-performance datapath acceleration architecture(DPAA), CoreNet fabric
infrastructure, as well as network and peripheral interfaces.

P3060QDS Board Overview:
Memory subsystem:
  - 2G Bytes unbuffered DDR3 SDRAM SO-DIMM(64bit bus)
  - 128M Bytes NOR flash single-chip memory
  - 16M Bytes SPI flash
  - 8K Bytes AT24C64 I2C EEPROM
Ethernet:
  - 4x1G + 4x1G/2.5G Ethernet controllers
  - 2xRGMII + 1xMII, three VSC8641 PHYs on board
  - Suport multiple Vitesse VSC8234 SGMII Cards in Slot1/2/3
PCIe: Two PCI Express 2.0 controllers/ports
USB:  Two USB2.0, USB1(TYPE-A) and USB2(TYPE-AB) on board
I2C:  Four I2C controllers
UART: Supports up to four UARTs
RapidIO: Supports two serial RapidIO ports

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Update localbus dts node (fix ranges and fpga node)

 arch/powerpc/boot/dts/p3060qds.dts           |  195 +++++++++
 arch/powerpc/boot/dts/p3060si.dtsi           |  600 ++++++++++++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig          |   12 +
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/p3060_qds.c      |   77 ++++
 6 files changed, 886 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p3060qds.dts
 create mode 100644 arch/powerpc/boot/dts/p3060si.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/p3060_qds.c

diff --git a/arch/powerpc/boot/dts/p3060qds.dts b/arch/powerpc/boot/dts/p3060qds.dts
new file mode 100644
index 0000000..5d04a55
--- /dev/null
+++ b/arch/powerpc/boot/dts/p3060qds.dts
@@ -0,0 +1,195 @@
+/*
+ * P3060QDS Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+/include/ "p3060si.dtsi"
+
+/ {
+	model = "fsl,P3060QDS";
+	compatible = "fsl,P3060QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc: soc@ffe000000 {
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		i2c@118100 {
+			eeprom@51 {
+				compatible = "at24,24c256";
+				reg = <0x51>;
+			};
+			eeprom@52 {
+				compatible = "at24,24c256";
+				reg = <0x52>;
+			};
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
+			};
+		};
+
+		usb0: usb@210000 {
+			phy_type = "ulpi";
+		};
+
+		usb1: usb@211000 {
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+	};
+
+	rapidio0: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x20000>;
+		ranges = <0 0 0xc 0x20000000 0 0x01000000>;
+	};
+
+	localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x1000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xffa00000 0x00040000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x08000000>;
+			bank-width = <2>;
+			device-width = <2>;
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x40000>;
+
+			partition@0 {
+				label = "NAND U-Boot Image";
+				reg = <0x0 0x02000000>;
+				read-only;
+			};
+
+			partition@2000000 {
+				label = "NAND Root File System";
+				reg = <0x02000000 0x10000000>;
+			};
+
+			partition@12000000 {
+				label = "NAND Compressed RFS Image";
+				reg = <0x12000000 0x08000000>;
+			};
+
+			partition@1a000000 {
+				label = "NAND Linux Kernel Image";
+				reg = <0x1a000000 0x04000000>;
+			};
+
+			partition@1e000000 {
+				label = "NAND DTB Image";
+				reg = <0x1e000000 0x01000000>;
+			};
+
+			partition@1f000000 {
+				label = "NAND Writable User area";
+				reg = <0x1f000000 0x21000000>;
+			};
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,p3060qds-fpga", "fsl,fpga-qixis";
+			reg = <3 0 0x100>;
+		};
+	};
+
+	pci0: pcie@ffe200000 {
+		reg = <0xf 0xfe200000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci1: pcie@ffe201000 {
+		reg = <0xf 0xfe201000 0 0x1000>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p3060si.dtsi b/arch/powerpc/boot/dts/p3060si.dtsi
new file mode 100644
index 0000000..0e2cd10
--- /dev/null
+++ b/arch/powerpc/boot/dts/p3060si.dtsi
@@ -0,0 +1,600 @@
+/*
+ * P3060 Silicon Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+
+/ {
+	compatible = "fsl,P3060";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		ccsr = &soc;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		msi0 = &msi0;
+		msi1 = &msi1;
+		msi2 = &msi2;
+
+		crypto = &crypto;
+		sec_jr0 = &sec_jr0;
+		sec_jr1 = &sec_jr1;
+		sec_jr2 = &sec_jr2;
+		sec_jr3 = &sec_jr3;
+		rtic_a = &rtic_a;
+		rtic_b = &rtic_b;
+		rtic_c = &rtic_c;
+		rtic_d = &rtic_d;
+		sec_mon = &sec_mon;
+
+		rio0 = &rapidio0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: PowerPC,e500mc@0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu1: PowerPC,e500mc@1 {
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu4: PowerPC,e500mc@4 {
+			device_type = "cpu";
+			reg = <4>;
+			next-level-cache = <&L2_4>;
+			L2_4: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu5: PowerPC,e500mc@5 {
+			device_type = "cpu";
+			reg = <5>;
+			next-level-cache = <&L2_5>;
+			L2_5: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu6: PowerPC,e500mc@6 {
+			device_type = "cpu";
+			reg = <6>;
+			next-level-cache = <&L2_6>;
+			L2_6: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu7: PowerPC,e500mc@7 {
+			device_type = "cpu";
+			reg = <7>;
+			next-level-cache = <&L2_7>;
+			L2_7: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+	};
+
+	soc: soc@ffe000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+
+		soc-sram-error {
+			compatible = "fsl,soc-sram-error";
+			interrupts = <16 2 1 29>;
+		};
+
+		corenet-law@0 {
+			compatible = "fsl,corenet-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <32>;
+		};
+
+		memory-controller@8000 {
+			compatible = "fsl,qoriq-memory-controller-v4.4", "fsl,qoriq-memory-controller";
+			reg = <0x8000 0x1000>;
+			interrupts = <16 2 1 23>;
+		};
+
+		cpc: l3-cache-controller@10000 {
+			compatible = "fsl,p3060-l3-cache-controller", "cache";
+			reg = <0x10000 0x1000
+			       0x11000 0x1000>;
+			interrupts = <16 2 1 27>;
+		};
+
+		corenet-cf@18000 {
+			compatible = "fsl,corenet-cf";
+			reg = <0x18000 0x1000>;
+			interrupts = <16 2 1 31>;
+			fsl,ccf-num-csdids = <32>;
+			fsl,ccf-num-snoopids = <32>;
+		};
+
+		iommu@20000 {
+			compatible = "fsl,pamu-v1.0", "fsl,pamu";
+			reg = <0x20000 0x5000>;
+			interrupts = <
+				24 2 0 0
+				16 2 1 30>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <4>;
+			reg = <0x40000 0x40000>;
+			compatible = "fsl,mpic", "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi0: msi@41600 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41600 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0 0 0
+				0xe1 0 0 0
+				0xe2 0 0 0
+				0xe3 0 0 0
+				0xe4 0 0 0
+				0xe5 0 0 0
+				0xe6 0 0 0
+				0xe7 0 0 0>;
+		};
+
+		msi1: msi@41800 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41800 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe8 0 0 0
+				0xe9 0 0 0
+				0xea 0 0 0
+				0xeb 0 0 0
+				0xec 0 0 0
+				0xed 0 0 0
+				0xee 0 0 0
+				0xef 0 0 0>;
+		};
+
+		msi2: msi@41a00 {
+			compatible = "fsl,mpic-msi";
+			reg = <0x41a00 0x200>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xf0 0 0 0
+				0xf1 0 0 0
+				0xf2 0 0 0
+				0xf3 0 0 0
+				0xf4 0 0 0
+				0xf5 0 0 0
+				0xf6 0 0 0
+				0xf7 0 0 0>;
+		};
+
+		guts: global-utilities@e0000 {
+			compatible = "fsl,qoriq-device-config-1.0";
+			reg = <0xe0000 0xe00>;
+			fsl,has-rstcr;
+			#sleep-cells = <1>;
+			fsl,liodn-bits = <12>;
+		};
+
+		pins: global-utilities@e0e00 {
+			compatible = "fsl,qoriq-pin-control-1.0";
+			reg = <0xe0e00 0x200>;
+			#sleep-cells = <2>;
+		};
+
+		clockgen: global-utilities@e1000 {
+			compatible = "fsl,p3060-clockgen", "fsl,qoriq-clockgen-1.0";
+			reg = <0xe1000 0x1000>;
+			clock-frequency = <0>;
+		};
+
+		rcpm: global-utilities@e2000 {
+			compatible = "fsl,qoriq-rcpm-1.0";
+			reg = <0xe2000 0x1000>;
+			#sleep-cells = <1>;
+		};
+
+		sfp: sfp@e8000 {
+			compatible = "fsl,p3060-sfp", "fsl,qoriq-sfp-1.0";
+			reg	   = <0xe8000 0x1000>;
+		};
+
+		serdes: serdes@ea000 {
+			compatible = "fsl,p3060-serdes";
+			reg	   = <0xea000 0x1000>;
+		};
+
+		dma0: dma@100300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p3060-dma", "fsl,eloplus-dma";
+			reg = <0x100300 0x4>;
+			ranges = <0x0 0x100100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupts = <28 2 0 0>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupts = <29 2 0 0>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupts = <30 2 0 0>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupts = <31 2 0 0>;
+			};
+		};
+
+		dma1: dma@101300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p3060-dma", "fsl,eloplus-dma";
+			reg = <0x101300 0x4>;
+			ranges = <0x0 0x101100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupts = <32 2 0 0>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupts = <33 2 0 0>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupts = <34 2 0 0>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p3060-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupts = <35 2 0 0>;
+			};
+		};
+
+		spi@110000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,p3060-espi", "fsl,mpc8536-espi";
+			reg = <0x110000 0x1000>;
+			interrupts = <53 0x2 0 0>;
+			fsl,espi-num-chipselects = <4>;
+		};
+
+		i2c@118000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x118000 0x100>;
+			interrupts = <38 2 0 0>;
+			dfsrr;
+		};
+
+		i2c@118100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x118100 0x100>;
+			interrupts = <38 2 0 0>;
+			dfsrr;
+		};
+
+		i2c@119000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <2>;
+			compatible = "fsl-i2c";
+			reg = <0x119000 0x100>;
+			interrupts = <39 2 0 0>;
+			dfsrr;
+		};
+
+		i2c@119100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <3>;
+			compatible = "fsl-i2c";
+			reg = <0x119100 0x100>;
+			interrupts = <39 2 0 0>;
+			dfsrr;
+		};
+
+		serial0: serial@11c500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11c500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <36 2 0 0>;
+		};
+
+		serial1: serial@11c600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11c600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <36 2 0 0>;
+		};
+
+		serial2: serial@11d500 {
+			cell-index = <2>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11d500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <37 2 0 0>;
+		};
+
+		serial3: serial@11d600 {
+			cell-index = <3>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11d600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <37 2 0 0>;
+		};
+
+		gpio0: gpio@130000 {
+			compatible = "fsl,p3060-gpio", "fsl,qoriq-gpio";
+			reg = <0x130000 0x1000>;
+			interrupts = <55 2 0 0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		usb0: usb@210000 {
+			compatible = "fsl,p3060-usb2-mph",
+					"fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+			reg = <0x210000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <44 0x2 0 0>;
+		};
+
+		usb1: usb@211000 {
+			compatible = "fsl,p3060-usb2-dr",
+					"fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+			reg = <0x211000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <45 0x2 0 0>;
+		};
+
+		crypto: crypto@300000 {
+			compatible = "fsl,sec-v4.1", "fsl,sec-v4.0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x300000 0x10000>;
+			ranges = <0 0x300000 0x10000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <92 2 0 0>;
+
+			sec_jr0: jr@1000 {
+				compatible = "fsl,sec-v4.1-job-ring", "fsl,sec-v4.0-job-ring";
+				reg = <0x1000 0x1000>;
+				interrupt-parent = <&mpic>;
+				interrupts = <88 2 0 0>;
+			};
+
+			sec_jr1: jr@2000 {
+				compatible = "fsl,sec-v4.1-job-ring", "fsl,sec-v4.0-job-ring";
+				reg = <0x2000 0x1000>;
+				interrupt-parent = <&mpic>;
+				interrupts = <89 2 0 0>;
+			};
+
+			sec_jr2: jr@3000 {
+				compatible = "fsl,sec-v4.1-job-ring", "fsl,sec-v4.0-job-ring";
+				reg = <0x3000 0x1000>;
+				interrupt-parent = <&mpic>;
+				interrupts = <90 2 0 0>;
+			};
+
+			sec_jr3: jr@4000 {
+				compatible = "fsl,sec-v4.1-job-ring", "fsl,sec-v4.0-job-ring";
+				reg = <0x4000 0x1000>;
+				interrupt-parent = <&mpic>;
+				interrupts = <91 2 0 0>;
+			};
+
+			rtic@6000 {
+				compatible = "fsl,sec-v4.1-rtic", "fsl,sec-v4.0-rtic";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x6000 0x100>;
+				ranges = <0x0 0x6100 0xe00>;
+
+				rtic_a: rtic-a@0 {
+					compatible = "fsl,sec-v4.1-rtic-memory", "fsl,sec-v4.0-rtic-memory";
+					reg = <0x00 0x20 0x100 0x80>;
+				};
+
+				rtic_b: rtic-b@20 {
+					compatible = "fsl,sec-v4.1-rtic-memory", "fsl,sec-v4.0-rtic-memory";
+					reg = <0x20 0x20 0x200 0x80>;
+				};
+
+				rtic_c: rtic-c@40 {
+					compatible = "fsl,sec-v4.1-rtic-memory", "fsl,sec-v4.0-rtic-memory";
+					reg = <0x40 0x20 0x300 0x80>;
+				};
+
+				rtic_d: rtic-d@60 {
+					compatible = "fsl,sec-v4.1-rtic-memory", "fsl,sec-v4.0-rtic-memory";
+					reg = <0x60 0x20 0x500 0x80>;
+				};
+			};
+		};
+
+		sec_mon: sec_mon@314000 {
+			compatible = "fsl,sec-v4.1-mon", "fsl,sec-v4.0-mon";
+			reg = <0x314000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <93 2 0 0>;
+		};
+	};
+
+	rapidio0: rapidio@ffe0c0000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "fsl,rapidio-delta";
+		interrupts = <
+			16 2 1 11 /* err_irq */
+			56 2 0 0  /* bell_outb_irq */
+			57 2 0 0  /* bell_inb_irq */
+			60 2 0 0  /* msg1_tx_irq */
+			61 2 0 0  /* msg1_rx_irq */
+			62 2 0 0  /* msg2_tx_irq */
+			63 2 0 0>; /* msg2_rx_irq */
+	};
+
+	localbus@ffe124000 {
+		compatible = "fsl,p3060-elbc", "fsl,elbc", "simple-bus";
+		interrupts = <25 2 0 0>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+	};
+
+	pci0: pcie@ffe200000 {
+		compatible = "fsl,p3060-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0x0 0xff>;
+		clock-frequency = <33333333>;
+		fsl,msi = <&msi0>;
+		interrupts = <16 2 1 15>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <16 2 1 15>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 40 1 0 0
+				0000 0 0 2 &mpic 1 1 0 0
+				0000 0 0 3 &mpic 2 1 0 0
+				0000 0 0 4 &mpic 3 1 0 0
+				>;
+		};
+	};
+
+	pci1: pcie@ffe201000 {
+		compatible = "fsl,p3060-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0 0xff>;
+		clock-frequency = <33333333>;
+		fsl,msi = <&msi1>;
+		interrupts = <16 2 1 14>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <16 2 1 14>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 41 1 0 0
+				0000 0 0 2 &mpic 5 1 0 0
+				0000 0 0 3 &mpic 6 1 0 0
+				0000 0 0 4 &mpic 7 1 0 0
+				>;
+		};
+	};
+};
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 49cfe85..014780c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -25,6 +25,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_P2041_RDB=y
 CONFIG_P3041_DS=y
+CONFIG_P3060_QDS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
 CONFIG_HIGHMEM=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ae82322..6df57f0 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -195,6 +195,18 @@ config P3041_DS
 	help
 	  This option enables support for the P3041 DS board
 
+config P3060_QDS
+	bool "Freescale P3060 QDS"
+	select DEFAULT_UIMAGE
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the P3060 QDS board
+
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 39e6c22..bc5acb9 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
 obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
+obj-$(CONFIG_P3060_QDS)   += p3060_qds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/p3060_qds.c b/arch/powerpc/platforms/85xx/p3060_qds.c
new file mode 100644
index 0000000..01dcf44
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p3060_qds.c
@@ -0,0 +1,77 @@
+/*
+ * P3060 QDS Setup
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/phy.h>
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/ehv_pic.h>
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p3060_qds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,P3060QDS"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,P3060QDS-hv")) {
+		ppc_md.init_IRQ = ehv_pic_init;
+		ppc_md.get_irq = ehv_pic_get_irq;
+		ppc_md.restart = fsl_hv_restart;
+		ppc_md.power_off = fsl_hv_halt;
+		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		 */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(p3060_qds) {
+	.name			= "P3060 QDS",
+	.probe			= p3060_qds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_coreint_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+	.power_save		= e500_idle,
+};
+
+machine_device_initcall(p3060_qds, declare_of_platform_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p3060_qds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.3.4

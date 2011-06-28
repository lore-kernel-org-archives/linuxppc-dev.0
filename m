Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 153A4B6F5A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2011 18:46:27 +1000 (EST)
Received: from mail101-tx2 (localhost.localdomain [127.0.0.1])	by
	mail101-tx2-R.bigfish.com (Postfix) with ESMTP id E60221050220	for
	<linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2011 08:46:23 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.247])	by
	mail101-tx2.bigfish.com (Postfix) with ESMTP id 32E0CC30050	for
	<linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2011 08:46:23 +0000 (UTC)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add p2040 RDB board support
Date: Tue, 28 Jun 2011 15:52:34 +0800
Message-ID: <1309247554-13580-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P2040RDB Specification:
-----------------------
2Gbyte unbuffered DDR3 SDRAM SO-DIMM(64bit bus)
128 Mbyte NOR flash single-chip memory
256 Kbit M24256 I2C EEPROM
16 Mbyte SPI memory
SD connector to interface with the SD memory card
dTSEC1: connected to the Vitesse SGMII PHY (VSC8221)
dTSEC2: connected to the Vitesse SGMII PHY (VSC8221)
dTSEC3: connected to the Vitesse SGMII PHY (VSC8221)
dTSEC4: connected to the Vitesse RGMII PHY (VSC8641)
dTSEC5: connected to the Vitesse RGMII PHY (VSC8641)
I2C1: Real time clock, Temperature sensor
I2C2: Vcore Regulator, 256Kbit I2C Bus EEPROM
SATA: Lanes C and Land D of Bank2 are connected to two SATA connectors
UART: supports two UARTs up to 115200 bps for console
USB 2.0: connected via a internal UTMI PHY to two TYPE-A interfaces
PCIe:
 - Lanes E, F, G and H of Bank1 are connected to one x4 PCIe SLOT1
 - Lanes C and Land D of Bank2 are connected to one x4 PCIe SLOT2

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
Based on http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

 arch/powerpc/boot/dts/p2040rdb.dts           |  166 +++++++
 arch/powerpc/boot/dts/p2040si.dtsi           |  623 ++++++++++++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig          |   12 +
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/p2040_rdb.c      |   88 ++++
 6 files changed, 891 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p2040rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p2040si.dtsi
 create mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c

diff --git a/arch/powerpc/boot/dts/p2040rdb.dts b/arch/powerpc/boot/dts/p2040rdb.dts
new file mode 100644
index 0000000..7d84e39
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2040rdb.dts
@@ -0,0 +1,166 @@
+/*
+ * P2040RDB Device Tree Source
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
+/include/ "p2040si.dtsi"
+
+/ {
+	model = "fsl,P2040RDB";
+	compatible = "fsl,P2040RDB";
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
+		i2c@118000 {
+			lm75b@48 {
+				compatible = "nxp,lm75a";
+				reg = <0x48>;
+			};
+			eeprom@50 {
+				compatible = "at24,24c256";
+				reg = <0x50>;
+			};
+			rtc@68 {
+				compatible = "pericom,pt7c4338";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@118100 {
+			eeprom@50 {
+				compatible = "at24,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		usb0: usb@210000 {
+			phy_type = "utmi";
+		};
+
+		usb1: usb@211000 {
+			dr_mode = "host";
+			phy_type = "utmi";
+		};
+	};
+
+	localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x1000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x08000000>;
+			bank-width = <2>;
+			device-width = <2>;
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
+
+	pci2: pcie@ffe202000 {
+		reg = <0xf 0xfe202000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
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
diff --git a/arch/powerpc/boot/dts/p2040si.dtsi b/arch/powerpc/boot/dts/p2040si.dtsi
new file mode 100644
index 0000000..0babc1d
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2040si.dtsi
@@ -0,0 +1,623 @@
+/*
+ * P2040 Silicon Device Tree Source
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
+	compatible = "fsl,P2040";
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
+		pci2 = &pci2;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		sdhc = &sdhc;
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
+		cpu2: PowerPC,e500mc@2 {
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2_2>;
+			L2_2: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu3: PowerPC,e500mc@3 {
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2_3>;
+			L2_3: l2-cache {
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
+			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
+			reg = <0x8000 0x1000>;
+			interrupts = <16 2 1 23>;
+		};
+
+		cpc: l3-cache-controller@10000 {
+			compatible = "fsl,p2040-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
+			reg = <0x10000 0x1000>;
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
+			reg = <0x20000 0x4000>;
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
+			compatible = "fsl,p2040-clockgen", "fsl,qoriq-clockgen-1.0";
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
+			compatible = "fsl,p2040-sfp", "fsl,qoriq-sfp-1.0";
+			reg	   = <0xe8000 0x1000>;
+		};
+
+		serdes: serdes@ea000 {
+			compatible = "fsl,p2040-serdes";
+			reg	   = <0xea000 0x1000>;
+		};
+
+		dma0: dma@100300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p2040-dma", "fsl,eloplus-dma";
+			reg = <0x100300 0x4>;
+			ranges = <0x0 0x100100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupts = <28 2 0 0>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupts = <29 2 0 0>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupts = <30 2 0 0>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p2040-dma-channel",
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
+			compatible = "fsl,p2040-dma", "fsl,eloplus-dma";
+			reg = <0x101300 0x4>;
+			ranges = <0x0 0x101100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupts = <32 2 0 0>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupts = <33 2 0 0>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p2040-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupts = <34 2 0 0>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p2040-dma-channel",
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
+			compatible = "fsl,p2040-espi", "fsl,mpc8536-espi";
+			reg = <0x110000 0x1000>;
+			interrupts = <53 0x2 0 0>;
+			fsl,espi-num-chipselects = <4>;
+
+		};
+
+		sdhc: sdhc@114000 {
+			compatible = "fsl,p2040-esdhc", "fsl,esdhc";
+			reg = <0x114000 0x1000>;
+			interrupts = <48 2 0 0>;
+			sdhci,auto-cmd12;
+			clock-frequency = <0>;
+		};
+
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
+			compatible = "fsl,p2040-gpio", "fsl,qoriq-gpio";
+			reg = <0x130000 0x1000>;
+			interrupts = <55 2 0 0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		usb0: usb@210000 {
+			compatible = "fsl,p2040-usb2-mph",
+					"fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+			reg = <0x210000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <44 0x2 0 0>;
+			port0;
+		};
+
+		usb1: usb@211000 {
+			compatible = "fsl,p2040-usb2-dr",
+					"fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+			reg = <0x211000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <45 0x2 0 0>;
+ 		};
+
+		sata@220000 {
+			compatible = "fsl,p2040-sata", "fsl,pq-sata-v2";
+			reg = <0x220000 0x1000>;
+			interrupts = <68 0x2 0 0>;
+		};
+
+		sata@221000 {
+			compatible = "fsl,p2040-sata", "fsl,pq-sata-v2";
+			reg = <0x221000 0x1000>;
+			interrupts = <69 0x2 0 0>;
+		};
+
+		crypto: crypto@300000 {
+			compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x300000 0x10000>;
+			ranges = <0 0x300000 0x10000>;
+			interrupts = <92 2 0 0>;
+
+			sec_jr0: jr@1000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x1000 0x1000>;
+				interrupts = <88 2 0 0>;
+			};
+
+			sec_jr1: jr@2000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x2000 0x1000>;
+				interrupts = <89 2 0 0>;
+			};
+
+			sec_jr2: jr@3000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x3000 0x1000>;
+				interrupts = <90 2 0 0>;
+			};
+
+			sec_jr3: jr@4000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x4000 0x1000>;
+				interrupts = <91 2 0 0>;
+			};
+
+			rtic@6000 {
+				compatible = "fsl,sec-v4.2-rtic",
+					     "fsl,sec-v4.0-rtic";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x6000 0x100>;
+				ranges = <0x0 0x6100 0xe00>;
+
+				rtic_a: rtic-a@0 {
+					compatible = "fsl,sec-v4.2-rtic-memory",
+						     "fsl,sec-v4.0-rtic-memory";
+					reg = <0x00 0x20 0x100 0x80>;
+				};
+
+				rtic_b: rtic-b@20 {
+					compatible = "fsl,sec-v4.2-rtic-memory",
+						     "fsl,sec-v4.0-rtic-memory";
+					reg = <0x20 0x20 0x200 0x80>;
+				};
+
+				rtic_c: rtic-c@40 {
+					compatible = "fsl,sec-v4.2-rtic-memory",
+						     "fsl,sec-v4.0-rtic-memory";
+					reg = <0x40 0x20 0x300 0x80>;
+				};
+
+				rtic_d: rtic-d@60 {
+					compatible = "fsl,sec-v4.2-rtic-memory",
+						     "fsl,sec-v4.0-rtic-memory";
+					reg = <0x60 0x20 0x500 0x80>;
+				};
+			};
+		};
+
+		sec_mon: sec_mon@314000 {
+			compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
+			reg = <0x314000 0x1000>;
+			interrupts = <93 2 0 0>;
+		};
+
+	};
+
+	localbus@ffe124000 {
+		compatible = "fsl,p2040-elbc", "fsl,elbc", "simple-bus";
+		interrupts = <25 2 0 0>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+	};
+
+	pci0: pcie@ffe200000 {
+		compatible = "fsl,p2040-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0x0 0xff>;
+		clock-frequency = <0x1fca055>;
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
+		compatible = "fsl,p2040-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0 0xff>;
+		clock-frequency = <0x1fca055>;
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
+
+	pci2: pcie@ffe202000 {
+		compatible = "fsl,p2040-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0x0 0xff>;
+		clock-frequency = <0x1fca055>;
+		fsl,msi = <&msi2>;
+		interrupts = <16 2 1 13>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <16 2 1 13>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 42 1 0 0
+				0000 0 0 2 &mpic 9 1 0 0
+				0000 0 0 3 &mpic 10 1 0 0
+				0000 0 0 4 &mpic 11 1 0 0
+				>;
+		};
+	};
+};
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 53f3949..8ea7137 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -23,6 +23,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_P2040_RDB=y
 CONFIG_P3041_DS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4706c71..498534c 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -171,6 +171,18 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
+config P2040_RDB
+	bool "Freescale P2040 RDB"
+	select DEFAULT_UIMAGE
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the P2040 RDB board
+
 config P3041_DS
 	bool "Freescale P3041 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 06b0c08..a971b32 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
+obj-$(CONFIG_P2040_RDB)   += p2040_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
diff --git a/arch/powerpc/platforms/85xx/p2040_rdb.c b/arch/powerpc/platforms/85xx/p2040_rdb.c
new file mode 100644
index 0000000..32b56ac
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p2040_rdb.c
@@ -0,0 +1,88 @@
+/*
+ * P2040 RDB Setup
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
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/phy.h>
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
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/ehv_pic.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p2040_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,P2040RDB-hv")) {
+		ppc_md.init_IRQ = ehv_pic_init;
+		ppc_md.get_irq = ehv_pic_get_irq;
+		ppc_md.restart = fsl_hv_restart;
+		ppc_md.power_off = fsl_hv_halt;
+		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(p2040_rdb) {
+	.name			= "P2040 RDB",
+	.probe			= p2040_rdb_probe,
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
+machine_device_initcall(p2040_rdb, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p2040_rdb, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.5.1

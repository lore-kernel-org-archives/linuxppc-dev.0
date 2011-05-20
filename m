Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 079B6B71F6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/14] powerpc/85xx: Add basic P1023RDS board support
Date: Fri, 20 May 2011 01:09:27 -0500
Message-Id: <1305871771-16334-10-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

The P1023 processor is an e500v2 based SoC that utilizes the DPAA
networking architecture.  This adds basic board support for non-DPAA
functionality (device tree, board file, etc).

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1023rds.dts           |  546 ++++++++++++++++++++++++++
 arch/powerpc/configs/85xx/p1023rds_defconfig |  173 ++++++++
 arch/powerpc/configs/mpc85xx_defconfig       |    7 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    6 +-
 arch/powerpc/platforms/85xx/Kconfig          |    6 +
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/p1023_rds.c      |  162 ++++++++
 7 files changed, 892 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1023rds.dts
 create mode 100644 arch/powerpc/configs/85xx/p1023rds_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/p1023_rds.c

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
new file mode 100644
index 0000000..bfa96aa
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -0,0 +1,546 @@
+/*
+ * P1023 RDS Device Tree Source
+ *
+ * Copyright 2010-2011 Freescale Semiconductor Inc.
+ *
+ * Author: Roy Zang <tie-fei.zang@freescale.com>
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
+	model = "fsl,P1023";
+	compatible = "fsl,P1023RDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
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
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: PowerPC,P1023@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu1: PowerPC,P1023@1 {
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
+	soc@ff600000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,p1023-immr", "simple-bus";
+		ranges = <0x0 0x0 0xff600000 0x200000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,p1023-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <16 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,p1023-memory-controller";
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
+			rtc@68 {
+				compatible = "dallas,ds1374";
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
+			compatible = "fsl,p1023-espi", "fsl,mpc8536-espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,espi-num-chipselects = <4>;
+
+			fsl_dataflash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at45db081d";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@u-boot {
+					/* 512KB for u-boot Bootloader Image */
+					label = "u-boot-spi";
+					reg = <0x00000000 0x00080000>;
+					read-only;
+				};
+				partition@dtb {
+					/* 512KB for DTB Image */
+					label = "dtb-spi";
+					reg = <0x00080000 0x00080000>;
+					read-only;
+				};
+			};
+		};
+
+		gpio: gpio-controller@f000 {
+			#gpio-cells = <2>;
+			compatible = "fsl,qoriq-gpio";
+			reg = <0xf000 0x100>;
+			interrupts = <47 0x2>;
+			interrupt-parent = <&mpic>;
+			gpio-controller;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,p1023-l2-cache-controller";
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
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+		crypto: crypto@300000 {
+			compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x30000 0x10000>;
+			ranges = <0 0x30000 0x10000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <58 2>;
+
+			sec_jr0: jr@1000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x1000 0x1000>;
+				interrupts = <45 2>;
+			};
+
+			sec_jr1: jr@2000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x2000 0x1000>;
+				interrupts = <45 2>;
+			};
+
+			sec_jr2: jr@3000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x3000 0x1000>;
+				interrupts = <57 2>;
+			};
+
+			sec_jr3: jr@4000 {
+				compatible = "fsl,sec-v4.2-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg = <0x4000 0x1000>;
+				interrupts = <57 2>;
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
+		power@e0070{
+			compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc",
+			             "fsl,p1022-pmc";
+			reg = <0xe0070 0x20>;
+			etsec1_clk: soc-clk@B0{
+				fsl,pmcdr-mask = <0x00000080>;
+			};
+			etsec2_clk: soc-clk@B1{
+				fsl,pmcdr-mask = <0x00000040>;
+			};
+			etsec3_clk: soc-clk@B2{
+				fsl,pmcdr-mask = <0x00000020>;
+			};
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
+			compatible = "fsl,p1023-msi", "fsl,mpic-msi";
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
+			compatible = "fsl,p1023-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	localbus@ff605000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,p1023-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xff605000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		/* NOR Flash, BCSR */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xe0000000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x02000000>;
+			bank-width = <1>;
+			device-width = <1>;
+			partition@0 {
+				label = "ramdisk";
+				reg = <0x00000000 0x01c00000>;
+			};
+			partition@1c00000 {
+				label = "kernel";
+				reg = <0x01c00000 0x002e0000>;
+			};
+			partiton@1ee0000 {
+				label = "dtb";
+				reg = <0x01ee0000 0x00020000>;
+			};
+			partition@1f00000 {
+				label = "firmware";
+				reg = <0x01f00000 0x00080000>;
+				read-only;
+			};
+			partition@1f80000 {
+				label = "u-boot";
+				reg = <0x01f80000 0x00080000>;
+				read-only;
+			};
+		};
+
+		fpga@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1023rds-fpga";
+			reg = <1 0 0x8000>;
+			ranges = <0 1 0 0x8000>;
+
+			bcsr@20 {
+				compatible = "fsl,p1023rds-bcsr";
+				reg = <0x20 0x20>;
+			};
+		};
+	};
+
+	pci0: pcie@ff60a000 {
+		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+		cell-index = <1>;
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xff60a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1
+				>;
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ff609000 {
+		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+		cell-index = <2>;
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xff609000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 4 1
+				0000 0 0 2 &mpic 5 1
+				0000 0 0 3 &mpic 6 1
+				0000 0 0 4 &mpic 7 1
+				>;
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
+	pci2: pcie@ff60b000 {
+		cell-index = <3>;
+		compatible = "fsl,p1023-pcie", "fsl,qoriq-pcie-v2.2";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xff60b000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 8 1
+				0000 0 0 2 &mpic 9 1
+				0000 0 0 3 &mpic 10 1
+				0000 0 0 4 &mpic 11 1
+				>;
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
diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
new file mode 100644
index 0000000..980ff8f
--- /dev/null
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -0,0 +1,173 @@
+CONFIG_PPC_85xx=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_AUDIT=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_EMBEDDED=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_P1023_RDS=y
+CONFIG_QUICC_ENGINE=y
+CONFIG_QE_GPIO=y
+CONFIG_CPM2=y
+CONFIG_MPC8xxx_GPIO=y
+CONFIG_HIGHMEM=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=m
+CONFIG_MATH_EMULATION=y
+CONFIG_SWIOTLB=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+CONFIG_INET_ESP=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
+CONFIG_EEPROM_LEGACY=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_ATA=y
+CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
+CONFIG_NET_ETHERNET=y
+CONFIG_FS_ENET=y
+CONFIG_E1000E=y
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_INPUT_FF_MEMLESS=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_QE=m
+CONFIG_HW_RANDOM=y
+CONFIG_NVRAM=y
+CONFIG_I2C=y
+CONFIG_I2C_CPM=m
+CONFIG_I2C_MPC=y
+# CONFIG_HWMON is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
+# CONFIG_NET_DMA is not set
+CONFIG_STAGING=y
+# CONFIG_STAGING_EXCLUDE_BUILD is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_ADFS_FS=m
+CONFIG_AFFS_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
+CONFIG_CRAMFS=y
+CONFIG_VXFS_FS=m
+CONFIG_HPFS_FS=m
+CONFIG_QNX4FS_FS=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
+CONFIG_CRC_T10DIF=y
+CONFIG_FRAME_WARN=8092
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_VIRQ_DEBUG=y
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 96b89df..1ac5198 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_AUDIT=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -26,6 +27,7 @@ CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
 CONFIG_P1022_DS=y
+CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_XES_MPC85xx=y
@@ -44,7 +46,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
@@ -65,8 +66,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NET_IPIP=y
-CONFIG_NET_IPGRE=y
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -170,7 +169,6 @@ CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
@@ -205,7 +203,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_VIRQ_DEBUG=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index de65841..f77eddd 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -7,6 +7,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_AUDIT=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -28,6 +29,7 @@ CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
 CONFIG_P1022_DS=y
+CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_XES_MPC85xx=y
@@ -46,7 +48,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
@@ -67,8 +68,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NET_IPIP=y
-CONFIG_NET_IPGRE=y
-CONFIG_NET_IPGRE_BROADCAST=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
@@ -172,7 +171,6 @@ CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index b6976e1..6db0275 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -75,6 +75,12 @@ config P1022_DS
 	help
 	  This option enables support for the Freescale P1022DS reference board.
 
+config P1023_RDS
+	bool "Freescale P1023 RDS"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the P1023 RDS board
+
 config SOCRATES
 	bool "Socrates"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index dd70db7..5c08be5 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
+obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
new file mode 100644
index 0000000..835e0b3
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright 2010-2011 Freescale Semiconductor, Inc.
+ *
+ * Author: Roy Zang <tie-fei.zang@freescale.com>
+ *
+ * Description:
+ * P1023 RDS Board Setup
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
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
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+#ifdef CONFIG_SMP
+void __init mpc85xx_smp_init(void);
+#endif
+
+static void __init mpc85xx_rds_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("p1023_rds_setup_arch()", 0);
+
+	/* Map BCSR area */
+	np = of_find_node_by_name(NULL, "bcsr");
+	if (np != NULL) {
+		static u8 __iomem *bcsr_regs;
+
+		bcsr_regs = of_iomap(np, 0);
+		of_node_put(np);
+
+		if (!bcsr_regs) {
+			printk(KERN_ERR
+			       "BCSR: Failed to map bcsr register space\n");
+			return;
+		} else {
+#define BCSR15_I2C_BUS0_SEG_CLR		0x07
+#define BCSR15_I2C_BUS0_SEG2		0x02
+/*
+ * Note: Accessing exclusively i2c devices.
+ *
+ * The i2c controller selects initially ID EEPROM in the u-boot;
+ * but if menu configuration selects RTC support in the kernel,
+ * the i2c controller switches to select RTC chip in the kernel.
+ */
+#ifdef CONFIG_RTC_CLASS
+			/* Enable RTC chip on the segment #2 of i2c */
+			clrbits8(&bcsr_regs[15], BCSR15_I2C_BUS0_SEG_CLR);
+			setbits8(&bcsr_regs[15], BCSR15_I2C_BUS0_SEG2);
+#endif
+
+			iounmap(bcsr_regs);
+		}
+	}
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,p1023-pcie")
+		fsl_add_bridge(np, 0);
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+}
+
+static struct of_device_id p1023_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+
+static int __init p1023_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, p1023_ids, NULL);
+
+	return 0;
+}
+
+machine_device_initcall(p1023_rds, p1023_publish_devices);
+
+static void __init mpc85xx_rds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
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
+		MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
+		MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
+		0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+static int __init p1023_rds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1023RDS");
+
+}
+
+define_machine(p1023_rds) {
+	.name			= "P1023 RDS",
+	.probe			= p1023_rds_probe,
+	.setup_arch		= mpc85xx_rds_setup_arch,
+	.init_IRQ		= mpc85xx_rds_pic_init,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
+
-- 
1.7.3.4

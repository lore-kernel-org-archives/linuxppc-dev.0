Return-Path: <Shengzhou.Liu@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36C2D2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 23:08:22 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] powerpc/fsl-booke: Add T2080QDS board support
Date: Fri, 15 Nov 2013 19:22:41 +0800
Message-ID: <1384514562-21137-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1384514562-21137-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1384514562-21137-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for Freescale T2080QDS Development System Board.
The T2080QDS Development System is a high-performance computing,
evaluation, and development platform that supports T2080 QorIQ
Power Architecture processor, with following major features:

 - Four 64-bit dual-threaded e6500 cores up to 1.8 GHz
 - Hierarchical interconnect fabric
 - One 32-/64-bit DDR3/3L SDRAM memory controllers with ECC and interleaving
   support and memory pre-fetch engine
 - Data Path Acceleration Architecture (DPAA) integrating FMAN, QMAN, BMAN,
   SEC5.2, PME2.1, DCE and RMAN
 - Ethernet interfaces: 8 mEMACs(four 1Gbps MACs and four 10Gbps/1Gbps MACs)
 - Sixteen SerDes lanes at up to 10.3125 GHz
 - Eight Ethernet interfaces supporting combinations of eight 1Gbps/four 10Gbps
   or four 2.5Gbps Ethernet MACs
 - High-speed peripheral interfaces
   - Four PCI Express controllers (two PCIe 2.0 and two PCIe 3.0 with SR-IOV)
   - Two Serial RapidIO 2.0 controllers/ports running at up to 5 GHz
 - Additional peripheral interfaces
   - Two SATA 2.0 controllers
   - Two high-speed USB 2.0 controllers with integrated PHY
   - Enhanced secure digital host controller (SD/SDHC/SDXC/eMMC)
   - Enhanced serial peripheral interface (eSPI)
   - Four I2C controllers and four 2-pin UARTs or two 4-pin UARTs
   - Integrated Flash controller supporting NAND and NOR flash
 - Three eight-channel DMA engines
 - Support for hardware virtualization and partitioning enforcement
 - QorIQ Platform's Trust Architecture 2.0

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t2080si-post.dtsi | 406 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t2080si-pre.dtsi  | 100 +++++++
 arch/powerpc/boot/dts/t2080qds.dts          | 276 +++++++++++++++++++
 3 files changed, 782 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/t2080si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t2080si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/t2080qds.dts

diff --git a/arch/powerpc/boot/dts/fsl/t2080si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2080si-post.dtsi
new file mode 100644
index 0000000..d84c55a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t2080si-post.dtsi
@@ -0,0 +1,406 @@
+/*
+ * T2080 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+	interrupts = <25 2 0 0>;
+};
+
+/* controller at 0x240000 */
+&pci0 {
+	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie-v3.0", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <20 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <20 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 40 1 0 0
+			0000 0 0 2 &mpic 1 1 0 0
+			0000 0 0 3 &mpic 2 1 0 0
+			0000 0 0 4 &mpic 3 1 0 0
+			>;
+	};
+};
+
+/* controller at 0x250000 */
+&pci1 {
+	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie-v3.0", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 0xff>;
+	interrupts = <21 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <21 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 41 1 0 0
+			0000 0 0 2 &mpic 5 1 0 0
+			0000 0 0 3 &mpic 6 1 0 0
+			0000 0 0 4 &mpic 7 1 0 0
+			>;
+	};
+};
+
+/* controller at 0x260000 */
+&pci2 {
+	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie-v3.0", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <22 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <22 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 42 1 0 0
+			0000 0 0 2 &mpic 9 1 0 0
+			0000 0 0 3 &mpic 10 1 0 0
+			0000 0 0 4 &mpic 11 1 0 0
+			>;
+	};
+};
+
+/* controller at 0x270000 */
+&pci3 {
+	compatible = "fsl,t2080-pcie", "fsl,qoriq-pcie-v3.0", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <23 2 0 0>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <23 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 43 1 0 0
+			0000 0 0 2 &mpic 0 1 0 0
+			0000 0 0 3 &mpic 4 1 0 0
+			0000 0 0 4 &mpic 8 1 0 0
+			>;
+	};
+};
+
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
+};
+
+&dcsr {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,dcsr", "simple-bus";
+
+	dcsr-epu@0 {
+		compatible = "fsl,t2080-dcsr-epu", "fsl,dcsr-epu";
+		interrupts = <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0
+			      94 2 0 0
+			      95 2 0 0>;
+		reg = <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible = "fsl,t2080-dcsr-cnpc", "fsl,dcsr-cnpc";
+		reg = <0x1000 0x1000 0x1002000 0x10000>;
+	};
+	dcsr-nxc@2000 {
+		compatible = "fsl,dcsr-nxc";
+		reg = <0x2000 0x1000>;
+	};
+	dcsr-corenet {
+		compatible = "fsl,dcsr-corenet";
+		reg = <0x8000 0x1000 0x1A000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,t2080-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,t2080-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,t2080-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,t2080-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x30000 0x1000 0x1022000 0x10000>;
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,t2080-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x31000 0x1000 0x1042000 0x10000>;
+	};
+	dcsr-snpc@32000 {
+		compatible = "fsl,t2080-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x32000 0x1000 0x1062000 0x10000>;
+	};
+	dcsr-cpu-sb-proxy@100000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu0>;
+		reg = <0x100000 0x1000 0x101000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@108000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x108000 0x1000 0x109000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@110000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu2>;
+		reg = <0x110000 0x1000 0x111000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@118000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu3>;
+		reg = <0x118000 0x1000 0x119000 0x1000>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "simple-bus";
+
+	soc-sram-error {
+		compatible = "fsl,soc-sram-error";
+		interrupts = <16 2 1 29>;
+	};
+
+	corenet-law@0 {
+		compatible = "fsl,corenet-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <32>;
+	};
+
+	ddr1: memory-controller@8000 {
+		compatible = "fsl,qoriq-memory-controller-v4.7",
+				"fsl,qoriq-memory-controller";
+		reg = <0x8000 0x1000>;
+		interrupts = <16 2 1 23>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,t2080-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000
+		       0x11000 0x1000
+		       0x12000 0x1000>;
+		interrupts = <16 2 1 27
+			      16 2 1 26
+			      16 2 1 25>;
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,corenet2-cf";
+		reg = <0x18000 0x1000>;
+		interrupts = <16 2 1 31>;
+		fsl,ccf-num-csdids = <32>;
+		fsl,ccf-num-snoopids = <32>;
+	};
+
+	iommu@20000 {
+		compatible = "fsl,pamu-v1.0", "fsl,pamu";
+		reg = <0x20000 0x6000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+	};
+
+/include/ "qoriq-mpic4.3.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,t2080-device-config", "fsl,qoriq-device-config-2.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0",
+				   "fixed-clock";
+		reg = <0xe1000 0x1000>;
+		clock-output-names = "sysclk";
+		#clock-cells = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820>;
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				      "pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux0";
+		};
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				      "pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux1";
+		};
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t2080-rcpm", "fsl,qoriq-rcpm-2.0";
+		reg = <0xe2000 0x1000>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,t2080-sfp";
+		reg = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,t2080-serdes";
+		reg = <0xea000 0x4000>;
+	};
+
+/include/ "elo3-dma-0.dtsi"
+/include/ "elo3-dma-1.dtsi"
+/include/ "elo3-dma-2.dtsi"
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		compatible = "fsl,t2080-esdhc", "fsl,esdhc";
+		sdhci,auto-cmd12;
+	};
+/include/ "qoriq-i2c-0.dtsi"
+/include/ "qoriq-i2c-1.dtsi"
+/include/ "qoriq-duart-0.dtsi"
+/include/ "qoriq-duart-1.dtsi"
+/include/ "qoriq-gpio-0.dtsi"
+/include/ "qoriq-gpio-1.dtsi"
+/include/ "qoriq-gpio-2.dtsi"
+/include/ "qoriq-gpio-3.dtsi"
+/include/ "qoriq-usb2-mph-0.dtsi"
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-mph-v2.4", "fsl-usb2-mph";
+		phy_type = "utmi";
+		port0;
+	};
+/include/ "qoriq-usb2-dr-0.dtsi"
+	usb1: usb@211000 {
+		compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+		dr_mode = "host";
+		phy_type = "utmi";
+	};
+/include/ "qoriq-sata2-0.dtsi"
+/include/ "qoriq-sata2-1.dtsi"
+/include/ "qoriq-sec5.2-0.dtsi"
+
+	L2_1: l2-cache-controller@c20000 {
+		/* Cluster 0 L2 cache */
+		compatible = "fsl,t2080-l2-cache-controller";
+		reg = <0xc20000 0x40000>;
+		next-level-cache = <&cpc>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t2080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t2080si-pre.dtsi
new file mode 100644
index 0000000..8c19167
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t2080si-pre.dtsi
@@ -0,0 +1,100 @@
+/*
+ * T2080 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "e6500_power_isa.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		ccsr = &soc;
+		dcsr = &dcsr;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+
+		crypto = &crypto;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		pci3 = &pci3;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		dma2 = &dma2;
+		sdhc = &sdhc;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * Temporarily add next-level-cache info in each cpu node so
+		 * that uboot can do L2 cache fixup. This can be removed once
+		 * u-boot can create cpu node with cache info.
+		 */
+		cpu0: PowerPC,e6500@0 {
+			device_type = "cpu";
+			reg = <0 1>;
+			clocks = <&mux0>;
+			next-level-cache = <&L2_1>;
+		};
+		cpu1: PowerPC,e6500@2 {
+			device_type = "cpu";
+			reg = <2 3>;
+			clocks = <&mux0>;
+			next-level-cache = <&L2_1>;
+		};
+		cpu2: PowerPC,e6500@4 {
+			device_type = "cpu";
+			reg = <4 5>;
+			clocks = <&mux0>;
+			next-level-cache = <&L2_1>;
+		};
+		cpu3: PowerPC,e6500@6 {
+			device_type = "cpu";
+			reg = <6 7>;
+			clocks = <&mux0>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/t2080qds.dts b/arch/powerpc/boot/dts/t2080qds.dts
new file mode 100644
index 0000000..4874ebd
--- /dev/null
+++ b/arch/powerpc/boot/dts/t2080qds.dts
@@ -0,0 +1,276 @@
+/*
+ * T2080QDS Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "fsl/t2080si-pre.dtsi"
+
+/ {
+	model = "fsl,T2080QDS";
+	compatible = "fsl,T2080QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	ifc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x2000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xff800000 0x00010000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x2 0x0 0x10000>;
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
+				/* 10MB for Linux Kernel Image */
+				reg = <0x00200000 0x00A00000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@C00000 {
+				/* 500MB for Root file System Image */
+				reg = <0x00c00000 0x1F400000>;
+				label = "NAND RFS Image";
+			};
+		};
+
+		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,paragon-fpga", "fsl,fpga-qixis";
+			reg = <3 0 0x300>;
+			ranges = <0 3 0 0x300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
+	};
+
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
+	soc: soc@ffe000000 {
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@u-boot {
+					label = "SPI U-Boot";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "SPI Kernel";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "SPI DTB";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label = "SPI File System";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+
+			flash@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "sst,sst25wf040";
+				reg = <1>;
+				spi-max-frequency = <40000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			pca9547@77 {
+				compatible = "nxp,pca9547";
+				reg = <0x77>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+
+					eeprom@51 {
+						compatible = "at24,24c02";
+						reg = <0x51>;
+					};
+
+					eeprom@57 {
+						compatible = "at24,24c02";
+						reg = <0x57>;
+					};
+
+					rtc@68 {
+						compatible = "dallas,ds3232";
+						reg = <0x68>;
+						interrupts = <0x1 0x1 0 0>;
+					};
+				};
+
+				i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x1>;
+
+					eeprom@55 {
+						compatible = "at24,24c02";
+						reg = <0x55>;
+					};
+				};
+			};
+		};
+
+		sdhc@114000 {
+			voltage-ranges = <1800 1800 3300 3300>;
+		};
+	};
+
+	pci0: pcie@ffe240000 {
+		reg = <0xf 0xfe240000 0 0x10000>;
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
+	pci1: pcie@ffe250000 {
+		reg = <0xf 0xfe250000 0 0x10000>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x10000000
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
+	pci2: pcie@ffe260000 {
+		reg = <0xf 0xfe260000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x30000000 0 0x10000000
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
+
+	pci3: pcie@ffe270000 {
+		reg = <0xf 0xfe270000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
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
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
+	};
+};
+
+/include/ "fsl/t2080si-post.dtsi"
-- 
1.8.0

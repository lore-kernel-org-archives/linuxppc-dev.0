Return-Path: <B32579@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C568A2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 13:44:51 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2][v8] powerpc/mpc85xx:Add initial device tree support of
 T104x
Date: Thu, 3 Oct 2013 09:14:25 +0530
Message-ID: <1380771865-2534-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>, scottwood@freescale.com,
 Varun Sethi <Varun.Sethi@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
processor cores with high-performance data path acceleration architecture
and network peripheral interfaces required for networking & telecommunications.

T1042 personality is a reduced personality of T1040 without Integrated 8-port
Gigabit Ethernet switch.

The T1040/T1042 SoC includes the following function and features:

 - Four e5500 cores, each with a private 256 KB L2 cache
 - 256 KB shared L3 CoreNet platform cache (CPC)
 - Interconnect CoreNet platform
 - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving
   support
 - Data Path Acceleration Architecture (DPAA) incorporating acceleration
 for the following functions:
    -  Packet parsing, classification, and distribution
    -  Queue management for scheduling, packet sequencing, and congestion
    	management
    -  Cryptography Acceleration (SEC 5.0)
    - RegEx Pattern Matching Acceleration (PME 2.2)
    - IEEE Std 1588 support
    - Hardware buffer management for buffer allocation and deallocation
 - Ethernet interfaces
    - Integrated 8-port Gigabit Ethernet switch (T1040 only)
    - Four 1 Gbps Ethernet controllers
 - Two RGMII interfaces or one RGMII and one MII interfaces
 - High speed peripheral interfaces
   - Four PCI Express 2.0 controllers running at up to 5 GHz
   - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
   - Upto two QSGMII interface
   - Upto six SGMII interface supporting 1000 Mbps
   - One SGMII interface supporting upto 2500 Mbps
 - Additional peripheral interfaces
   - Two USB 2.0 controllers with integrated PHY
   - SD/eSDHC/eMMC
   -  eSPI controller
   - Four I2C controllers
   - Four UARTs
   - Four GPIO controllers
   - Integrated flash controller (IFC)
   - Change this to  LCD/ HDMI interface (DIU) with 12 bit dual data rate
   - TDM interface
 - Multicore programmable interrupt controller (PIC)
 - Two 8-channel DMA engines
 - Single source clocking implementation
 - Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
 Branch merge

Changes for v2: Incorporated Scott's comments
	- Update t1040si-post.dtsi
    - update clock device tree node as per
      http://patchwork.ozlabs.org/patch/274134/
    - removed DMA node, It will be added later as per
      http://patchwork.ozlabs.org/patch/271238/
    - Updated display compatible field
 
 Changes for v3: Incorporated Scott's comments
   - Updated soc compatible field
   - updated clock compatible field

 Changes for v4: Sending as it is 
 Changes for v5: Sending as it is 
 Changes for v6: Updated branch of creation 
 Changes for v7: Incororated Scott's commetns
    - Create patch set
    - remove whitespace
    - Removed l2switch. It will be added later
 Changes for v8: Incorporated Scott's comments
    - Added comment line in T1042si-post.dtsi
    - removed extra lines

 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  418 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi |   37 +++
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi  |  106 +++++++
 3 files changed, 561 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
new file mode 100644
index 0000000..9bf1c30
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -0,0 +1,418 @@
+/*
+ * T1040 Silicon/SoC Device Tree Source (post include)
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
+	interrupts = <25 2 0 0>;
+};
+
+&pci0 {
+	compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <20 2 0 0>;
+	fsl,iommu-parent = <&pamu0>;
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
+&pci1 {
+	compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 0xff>;
+	interrupts = <21 2 0 0>;
+	fsl,iommu-parent = <&pamu0>;
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
+&pci2 {
+	compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <22 2 0 0>;
+	fsl,iommu-parent = <&pamu0>;
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
+&pci3 {
+	compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <23 2 0 0>;
+	fsl,iommu-parent = <&pamu0>;
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
+&dcsr {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,dcsr", "simple-bus";
+
+	dcsr-epu@0 {
+		compatible = "fsl,t1040-dcsr-epu", "fsl,dcsr-epu";
+		interrupts = <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0>;
+		reg = <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible = "fsl,t1040-dcsr-cnpc", "fsl,dcsr-cnpc";
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
+	dcsr-dpaa@9000 {
+		compatible = "fsl,t1040-dcsr-dpaa", "fsl,dcsr-dpaa";
+		reg = <0x9000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,t1040-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,t1040-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,t1040-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,t1040-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x30000 0x1000 0x1022000 0x10000>;
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,t1040-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x31000 0x1000 0x1042000 0x10000>;
+	};
+	dcsr-cpu-sb-proxy@100000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu0>;
+		reg = <0x100000 0x1000 0x101000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@108000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x108000 0x1000 0x109000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@110000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu2>;
+		reg = <0x110000 0x1000 0x111000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@118000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
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
+		fsl,num-laws = <16>;
+	};
+
+	ddr1: memory-controller@8000 {
+		compatible = "fsl,qoriq-memory-controller-v5.0",
+				"fsl,qoriq-memory-controller";
+		reg = <0x8000 0x1000>;
+		interrupts = <16 2 1 23>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,t1040-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000>;
+		interrupts = <16 2 1 27>;
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
+		reg = <0x20000 0x1000>;
+		ranges = <0 0x20000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <128 1>;
+			fsl,secondary-cache-geometry = <16 2>;
+		};
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,t1040-device-config", "fsl,qoriq-device-config-2.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,t1040-clockgen", "fsl,qoriq-clockgen-2.0",
+				   "fixed-clock";
+		reg = <0xe1000 0x1000>;
+		clock-output-names = "sysclk";
+		#clock-cells = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		pll0: pll0@800 {
+			#clock-cells = <1>;
+			reg = <0x800 4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&clockgen>;
+			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		};
+		pll1: pll1@820 {
+			#clock-cells = <1>;
+			reg = <0x820 4>;
+			compatible = "fsl,qoriq-core-pll-2.0";
+			clocks = <&clockgen>;
+			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		};
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux0";
+		};
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux1";
+		};
+		mux2: mux2@40 {
+			#clock-cells = <0>;
+			reg = <0x40 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux2";
+		};
+		mux3: mux3@60 {
+			#clock-cells = <0>;
+			reg = <0x60 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clock-names = "pll0_0", "pll0_1", "pll0_2",
+				"pll1_0", "pll1_1", "pll1_2";
+			clock-output-names = "cmux3";
+		};
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t1040-rcpm", "fsl,qoriq-rcpm-2.0";
+		reg = <0xe2000 0x1000>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,t1040-sfp";
+		reg	   = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,t1040-serdes";
+		reg	   = <0xea000 0x4000>;
+	};
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		compatible = "fsl,t1040-esdhc", "fsl,esdhc";
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
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
+		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v2.4", "fsl-usb2-mph";
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+			phy_type = "utmi";
+			port0;
+		};
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+			dr_mode = "host";
+			phy_type = "utmi";
+		};
+
+	display@180000 {
+		compatible = "fsl,t1040-diu", "fsl,diu";
+		reg = <0x180000 1000>;
+		interrupts = <74 2 0 0>;
+	};
+
+/include/ "qoriq-sata2-0.dtsi"
+sata@220000 {
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+};
+/include/ "qoriq-sata2-1.dtsi"
+sata@221000 {
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
+};
+/include/ "qoriq-sec5.0-0.dtsi"
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
new file mode 100644
index 0000000..319b74f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1042si-post.dtsi
@@ -0,0 +1,37 @@
+/*
+ * T1042 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
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
+/include/ "t1040si-post.dtsi"
+
+/* Place holder for ethernet related device tree nodes */
diff --git a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
new file mode 100644
index 0000000..c0ae954
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
@@ -0,0 +1,106 @@
+/*
+ * T1040/T1042 Silicon/SoC Device Tree Source (pre include)
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
+/include/ "e5500_power_isa.dtsi"
+
+/ {
+	compatible = "fsl,T104x";
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
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		pci3 = &pci3;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		sdhc = &sdhc;
+
+		crypto = &crypto;
+
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: PowerPC,e5500@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&mux0>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu1: PowerPC,e5500@1 {
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&mux1>;
+			next-level-cache = <&L2_2>;
+			L2_2: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu2: PowerPC,e5500@2 {
+			device_type = "cpu";
+			reg = <2>;
+			clocks = <&mux2>;
+			next-level-cache = <&L2_3>;
+			L2_3: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu3: PowerPC,e5500@3 {
+			device_type = "cpu";
+			reg = <3>;
+			clocks = <&mux3>;
+			next-level-cache = <&L2_4>;
+			L2_4: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+	};
+};
-- 
1.7.9.5

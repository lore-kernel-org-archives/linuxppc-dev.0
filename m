Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAD301A1596
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:28:30 +1100 (AEDT)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/4] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
Date: Thu, 29 Jan 2015 15:52:24 +0800
Message-ID: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The T1024 SoC includes the following function and features:
- Two 64-bit Power architecture e5500 cores, up to 1.4GHz
- private 256KB L2 cache each core and shared 256KB CoreNet platform cache (CPC)
- 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving support
- Data Path Acceleration Architecture (DPAA) incorporating acceleration
- Four MAC for 1G/2.5G/10G network interfaces (RGMII, SGMII, QSGMII, XFI)
- High-speed peripheral interfaces
  - Three PCI Express 2.0 controllers
- Additional peripheral interfaces
  - One SATA 2.0 controller
  - Two USB 2.0 controllers with integrated PHY
  - Enhanced secure digital host controller (SD/eSDHC/eMMC)
  - Enhanced serial peripheral interface (eSPI)
  - Four I2C controllers
  - Four 2-pin UARTs or two 4-pin UARTs
  - Integrated Flash Controller supporting NAND and NOR flash
- Two 8-channel DMA engines
- Multicore programmable interrupt controller (PIC)
- LCD interface (DIU) with 12 bit dual data rate
- QUICC Engine block supporting TDM, HDLC, and UART
- Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)
- Support for hardware virtualization and partitioning enforcement
- QorIQ Platform's Trust Architecture 2.0

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 351 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi |  50 ++++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi  |  88 +++++++
 3 files changed, 489 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
new file mode 100644
index 0000000..23fbc5d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -0,0 +1,351 @@
+/*
+ * T1023 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
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
+	compatible = "fsl,t1024-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
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
+	compatible = "fsl,t1024-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
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
+	compatible = "fsl,t1024-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
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
+&dcsr {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,dcsr", "simple-bus";
+
+	dcsr-epu@0 {
+		compatible = "fsl,t1024-dcsr-epu", "fsl,dcsr-epu";
+		interrupts = <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0>;
+		reg = <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible = "fsl,t1024-dcsr-cnpc", "fsl,dcsr-cnpc";
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
+		compatible = "fsl,t1024-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,t1024-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,t1024-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,t1024-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x30000 0x1000 0x1022000 0x10000>;
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,t1024-dcsr-snpc", "fsl,dcsr-snpc";
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
+		compatible = "fsl,t1024-l3-cache-controller", "cache";
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
+		compatible = "fsl,t1024-device-config", "fsl,qoriq-device-config-2.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,t1024-clockgen", "fsl,qoriq-clockgen-2.0",
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
+			compatible = "fsl,core-pll-clock";
+			clocks = <&clockgen>;
+			clock-output-names = "pll0", "pll0-div2";
+		};
+		mux0: mux0@0 {
+			#clock-cells = <0>;
+			reg = <0x0 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>;
+			clock-names = "pll0_0", "pll0_1";
+			clock-output-names = "cmux0";
+		};
+		mux1: mux1@20 {
+			#clock-cells = <0>;
+			reg = <0x20 4>;
+			compatible = "fsl,core-mux-clock";
+			clocks = <&pll0 0>, <&pll0 1>;
+			clock-names = "pll0_0", "pll0_1";
+			clock-output-names = "cmux1";
+		};
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t1024-rcpm", "fsl,qoriq-rcpm-2.0";
+		reg = <0xe2000 0x1000>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,t1024-sfp";
+		reg	   = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,t1024-serdes";
+		reg	   = <0xea000 0x4000>;
+	};
+
+	scfg: global-utilities@fc000 {
+		compatible = "fsl,t1024-scfg";
+		reg = <0xfc000 0x1000>;
+	};
+
+/include/ "elo3-dma-0.dtsi"
+/include/ "elo3-dma-1.dtsi"
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		compatible = "fsl,t1024-esdhc", "fsl,esdhc";
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
+		sdhci,auto-cmd12;
+		no-1-8-v;
+		sleep = <&rcpm 0x00000080>;
+	};
+/include/ "qoriq-i2c-0.dtsi"
+/include/ "qoriq-i2c-1.dtsi"
+/include/ "qoriq-duart-0.dtsi"
+/include/ "qoriq-duart-1.dtsi"
+/include/ "qoriq-gpio-0.dtsi"
+	gpio@130000 {
+		sleep = <&rcpm 0x00000040>;
+	};
+/include/ "qoriq-gpio-1.dtsi"
+/include/ "qoriq-gpio-2.dtsi"
+/include/ "qoriq-gpio-3.dtsi"
+/include/ "qoriq-usb2-mph-0.dtsi"
+		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+			phy_type = "utmi";
+			sleep = <&rcpm 0x00000020>;
+			port0;
+		};
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+			dr_mode = "host";
+			phy_type = "utmi";
+			sleep = <&rcpm 0x00000010>;
+		};
+/include/ "qoriq-sata2-0.dtsi"
+sata@220000 {
+			fsl,iommu-parent = <&pamu0>;
+			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+};
+
+/include/ "qoriq-sec5.0-0.dtsi"
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1024si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1024si-post.dtsi
new file mode 100644
index 0000000..cdc570d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1024si-post.dtsi
@@ -0,0 +1,50 @@
+/*
+ * T1024 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
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
+/include/ "t1023si-post.dtsi"
+
+/ {
+	aliases {
+		vga = &display;
+		display = &display;
+	};
+};
+
+&soc {
+	display:display@180000 {
+		compatible = "fsl,t1024-diu", "fsl,diu";
+		reg = <0x180000 1000>;
+		interrupts = <74 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
new file mode 100644
index 0000000..7e513b7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
@@ -0,0 +1,88 @@
+/*
+ * T1024/T1023 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
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
+		dma0 = &dma0;
+		dma1 = &dma1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		sdhc = &sdhc;
+
+		crypto = &crypto;
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
+	};
+};
-- 
1.8.0

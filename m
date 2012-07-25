Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E7D22C0085
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2012 04:17:18 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v3] powerpc/p5040ds: Add support for P5040DS board
Date: Wed, 25 Jul 2012 13:17:04 -0500
Message-ID: <1343240224-17607-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Freescale P5040DS Reference Board ("Superhydra"), which
is similar to the P5020DS.  Features of the P5040 are listed below, but
not all of these features (e.g. DPAA networking) are currently supported.

Four P5040 single-threaded e5500 cores built
    Up to 2.4 GHz with 64-bit ISA support
    Three levels of instruction: user, supervisor, hypervisor
CoreNet platform cache (CPC)
    2.0 MB configures as dual 1 MB blocks hierarchical interconnect fabric
Two 64-bit DDR3/3L SDRAM memory controllers with ECC and interleaving support
    Up to 1600MT/s
    Memory pre-fetch engine
DPAA incorporating acceleration for the following functions
    Packet parsing, classification, and distribution (FMAN)
    Queue management for scheduling, packet sequencing and
	congestion management (QMAN)
    Hardware buffer management for buffer allocation and
	de-allocation (BMAN)
    Cryptography acceleration (SEC 5.0) at up to 40 Gbps
SerDes
    20 lanes at up to 5 Gbps
    Supports SGMII, XAUI, PCIe rev1.1/2.0, SATA
Ethernet interfaces
    Two 10 Gbps Ethernet MACs
    Ten 1 Gbps Ethernet MACs
High-speed peripheral interfaces
    Two PCI Express 2.0/3.0 controllers
Additional peripheral interfaces
    Two serial ATA (SATA 2.0) controllers
    Two high-speed USB 2.0 controllers with integrated PHY
    Enhanced secure digital host controller (SD/MMC/eMMC)
    Enhanced serial peripheral interface (eSPI)
    Two I2C controllers
    Four UARTs
    Integrated flash controller supporting NAND and NOR flash
DMA
    Dual four channel
Support for hardware virtualization and partitioning enforcement
    Extra privileged level for hypervisor support
QorIQ Trust Architecture 1.1
    Secure boot, secure debug, tamper detection, volatile key storage

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v3: fixes per Scott's comments, although only the things that I knew how
to fix.

 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  320 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    |  111 +++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |  118 +++++++++
 arch/powerpc/boot/dts/p5040ds.dts             |  203 ++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig  |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig  |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |   14 +
 arch/powerpc/platforms/85xx/Makefile          |    1 +
 arch/powerpc/platforms/85xx/p5040_ds.c        |   89 +++++++
 9 files changed, 858 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/p5040ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c

diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
new file mode 100644
index 0000000..db2c9a7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -0,0 +1,320 @@
+/*
+ * P5040 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+&lbc {
+	compatible = "fsl,p5040-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <25 2 0 0>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+};
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.4";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 1 15>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 1 15>;
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
+/* controller at 0x201000 */
+&pci1 {
+	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.4";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 1 14>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 1 14>;
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
+/* controller at 0x202000 */
+&pci2 {
+	compatible = "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.4";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 1 13>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 1 13>;
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
+		compatible = "fsl,dcsr-epu";
+		interrupts = <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0>;
+		reg = <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible = "fsl,dcsr-npc";
+		reg = <0x1000 0x1000 0x1000000 0x8000>;
+	};
+	dcsr-nxc@2000 {
+		compatible = "fsl,dcsr-nxc";
+		reg = <0x2000 0x1000>;
+	};
+	dcsr-corenet {
+		compatible = "fsl,dcsr-corenet";
+		reg = <0x8000 0x1000 0xB0000 0x1000>;
+	};
+	dcsr-dpaa@9000 {
+		compatible = "fsl,p5040-dcsr-dpaa", "fsl,dcsr-dpaa";
+		reg = <0x9000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,p5040-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-ddr@13000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr2>;
+		reg = <0x13000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,p5040-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,p5040-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@40000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu0>;
+		reg = <0x40000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@41000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x41000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@42000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu2>;
+		reg = <0x42000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@43000 {
+		compatible = "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu3>;
+		reg = <0x43000 0x1000>;
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
+		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
+		reg = <0x8000 0x1000>;
+		interrupts = <16 2 1 23>;
+	};
+
+	ddr2: memory-controller@9000 {
+		compatible = "fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-controller";
+		reg = <0x9000 0x1000>;
+		interrupts = <16 2 1 22>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,p5040-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000
+		       0x11000 0x1000>;
+		interrupts = <16 2 1 27
+			      16 2 1 26>;
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,corenet-cf";
+		reg = <0x18000 0x1000>;
+		interrupts = <16 2 1 31>;
+		fsl,ccf-num-csdids = <32>;
+		fsl,ccf-num-snoopids = <32>;
+	};
+
+	iommu@20000 {
+		compatible = "fsl,pamu-v1.0", "fsl,pamu";
+		reg = <0x20000 0x5000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,p5040-device-config", "fsl,qoriq-device-config-1.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells = <1>;
+		fsl,liodn-bits = <12>;
+	};
+
+	pins: global-utilities@e0e00 {
+		compatible = "fsl,p5040-pin-control", "fsl,qoriq-pin-control-1.0";
+		reg = <0xe0e00 0x200>;
+		#sleep-cells = <2>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
+		reg = <0xe1000 0x1000>;
+		clock-frequency = <0>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,p5040-rcpm", "fsl,qoriq-rcpm-1.0";
+		reg = <0xe2000 0x1000>;
+		#sleep-cells = <1>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,p5040-sfp", "fsl,qoriq-sfp-1.0";
+		reg	   = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,p5040-serdes";
+		reg	   = <0xea000 0x1000>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+/include/ "qoriq-dma-1.dtsi"
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		sdhci,auto-cmd12;
+	};
+
+/include/ "qoriq-i2c-0.dtsi"
+/include/ "qoriq-i2c-1.dtsi"
+/include/ "qoriq-duart-0.dtsi"
+/include/ "qoriq-duart-1.dtsi"
+/include/ "qoriq-gpio-0.dtsi"
+/include/ "qoriq-usb2-mph-0.dtsi"
+		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+			phy_type = "utmi";
+			port0;
+		};
+
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+			dr_mode = "host";
+			phy_type = "utmi";
+		};
+
+/include/ "qoriq-sata2-0.dtsi"
+/include/ "qoriq-sata2-1.dtsi"
+/include/ "qoriq-sec5.2-0.dtsi"
+};
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
new file mode 100644
index 0000000..52721b6
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -0,0 +1,111 @@
+/*
+ * P5040 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+/dts-v1/;
+/ {
+	compatible = "fsl,P5040";
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
+		cpu0: PowerPC,e5500@0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu1: PowerPC,e5500@1 {
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu2: PowerPC,e5500@2 {
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2_2>;
+			L2_2: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+		cpu3: PowerPC,e5500@3 {
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2_3>;
+			L2_3: l2-cache {
+				next-level-cache = <&cpc>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
new file mode 100644
index 0000000..7b2ab8a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
@@ -0,0 +1,118 @@
+/*
+ * QorIQ Sec/Crypto 5.2 device tree stub [ controller @ offset 0x300000 ]
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
+crypto: crypto@300000 {
+	compatible = "fsl,sec-v5.2", "fsl,sec-v5.0", "fsl,sec-v4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg		 = <0x300000 0x10000>;
+	ranges		 = <0 0x300000 0x10000>;
+	interrupts	 = <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x2000 0x1000>;
+		interrupts = <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x3000 0x1000>;
+		interrupts = <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x4000 0x1000>;
+		interrupts = <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible = "fsl,sec-v5.2-rtic",
+			     "fsl,sec-v5.0-rtic",
+			     "fsl,sec-v4.0-rtic";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x6000 0x100>;
+		ranges = <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible = "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible = "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible = "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible = "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible = "fsl,sec-v5.2-mon", "fsl,sec-v5.0-mon", "fsl,sec-v4.0-mon";
+	reg = <0x314000 0x1000>;
+	interrupts = <93 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
new file mode 100644
index 0000000..d86bf2e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -0,0 +1,203 @@
+/*
+ * P5040DS Device Tree Source
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+/include/ "fsl/p5040si-pre.dtsi"
+
+/ {
+	model = "fsl,P5040DS";
+	compatible = "fsl,P5040DS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	memory {
+		device_type = "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
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
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
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
+		};
+
+		i2c@119100 {
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
+			};
+		};
+	};
+
+	lbc: localbus@ffe124000 {
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
+				reg = <0x1f000000 0x01000000>;
+			};
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,p5040ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x40>;
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
+
+/include/ "fsl/p5040si-post.dtsi"
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index cbb98c1..3b40015 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -25,6 +25,7 @@ CONFIG_P2041_RDB=y
 CONFIG_P3041_DS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
+CONFIG_P5040_DS=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index dd89de8..36df45b 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -23,6 +23,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_P5020_DS=y
+CONFIG_P5040_DS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_IRQ_ALL_CPUS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 159c01e..31f0618 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -254,6 +254,20 @@ config P5020_DS
 	help
 	  This option enables support for the P5020 DS board
 
+config P5040_DS
+	bool "Freescale P5040 DS"
+	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the P5040 DS board
+
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	depends on EXPERIMENTAL
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 3dfe811..d99268a 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
+obj-$(CONFIG_P5040_DS)    += p5040_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
new file mode 100644
index 0000000..8e22a34
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -0,0 +1,89 @@
+/*
+ * P5040 DS Setup
+ *
+ * Copyright 2009-2010 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <linux/of_fdt.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/ehv_pic.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p5040_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS-hv")) {
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
+define_machine(p5040_ds) {
+	.name			= "P5040 DS",
+	.probe			= p5040_ds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
+#ifdef CONFIG_PPC64
+	.get_irq		= mpic_get_irq,
+#else
+	.get_irq		= mpic_get_coreint_irq,
+#endif
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		= book3e_idle,
+#else
+	.power_save		= e500_idle,
+#endif
+};
+
+machine_device_initcall(p5040_ds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p5040_ds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.3.4

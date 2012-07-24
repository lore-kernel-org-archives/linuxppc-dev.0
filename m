Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0C582C007F
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 02:42:12 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/p5040ds: Add support for P5040DS board
Date: Tue, 24 Jul 2012 11:42:02 -0500
Message-ID: <1343148122-4584-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Freescale P5040DS Reference Board ("Superhydra"), whi=
ch
is similar to the P5020DS.  Features of the P5040 are listed below, but
not all of these features (e.g. DPAA networking) are currently supported.

Four P5040 single-threaded e5500 cores built
    Up to 2.4 GHz with 64-bit ISA support
    Three levels of instruction: user, supervisor, hypervisor
CoreNet platform cache (CPC)
    2.0 MB configures as dual 1 MB blocks hierarchical interconnect fabri=
c
Two 64-bit DDR3/3L SDRAM memory controllers with ECC and interleaving sup=
port
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
    Two I=C2=B2C controllers
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
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  320 +++++++++++++++++++=
++++++
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    |  111 +++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |  118 +++++++++
 arch/powerpc/boot/dts/p5040ds.dts             |  207 ++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig  |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig  |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |   14 +
 arch/powerpc/platforms/85xx/Makefile          |    1 +
 arch/powerpc/platforms/85xx/p5040_ds.c        |   96 ++++++++
 9 files changed, 869 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/p5040ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c

diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/b=
oot/dts/fsl/p5040si-post.dtsi
new file mode 100644
index 0000000..cc1e606
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -0,0 +1,320 @@
+/*
+ * P5040 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *       notice, this list of conditions and the following disclaimer in=
 the
+ *       documentation and/or other materials provided with the distribu=
tion.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote pro=
ducts
+ *       derived from this software without specific prior written permi=
ssion.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the imp=
lied
+ * warranties of merchantability and fitness for a particular purpose ar=
e
+ * disclaimed. In no event shall Freescale Semiconductor be liable for a=
ny
+ * direct, indirect, incidental, special, exemplary, or consequential da=
mages
+ * (including, but not limited to, procurement of substitute goods or se=
rvices;
+ * loss of use, data, or profits; or business interruption) however caus=
ed and
+ * on any theory of liability, whether in contract, strict liability, or=
 tort
+ * (including negligence or otherwise) arising in any way out of the use=
 of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+&lbc {
+	compatible =3D "fsl,p5040-elbc", "fsl,elbc", "simple-bus";
+	interrupts =3D <25 2 0 0>;
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+};
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible =3D "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type =3D "pci";
+	#size-cells =3D <2>;
+	#address-cells =3D <3>;
+	bus-range =3D <0x0 0xff>;
+	clock-frequency =3D <33333333>;
+	interrupts =3D <16 2 1 15>;
+	pcie@0 {
+		reg =3D <0 0 0 0 0>;
+		#interrupt-cells =3D <1>;
+		#size-cells =3D <2>;
+		#address-cells =3D <3>;
+		device_type =3D "pci";
+		interrupts =3D <16 2 1 15>;
+		interrupt-map-mask =3D <0xf800 0 0 7>;
+		interrupt-map =3D <
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
+	compatible =3D "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type =3D "pci";
+	#size-cells =3D <2>;
+	#address-cells =3D <3>;
+	bus-range =3D <0 0xff>;
+	clock-frequency =3D <33333333>;
+	interrupts =3D <16 2 1 14>;
+	pcie@0 {
+		reg =3D <0 0 0 0 0>;
+		#interrupt-cells =3D <1>;
+		#size-cells =3D <2>;
+		#address-cells =3D <3>;
+		device_type =3D "pci";
+		interrupts =3D <16 2 1 14>;
+		interrupt-map-mask =3D <0xf800 0 0 7>;
+		interrupt-map =3D <
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
+	compatible =3D "fsl,p5040-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type =3D "pci";
+	#size-cells =3D <2>;
+	#address-cells =3D <3>;
+	bus-range =3D <0x0 0xff>;
+	clock-frequency =3D <33333333>;
+	interrupts =3D <16 2 1 13>;
+	pcie@0 {
+		reg =3D <0 0 0 0 0>;
+		#interrupt-cells =3D <1>;
+		#size-cells =3D <2>;
+		#address-cells =3D <3>;
+		device_type =3D "pci";
+		interrupts =3D <16 2 1 13>;
+		interrupt-map-mask =3D <0xf800 0 0 7>;
+		interrupt-map =3D <
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
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	compatible =3D "fsl,dcsr", "simple-bus";
+
+	dcsr-epu@0 {
+		compatible =3D "fsl,dcsr-epu";
+		interrupts =3D <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0>;
+		reg =3D <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible =3D "fsl,dcsr-npc";
+		reg =3D <0x1000 0x1000 0x1000000 0x8000>;
+	};
+	dcsr-nxc@2000 {
+		compatible =3D "fsl,dcsr-nxc";
+		reg =3D <0x2000 0x1000>;
+	};
+	dcsr-corenet {
+		compatible =3D "fsl,dcsr-corenet";
+		reg =3D <0x8000 0x1000 0xB0000 0x1000>;
+	};
+	dcsr-dpaa@9000 {
+		compatible =3D "fsl,p5040-dcsr-dpaa", "fsl,dcsr-dpaa";
+		reg =3D <0x9000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible =3D "fsl,p5040-dcsr-ocn", "fsl,dcsr-ocn";
+		reg =3D <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible =3D "fsl,dcsr-ddr";
+		dev-handle =3D <&ddr1>;
+		reg =3D <0x12000 0x1000>;
+	};
+	dcsr-ddr@13000 {
+		compatible =3D "fsl,dcsr-ddr";
+		dev-handle =3D <&ddr2>;
+		reg =3D <0x13000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible =3D "fsl,p5040-dcsr-nal", "fsl,dcsr-nal";
+		reg =3D <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible =3D "fsl,p5040-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg =3D <0x22000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@40000 {
+		compatible =3D "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle =3D <&cpu0>;
+		reg =3D <0x40000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@41000 {
+		compatible =3D "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle =3D <&cpu1>;
+		reg =3D <0x41000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@42000 {
+		compatible =3D "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle =3D <&cpu2>;
+		reg =3D <0x42000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@43000 {
+		compatible =3D "fsl,dcsr-e5500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle =3D <&cpu3>;
+		reg =3D <0x43000 0x1000>;
+	};
+};
+
+&soc {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	device_type =3D "soc";
+	compatible =3D "simple-bus";
+
+	soc-sram-error {
+		compatible =3D "fsl,soc-sram-error";
+		interrupts =3D <16 2 1 29>;
+	};
+
+	corenet-law@0 {
+		compatible =3D "fsl,corenet-law";
+		reg =3D <0x0 0x1000>;
+		fsl,num-laws =3D <32>;
+	};
+
+	ddr1: memory-controller@8000 {
+		compatible =3D "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-c=
ontroller";
+		reg =3D <0x8000 0x1000>;
+		interrupts =3D <16 2 1 23>;
+	};
+
+	ddr2: memory-controller@9000 {
+		compatible =3D "fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-co=
ntroller";
+		reg =3D <0x9000 0x1000>;
+		interrupts =3D <16 2 1 22>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible =3D "fsl,p5040-l3-cache-controller", "fsl,p4080-l3-cache-co=
ntroller", "cache";
+		reg =3D <0x10000 0x1000
+		       0x11000 0x1000>;
+		interrupts =3D <16 2 1 27
+			      16 2 1 26>;
+	};
+
+	corenet-cf@18000 {
+		compatible =3D "fsl,corenet-cf";
+		reg =3D <0x18000 0x1000>;
+		interrupts =3D <16 2 1 31>;
+		fsl,ccf-num-csdids =3D <32>;
+		fsl,ccf-num-snoopids =3D <32>;
+	};
+
+	iommu@20000 {
+		compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
+		reg =3D <0x20000 0x5000>;
+		interrupts =3D <
+			24 2 0 0
+			16 2 1 30>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible =3D "fsl,qoriq-device-config-1.0";
+		reg =3D <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells =3D <1>;
+		fsl,liodn-bits =3D <12>;
+	};
+
+	pins: global-utilities@e0e00 {
+		compatible =3D "fsl,qoriq-pin-control-1.0";
+		reg =3D <0xe0e00 0x200>;
+		#sleep-cells =3D <2>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible =3D "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
+		reg =3D <0xe1000 0x1000>;
+		clock-frequency =3D <0>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible =3D "fsl,qoriq-rcpm-1.0";
+		reg =3D <0xe2000 0x1000>;
+		#sleep-cells =3D <1>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible =3D "fsl,p5040-sfp", "fsl,qoriq-sfp-1.0";
+		reg	   =3D <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible =3D "fsl,p5040-serdes";
+		reg	   =3D <0xea000 0x1000>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+/include/ "qoriq-dma-1.dtsi"
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects =3D <4>;
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
+			compatible =3D "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2=
-mph";
+			phy_type =3D "utmi";
+			port0;
+		};
+
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			compatible =3D "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-d=
r";
+			dr_mode =3D "host";
+			phy_type =3D "utmi";
+		};
+
+/include/ "qoriq-sata2-0.dtsi"
+/include/ "qoriq-sata2-1.dtsi"
+/include/ "qoriq-sec5.2-0.dtsi"
+};
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/bo=
ot/dts/fsl/p5040si-pre.dtsi
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
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *       notice, this list of conditions and the following disclaimer in=
 the
+ *       documentation and/or other materials provided with the distribu=
tion.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote pro=
ducts
+ *       derived from this software without specific prior written permi=
ssion.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the imp=
lied
+ * warranties of merchantability and fitness for a particular purpose ar=
e
+ * disclaimed. In no event shall Freescale Semiconductor be liable for a=
ny
+ * direct, indirect, incidental, special, exemplary, or consequential da=
mages
+ * (including, but not limited to, procurement of substitute goods or se=
rvices;
+ * loss of use, data, or profits; or business interruption) however caus=
ed and
+ * on any theory of liability, whether in contract, strict liability, or=
 tort
+ * (including negligence or otherwise) arising in any way out of the use=
 of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+/dts-v1/;
+/ {
+	compatible =3D "fsl,P5040";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+
+	aliases {
+		ccsr =3D &soc;
+		dcsr =3D &dcsr;
+
+		serial0 =3D &serial0;
+		serial1 =3D &serial1;
+		serial2 =3D &serial2;
+		serial3 =3D &serial3;
+		pci0 =3D &pci0;
+		pci1 =3D &pci1;
+		pci2 =3D &pci2;
+		usb0 =3D &usb0;
+		usb1 =3D &usb1;
+		dma0 =3D &dma0;
+		dma1 =3D &dma1;
+		sdhc =3D &sdhc;
+		msi0 =3D &msi0;
+		msi1 =3D &msi1;
+		msi2 =3D &msi2;
+
+		crypto =3D &crypto;
+		sec_jr0 =3D &sec_jr0;
+		sec_jr1 =3D &sec_jr1;
+		sec_jr2 =3D &sec_jr2;
+		sec_jr3 =3D &sec_jr3;
+		rtic_a =3D &rtic_a;
+		rtic_b =3D &rtic_b;
+		rtic_c =3D &rtic_c;
+		rtic_d =3D &rtic_d;
+		sec_mon =3D &sec_mon;
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu0: PowerPC,e5500@0 {
+			device_type =3D "cpu";
+			reg =3D <0>;
+			next-level-cache =3D <&L2_0>;
+			L2_0: l2-cache {
+				next-level-cache =3D <&cpc>;
+			};
+		};
+		cpu1: PowerPC,e5500@1 {
+			device_type =3D "cpu";
+			reg =3D <1>;
+			next-level-cache =3D <&L2_1>;
+			L2_1: l2-cache {
+				next-level-cache =3D <&cpc>;
+			};
+		};
+		cpu2: PowerPC,e5500@2 {
+			device_type =3D "cpu";
+			reg =3D <2>;
+			next-level-cache =3D <&L2_2>;
+			L2_2: l2-cache {
+				next-level-cache =3D <&cpc>;
+			};
+		};
+		cpu3: PowerPC,e5500@3 {
+			device_type =3D "cpu";
+			reg =3D <3>;
+			next-level-cache =3D <&L2_3>;
+			L2_3: l2-cache {
+				next-level-cache =3D <&cpc>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi b/arch/powerpc=
/boot/dts/fsl/qoriq-sec5.2-0.dtsi
new file mode 100644
index 0000000..7b2ab8a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi
@@ -0,0 +1,118 @@
+/*
+ * QorIQ Sec/Crypto 5.2 device tree stub [ controller @ offset 0x300000 =
]
+ *
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *       notice, this list of conditions and the following disclaimer in=
 the
+ *       documentation and/or other materials provided with the distribu=
tion.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote pro=
ducts
+ *       derived from this software without specific prior written permi=
ssion.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto: crypto@300000 {
+	compatible =3D "fsl,sec-v5.2", "fsl,sec-v5.0", "fsl,sec-v4.0";
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	reg		 =3D <0x300000 0x10000>;
+	ranges		 =3D <0 0x300000 0x10000>;
+	interrupts	 =3D <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible =3D "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg =3D <0x1000 0x1000>;
+		interrupts =3D <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible =3D "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg =3D <0x2000 0x1000>;
+		interrupts =3D <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible =3D "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg =3D <0x3000 0x1000>;
+		interrupts =3D <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible =3D "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg =3D <0x4000 0x1000>;
+		interrupts =3D <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible =3D "fsl,sec-v5.2-rtic",
+			     "fsl,sec-v5.0-rtic",
+			     "fsl,sec-v4.0-rtic";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x6000 0x100>;
+		ranges =3D <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible =3D "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg =3D <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible =3D "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg =3D <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible =3D "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg =3D <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible =3D "fsl,sec-v5.2-rtic-memory",
+				     "fsl,sec-v5.0-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg =3D <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible =3D "fsl,sec-v5.2-mon", "fsl,sec-v5.0-mon", "fsl,sec-v4.0-mo=
n";
+	reg =3D <0x314000 0x1000>;
+	interrupts =3D <93 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5=
040ds.dts
new file mode 100644
index 0000000..c15ba68
--- /dev/null
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -0,0 +1,207 @@
+/*
+ * P5040DS Device Tree Source
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *       notice, this list of conditions and the following disclaimer in=
 the
+ *       documentation and/or other materials provided with the distribu=
tion.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote pro=
ducts
+ *       derived from this software without specific prior written permi=
ssion.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the imp=
lied
+ * warranties of merchantability and fitness for a particular purpose ar=
e
+ * disclaimed. In no event shall Freescale Semiconductor be liable for a=
ny
+ * direct, indirect, incidental, special, exemplary, or consequential da=
mages
+ * (including, but not limited to, procurement of substitute goods or se=
rvices;
+ * loss of use, data, or profits; or business interruption) however caus=
ed and
+ * on any theory of liability, whether in contract, strict liability, or=
 tort
+ * (including negligence or otherwise) arising in any way out of the use=
 of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+/include/ "fsl/p5040si-pre.dtsi"
+
+/ {
+	model =3D "fsl,P5040DS";
+	compatible =3D "fsl,P5040DS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+
+	memory {
+		device_type =3D "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges =3D <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
+	soc: soc@ffe000000 {
+		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg =3D <0xf 0xfe000000 0 0x00001000>;
+		spi@110000 {
+			flash@0 {
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				compatible =3D "spansion,s25sl12801";
+				reg =3D <0>;
+				spi-max-frequency =3D <40000000>; /* input clock */
+				partition@u-boot {
+					label =3D "u-boot";
+					reg =3D <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label =3D "kernel";
+					reg =3D <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label =3D "dtb";
+					reg =3D <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label =3D "file system";
+					reg =3D <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		i2c@118100 {
+			eeprom@51 {
+				compatible =3D "at24,24c256";
+				reg =3D <0x51>;
+			};
+			eeprom@52 {
+				compatible =3D "at24,24c256";
+				reg =3D <0x52>;
+			};
+		};
+
+		i2c@119100 {
+			rtc@68 {
+				compatible =3D "dallas,ds3232";
+				reg =3D <0x68>;
+				interrupts =3D <0x1 0x1 0 0>;
+			};
+		};
+	};
+
+	lbc: localbus@ffe124000 {
+		reg =3D <0xf 0xfe124000 0 0x1000>;
+		ranges =3D <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xffa00000 0x00040000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		flash@0,0 {
+			compatible =3D "cfi-flash";
+			reg =3D <0 0 0x08000000>;
+			bank-width =3D <2>;
+			device-width =3D <2>;
+		};
+
+		nand@2,0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "fsl,elbc-fcm-nand";
+			reg =3D <0x2 0x0 0x40000>;
+
+			partition@0 {
+				label =3D "NAND U-Boot Image";
+				reg =3D <0x0 0x02000000>;
+				read-only;
+			};
+
+			partition@2000000 {
+				label =3D "NAND Root File System";
+				reg =3D <0x02000000 0x10000000>;
+			};
+
+			partition@12000000 {
+				label =3D "NAND Compressed RFS Image";
+				reg =3D <0x12000000 0x08000000>;
+			};
+
+			partition@1a000000 {
+				label =3D "NAND Linux Kernel Image";
+				reg =3D <0x1a000000 0x04000000>;
+			};
+
+			partition@1e000000 {
+				label =3D "NAND DTB Image";
+				reg =3D <0x1e000000 0x01000000>;
+			};
+
+			partition@1f000000 {
+				label =3D "NAND Writable User area";
+				reg =3D <0x1f000000 0x01000000>;
+			};
+		};
+
+		board-control@3,0 {
+			compatible =3D "fsl,p5040ds-fpga", "fsl,fpga-ngpixis";
+			reg =3D <3 0 0x40>;
+		};
+	};
+
+	pci0: pcie@ffe200000 {
+		reg =3D <0xf 0xfe200000 0 0x1000>;
+		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
+		reg =3D <0xf 0xfe201000 0 0x1000>;
+		ranges =3D <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
+		reg =3D <0xf 0xfe202000 0 0x1000>;
+		ranges =3D <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/=
configs/corenet32_smp_defconfig
index cbb98c1..3b40015 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -25,6 +25,7 @@ CONFIG_P2041_RDB=3Dy
 CONFIG_P3041_DS=3Dy
 CONFIG_P4080_DS=3Dy
 CONFIG_P5020_DS=3Dy
+CONFIG_P5040_DS=3Dy
 CONFIG_HIGHMEM=3Dy
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/=
configs/corenet64_smp_defconfig
index dd89de8..36df45b 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -23,6 +23,7 @@ CONFIG_MODVERSIONS=3Dy
 CONFIG_PARTITION_ADVANCED=3Dy
 CONFIG_MAC_PARTITION=3Dy
 CONFIG_P5020_DS=3Dy
+CONFIG_P5040_DS=3Dy
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=3Dm
 CONFIG_IRQ_ALL_CPUS=3Dy
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms=
/85xx/Kconfig
index 159c01e..31f0618 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -254,6 +254,20 @@ config P5020_DS
 	help
 	  This option enables support for the P5020 DS board
=20
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
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platform=
s/85xx/Makefile
index 3dfe811..d99268a 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_P2041_RDB)   +=3D p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    +=3D p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    +=3D p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    +=3D p5020_ds.o corenet_ds.o
+obj-$(CONFIG_P5040_DS)    +=3D p5040_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  +=3D stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  +=3D tqm85xx.o
 obj-$(CONFIG_SBC8548)     +=3D sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platfo=
rms/85xx/p5040_ds.c
new file mode 100644
index 0000000..ca3358f
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -0,0 +1,96 @@
+/*
+ * P5040 DS Setup
+ *
+ * Copyright 2009-2010 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify=
 it
+ * under  the terms of  the GNU General  Public License as published by =
the
+ * Free Software Foundation;  either version 2 of the  License, or (at y=
our
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
+static int __init p5040_ds_probe(void)
+{
+	unsigned long root =3D of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS-hv")) {
+		ppc_md.init_IRQ =3D ehv_pic_init;
+		ppc_md.get_irq =3D ehv_pic_get_irq;
+		ppc_md.restart =3D fsl_hv_restart;
+		ppc_md.power_off =3D fsl_hv_halt;
+		ppc_md.halt =3D fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase =3D NULL;
+		smp_85xx_ops.take_timebase =3D NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(p5040_ds) {
+	.name			=3D "P5040 DS",
+	.probe			=3D p5040_ds_probe,
+	.setup_arch		=3D corenet_ds_setup_arch,
+	.init_IRQ		=3D corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
+#endif
+/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
+#ifdef CONFIG_PPC64
+	.get_irq		=3D mpic_get_irq,
+#else
+	.get_irq		=3D mpic_get_coreint_irq,
+#endif
+	.restart		=3D fsl_rstcr_restart,
+	.calibrate_decr		=3D generic_calibrate_decr,
+	.progress		=3D udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		=3D book3e_idle,
+#else
+	.power_save		=3D e500_idle,
+#endif
+};
+
+machine_device_initcall(p5040_ds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p5040_ds, swiotlb_setup_bus_notifier);
+#endif
--=20
1.7.3.4

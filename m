Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C6047101624
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:15:01 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGEv4F031968
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:58 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 25/30] powerpc/85xx: Rework P3041DS device tree
Date: Thu, 10 Nov 2011 10:14:08 -0600
Message-Id: <1320941653-29797-26-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-25-git-send-email-galak@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-17-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-18-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-19-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-20-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-21-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-22-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-23-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-24-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-25-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  332 ++++++++++++
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi  |  112 ++++
 arch/powerpc/boot/dts/p3041ds.dts           |   12 +-
 arch/powerpc/boot/dts/p3041si.dtsi          |  729 ---------------------------
 4 files changed, 454 insertions(+), 731 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
 delete mode 100644 arch/powerpc/boot/dts/p3041si.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
new file mode 100644
index 0000000..9cda481
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -0,0 +1,332 @@
+/*
+ * P3041 Silicon/SoC Device Tree Source (post include)
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
+&lbc {
+	compatible = "fsl,p3041-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <25 2 0 0>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+};
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
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
+	compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
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
+	compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
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
+/* controller at 0x203000 */
+&pci3 {
+	compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 1 12>;
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 1 12>;
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
+		compatible = "fsl,p3041-dcsr-dpaa", "fsl,dcsr-dpaa";
+		reg = <0x9000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,p3041-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,p3041-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,p3041-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@40000 {
+		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu0>;
+		reg = <0x40000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@41000 {
+		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x41000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@42000 {
+		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu2>;
+		reg = <0x42000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@43000 {
+		compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
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
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,p3041-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000>;
+		interrupts = <16 2 1 27>;
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
+		reg = <0x20000 0x4000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,qoriq-device-config-1.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells = <1>;
+		fsl,liodn-bits = <12>;
+	};
+
+	pins: global-utilities@e0e00 {
+		compatible = "fsl,qoriq-pin-control-1.0";
+		reg = <0xe0e00 0x200>;
+		#sleep-cells = <2>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
+		reg = <0xe1000 0x1000>;
+		clock-frequency = <0>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,qoriq-rcpm-1.0";
+		reg = <0xe2000 0x1000>;
+		#sleep-cells = <1>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,p3041-sfp", "fsl,qoriq-sfp-1.0";
+		reg	   = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,p3041-serdes";
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
+			phy_type = "utmi";
+			port0;
+		};
+
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			dr_mode = "host";
+			phy_type = "utmi";
+		};
+
+/include/ "qoriq-sata2-0.dtsi"
+/include/ "qoriq-sata2-1.dtsi"
+/include/ "qoriq-sec4.2-0.dtsi"
+};
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
new file mode 100644
index 0000000..136def3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
@@ -0,0 +1,112 @@
+/*
+ * P3041 Silicon/SoC Device Tree Source (pre include)
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
+/ {
+	compatible = "fsl,P3041";
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
+};
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index bbd113b..1053d69 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/include/ "p3041si.dtsi"
+/include/ "fsl/p3041si-pre.dtsi"
 
 / {
 	model = "fsl,P3041DS";
@@ -50,6 +50,8 @@
 	};
 
 	soc: soc@ffe000000 {
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
 		spi@110000 {
 			flash@0 {
 				#address-cells = <1>;
@@ -99,7 +101,7 @@
 		};
 	};
 
-	localbus@ffe124000 {
+	lbc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
 			  2 0 0xf 0xffa00000 0x00040000
@@ -160,6 +162,7 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -175,6 +178,7 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -190,6 +194,7 @@
 		reg = <0xf 0xfe202000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -205,6 +210,7 @@
 		reg = <0xf 0xfe203000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
+		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -216,3 +222,5 @@
 		};
 	};
 };
+
+/include/ "fsl/p3041si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p3041si.dtsi b/arch/powerpc/boot/dts/p3041si.dtsi
deleted file mode 100644
index 87130b7..0000000
--- a/arch/powerpc/boot/dts/p3041si.dtsi
+++ /dev/null
@@ -1,729 +0,0 @@
-/*
- * P3041 Silicon Device Tree Source
- *
- * Copyright 2010-2011 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/dts-v1/;
-
-/ {
-	compatible = "fsl,P3041";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ccsr = &soc;
-		dcsr = &dcsr;
-
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		serial3 = &serial3;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-		pci3 = &pci3;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		dma0 = &dma0;
-		dma1 = &dma1;
-		sdhc = &sdhc;
-		msi0 = &msi0;
-		msi1 = &msi1;
-		msi2 = &msi2;
-
-		crypto = &crypto;
-		sec_jr0 = &sec_jr0;
-		sec_jr1 = &sec_jr1;
-		sec_jr2 = &sec_jr2;
-		sec_jr3 = &sec_jr3;
-		rtic_a = &rtic_a;
-		rtic_b = &rtic_b;
-		rtic_c = &rtic_c;
-		rtic_d = &rtic_d;
-		sec_mon = &sec_mon;
-
-/*
-		rio0 = &rapidio0;
- */
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e500mc@0 {
-			device_type = "cpu";
-			reg = <0>;
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu1: PowerPC,e500mc@1 {
-			device_type = "cpu";
-			reg = <1>;
-			next-level-cache = <&L2_1>;
-			L2_1: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu2: PowerPC,e500mc@2 {
-			device_type = "cpu";
-			reg = <2>;
-			next-level-cache = <&L2_2>;
-			L2_2: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-		cpu3: PowerPC,e500mc@3 {
-			device_type = "cpu";
-			reg = <3>;
-			next-level-cache = <&L2_3>;
-			L2_3: l2-cache {
-				next-level-cache = <&cpc>;
-			};
-		};
-	};
-
-	dcsr: dcsr@f00000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,dcsr", "simple-bus";
-
-		dcsr-epu@0 {
-			compatible = "fsl,dcsr-epu";
-			interrupts = <52 2 0 0
-				      84 2 0 0
-				      85 2 0 0>;
-			interrupt-parent = <&mpic>;
-			reg = <0x0 0x1000>;
-		};
-		dcsr-npc {
-			compatible = "fsl,dcsr-npc";
-			reg = <0x1000 0x1000 0x1000000 0x8000>;
-		};
-		dcsr-nxc@2000 {
-			compatible = "fsl,dcsr-nxc";
-			reg = <0x2000 0x1000>;
-		};
-		dcsr-corenet {
-			compatible = "fsl,dcsr-corenet";
-			reg = <0x8000 0x1000 0xB0000 0x1000>;
-		};
-		dcsr-dpaa@9000 {
-			compatible = "fsl,p43041-dcsr-dpaa", "fsl,dcsr-dpaa";
-			reg = <0x9000 0x1000>;
-		};
-		dcsr-ocn@11000 {
-			compatible = "fsl,p43041-dcsr-ocn", "fsl,dcsr-ocn";
-			reg = <0x11000 0x1000>;
-		};
-		dcsr-ddr@12000 {
-			compatible = "fsl,dcsr-ddr";
-			dev-handle = <&ddr>;
-			reg = <0x12000 0x1000>;
-		};
-		dcsr-nal@18000 {
-			compatible = "fsl,p43041-dcsr-nal", "fsl,dcsr-nal";
-			reg = <0x18000 0x1000>;
-		};
-		dcsr-rcpm@22000 {
-			compatible = "fsl,p43041-dcsr-rcpm", "fsl,dcsr-rcpm";
-			reg = <0x22000 0x1000>;
-		};
-		dcsr-cpu-sb-proxy@40000 {
-			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-			cpu-handle = <&cpu0>;
-			reg = <0x40000 0x1000>;
-		};
-		dcsr-cpu-sb-proxy@41000 {
-			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-			cpu-handle = <&cpu1>;
-			reg = <0x41000 0x1000>;
-		};
-		dcsr-cpu-sb-proxy@42000 {
-			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-			cpu-handle = <&cpu2>;
-			reg = <0x42000 0x1000>;
-		};
-		dcsr-cpu-sb-proxy@43000 {
-			compatible = "fsl,dcsr-e500mc-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
-			cpu-handle = <&cpu3>;
-			reg = <0x43000 0x1000>;
-		};
-	};
-
-	soc: soc@ffe000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-
-		soc-sram-error {
-			compatible = "fsl,soc-sram-error";
-			interrupts = <16 2 1 29>;
-		};
-
-		corenet-law@0 {
-			compatible = "fsl,corenet-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <32>;
-		};
-
-		ddr: memory-controller@8000 {
-			compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
-			reg = <0x8000 0x1000>;
-			interrupts = <16 2 1 23>;
-		};
-
-		cpc: l3-cache-controller@10000 {
-			compatible = "fsl,p3041-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
-			reg = <0x10000 0x1000>;
-			interrupts = <16 2 1 27>;
-		};
-
-		corenet-cf@18000 {
-			compatible = "fsl,corenet-cf";
-			reg = <0x18000 0x1000>;
-			interrupts = <16 2 1 31>;
-			fsl,ccf-num-csdids = <32>;
-			fsl,ccf-num-snoopids = <32>;
-		};
-
-		iommu@20000 {
-			compatible = "fsl,pamu-v1.0", "fsl,pamu";
-			reg = <0x20000 0x4000>;
-			interrupts = <
-				24 2 0 0
-				16 2 1 30>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi0: msi@41600 {
-			compatible = "fsl,mpic-msi";
-			reg = <0x41600 0x200>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
-		};
-
-		msi1: msi@41800 {
-			compatible = "fsl,mpic-msi";
-			reg = <0x41800 0x200>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe8 0 0 0
-				0xe9 0 0 0
-				0xea 0 0 0
-				0xeb 0 0 0
-				0xec 0 0 0
-				0xed 0 0 0
-				0xee 0 0 0
-				0xef 0 0 0>;
-		};
-
-		msi2: msi@41a00 {
-			compatible = "fsl,mpic-msi";
-			reg = <0x41a00 0x200>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xf0 0 0 0
-				0xf1 0 0 0
-				0xf2 0 0 0
-				0xf3 0 0 0
-				0xf4 0 0 0
-				0xf5 0 0 0
-				0xf6 0 0 0
-				0xf7 0 0 0>;
-		};
-
-		guts: global-utilities@e0000 {
-			compatible = "fsl,qoriq-device-config-1.0";
-			reg = <0xe0000 0xe00>;
-			fsl,has-rstcr;
-			#sleep-cells = <1>;
-			fsl,liodn-bits = <12>;
-		};
-
-		pins: global-utilities@e0e00 {
-			compatible = "fsl,qoriq-pin-control-1.0";
-			reg = <0xe0e00 0x200>;
-			#sleep-cells = <2>;
-		};
-
-		clockgen: global-utilities@e1000 {
-			compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
-			reg = <0xe1000 0x1000>;
-			clock-frequency = <0>;
-		};
-
-		rcpm: global-utilities@e2000 {
-			compatible = "fsl,qoriq-rcpm-1.0";
-			reg = <0xe2000 0x1000>;
-			#sleep-cells = <1>;
-		};
-
-		sfp: sfp@e8000 {
-			compatible = "fsl,p3041-sfp", "fsl,qoriq-sfp-1.0";
-			reg	   = <0xe8000 0x1000>;
-		};
-
-		serdes: serdes@ea000 {
-			compatible = "fsl,p3041-serdes";
-			reg	   = <0xea000 0x1000>;
-		};
-
-		dma0: dma@100300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p3041-dma", "fsl,eloplus-dma";
-			reg = <0x100300 0x4>;
-			ranges = <0x0 0x100100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <28 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <29 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <30 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <31 2 0 0>;
-			};
-		};
-
-		dma1: dma@101300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p3041-dma", "fsl,eloplus-dma";
-			reg = <0x101300 0x4>;
-			ranges = <0x0 0x101100 0x200>;
-			cell-index = <1>;
-			dma-channel@0 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <32 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <33 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <34 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,p3041-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <35 2 0 0>;
-			};
-		};
-
-		spi@110000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,p3041-espi", "fsl,mpc8536-espi";
-			reg = <0x110000 0x1000>;
-			interrupts = <53 0x2 0 0>;
-			fsl,espi-num-chipselects = <4>;
-		};
-
-		sdhc: sdhc@114000 {
-			compatible = "fsl,p3041-esdhc", "fsl,esdhc";
-			reg = <0x114000 0x1000>;
-			interrupts = <48 2 0 0>;
-			sdhci,auto-cmd12;
-			clock-frequency = <0>;
-		};
-
-		i2c@118000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x118000 0x100>;
-			interrupts = <38 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@118100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x118100 0x100>;
-			interrupts = <38 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@119000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <2>;
-			compatible = "fsl-i2c";
-			reg = <0x119000 0x100>;
-			interrupts = <39 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@119100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <3>;
-			compatible = "fsl-i2c";
-			reg = <0x119100 0x100>;
-			interrupts = <39 2 0 0>;
-			dfsrr;
-		};
-
-		serial0: serial@11c500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x11c500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <36 2 0 0>;
-		};
-
-		serial1: serial@11c600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x11c600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <36 2 0 0>;
-		};
-
-		serial2: serial@11d500 {
-			cell-index = <2>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x11d500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <37 2 0 0>;
-		};
-
-		serial3: serial@11d600 {
-			cell-index = <3>;
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <0x11d600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <37 2 0 0>;
-		};
-
-		gpio0: gpio@130000 {
-			compatible = "fsl,p3041-gpio", "fsl,qoriq-gpio";
-			reg = <0x130000 0x1000>;
-			interrupts = <55 2 0 0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-		};
-
-		usb0: usb@210000 {
-			compatible = "fsl,p3041-usb2-mph",
-					"fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <44 0x2 0 0>;
-			phy_type = "utmi";
-			port0;
-		};
-
-		usb1: usb@211000 {
-			compatible = "fsl,p3041-usb2-dr",
-					"fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-			reg = <0x211000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <45 0x2 0 0>;
-			dr_mode = "host";
-			phy_type = "utmi";
-		};
-
-		sata@220000 {
-			compatible = "fsl,p3041-sata", "fsl,pq-sata-v2";
-			reg = <0x220000 0x1000>;
-			interrupts = <68 0x2 0 0>;
-		};
-
-		sata@221000 {
-			compatible = "fsl,p3041-sata", "fsl,pq-sata-v2";
-			reg = <0x221000 0x1000>;
-			interrupts = <69 0x2 0 0>;
-		};
-
-		crypto: crypto@300000 {
-			compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg		 = <0x300000 0x10000>;
-			ranges		 = <0 0x300000 0x10000>;
-			interrupts	 = <92 2 0 0>;
-
-			sec_jr0: jr@1000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x1000 0x1000>;
-				interrupts = <88 2 0 0>;
-			};
-
-			sec_jr1: jr@2000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x2000 0x1000>;
-				interrupts = <89 2 0 0>;
-			};
-
-			sec_jr2: jr@3000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x3000 0x1000>;
-				interrupts = <90 2 0 0>;
-			};
-
-			sec_jr3: jr@4000 {
-				compatible = "fsl,sec-v4.2-job-ring",
-					     "fsl,sec-v4.0-job-ring";
-				reg = <0x4000 0x1000>;
-				interrupts = <91 2 0 0>;
-			};
-
-			rtic@6000 {
-				compatible = "fsl,sec-v4.2-rtic",
-					     "fsl,sec-v4.0-rtic";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0x6000 0x100>;
-				ranges = <0x0 0x6100 0xe00>;
-
-				rtic_a: rtic-a@0 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x00 0x20 0x100 0x80>;
-				};
-
-				rtic_b: rtic-b@20 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x20 0x20 0x200 0x80>;
-				};
-
-				rtic_c: rtic-c@40 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x40 0x20 0x300 0x80>;
-				};
-
-				rtic_d: rtic-d@60 {
-					compatible = "fsl,sec-v4.2-rtic-memory",
-						     "fsl,sec-v4.0-rtic-memory";
-					reg = <0x60 0x20 0x500 0x80>;
-				};
-			};
-		};
-
-		sec_mon: sec_mon@314000 {
-			compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
-			reg = <0x314000 0x1000>;
-			interrupts = <93 2 0 0>;
-		};
-	};
-
-/*
-	rapidio0: rapidio@ffe0c0000
-*/
-
-	localbus@ffe124000 {
-		compatible = "fsl,p3041-elbc", "fsl,elbc", "simple-bus";
-		interrupts = <25 2 0 0>;
-		#address-cells = <2>;
-		#size-cells = <1>;
-	};
-
-	pci0: pcie@ffe200000 {
-		compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		bus-range = <0x0 0xff>;
-		clock-frequency = <0x1fca055>;
-		fsl,msi = <&msi0>;
-		interrupts = <16 2 1 15>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupts = <16 2 1 15>;
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 40 1 0 0
-				0000 0 0 2 &mpic 1 1 0 0
-				0000 0 0 3 &mpic 2 1 0 0
-				0000 0 0 4 &mpic 3 1 0 0
-				>;
-		};
-	};
-
-	pci1: pcie@ffe201000 {
-		compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		bus-range = <0 0xff>;
-		clock-frequency = <0x1fca055>;
-		fsl,msi = <&msi1>;
-		interrupts = <16 2 1 14>;
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupts = <16 2 1 14>;
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 41 1 0 0
-				0000 0 0 2 &mpic 5 1 0 0
-				0000 0 0 3 &mpic 6 1 0 0
-				0000 0 0 4 &mpic 7 1 0 0
-				>;
-		};
-	};
-
-	pci2: pcie@ffe202000 {
-		compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		bus-range = <0x0 0xff>;
-		clock-frequency = <0x1fca055>;
-		fsl,msi = <&msi2>;
-		interrupts = <16 2 1 13>;
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupts = <16 2 1 13>;
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 42 1 0 0
-				0000 0 0 2 &mpic 9 1 0 0
-				0000 0 0 3 &mpic 10 1 0 0
-				0000 0 0 4 &mpic 11 1 0 0
-				>;
-		};
-	};
-
-	pci3: pcie@ffe203000 {
-		compatible = "fsl,p3041-pcie", "fsl,qoriq-pcie-v2.2";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
-		bus-range = <0x0 0xff>;
-		clock-frequency = <0x1fca055>;
-		fsl,msi = <&msi2>;
-		interrupts = <16 2 1 12>;
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			interrupts = <16 2 1 12>;
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 43 1 0 0
-				0000 0 0 2 &mpic 0 1 0 0
-				0000 0 0 3 &mpic 4 1 0 0
-				0000 0 0 4 &mpic 8 1 0 0
-				>;
-		};
-	};
-};
-- 
1.7.3.4

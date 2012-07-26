Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 747472C0092
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 01:09:07 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] [v2] powerpc/85xx: add Freescale P5040 SOC and SEC v5.2
 device trees
Date: Thu, 26 Jul 2012 10:08:53 -0500
Message-ID: <1343315334-800-2-git-send-email-timur@freescale.com>
In-Reply-To: <1343315334-800-1-git-send-email-timur@freescale.com>
References: <1343315334-800-1-git-send-email-timur@freescale.com>
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

From: Kim Phillips <kim.phillips@freescale.com>

Add device tree (dtsi) files for the Freescale P5040 SOC.  Since this
SOC introduces SEC v5.2, add the dtsi file for that also.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   |  320 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    |  111 +++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |  118 +++++++++
 3 files changed, 549 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi

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
-- 
1.7.3.4

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 70B802C0324
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:06 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r25NG31E024142
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Mar 2013 17:16:04 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] powerpc/fsl-booke: Add initial silicon device tree for
Date: Tue,  5 Mar 2013 17:15:57 -0600
Message-Id: <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable a baseline T4240 SoC to boot.  There are several things missing
from the device trees for T4240:

* Thread support on e6500
* Proper PAMU topology information
* DPAA related nodes (Qman, Bman, Fman, Rman, DCE)
* Prefetch Manager
* Thermal monitor unit
* Interlaken

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Vakul Garg <vakul@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi |   41 ++++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi |   41 ++++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi |   41 ++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  311 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |  129 +++++++++++
 5 files changed, 563 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi
new file mode 100644
index 0000000..c2f9cda
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ GPIO device tree stub [ controller @ offset 0x131000 ]
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
+gpio1: gpio@131000 {
+	compatible = "fsl,qoriq-gpio";
+	reg = <0x131000 0x1000>;
+	interrupts = <54 2 0 0>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi
new file mode 100644
index 0000000..33f3ccb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ GPIO device tree stub [ controller @ offset 0x132000 ]
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
+gpio2: gpio@132000 {
+	compatible = "fsl,qoriq-gpio";
+	reg = <0x132000 0x1000>;
+	interrupts = <86 2 0 0>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi
new file mode 100644
index 0000000..86954e9
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ GPIO device tree stub [ controller @ offset 0x133000 ]
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
+gpio3: gpio@133000 {
+	compatible = "fsl,qoriq-gpio";
+	reg = <0x133000 0x1000>;
+	interrupts = <87 2 0 0>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
new file mode 100644
index 0000000..a0cc3fb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -0,0 +1,311 @@
+/*
+ * T4240 Silicon/SoC Device Tree Source (post include)
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
+/* controller at 0x240000 */
+&pci0 {
+	compatible = "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <20 2 0 0>;
+	pcie@0 {
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
+	compatible = "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <21 2 0 0>;
+	pcie@0 {
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
+	compatible = "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <22 2 0 0>;
+	pcie@0 {
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
+	compatible = "fsl,t4240-pcie", "fsl,qoriq-pcie-v3.0";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <33333333>;
+	interrupts = <23 2 0 0>;
+	pcie@0 {
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
+	ddr2: memory-controller@9000 {
+		compatible = "fsl,qoriq-memory-controller-v4.7",
+				"fsl,qoriq-memory-controller";
+		reg = <0x9000 0x1000>;
+		interrupts = <16 2 1 22>;
+	};
+
+	ddr3: memory-controller@a000 {
+		compatible = "fsl,qoriq-memory-controller-v4.7",
+				"fsl,qoriq-memory-controller";
+		reg = <0xa000 0x1000>;
+		interrupts = <16 2 1 21>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,t4240-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000
+		       0x11000 0x1000
+		       0x12000 0x1000>;
+		interrupts = <16 2 1 27
+			      16 2 1 26
+			      16 2 1 25>;
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
+		reg = <0x20000 0x6000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,t4240-device-config";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2";
+		reg = <0xe1000 0x1000>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2";
+		reg = <0xe2000 0x1000>;
+	};
+
+	sfp: sfp@e8000 {
+		compatible = "fsl,t4240-sfp";
+		reg	   = <0xe8000 0x1000>;
+	};
+
+	serdes: serdes@ea000 {
+		compatible = "fsl,t4240-serdes";
+		reg	   = <0xea000 0x4000>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+/include/ "qoriq-dma-1.dtsi"
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
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
+			phy_type = "utmi";
+			port0;
+		};
+/include/ "qoriq-usb2-dr-0.dtsi"
+		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+			dr_mode = "host";
+			phy_type = "utmi";
+		};
+/include/ "qoriq-sata2-0.dtsi"
+/include/ "qoriq-sata2-1.dtsi"
+/include/ "qoriq-sec5.0-0.dtsi"
+
+	L2_1: l2-cache-controller@c20000 {
+		compatible = "fsl,t4240-l2-cache-controller";
+		reg = <0xc20000 0x40000>;
+		next-level-cache = <&cpc>;
+	};
+	L2_2: l2-cache-controller@c60000 {
+		compatible = "fsl,t4240-l2-cache-controller";
+		reg = <0xc60000 0x40000>;
+		next-level-cache = <&cpc>;
+	};
+	L2_3: l2-cache-controller@ca0000 {
+		compatible = "fsl,t4240-l2-cache-controller";
+		reg = <0xca0000 0x40000>;
+		next-level-cache = <&cpc>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
new file mode 100644
index 0000000..0ddf072
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -0,0 +1,129 @@
+/*
+ * T4240 Silicon/SoC Device Tree Source (pre include)
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
+/include/ "e6500_power_isa.dtsi"
+
+/ {
+	compatible = "fsl,T4240";
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
+		crypto = &crypto;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		pci3 = &pci3;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		sdhc = &sdhc;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,e6500@0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2_1>;
+		};
+		PowerPC,e6500@1 {
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2_1>;
+		};
+		PowerPC,e6500@2 {
+			device_type = "cpu";
+			reg = <4>;
+			next-level-cache = <&L2_1>;
+		};
+		PowerPC,e6500@3 {
+			device_type = "cpu";
+			reg = <6>;
+			next-level-cache = <&L2_1>;
+		};
+
+		PowerPC,e6500@4 {
+			device_type = "cpu";
+			reg = <8>;
+			next-level-cache = <&L2_2>;
+		};
+		PowerPC,e6500@5 {
+			device_type = "cpu";
+			reg = <10>;
+			next-level-cache = <&L2_2>;
+		};
+		PowerPC,e6500@6 {
+			device_type = "cpu";
+			reg = <12>;
+			next-level-cache = <&L2_2>;
+		};
+		PowerPC,e6500@7 {
+			device_type = "cpu";
+			reg = <14>;
+			next-level-cache = <&L2_2>;
+		};
+
+		PowerPC,e6500@8 {
+			device_type = "cpu";
+			reg = <16>;
+			next-level-cache = <&L2_3>;
+		};
+		PowerPC,e6500@9 {
+			device_type = "cpu";
+			reg = <18>;
+			next-level-cache = <&L2_3>;
+		};
+		PowerPC,e6500@10 {
+			device_type = "cpu";
+			reg = <20>;
+			next-level-cache = <&L2_3>;
+		};
+		PowerPC,e6500@11 {
+			device_type = "cpu";
+			reg = <22>;
+			next-level-cache = <&L2_3>;
+		};
+	};
+};
-- 
1.7.9.7

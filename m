Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD9FD2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:55:23 +1100 (EST)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree files
 for B4860QDS
Date: Fri, 15 Mar 2013 13:25:04 +0530
Message-ID: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  184 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   80 ++++++++++++
 2 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
new file mode 100644
index 0000000..2db68b2
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -0,0 +1,184 @@
+/*
+ * B4860 Silicon/SoC Device Tree Source (post include)
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
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,b4860-pcie", "fsl,qoriq-pcie-v2.4";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
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
+		interrupts = <16 2 1 2>;
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
+		interrupts = <16 2 1 8>;
+	};
+
+	ddr2: memory-controller@9000 {
+		compatible = "fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-controller";
+		reg = <0x9000 0x1000>;
+		interrupts = <16 2 1 9>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,p5020-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000
+		       0x11000 0x1000>;
+		interrupts = <16 2 1 4
+			      16 2 1 5>;
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,corenet-cf";
+		reg = <0x18000 0x1000>;
+		interrupts = <16 2 1 0>;
+		fsl,ccf-num-csdids = <32>;
+		fsl,ccf-num-snoopids = <32>;
+	};
+
+	iommu@20000 {
+		compatible = "fsl,pamu-v1.0", "fsl,pamu";
+		reg = <0x20000 0x4000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 1>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,b4860-device-config";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2";
+		reg = <0xe1000 0x1000>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2";
+		reg = <0xe2000 0x1000>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+/include/ "qoriq-dma-1.dtsi"
+
+/include/ "qonverge-usb2-dr-0.dtsi"
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+	};
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		sdhci,auto-cmd12;
+	};
+/include/ "qoriq-i2c-0.dtsi"
+/include/ "qoriq-i2c-1.dtsi"
+/include/ "qoriq-duart-0.dtsi"
+/include/ "qoriq-duart-1.dtsi"
+
+	L2: l2-cache-controller@c20000 {
+		next-level-cache = <&cpc>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
new file mode 100644
index 0000000..33bc600
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -0,0 +1,80 @@
+/*
+ * B4860 Silicon/SoC Device Tree Source (pre include)
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
+/ {
+	compatible = "fsl,B4860";
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
+			reg = <0 1>;
+			next-level-cache = <&L2>;
+		};
+		PowerPC,e6500@1 {
+			device_type = "cpu";
+			reg = <2 3>;
+			next-level-cache = <&L2>;
+		};
+		PowerPC,e6500@2 {
+			device_type = "cpu";
+			reg = <4 5>;
+			next-level-cache = <&L2>;
+		};
+		PowerPC,e6500@3 {
+			device_type = "cpu";
+			reg = <6 7>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
-- 
1.7.6.GIT

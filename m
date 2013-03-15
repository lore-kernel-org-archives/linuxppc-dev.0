Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74E4C2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:55:24 +1100 (EST)
Received: from mail54-tx2 (localhost [127.0.0.1])	by mail54-tx2-R.bigfish.com
 (Postfix) with ESMTP id E5E812E02A0	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 15 Mar 2013 07:55:19 +0000 (UTC)
Received: from TX2EHSMHS033.bigfish.com (unknown [10.9.14.246])	by
 mail54-tx2.bigfish.com (Postfix) with ESMTP id CD4A734007C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 07:55:16 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/6] powerpc/fsl-booke: Add initial silicon device tree files
 for B4420QDS
Date: Fri, 15 Mar 2013 13:25:06 +0530
Message-ID: <1363334109-21922-3-git-send-email-shaveta@freescale.com>
In-Reply-To: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
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
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  151 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   70 ++++++++++++
 2 files changed, 221 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
new file mode 100644
index 0000000..e45d605
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -0,0 +1,151 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
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
+	compatible = "fsl,b4420-pcie", "fsl,qoriq-pcie-v2.4";
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
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,p5020-l3-cache-controller", "fsl,p4080-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000>;
+		interrupts = <16 2 1 4>;
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
+		compatible = "fsl,pamu";
+		reg = <0x20000 0x4000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 1>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,b4420-device-config";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,b4420-rcpm", "fsl,qoriq-rcpm-2";
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
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
new file mode 100644
index 0000000..c1ade3b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -0,0 +1,70 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+/dts-v1/;
+/ {
+	compatible = "fsl,B4420";
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
+	};
+};
-- 
1.7.6.GIT

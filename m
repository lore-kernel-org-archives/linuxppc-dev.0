Return-Path: <hongbo.zhang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F02C2C032E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 21:26:37 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH resend 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
Date: Mon, 11 Nov 2013 18:26:06 +0800
Message-ID: <1384165567-4883-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1384165567-4883-1-git-send-email-hongbo.zhang@freescale.com>
References: <1384165567-4883-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch adds
the device tree nodes for them.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 .../devicetree/bindings/powerpc/fsl/dma.txt        |   70 +++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   82 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   82 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
 5 files changed, 238 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
index 0584168..7fc1b01 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
@@ -128,6 +128,76 @@ Example:
 		};
 	};
 
+** Freescale Elo3 DMA Controller
+   DMA controller which has same function as EloPlus except that Elo3 has 8
+   channels while EloPlus has only 4, it is used in Freescale Txxx and Bxxx
+   series chips, such as t1040, t4240, b4860.
+
+Required properties:
+
+- compatible        : must include "fsl,elo3-dma"
+- reg               : contains two entries for DMA General Status Registers,
+                      i.e. DGSR0 which includes status for channel 1~4, and
+                      DGSR1 for channel 5~8
+- ranges            : describes the mapping between the address space of the
+                      DMA channels and the address space of the DMA controller
+
+- DMA channel nodes:
+        - compatible        : must include "fsl,eloplus-dma-channel"
+        - reg               : DMA channel specific registers
+        - interrupts        : interrupt specifier for DMA channel IRQ
+        - interrupt-parent  : optional, if needed for interrupt mapping
+
+Example:
+dma@100300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x100300 0x4>,
+	      <0x100600 0x4>;
+	ranges = <0x0 0x100100 0x500>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		interrupts = <28 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		interrupts = <29 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		interrupts = <30 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		interrupts = <31 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		interrupts = <76 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		interrupts = <77 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		interrupts = <78 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		interrupts = <79 2 0 0>;
+	};
+};
+
 Note on DMA channel compatible properties: The compatible property must say
 "fsl,elo-dma-channel" or "fsl,eloplus-dma-channel" to be used by the Elo DMA
 driver (fsldma).  Any DMA channel used by fsldma cannot be used by another
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 4c617bf..4f6e482 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -223,13 +223,13 @@
 		reg = <0xe2000 0x1000>;
 	};
 
-/include/ "qoriq-dma-0.dtsi"
+/include/ "elo3-dma-0.dtsi"
 	dma@100300 {
 		fsl,iommu-parent = <&pamu0>;
 		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
 	};
 
-/include/ "qoriq-dma-1.dtsi"
+/include/ "elo3-dma-1.dtsi"
 	dma@101300 {
 		fsl,iommu-parent = <&pamu0>;
 		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
new file mode 100644
index 0000000..3c210e0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
@@ -0,0 +1,82 @@
+/*
+ * QorIQ Elo3 DMA device tree stub [ controller @ offset 0x100000 ]
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
+dma0: dma@100300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x100300 0x4>,
+	      <0x100600 0x4>;
+	ranges = <0x0 0x100100 0x500>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		interrupts = <28 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		interrupts = <29 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		interrupts = <30 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		interrupts = <31 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		interrupts = <76 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		interrupts = <77 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		interrupts = <78 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		interrupts = <79 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
new file mode 100644
index 0000000..cccf3bb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
@@ -0,0 +1,82 @@
+/*
+ * QorIQ Elo3 DMA device tree stub [ controller @ offset 0x101000 ]
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
+dma1: dma@101300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x101300 0x4>,
+	      <0x101600 0x4>;
+	ranges = <0x0 0x101100 0x500>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		interrupts = <32 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		interrupts = <33 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		interrupts = <34 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		interrupts = <35 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		interrupts = <80 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		interrupts = <81 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		interrupts = <82 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		interrupts = <83 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 510afa3..4143a97 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -387,8 +387,8 @@
 		reg	   = <0xea000 0x4000>;
 	};
 
-/include/ "qoriq-dma-0.dtsi"
-/include/ "qoriq-dma-1.dtsi"
+/include/ "elo3-dma-0.dtsi"
+/include/ "elo3-dma-1.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
-- 
1.7.9.5

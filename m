Return-Path: <Shengzhou.Liu@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A198F2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 22:00:13 +1100 (EST)
Received: from mail189-ch1 (localhost [127.0.0.1])	by
 mail189-ch1-R.bigfish.com (Postfix) with ESMTP id E3C6E1801DC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 11:00:07 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 1/4] powerpc/85xx/dts: add third elo3 dma component
Date: Wed, 25 Dec 2013 18:06:55 +0800
Message-ID: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add elo3-dma-2.dtsi to support the third DMA controller.
This is used on T2080, T4240, B4860, etc.

FSL MPIC v4.3 adds a new discontiguous address range for internal interrupts,
e.g. internal interrupt 0 is at offset 0x200 and thus interrupt number is:
0x200 >> 5 = 16 in the device tree.  DMA controller 3 channel 0 internal
interrupt 240 is at offset 0x3a00, and thus the corresponding interrupt
number is: 0x3a00 >> 5 = 464, it's similar for other 7 interrupt numbers
of DMA 3 channels.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
new file mode 100644
index 0000000..d3cc8d0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
@@ -0,0 +1,82 @@
+/*
+ * QorIQ Elo3 DMA device tree stub [ controller @ offset 0x102300 ]
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
+dma2: dma@102300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,elo3-dma";
+	reg = <0x102300 0x4>,
+	      <0x102600 0x4>;
+	ranges = <0x0 0x102100 0x500>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		interrupts = <464 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		interrupts = <465 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		interrupts = <466 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		interrupts = <467 2 0 0>;
+	};
+	dma-channel@300 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x300 0x80>;
+		interrupts = <468 2 0 0>;
+	};
+	dma-channel@380 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x380 0x80>;
+		interrupts = <469 2 0 0>;
+	};
+	dma-channel@400 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x400 0x80>;
+		interrupts = <470 2 0 0>;
+	};
+	dma-channel@480 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x480 0x80>;
+		interrupts = <471 2 0 0>;
+	};
+};
-- 
1.8.0

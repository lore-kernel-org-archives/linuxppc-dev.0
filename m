Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06EF6DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:16:03 +1100 (EST)
Date: Tue, 22 Jan 2008 15:13:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
Message-ID: <Pine.LNX.4.64.0801221511540.24873@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Guys please review and make sure I got all your previous comments fixed
up.  I've added cell-index. and the examples should represent real HW.

 Documentation/powerpc/booting-without-of.txt |  128 ++++++++++++++++++++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index da98154..3584c33 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2615,6 +2615,134 @@ platforms are moved over to use the flattened-device-tree model.
        - clock-frequency  : The frequency of the input clock, which typically
                             comes from an on-board dedicated oscillator.

+    * Freescale 83xx DMA Controller
+
+    Freescale PowerPC 83xx have on chip general purpose DMA controllers.
+
+    Required properties:
+
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-dma", where CHIP is the processor
+			 (mpc8349, mpc8360, etc.) and the second is
+			 "fsl,elo-dma"
+    - reg               : <registers mapping for DMA general status reg>
+    - ranges 		: Should be defined as specified in 1) to describe the
+			  DMA controller channels.
+    - cell-index        : controller index.  0 for controller @ 0x8100
+    - interrupts        : <interrupt mapping for DMA IRQ>
+    - interrupt-parent  : optional, if needed for interrupt mapping
+
+
+    - DMA channel nodes:
+	    - compatible        : compatible list, contains 2 entries, first is
+				 "fsl,CHIP-dma-channel", where CHIP is the processor
+				 (mpc8349, mpc8350, etc.) and the second is
+				 "fsl,elo-dma-channel"
+	    - reg               : <registers mapping for channel>
+	    - cell-index        : dma channel index starts at 0.
+
+    Optional properties:
+	    - interrupts        : <interrupt mapping for DMA channel IRQ>
+				  (on 83xx this is expected to be identical to
+				   the interrupts property of the parent node)
+	    - interrupt-parent  : optional, if needed for interrupt mapping
+
+  Example:
+	dma@82a8 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+		reg = <82a8 4>;
+		ranges = <0 8100 1a4>;
+		interrupt-parent = <&ipic>;
+		interrupts = <47 8>;
+		cell-index = <0>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <0>;
+			reg = <0 80>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <1>;
+			reg = <80 80>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <2>;
+			reg = <100 80>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			cell-index = <3>;
+			reg = <180 80>;
+		};
+	};
+
+   * Freescale 85xx/86xx DMA Controller
+
+    Freescale PowerPC 85xx/86xx have on chip general purpose DMA controllers.
+
+    Required properties:
+
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-dma", where CHIP is the processor
+			 (mpc8540, mpc8540, etc.) and the second is
+			 "fsl,eloplus-dma"
+    - reg               : <registers mapping for DMA general status reg>
+    - cell-index        : controller index.  0 for controller @ 0x21000,
+                                             1 for controller @ 0xc000
+    - ranges 		: Should be defined as specified in 1) to describe the
+			  DMA controller channels.
+
+    - DMA channel nodes:
+	    - compatible        : compatible list, contains 2 entries, first is
+				 "fsl,CHIP-dma-channel", where CHIP is the processor
+				 (mpc8540, mpc8560, etc.) and the second is
+				 "fsl,eloplus-dma-channel"
+	    - cell-index        : dma channel index starts at 0.
+	    - reg               : <registers mapping for channel>
+	    - interrupts        : <interrupt mapping for DMA channel IRQ>
+	    - interrupt-parent  : optional, if needed for interrupt mapping
+
+  Example:
+	dma@21300 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+		reg = <21300 4>;
+		ranges = <0 21100 200>;
+		cell-index = <0>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <0 80>;
+			cell-index = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <14 2>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <80 80>;
+			cell-index = <1>;
+			interrupt-parent = <&mpic>;
+			interrupts = <15 2>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <100 80>;
+			cell-index = <2>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <180 80>;
+			cell-index = <3>;
+			interrupt-parent = <&mpic>;
+			interrupts = <17 2>;
+		};
+	};
+

    More devices will be defined as this spec matures.

-- 
1.5.3.7

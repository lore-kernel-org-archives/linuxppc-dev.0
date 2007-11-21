Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83BDDDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:16:28 +1100 (EST)
Date: Tue, 20 Nov 2007 23:14:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel device
	tree nodes
In-Reply-To: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 Documentation/powerpc/booting-without-of.txt |  113 ++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3d959d6..161fb0d 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2578,6 +2578,119 @@ platforms are moved over to use the flattened-device-tree model.
 		interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
 	};

+   * Freescale 83xx DMA Controller
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
+
+    Optional properties:
+	    - interrupts        : <interrupt mapping for DMA channel IRQ>
+				  (on 83xx this is expected to be identical to
+				   the interrupts property of the parent node)
+	    - interrupt-parent  : optional, if needed for interrupt mapping
+
+  Example:
+	dma@21000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+		reg = <21300 4>;
+		ranges = <0 21100 200>;
+		interrupt-parent = <&ipic>;
+		interrupts = <14 2>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			reg = <0 80>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			reg = <80 80>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			reg = <100 80>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+			reg = <180 80>;
+		};
+	};
+
+   * Freescale 85xx DMA Controller
+
+    Freescale PowerPC 85xx have on chip general purpose DMA controllers.
+
+    Required properties:
+
+    - compatible        : compatible list, contains 2 entries, first is
+			 "fsl,CHIP-dma", where CHIP is the processor
+			 (mpc8540, mpc8540, etc.) and the second is
+			 "fsl,eloplus-dma"
+    - reg               : <registers mapping for DMA general status reg>
+    - ranges 		: Should be defined as specified in 1) to describe the
+			  DMA controller channels.
+
+    - DMA channel nodes:
+	    - compatible        : compatible list, contains 2 entries, first is
+				 "fsl,CHIP-dma-channel", where CHIP is the processor
+				 (mpc8540, mpc8560, etc.) and the second is
+				 "fsl,eloplus-dma-channel"
+	    - reg               : <registers mapping for channel>
+	    - interrupts        : <interrupt mapping for DMA channel IRQ>
+	    - interrupt-parent  : optional, if needed for interrupt mapping
+
+  Example:
+	dma@21000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+		reg = <21300 4>;
+		ranges = <0 21100 200>;
+		dma-channel@0 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <0 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <14 2>;
+		};
+		dma-channel@80 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <80 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <15 2>;
+		};
+		dma-channel@100 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <100 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+		dma-channel@180 {
+			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+			reg = <180 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <17 2>;
+		};
+	};
+
    More devices will be defined as this spec matures.

 VII - Specifying interrupt information for devices
-- 
1.5.3.4

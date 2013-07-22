Return-Path: <B45939@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56AC92C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 15:56:26 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <vinod.koul@intel.com>, <djbw@fb.com>, <leoli@freescale.com>,
 <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 1/3] DMA: Freescale: revise device tree binding document
Date: Mon, 22 Jul 2013 13:55:38 +0800
Message-ID: <1374472540-21177-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1374472540-21177-1-git-send-email-hongbo.zhang@freescale.com>
References: <1374472540-21177-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 vakul@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

This updates the discription of each type of DMA controller and its channels,
it is preparation for adding another new DMA controller binding, also fixes
some defects of indent for text alignment at the same time.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/dma.txt        |   56 +++++++++++---------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
index 2a4b4bc..0650171 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
@@ -1,33 +1,33 @@
-* Freescale 83xx DMA Controller
+* Freescale DMA Controllers
 
-Freescale PowerPC 83xx have on chip general purpose DMA controllers.
+** Freescale ELO DMA Controller
+   This is a little-endian DMA controller.
+   Used in Freescale PowerPC 83xx series, such as:
+   mpc8313, mpc8315, mpc8323, mpc8347, mpc8349, mpc8360, mpc8377, mpc8378, mpc8379.
 
 Required properties:
 
 - compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-dma", where CHIP is the processor
-		 (mpc8349, mpc8360, etc.) and the second is
-		 "fsl,elo-dma"
+                      "fsl,CHIP-dma", where CHIP is the processor
+                      and the second is "fsl,elo-dma"
 - reg               : <registers mapping for DMA general status reg>
-- ranges		: Should be defined as specified in 1) to describe the
-		  DMA controller channels.
+- ranges            : physical address range of DMA controller channels
 - cell-index        : controller index.  0 for controller @ 0x8100
 - interrupts        : <interrupt mapping for DMA IRQ>
 - interrupt-parent  : optional, if needed for interrupt mapping
 
-
 - DMA channel nodes:
         - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma-channel", where CHIP is the processor
-			 (mpc8349, mpc8350, etc.) and the second is
-			 "fsl,elo-dma-channel". However, see note below.
+                              "fsl,CHIP-dma-channel", where CHIP is the processor
+                              and the second is "fsl,elo-dma-channel".
+                              However, see note below.
         - reg               : <registers mapping for channel>
         - cell-index        : dma channel index starts at 0.
 
 Optional properties:
         - interrupts        : <interrupt mapping for DMA channel IRQ>
-			  (on 83xx this is expected to be identical to
-			   the interrupts property of the parent node)
+                              (on 83xx this is expected to be identical to
+                              the interrupts property of the parent node)
         - interrupt-parent  : optional, if needed for interrupt mapping
 
 Example:
@@ -70,27 +70,31 @@ Example:
 		};
 	};
 
-* Freescale 85xx/86xx DMA Controller
-
-Freescale PowerPC 85xx/86xx have on chip general purpose DMA controllers.
+** Freescale ELOPLUS DMA Controller
+   This is DMA controller with extended addresses and chaining.
+   Used in Freescale PowerPC 85xx/86xx and pxxx series chips, such as:
+   [1] mpc8540, mpc8541, mpc8555, mpc8560, mpc8610, mpc8641,
+   [2] mpc8536, mpc8544, mpc8548, mpc8568, mpc8569, mpc8572, p1010, p1020, p1021,
+       p1022, p1023, p2020, p2041, p3041, p4080, p5020, p5040, and also bsc9131.
 
 Required properties:
 
-- compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-dma", where CHIP is the processor
-		 (mpc8540, mpc8540, etc.) and the second is
-		 "fsl,eloplus-dma"
+- compatible        : compatible list, contains 2 entries for chips in above
+                      list[1], the first is "fsl,CHIP-dma", where CHIP is the
+                      processor and the second is "fsl,eloplus-dma". contains
+                      only one "fsl,eloplus-dma" for chips in above list[2]
 - reg               : <registers mapping for DMA general status reg>
 - cell-index        : controller index.  0 for controller @ 0x21000,
                                          1 for controller @ 0xc000
-- ranges		: Should be defined as specified in 1) to describe the
-		  DMA controller channels.
+- ranges            : physical address range of DMA controller channels
 
 - DMA channel nodes:
-        - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma-channel", where CHIP is the processor
-			 (mpc8540, mpc8560, etc.) and the second is
-			 "fsl,eloplus-dma-channel". However, see note below.
+        - compatible        : compatible list, contains 2 entries for chips in
+                              above list[1], the first is "fsl,CHIP-dma-channel",
+                              where CHIP is the processor and the second is
+                              "fsl,eloplus-dma-channel". contains only one
+                              "fsl,eloplus-dma-channel" for chips in above list[2]
+                              However, see note below.
         - cell-index        : dma channel index starts at 0.
         - reg               : <registers mapping for channel>
         - interrupts        : <interrupt mapping for DMA channel IRQ>
-- 
1.7.9.5

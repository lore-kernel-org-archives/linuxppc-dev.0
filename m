Return-Path: <B45939@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 986402C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 20:16:15 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <rob.herring@calxeda.com>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <swarren@wwwdotorg.org>, <ian.campbell@citrix.com>, <vinod.koul@intel.com>,
 <djbw@fb.com>
Subject: [PATCH v10 1/3] DMA: Freescale: revise device tree binding document
Date: Wed, 18 Sep 2013 18:15:31 +0800
Message-ID: <1379499333-4745-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

This patch updates the discription of each type of DMA controller and its
channels, it is preparation for adding another new DMA controller binding, it
also fixes some defects of indent for text alignment at the same time.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 .../devicetree/bindings/powerpc/fsl/dma.txt        |   68 +++++++++-----------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
index 2a4b4bc..0584168 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
@@ -1,33 +1,30 @@
-* Freescale 83xx DMA Controller
+* Freescale DMA Controllers
 
-Freescale PowerPC 83xx have on chip general purpose DMA controllers.
+** Freescale Elo DMA Controller
+   This is a little-endian 4-channel DMA controller, used in Freescale mpc83xx
+   series chips such as mpc8315, mpc8349, mpc8379 etc.
 
 Required properties:
 
-- compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-dma", where CHIP is the processor
-		 (mpc8349, mpc8360, etc.) and the second is
-		 "fsl,elo-dma"
-- reg               : <registers mapping for DMA general status reg>
-- ranges		: Should be defined as specified in 1) to describe the
-		  DMA controller channels.
+- compatible        : must include "fsl,elo-dma"
+- reg               : DMA General Status Register, i.e. DGSR which contains
+                      status for all the 4 DMA channels
+- ranges            : describes the mapping between the address space of the
+                      DMA channels and the address space of the DMA controller
 - cell-index        : controller index.  0 for controller @ 0x8100
-- interrupts        : <interrupt mapping for DMA IRQ>
+- interrupts        : interrupt specifier for DMA IRQ
 - interrupt-parent  : optional, if needed for interrupt mapping
 
-
 - DMA channel nodes:
-        - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma-channel", where CHIP is the processor
-			 (mpc8349, mpc8350, etc.) and the second is
-			 "fsl,elo-dma-channel". However, see note below.
-        - reg               : <registers mapping for channel>
-        - cell-index        : dma channel index starts at 0.
+        - compatible        : must include "fsl,elo-dma-channel"
+                              However, see note below.
+        - reg               : DMA channel specific registers
+        - cell-index        : DMA channel index starts at 0.
 
 Optional properties:
-        - interrupts        : <interrupt mapping for DMA channel IRQ>
-			  (on 83xx this is expected to be identical to
-			   the interrupts property of the parent node)
+        - interrupts        : interrupt specifier for DMA channel IRQ
+                              (on 83xx this is expected to be identical to
+                              the interrupts property of the parent node)
         - interrupt-parent  : optional, if needed for interrupt mapping
 
 Example:
@@ -70,30 +67,27 @@ Example:
 		};
 	};
 
-* Freescale 85xx/86xx DMA Controller
-
-Freescale PowerPC 85xx/86xx have on chip general purpose DMA controllers.
+** Freescale EloPlus DMA Controller
+   This is a 4-channel DMA controller with extended addresses and chaining,
+   mainly used in Freescale mpc85xx/86xx, Pxxx and BSC series chips, such as
+   mpc8540, mpc8641 p4080, bsc9131 etc.
 
 Required properties:
 
-- compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-dma", where CHIP is the processor
-		 (mpc8540, mpc8540, etc.) and the second is
-		 "fsl,eloplus-dma"
-- reg               : <registers mapping for DMA general status reg>
+- compatible        : must include "fsl,eloplus-dma"
+- reg               : DMA General Status Register, i.e. DGSR which contains
+                      status for all the 4 DMA channels
 - cell-index        : controller index.  0 for controller @ 0x21000,
                                          1 for controller @ 0xc000
-- ranges		: Should be defined as specified in 1) to describe the
-		  DMA controller channels.
+- ranges            : describes the mapping between the address space of the
+                      DMA channels and the address space of the DMA controller
 
 - DMA channel nodes:
-        - compatible        : compatible list, contains 2 entries, first is
-			 "fsl,CHIP-dma-channel", where CHIP is the processor
-			 (mpc8540, mpc8560, etc.) and the second is
-			 "fsl,eloplus-dma-channel". However, see note below.
-        - cell-index        : dma channel index starts at 0.
-        - reg               : <registers mapping for channel>
-        - interrupts        : <interrupt mapping for DMA channel IRQ>
+        - compatible        : must include "fsl,eloplus-dma-channel"
+                              However, see note below.
+        - cell-index        : DMA channel index starts at 0.
+        - reg               : DMA channel specific registers
+        - interrupts        : interrupt specifier for DMA channel IRQ
         - interrupt-parent  : optional, if needed for interrupt mapping
 
 Example:
-- 
1.7.9.5

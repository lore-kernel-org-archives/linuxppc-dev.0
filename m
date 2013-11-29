Return-Path: <hongbo.zhang@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24B7C2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 19:07:50 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] DTS: DMA: Fix DMA3 interrupts
Date: Fri, 29 Nov 2013 16:07:26 +0800
Message-ID: <1385712446-28221-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

MPIC registers for internal interrupts is non-continous in address, any
internal interrupt number greater than 159 should be added (16+208) to work.
16 is due to external interrupts as usual, 208 is due to the non-continous MPIC
register space.
Tested on T4240 rev2 with SRIO2 disabled.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
index b89d816..d3cc8d0 100644
--- a/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi
@@ -42,41 +42,41 @@ dma2: dma@102300 {
 	dma-channel@0 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x0 0x80>;
-		interrupts = <256 2 0 0>;
+		interrupts = <464 2 0 0>;
 	};
 	dma-channel@80 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x80 0x80>;
-		interrupts = <257 2 0 0>;
+		interrupts = <465 2 0 0>;
 	};
 	dma-channel@100 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x100 0x80>;
-		interrupts = <258 2 0 0>;
+		interrupts = <466 2 0 0>;
 	};
 	dma-channel@180 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x180 0x80>;
-		interrupts = <259 2 0 0>;
+		interrupts = <467 2 0 0>;
 	};
 	dma-channel@300 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x300 0x80>;
-		interrupts = <260 2 0 0>;
+		interrupts = <468 2 0 0>;
 	};
 	dma-channel@380 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x380 0x80>;
-		interrupts = <261 2 0 0>;
+		interrupts = <469 2 0 0>;
 	};
 	dma-channel@400 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x400 0x80>;
-		interrupts = <262 2 0 0>;
+		interrupts = <470 2 0 0>;
 	};
 	dma-channel@480 {
 		compatible = "fsl,eloplus-dma-channel";
 		reg = <0x480 0x80>;
-		interrupts = <263 2 0 0>;
+		interrupts = <471 2 0 0>;
 	};
 };
-- 
1.7.9.5

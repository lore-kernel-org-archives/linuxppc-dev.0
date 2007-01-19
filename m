Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40595DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:40:41 +1100 (EST)
Received: from ng (84-73-191-27.dclient.hispeed.ch [84.73.191.27])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.11.20060308/8.12.11/taifun-1.0) with ESMTP id
	l0JKeaWD004102
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Jan 2007 21:40:36 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc: fix memory-to-memory DMA on PPC4xx
Date: Fri, 19 Jan 2007 21:40:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701192140.35760.niklaus.giger@member.fsf.org>
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[PATCH] pcc: fix memory-to-memory DMA on PPC4xx

During a memory-to-memory DMA transfers using the PPC4xx internal DMA 
controllers the source and destination addresses were not incremented after 
each data transfer.

Signed-off-by: Niklaus Giger <niklaus.giger at member.fsf.org>
---
c97d534851539b5ac18a90761bba9ea261545972
 arch/ppc/syslib/ppc4xx_dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/ppc4xx_dma.c b/arch/ppc/syslib/ppc4xx_dma.c
index 1eef4ff..1cb68a6 100644
--- a/arch/ppc/syslib/ppc4xx_dma.c
+++ b/arch/ppc/syslib/ppc4xx_dma.c
@@ -104,7 +104,8 @@ ppc4xx_enable_dma(unsigned int dmanr)
 	control &= ~(DMA_TM_MASK | DMA_TD);	/* clear all mode bits */
 	if (p_dma_ch->mode == DMA_MODE_MM) {
 		/* software initiated memory to memory */
-		control |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
+		control |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE |
+			   DMA_SAI | DMA_DAI ;
 	}
 
 	mtdcr(DCRN_DMACR0 + (dmanr * 0x8), control);

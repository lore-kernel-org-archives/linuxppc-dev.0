Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13382DE0CE
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:27:04 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, fujita.tomonori@lab.ntt.co.jp
Subject: [PATCH 1/5] powerpc: Use sg->dma_length in sg_dma_len() macro on
	32-bit
Date: Mon, 20 Apr 2009 11:26:46 -0500
Message-Id: <1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the 32-bit code uses sg->length instead of sg->dma_lentgh
to report sg_dma_len.  However, since the default dma code for 32-bit
(the dma_direct case) sets dma_length and length to the same thing,
we should be able to use dma_length there as well.  This gets rid of
some 32-vs-64-bit ifdefs, and is needed by the swiotlb code which
actually distinguishes between dma_length and length.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/scatterlist.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/scatterlist.h b/arch/powerpc/include/asm/scatterlist.h
index fcf7d55..912bf59 100644
--- a/arch/powerpc/include/asm/scatterlist.h
+++ b/arch/powerpc/include/asm/scatterlist.h
@@ -21,7 +21,7 @@ struct scatterlist {
 	unsigned int offset;
 	unsigned int length;
 
-	/* For TCE support */
+	/* For TCE or SWIOTLB support */
 	dma_addr_t dma_address;
 	u32 dma_length;
 };
@@ -34,11 +34,7 @@ struct scatterlist {
  * is 0.
  */
 #define sg_dma_address(sg)	((sg)->dma_address)
-#ifdef __powerpc64__
 #define sg_dma_len(sg)		((sg)->dma_length)
-#else
-#define sg_dma_len(sg)		((sg)->length)
-#endif
 
 #ifdef __powerpc64__
 #define ISA_DMA_THRESHOLD	(~0UL)
-- 
1.6.0.6

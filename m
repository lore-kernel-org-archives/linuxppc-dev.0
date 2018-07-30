Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQHl5yX1zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:38:43 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 02/20] kernel/dma/direct: refine dma_direct_alloc zone
 selection
Date: Mon, 30 Jul 2018 18:38:06 +0200
Message-Id: <20180730163824.10064-3-hch@lst.de>
In-Reply-To: <20180730163824.10064-1-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to take the DMA offset and encryption bit into account when selecting
a zone.  Add a helper that takes those into account and use it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d32d4f0d2c0c..c2c1df8827f2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -58,6 +58,14 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 	return addr + size - 1 <= dev->coherent_dma_mask;
 }
 
+static bool dma_coherent_below(struct device *dev, u64 mask)
+{
+	dma_addr_t addr = force_dma_unencrypted() ?
+		__phys_to_dma(dev, mask) : phys_to_dma(dev, mask);
+
+	return dev->coherent_dma_mask <= addr;
+}
+
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -70,9 +78,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	gfp &= ~__GFP_ZERO;
 
 	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (dma_coherent_below(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		gfp |= GFP_DMA;
-	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
+	if (dma_coherent_below(dev, DMA_BIT_MASK(32) && !(gfp & GFP_DMA)))
 		gfp |= GFP_DMA32;
 
 again:
@@ -92,14 +100,14 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
+		    dma_coherent_below(dev, DMA_BIT_MASK(64)) &&
 		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
 			gfp |= GFP_DMA32;
 			goto again;
 		}
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    dma_coherent_below(dev, DMA_BIT_MASK(32)) &&
 		    !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
-- 
2.18.0

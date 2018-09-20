Return-Path: <BATV+17e4623c997d928794c6+5506+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GQq76csyzF3Ng
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 04:53:20 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date: Thu, 20 Sep 2018 20:52:47 +0200
Message-Id: <20180920185247.20037-6-hch@lst.de>
In-Reply-To: <20180920185247.20037-1-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This way an architecture with less than 4G of RAM can support dma_mask
smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
case on powerpc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 64466b7ef67b..d1e103c6b107 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,6 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
+#include <linux/bootmem.h> /* for max_pfn */
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
@@ -283,21 +284,24 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	return nents;
 }
 
+/*
+ * Because 32-bit DMA masks are so common we expect every architecture to be
+ * able to satisfy them - either by not supporting more physical memory, or by
+ * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
+ * use an IOMMU instead of the direct mapping.
+ */
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-#ifdef CONFIG_ZONE_DMA
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
-		return 0;
-#else
-	/*
-	 * Because 32-bit DMA masks are so common we expect every architecture
-	 * to be able to satisfy them - either by not supporting more physical
-	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
-	 * architecture needs to use an IOMMU instead of the direct mapping.
-	 */
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
+	u64 min_mask;
+
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
+	else
+		min_mask = min_t(u64, DMA_BIT_MASK(32),
+				 (max_pfn - 1) << PAGE_SHIFT);
+
+	if (mask >= phys_to_dma(dev, min_mask))
 		return 0;
-#endif
 	return 1;
 }
 
-- 
2.18.0

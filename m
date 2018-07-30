Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQHn1QnWzF0xv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:38:45 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 01/20] kernel/dma/direct: take DMA offset into account in
 dma_direct_supported
Date: Mon, 30 Jul 2018 18:38:05 +0200
Message-Id: <20180730163824.10064-2-hch@lst.de>
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

When a device has a DMA offset the dma capable result will change due
to the difference between the physical and DMA address.  Take that into
account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8be8106270c2..d32d4f0d2c0c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -167,7 +167,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_ZONE_DMA
-	if (mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		return 0;
 #else
 	/*
@@ -176,14 +176,14 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
 	 * architecture needs to use an IOMMU instead of the direct mapping.
 	 */
-	if (mask < DMA_BIT_MASK(32))
+	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
 	/*
 	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
 	 * if the device itself might support it.
 	 */
-	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+	if (dev->dma_32bit_limit && mask > phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 	return 1;
 }
-- 
2.18.0

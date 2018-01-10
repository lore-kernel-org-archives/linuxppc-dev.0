Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhWM46zRzDqnb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:09:51 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/22] arm64: rename swiotlb_dma_ops
Date: Wed, 10 Jan 2018 09:09:12 +0100
Message-Id: <20180110080932.14157-3-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'll need that name for a generic implementation soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index f3a637b98487..6840426bbe77 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -368,7 +368,7 @@ static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
 	return 0;
 }
 
-static const struct dma_map_ops swiotlb_dma_ops = {
+static const struct dma_map_ops arm64_swiotlb_dma_ops = {
 	.alloc = __dma_alloc,
 	.free = __dma_free,
 	.mmap = __swiotlb_mmap,
@@ -923,7 +923,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
 	if (!dev->dma_ops)
-		dev->dma_ops = &swiotlb_dma_ops;
+		dev->dma_ops = &arm64_swiotlb_dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
-- 
2.14.2

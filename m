Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhWH432xzF0gR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:09:47 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Subject: [PATCH 01/22] swiotlb: suppress warning when __GFP_NOWARN is set
Date: Wed, 10 Jan 2018 09:09:11 +0100
Message-Id: <20180110080932.14157-2-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian König <ckoenig.leichtzumerken@gmail.com>

TTM tries to allocate coherent memory in chunks of 2MB first to improve
TLB efficiency and falls back to allocating 4K pages if that fails.

Suppress the warning when the 2MB allocations fails since there is a
valid fall back path.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104082
CC: stable@vger.kernel.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 6583f3512386..125c1062119f 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -586,7 +586,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 
 not_found:
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
-	if (printk_ratelimit())
+	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
@@ -713,6 +713,7 @@ void *
 swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		       dma_addr_t *dma_handle, gfp_t flags)
 {
+	bool warn = !(flags & __GFP_NOWARN);
 	dma_addr_t dev_addr;
 	void *ret;
 	int order = get_order(size);
@@ -738,8 +739,8 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 		 * GFP_DMA memory; fall back on map_single(), which
 		 * will grab memory from the lowest available address range.
 		 */
-		phys_addr_t paddr = map_single(hwdev, 0, size,
-					       DMA_FROM_DEVICE, 0);
+		phys_addr_t paddr = map_single(hwdev, 0, size, DMA_FROM_DEVICE,
+					       warn ? 0 : DMA_ATTR_NO_WARN);
 		if (paddr == SWIOTLB_MAP_ERROR)
 			goto err_warn;
 
@@ -769,9 +770,11 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	return ret;
 
 err_warn:
-	pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
-		dev_name(hwdev), size);
-	dump_stack();
+	if (warn && printk_ratelimit()) {
+		pr_warn("swiotlb: coherent allocation failed for device %s size=%zu\n",
+			dev_name(hwdev), size);
+		dump_stack();
+	}
 
 	return NULL;
 }
-- 
2.14.2

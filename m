Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQJD1BgSzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:39:08 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 10/20] powerpc/dma-noncoherent: don't disable irqs over
 kmap_atomic
Date: Mon, 30 Jul 2018 18:38:14 +0200
Message-Id: <20180730163824.10064-11-hch@lst.de>
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

The requirement to disable local irqs over kmap_atomic is long gone,
so remove those calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/mm/dma-noncoherent.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 382528475433..d1c16456abac 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -357,12 +357,10 @@ static inline void __dma_sync_page_highmem(struct page *page,
 {
 	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size = seg_size;
-	unsigned long flags, start, seg_offset = offset;
+	unsigned long start, seg_offset = offset;
 	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
 	int seg_nr = 0;
 
-	local_irq_save(flags);
-
 	do {
 		start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
 
@@ -378,8 +376,6 @@ static inline void __dma_sync_page_highmem(struct page *page,
 		cur_size += seg_size;
 		seg_offset = 0;
 	} while (seg_nr < nr_segs);
-
-	local_irq_restore(flags);
 }
 #endif /* CONFIG_HIGHMEM */
 
-- 
2.18.0

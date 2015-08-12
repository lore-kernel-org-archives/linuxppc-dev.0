Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5ABC1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:56 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org,
	axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
 alex.williamson@redhat.com, grundler@parisc-linux.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Subject: [PATCH 24/31] xtensa: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:43 +0200
Message-Id: <1439363150-8661-25-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make all cache invalidation conditional on sg_has_page().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 1f5f6dc..262a1d1 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -61,10 +61,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sglist, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-
 		sg->dma_address = sg_phys(sg);
-		consistent_sync(sg_virt(sg), sg->length, direction);
+		if (sg_has_page(sg))
+			consistent_sync(sg_virt(sg), sg->length, direction);
 	}
 
 	return nents;
@@ -131,8 +130,10 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		consistent_sync(sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg))
+			consistent_sync(sg_virt(sg), sg->length, dir);
+	}
 }
 
 static inline void
@@ -142,8 +143,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		consistent_sync(sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg))
+			consistent_sync(sg_virt(sg), sg->length, dir);
+	}
 }
 static inline int
 dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-- 
1.9.1

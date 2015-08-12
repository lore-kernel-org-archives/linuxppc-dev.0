Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83CEE1A06F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:51 +1000 (AEST)
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
Subject: [PATCH 22/31] metag: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:41 +0200
Message-Id: <1439363150-8661-23-git-send-email-hch@lst.de>
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
 arch/metag/include/asm/dma-mapping.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
index eb5cdec..2ae9057 100644
--- a/arch/metag/include/asm/dma-mapping.h
+++ b/arch/metag/include/asm/dma-mapping.h
@@ -55,10 +55,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	WARN_ON(nents == 0 || sglist[0].length == 0);
 
 	for_each_sg(sglist, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-
 		sg->dma_address = sg_phys(sg);
-		dma_sync_for_device(sg_virt(sg), sg->length, direction);
+		if (sg_has_page(sg))
+			dma_sync_for_device(sg_virt(sg), sg->length, direction);
 	}
 
 	return nents;
@@ -94,10 +93,9 @@ dma_unmap_sg(struct device *dev, struct scatterlist *sglist, int nhwentries,
 	WARN_ON(nhwentries == 0 || sglist[0].length == 0);
 
 	for_each_sg(sglist, sg, nhwentries, i) {
-		BUG_ON(!sg_page(sg));
-
 		sg->dma_address = sg_phys(sg);
-		dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
+		if (sg_has_page(sg))
+			dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
 	}
 }
 
@@ -140,8 +138,10 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg))
+			dma_sync_for_cpu(sg_virt(sg), sg->length, direction);
+	}
 }
 
 static inline void
@@ -151,8 +151,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		dma_sync_for_device(sg_virt(sg), sg->length, direction);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg))
+			dma_sync_for_device(sg_virt(sg), sg->length, direction);
+	}
 }
 
 static inline int
-- 
1.9.1

Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECCCE1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:41 +1000 (AEST)
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
Subject: [PATCH 19/31] arc: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:38 +0200
Message-Id: <1439363150-8661-20-git-send-email-hch@lst.de>
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

Make all cache invalidation conditional on sg_has_page() and use
sg_phys to get the physical address directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/include/asm/dma-mapping.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
index 2d28ba9..42eb526 100644
--- a/arch/arc/include/asm/dma-mapping.h
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -108,9 +108,13 @@ dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *s;
 	int i;
 
-	for_each_sg(sg, s, nents, i)
-		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
-					       s->length, dir);
+	for_each_sg(sg, s, nents, i) {
+		if (sg_has_page(s)) {
+			_dma_cache_sync((unsigned long)sg_virt(s), s->length,
+					dir);
+		}
+		s->dma_address = sg_phys(s);
+	}
 
 	return nents;
 }
@@ -163,8 +167,12 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg)) {
+			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
+					dir);
+		}
+	}
 }
 
 static inline void
@@ -174,8 +182,12 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nelems, i)
-		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
+	for_each_sg(sglist, sg, nelems, i) {
+		if (sg_has_page(sg)) {
+			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
+				dir);
+		}
+	}
 }
 
 static inline int dma_supported(struct device *dev, u64 dma_mask)
-- 
1.9.1

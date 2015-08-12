Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46C3B1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:45 +1000 (AEST)
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
Subject: [PATCH 20/31] avr32: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:39 +0200
Message-Id: <1439363150-8661-21-git-send-email-hch@lst.de>
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
sg_phys to get the physical address directly, bypassing the noop
page_to_bus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/avr32/include/asm/dma-mapping.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/asm/dma-mapping.h
index ae7ac92..a662ce2 100644
--- a/arch/avr32/include/asm/dma-mapping.h
+++ b/arch/avr32/include/asm/dma-mapping.h
@@ -216,11 +216,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	struct scatterlist *sg;
 
 	for_each_sg(sglist, sg, nents, i) {
-		char *virt;
-
-		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
-		virt = sg_virt(sg);
-		dma_cache_sync(dev, virt, sg->length, direction);
+		sg->dma_address = sg_phys(sg);
+		if (sg_has_page(sg))
+			dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
 	}
 
 	return nents;
@@ -328,8 +326,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
 	int i;
 	struct scatterlist *sg;
 
-	for_each_sg(sglist, sg, nents, i)
-		dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
+	for_each_sg(sglist, sg, nents, i) {
+		if (sg_has_page(sg))
+			dma_cache_sync(dev, sg_virt(sg), sg->length, direction);
+	}
 }
 
 /* Now for the API extensions over the pci_ one */
-- 
1.9.1

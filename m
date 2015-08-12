Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6EF1A067D
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
Subject: [PATCH 21/31] blackfin: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:40 +0200
Message-Id: <1439363150-8661-22-git-send-email-hch@lst.de>
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

Switch from sg_virt to sg_phys as blackfin like all nommu architectures
has a 1:1 virtual to physical mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/blackfin/kernel/dma-mapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/kernel/dma-mapping.c b/arch/blackfin/kernel/dma-mapping.c
index df437e5..e2c4d1a 100644
--- a/arch/blackfin/kernel/dma-mapping.c
+++ b/arch/blackfin/kernel/dma-mapping.c
@@ -120,7 +120,7 @@ dma_map_sg(struct device *dev, struct scatterlist *sg_list, int nents,
 	int i;
 
 	for_each_sg(sg_list, sg, nents, i) {
-		sg->dma_address = (dma_addr_t) sg_virt(sg);
+		sg->dma_address = sg_phys(sg);
 		__dma_sync(sg_dma_address(sg), sg_dma_len(sg), direction);
 	}
 
@@ -135,7 +135,7 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg_list,
 	int i;
 
 	for_each_sg(sg_list, sg, nelems, i) {
-		sg->dma_address = (dma_addr_t) sg_virt(sg);
+		sg->dma_address = sg_phys(sg);
 		__dma_sync(sg_dma_address(sg), sg_dma_len(sg), direction);
 	}
 }
-- 
1.9.1

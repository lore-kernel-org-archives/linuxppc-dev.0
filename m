Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C772E1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:10:17 +1000 (AEST)
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
Subject: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for page-less
 SG entries
Date: Wed, 12 Aug 2015 09:05:50 +0200
Message-Id: <1439363150-8661-32-git-send-email-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/dma-mapping-common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 940d5ec..afc3eaf 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -51,8 +51,10 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	int i, ents;
 	struct scatterlist *s;
 
-	for_each_sg(sg, s, nents, i)
-		kmemcheck_mark_initialized(sg_virt(s), s->length);
+	for_each_sg(sg, s, nents, i) {
+		if (sg_has_page(s))
+			kmemcheck_mark_initialized(sg_virt(s), s->length);
+	}
 	BUG_ON(!valid_dma_direction(dir));
 	ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
-- 
1.9.1

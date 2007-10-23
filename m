Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AB13DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:06:07 +1000 (EST)
Subject: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 23:00:22 +0200
Message-Id: <1193173222.7733.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 33ff910f0f466184ffc3514628f18403dcd86761 fixed commit
78bdc3106a877cfa50439fa66b52acbc4e7868df but the code that got put in
uses struct scatterlist->page which no longer exists since commit
18dabf473e15850c0dbc8ff13ac1e2806d542c15 which requires using
sg_page(sg) instead of sg->page.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
If it was fixed before please ignore, I just ran into this.

--- linux-2.6.orig/include/asm/dma-mapping.h	2007-10-23 22:55:33.551133142 +0200
+++ linux-2.6/include/asm/dma-mapping.h	2007-10-23 22:56:07.081133142 +0200
@@ -285,9 +285,9 @@ dma_map_sg(struct device *dev, struct sc
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg->page);
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
-		sg->dma_address = page_to_bus(sg->page) + sg->offset;
+		BUG_ON(!sg_page(sg));
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		sg->dma_address = page_to_bus(sg_page(sg)) + sg->offset;
 	}
 
 	return nents;
@@ -328,7 +328,7 @@ static inline void dma_sync_sg_for_cpu(s
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
@@ -341,7 +341,7 @@ static inline void dma_sync_sg_for_devic
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline int dma_mapping_error(dma_addr_t dma_addr)

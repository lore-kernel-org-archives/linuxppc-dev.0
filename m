Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 511D5DDF7E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 00:53:03 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 23 Oct 2007 07:53:01 -0700
To: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] [POWERPC] Fix fallout from sg_page changes
Message-ID: <20071023145300.GA18989@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 include/asm-powerpc/dma-mapping.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 65be95d..43b4f3b 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -285,9 +285,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg->page);
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
-		sg->dma_address = page_to_bus(sg->page) + sg->offset;
+		BUG_ON(!sg_page(sg));
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		sg->dma_address = virt_to_bus(sg_virt(sg));
 	}
 
 	return nents;
@@ -328,7 +328,7 @@ static inline void dma_sync_sg_for_cpu(struct device *dev,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
@@ -341,7 +341,7 @@ static inline void dma_sync_sg_for_device(struct device *dev,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static inline int dma_mapping_error(dma_addr_t dma_addr)
-- 
1.5.3.4

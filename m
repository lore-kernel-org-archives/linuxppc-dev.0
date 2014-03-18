Return-Path: <xuelin.shi@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C06F22C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Mar 2014 20:15:25 +1100 (EST)
From: <xuelin.shi@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] fix dmaengine_unmap failure.
Date: Tue, 18 Mar 2014 16:32:00 +0800
Message-ID: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

The count which is used to get_unmap_data maybe not the same as the
count computed in dmaengine_unmap which causes to free data in a
wrong pool.

This patch fixes this issue by keeping the pool in unmap_data
structure.

Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
---
 drivers/dma/dmaengine.c   | 7 +++++--
 include/linux/dmaengine.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ed610b4..2977eee 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1014,7 +1014,7 @@ static void dmaengine_unmap(struct kref *kref)
 		dma_unmap_page(dev, unmap->addr[i], unmap->len,
 			       DMA_BIDIRECTIONAL);
 	}
-	mempool_free(unmap, __get_unmap_pool(cnt)->pool);
+	mempool_free(unmap, unmap->unmap_pool->pool);
 }
 
 void dmaengine_unmap_put(struct dmaengine_unmap_data *unmap)
@@ -1071,14 +1071,17 @@ struct dmaengine_unmap_data *
 dmaengine_get_unmap_data(struct device *dev, int nr, gfp_t flags)
 {
 	struct dmaengine_unmap_data *unmap;
+	struct dmaengine_unmap_pool *unmap_pool;
 
-	unmap = mempool_alloc(__get_unmap_pool(nr)->pool, flags);
+	unmap_pool = __get_unmap_pool(nr);
+	unmap = mempool_alloc(unmap_pool->pool, flags);
 	if (!unmap)
 		return NULL;
 
 	memset(unmap, 0, sizeof(*unmap));
 	kref_init(&unmap->kref);
 	unmap->dev = dev;
+	unmap->unmap_pool = unmap_pool;
 
 	return unmap;
 }
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c5c92d5..6a25635 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -439,6 +439,7 @@ struct dmaengine_unmap_data {
 	struct device *dev;
 	struct kref kref;
 	size_t len;
+	struct dmaengine_unmap_pool *unmap_pool;
 	dma_addr_t addr[0];
 };
 
-- 
1.8.3.2

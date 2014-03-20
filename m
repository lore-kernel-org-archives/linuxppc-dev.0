Return-Path: <xuelin.shi@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E4302C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 18:17:36 +1100 (EST)
From: <xuelin.shi@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>
Subject: [PATCH v2] fix dmaengine_unmap failure
Date: Thu, 20 Mar 2014 14:33:50 +0800
Message-ID: <1395297230-8195-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
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

This patch fixes this issue by keeping the map count with unmap_data
structure and use this count to get the pool.

Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
---
change history:
	v1: keep mempool pointer with unmap struct
	v2: keep u8 map_cnt instead of mempool pointer to save mem.

 drivers/dma/dmaengine.c   | 2 ++
 include/linux/dmaengine.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ed610b4..a4068e2 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1014,6 +1014,7 @@ static void dmaengine_unmap(struct kref *kref)
 		dma_unmap_page(dev, unmap->addr[i], unmap->len,
 			       DMA_BIDIRECTIONAL);
 	}
+	cnt = unmap->map_cnt;
 	mempool_free(unmap, __get_unmap_pool(cnt)->pool);
 }
 
@@ -1079,6 +1080,7 @@ dmaengine_get_unmap_data(struct device *dev, int nr, gfp_t flags)
 	memset(unmap, 0, sizeof(*unmap));
 	kref_init(&unmap->kref);
 	unmap->dev = dev;
+	unmap->map_cnt = nr;
 
 	return unmap;
 }
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c5c92d5..0a5f552 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -433,6 +433,7 @@ typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
 typedef void (*dma_async_tx_callback)(void *dma_async_param);
 
 struct dmaengine_unmap_data {
+	u8 map_cnt;
 	u8 to_cnt;
 	u8 from_cnt;
 	u8 bidi_cnt;
-- 
1.8.3.2

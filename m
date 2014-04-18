Return-Path: <hongbo.zhang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 388E4140121
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 18:18:43 +1000 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v4 4/8] DMA: Freescale: add fsl_dma_free_descriptor() to
 reduce code duplication
Date: Fri, 18 Apr 2014 16:17:47 +0800
Message-ID: <1397809071-5353-5-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leo.li@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

There are several places where descriptors are freed using identical code.
This patch puts this code into a function to reduce code duplication.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/dma/fsldma.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b71cc04..adc266e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -418,6 +418,19 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 }
 
 /**
+ * fsl_dma_free_descriptor - Free descriptor from channel's DMA pool.
+ * @chan : Freescale DMA channel
+ * @desc: descriptor to be freed
+ */
+static void fsl_dma_free_descriptor(struct fsldma_chan *chan,
+		struct fsl_desc_sw *desc)
+{
+	list_del(&desc->node);
+	chan_dbg(chan, "LD %p free\n", desc);
+	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
+}
+
+/**
  * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
  * @chan : Freescale DMA channel
  *
@@ -489,11 +502,8 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
 {
 	struct fsl_desc_sw *desc, *_desc;
 
-	list_for_each_entry_safe(desc, _desc, list, node) {
-		list_del(&desc->node);
-		chan_dbg(chan, "LD %p free\n", desc);
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	list_for_each_entry_safe(desc, _desc, list, node)
+		fsl_dma_free_descriptor(chan, desc);
 }
 
 static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
@@ -501,11 +511,8 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 {
 	struct fsl_desc_sw *desc, *_desc;
 
-	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
-		list_del(&desc->node);
-		chan_dbg(chan, "LD %p free\n", desc);
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	list_for_each_entry_safe_reverse(desc, _desc, list, node)
+		fsl_dma_free_descriptor(chan, desc);
 }
 
 /**
-- 
1.7.9.5

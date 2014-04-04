Return-Path: <hongbo.zhang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF2191400AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 14:28:01 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vkoul@infradead.org>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH v2 1/8] DMA: Freescale: remove the unnecessary FSL_DMA_LD_DEBUG
Date: Fri, 4 Apr 2014 11:27:10 +0800
Message-ID: <1396582037-23065-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1396582037-23065-1-git-send-email-hongbo.zhang@freescale.com>
References: <1396582037-23065-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Some codes are calling chan_dbg with FSL_DMA_LD_DEBUG surrounded, it is really
unnecessary to use such a macro because chan_dbg is a wrapper of dev_dbg, we do
have corresponding DEBUG macro to switch on/off dev_dbg, and most of the other
codes are also calling chan_dbg directly without using FSL_DMA_LD_DEBUG.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 drivers/dma/fsldma.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f157c6f..ec50420 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -426,9 +426,7 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(struct fsldma_chan *chan)
 	desc->async_tx.tx_submit = fsl_dma_tx_submit;
 	desc->async_tx.phys = pdesc;
 
-#ifdef FSL_DMA_LD_DEBUG
 	chan_dbg(chan, "LD %p allocated\n", desc);
-#endif
 
 	return desc;
 }
@@ -479,9 +477,7 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe(desc, _desc, list, node) {
 		list_del(&desc->node);
-#ifdef FSL_DMA_LD_DEBUG
 		chan_dbg(chan, "LD %p free\n", desc);
-#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -493,9 +489,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
 		list_del(&desc->node);
-#ifdef FSL_DMA_LD_DEBUG
 		chan_dbg(chan, "LD %p free\n", desc);
-#endif
 		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 }
@@ -832,9 +826,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
 
 	/* Run the link descriptor callback function */
 	if (txd->callback) {
-#ifdef FSL_DMA_LD_DEBUG
 		chan_dbg(chan, "LD %p callback\n", desc);
-#endif
 		txd->callback(txd->callback_param);
 	}
 
@@ -842,9 +834,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
 	dma_run_dependencies(txd);
 
 	dma_descriptor_unmap(txd);
-#ifdef FSL_DMA_LD_DEBUG
 	chan_dbg(chan, "LD %p free\n", desc);
-#endif
 	dma_pool_free(chan->desc_pool, desc, txd->phys);
 }
 
-- 
1.7.9.5

Return-Path: <hongbo.zhang@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DF092C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 16:48:11 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH 2/7] DMA: Freescale: remove attribute DMA_INTERRUPT of
 dmaengine
Date: Thu, 16 Jan 2014 13:47:21 +0800
Message-ID: <1389851246-8564-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
References: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
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

Delete attribute DMA_INTERRUPT because fsldma doesn't support this function,
exception will be thrown if talitos is used to offload xor at the same time.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/dma/fsldma.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index fbf19d3..95236e6 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -534,35 +534,6 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 }
 
 static struct dma_async_tx_descriptor *
-fsl_dma_prep_interrupt(struct dma_chan *dchan, unsigned long flags)
-{
-	struct fsldma_chan *chan;
-	struct fsl_desc_sw *new;
-
-	if (!dchan)
-		return NULL;
-
-	chan = to_fsl_chan(dchan);
-
-	new = fsl_dma_alloc_descriptor(chan);
-	if (!new) {
-		chan_err(chan, "%s\n", msg_ld_oom);
-		return NULL;
-	}
-
-	new->async_tx.cookie = -EBUSY;
-	new->async_tx.flags = flags;
-
-	/* Insert the link descriptor to the LD ring */
-	list_add_tail(&new->node, &new->tx_list);
-
-	/* Set End-of-link to the last link descriptor of new list */
-	set_ld_eol(chan, new);
-
-	return &new->async_tx;
-}
-
-static struct dma_async_tx_descriptor *
 fsl_dma_prep_memcpy(struct dma_chan *dchan,
 	dma_addr_t dma_dst, dma_addr_t dma_src,
 	size_t len, unsigned long flags)
@@ -1318,12 +1289,10 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
-	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
 	dma_cap_set(DMA_SG, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
 	fdev->common.device_alloc_chan_resources = fsl_dma_alloc_chan_resources;
 	fdev->common.device_free_chan_resources = fsl_dma_free_chan_resources;
-	fdev->common.device_prep_dma_interrupt = fsl_dma_prep_interrupt;
 	fdev->common.device_prep_dma_memcpy = fsl_dma_prep_memcpy;
 	fdev->common.device_prep_dma_sg = fsl_dma_prep_sg;
 	fdev->common.device_tx_status = fsl_tx_status;
-- 
1.7.9.5

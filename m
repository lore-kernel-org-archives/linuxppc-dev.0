Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE5672C05B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 18:48:31 +1000 (EST)
From: <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
 <dan.j.williams@gmail.com>, <vinod.koul@intel.com>
Subject: [PATCH v7 3/8] fsl-dma: add fsl_dma_free_descriptor() to reduce code
 duplication
Date: Thu, 9 Aug 2012 16:21:40 +0800
Message-ID: <1344500500-11003-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: arnd@arndb.de, "Ira W. Snyder" <iws@ovro.caltech.edu>,
 gregkh@linuxfoundation.org, Qiang Liu <qiang.liu@freescale.com>,
 herbert@gondor.hengli.com.au, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Qiang Liu <qiang.liu@freescale.com>

There are several places where descriptors are freed using identical
code. Put this code into a function to reduce code duplication.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dan Williams <dan.j.williams@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4f2f212..d4720d3 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -427,6 +427,21 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
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
+#ifdef FSL_DMA_LD_DEBUG
+	chan_dbg(chan, "LD %p free\n", desc);
+#endif
+	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
+}
+
+/**
  * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
  * @chan : Freescale DMA channel
  *
@@ -500,13 +515,8 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
 {
 	struct fsl_desc_sw *desc, *_desc;

-	list_for_each_entry_safe(desc, _desc, list, node) {
-		list_del(&desc->node);
-#ifdef FSL_DMA_LD_DEBUG
-		chan_dbg(chan, "LD %p free\n", desc);
-#endif
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	list_for_each_entry_safe(desc, _desc, list, node)
+		fsl_dma_free_descriptor(chan, desc);
 }

 static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
@@ -514,13 +524,8 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 {
 	struct fsl_desc_sw *desc, *_desc;

-	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
-		list_del(&desc->node);
-#ifdef FSL_DMA_LD_DEBUG
-		chan_dbg(chan, "LD %p free\n", desc);
-#endif
-		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-	}
+	list_for_each_entry_safe_reverse(desc, _desc, list, node)
+		fsl_dma_free_descriptor(chan, desc);
 }

 /**
@@ -855,10 +860,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
 			dma_unmap_page(dev, src, len, DMA_TO_DEVICE);
 	}

-#ifdef FSL_DMA_LD_DEBUG
-	chan_dbg(chan, "LD %p free\n", desc);
-#endif
-	dma_pool_free(chan->desc_pool, desc, txd->phys);
+	fsl_dma_free_descriptor(chan, desc);
 }

 /**
--
1.7.5.1

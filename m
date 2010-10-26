Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2ED57B71D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 10:53:16 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [PATCH 4/6] mpc512x_dma: try to free descriptors in case of
	allocation failure
Date: Wed, 27 Oct 2010 01:52:58 +0200
Message-Id: <1288137180-3220-5-git-send-email-yanok@emcraft.com>
In-Reply-To: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently completed descriptors are processed in the tasklet. This can
lead to dead lock in case of CONFIG_NET_DMA enabled (new requests are
submitted from softirq context and dma_memcpy_to_iovec() busy loops until
the requests is submitted). To prevent this we should process completed
descriptors from the allocation failure path in prepare_memcpy too.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
---
 drivers/dma/mpc512x_dma.c |   79 +++++++++++++++++++++++++-------------------
 1 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 97b92ec..59c2701 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -328,19 +328,55 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* DMA Tasklet */
-static void mpc_dma_tasklet(unsigned long data)
+/* proccess completed descriptors */
+static void mpc_dma_process_completed(struct mpc_dma *mdma)
 {
-	struct mpc_dma *mdma = (void *)data;
 	dma_cookie_t last_cookie = 0;
 	struct mpc_dma_chan *mchan;
 	struct mpc_dma_desc *mdesc;
 	struct dma_async_tx_descriptor *desc;
 	unsigned long flags;
 	LIST_HEAD(list);
-	uint es;
 	int i;
 
+	for (i = 0; i < mdma->dma.chancnt; i++) {
+		mchan = &mdma->channels[i];
+
+		/* Get all completed descriptors */
+		spin_lock_irqsave(&mchan->lock, flags);
+		if (!list_empty(&mchan->completed))
+			list_splice_tail_init(&mchan->completed, &list);
+		spin_unlock_irqrestore(&mchan->lock, flags);
+
+		if (list_empty(&list))
+			continue;
+
+		/* Execute callbacks and run dependencies */
+		list_for_each_entry(mdesc, &list, node) {
+			desc = &mdesc->desc;
+
+			if (desc->callback)
+				desc->callback(desc->callback_param);
+
+			last_cookie = desc->cookie;
+			dma_run_dependencies(desc);
+		}
+
+		/* Free descriptors */
+		spin_lock_irqsave(&mchan->lock, flags);
+		list_splice_tail_init(&list, &mchan->free);
+		mchan->completed_cookie = last_cookie;
+		spin_unlock_irqrestore(&mchan->lock, flags);
+	}
+}
+
+/* DMA Tasklet */
+static void mpc_dma_tasklet(unsigned long data)
+{
+	struct mpc_dma *mdma = (void *)data;
+	unsigned long flags;
+	uint es;
+
 	spin_lock_irqsave(&mdma->error_status_lock, flags);
 	es = mdma->error_status;
 	mdma->error_status = 0;
@@ -379,35 +415,7 @@ static void mpc_dma_tasklet(unsigned long data)
 			dev_err(mdma->dma.dev, "- Destination Bus Error\n");
 	}
 
-	for (i = 0; i < mdma->dma.chancnt; i++) {
-		mchan = &mdma->channels[i];
-
-		/* Get all completed descriptors */
-		spin_lock_irqsave(&mchan->lock, flags);
-		if (!list_empty(&mchan->completed))
-			list_splice_tail_init(&mchan->completed, &list);
-		spin_unlock_irqrestore(&mchan->lock, flags);
-
-		if (list_empty(&list))
-			continue;
-
-		/* Execute callbacks and run dependencies */
-		list_for_each_entry(mdesc, &list, node) {
-			desc = &mdesc->desc;
-
-			if (desc->callback)
-				desc->callback(desc->callback_param);
-
-			last_cookie = desc->cookie;
-			dma_run_dependencies(desc);
-		}
-
-		/* Free descriptors */
-		spin_lock_irqsave(&mchan->lock, flags);
-		list_splice_tail_init(&list, &mchan->free);
-		mchan->completed_cookie = last_cookie;
-		spin_unlock_irqrestore(&mchan->lock, flags);
-	}
+	mpc_dma_process_completed(mdma);
 }
 
 /* Submit descriptor to hardware */
@@ -587,8 +595,11 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 	}
 	spin_unlock_irqrestore(&mchan->lock, iflags);
 
-	if (!mdesc)
+	if (!mdesc) {
+		/* try to free completed descriptors */
+		mpc_dma_process_completed(mdma);
 		return NULL;
+	}
 
 	mdesc->error = 0;
 	tcd = mdesc->tcd;
-- 
1.7.2.3

Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 815B8B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 22:25:29 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [PATCH 2/3] mpc512x_dma: fix the hanged transfer issue
Date: Tue, 28 Sep 2010 14:24:55 +0200
Message-Id: <1285676696-5358-3-git-send-email-yanok@emcraft.com>
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

Current code clears interrupt active status _after_ submiting new
transfers. This leaves a possibility of clearing the interrupt for this
new transfer (if it is triggered fast enough) and thus lose this
interrupt. We want to clear interrupt active status _before_ new
transfers is submited and for current channel only.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
---
 drivers/dma/mpc512x_dma.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 1bc04aa..0717527 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -276,6 +276,9 @@ static void mpc_dma_irq_process(struct mpc_dma *mdma, u32 is, u32 es, int off)
 
 		spin_lock(&mchan->lock);
 
+		out_8(&mdma->regs->dmacint, ch + off);
+		out_8(&mdma->regs->dmacerr, ch + off);
+
 		/* Check error status */
 		if (es & (1 << ch))
 			list_for_each_entry(mdesc, &mchan->active, node)
@@ -309,12 +312,6 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
 					in_be32(&mdma->regs->dmaerrl), 0);
 
-	/* Ack interrupt on all channels */
-	out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
-	out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
-
 	/* Schedule tasklet */
 	tasklet_schedule(&mdma->tasklet);
 
-- 
1.7.2.3

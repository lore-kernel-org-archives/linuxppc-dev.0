Return-Path: <B32616@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8619D2C0211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 19:22:48 +1000 (EST)
From: Qiang Liu <qiang.liu@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 3/4] fsl-dma: change the release process of dma descriptor
Date: Wed, 11 Jul 2012 17:01:25 +0800
Message-ID: <1341997285-18459-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Vinod Koul <vinod.koul@intel.com>, Qiang Liu <qiang.liu@freescale.com>,
 herbert@gondor.hengli.com.au, Dan Williams <dan.j.williams@intel.com>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify the release process of dma descriptor for avoiding exception when
enable config NET_DMA, release dma descriptor from 1st to last second, the
last descriptor which is reserved in current descriptor register may not be
completed, race condition will be raised if free current descriptor.

A race condition which is raised when use both of talitos and dmaengine to
offload xor is because napi scheduler (NET_DMA is enabled) will sync all
pending requests in dma channels, it affects the process of raid operations.
The descriptor is freed which is submitted just now, but async_tx must check
whether this depend tx descriptor is acked, there are poison contents in the
invalid address, then BUG_ON() is thrown, so this descriptor will be freed
in the next time.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Li Yang <leoli@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/dma/fsldma.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4f2f212..0ba3e40 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1035,14 +1035,22 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 static void dma_do_tasklet(unsigned long data)
 {
 	struct fsldma_chan *chan = (struct fsldma_chan *)data;
-	struct fsl_desc_sw *desc, *_desc;
+	struct fsl_desc_sw *desc, *_desc, *prev = NULL;
 	LIST_HEAD(ld_cleanup);
 	unsigned long flags;
+	dma_addr_t curr_phys = get_cdar(chan);

 	chan_dbg(chan, "tasklet entry\n");

 	spin_lock_irqsave(&chan->desc_lock, flags);

+	/* find the descriptor which is already completed */
+	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
+		if (prev && desc->async_tx.phys == curr_phys)
+			break;
+		prev = desc;
+	}
+
 	/* update the cookie if we have some descriptors to cleanup */
 	if (!list_empty(&chan->ld_running)) {
 		dma_cookie_t cookie;
@@ -1058,13 +1066,14 @@ static void dma_do_tasklet(unsigned long data)
 	 * move the descriptors to a temporary list so we can drop the lock
 	 * during the entire cleanup operation
 	 */
-	list_splice_tail_init(&chan->ld_running, &ld_cleanup);
+	list_cut_position(&ld_cleanup, &chan->ld_running, &prev->node);

 	/* the hardware is now idle and ready for more */
 	chan->idle = true;

 	/*
-	 * Start any pending transactions automatically
+	 * Start any pending transactions automatically if current descriptor
+	 * list is completed
 	 *
 	 * In the ideal case, we keep the DMA controller busy while we go
 	 * ahead and free the descriptors below.
--
1.7.5.1

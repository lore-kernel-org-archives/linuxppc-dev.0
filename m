Return-Path: <B29237@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 901E9B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2011 17:49:43 +1100 (EST)
From: <b29237@freescale.com>
To: <iws@ovro.caltech.edu>, <vinod.koul@intel.com>,
 <dan.j.williams@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] fsldma: fix performance degradation by optimizing spinlock
 use.
Date: Mon, 26 Dec 2011 14:01:03 +0800
Message-ID: <1324879263-11845-1-git-send-email-b29237@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Forrest shi <b29237@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Forrest shi <b29237@freescale.com>

    dma status check function fsl_tx_status is heavily called in
    a tight loop and the desc lock in fsl_tx_status contended by
    the dma status update function. this caused the dma performance
    degrades much.

    this patch releases the lock in the fsl_tx_status function, and
    introduce the smp_mb() to avoid possible memory inconsistency.

    Signed-off-by: Forrest Shi <xuelin.shi@freescale.com>
---
 drivers/dma/fsldma.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 8a78154..008fb5e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -986,15 +986,11 @@ static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
 	dma_cookie_t last_complete;
 	dma_cookie_t last_used;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
 
	last_complete = chan->completed_cookie;
+	smp_mb();
	last_used = dchan->cookie;
 
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 	return dma_async_is_complete(cookie, last_complete, last_used);
}
-- 
1.7.0.4

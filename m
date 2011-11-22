Return-Path: <B29237@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6F6B51007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 17:11:02 +1100 (EST)
From: <b29237@freescale.com>
To: <dan.j.williams@intel.com>, <leoli@freescale.com>, <zw@zh-kernel.org>,
 <vinod.koul@intel.com>
Subject: [PATCH][RFC] fsldma: fix performance degradation by optimizing
 spinlock use.
Date: Tue, 22 Nov 2011 12:55:05 +0800
Message-ID: <1321937705-19587-1-git-send-email-b29237@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Forrest Shi <b29237@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Forrest Shi <b29237@freescale.com>

    dma status check function fsl_tx_status is heavily called in
    a tight loop and the desc lock in fsl_tx_status contended by
    the dma status update function. this caused the dma performance
    degrades much.

    this patch releases the lock in the fsl_tx_status function.
    I believe it has no neglect impact on the following call of
    dma_async_is_complete(...).

    we can see below three conditions will be identified as success
    a)  x < complete < use
    b)  x < complete+N < use+N
    c)  x < complete < use+N
    here complete is the completed_cookie, use is the last_used
    cookie, x is the querying cookie, N is MAX cookie

    when chan->completed_cookie is being read, the last_used may
    be incresed. Anyway it has no neglect impact on the dma status
    decision.

    Signed-off-by: Forrest Shi <xuelin.shi@freescale.com>
---
 drivers/dma/fsldma.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 8a78154..1dca56f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -986,15 +986,10 @@ static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
 	dma_cookie_t last_complete;
 	dma_cookie_t last_used;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
 
 	last_complete = chan->completed_cookie;
 	last_used = dchan->cookie;
 
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-
 	dma_set_tx_state(txstate, last_complete, last_used, 0);
 	return dma_async_is_complete(cookie, last_complete, last_used);
 }
-- 
1.7.0.4

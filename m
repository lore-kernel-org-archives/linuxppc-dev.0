Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id C33632C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 22:14:52 +1000 (EST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <djbw@fb.com>
Subject: [PATCH 05/12] fsldma: remove useless use of lock
Date: Mon, 27 May 2013 15:14:35 +0300
Message-Id: <1369656882-25241-6-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Zhang Wei <zw@zh-kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Accordingly to dma_cookie_status() description locking is not required.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Zhang Wei <zw@zh-kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/dma/fsldma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 49e8fbd..b3f3e90 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -979,15 +979,7 @@ static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 					dma_cookie_t cookie,
 					struct dma_tx_state *txstate)
 {
-	struct fsldma_chan *chan = to_fsl_chan(dchan);
-	enum dma_status ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->desc_lock, flags);
-	ret = dma_cookie_status(dchan, cookie, txstate);
-	spin_unlock_irqrestore(&chan->desc_lock, flags);
-
-	return ret;
+	return dma_cookie_status(dchan, cookie, txstate);
 }
 
 /*----------------------------------------------------------------------------*/
-- 
1.8.2.rc0.22.gb3600c3

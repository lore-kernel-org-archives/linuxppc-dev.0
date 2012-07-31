Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2DC5E2C0081
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 23:57:43 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: dan.j.williams@intel.com
Subject: [PATCH] dma/fsldma: fix a compilation warnings
Date: Tue, 31 Jul 2012 08:57:38 -0500
Message-Id: <1343743058-8013-1-git-send-email-galak@kernel.crashing.org>
Cc: vinod.koul@intel.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drivers/dma/fsldma.c: In function 'fsl_dma_tx_submit':
drivers/dma/fsldma.c:409:15: warning: 'cookie' may be used uninitialized in this function

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/dma/fsldma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 8f84761..6194eb7 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -406,7 +406,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_desc_sw *child;
 	unsigned long flags;
-	dma_cookie_t cookie;
+	dma_cookie_t cookie = 0;
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
-- 
1.7.9.7

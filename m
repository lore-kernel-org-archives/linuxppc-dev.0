Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 3336C2C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 09:46:01 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 6/7] fsl-dma: fix a warning of unitialized cookie
Date: Tue, 31 Jul 2012 16:45:51 -0700
Message-Id: <1343778352-5549-7-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
References: <1343778352-5549-1-git-send-email-iws@ovro.caltech.edu>
Cc: Vinod Koul <vinod.koul@intel.com>, B32616@freescale.com,
 Qiang Liu <qiang.liu@freescale.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Qiang Liu <qiang.liu@freescale.com>

Fix a warning of unitialized value when compile with -Wuninitialized.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Li Yang <leoli@freescale.com>
Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
Cc: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/dma/fsldma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 380c1b7..8588cf7 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -523,7 +523,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
 	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
 	struct fsl_desc_sw *child;
-	dma_cookie_t cookie;
+	dma_cookie_t cookie = 0;
 
 	spin_lock_irq(&chan->desc_lock);
 
-- 
1.7.8.6

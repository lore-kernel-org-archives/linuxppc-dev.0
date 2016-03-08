Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AAAA1A0324
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 19:00:19 +1100 (AEDT)
From: <xuelin.shi@nxp.com>
To: <vinod.koul@intel.com>, <pku.leo@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <dmaengine@vger.kernel.org>, Xuelin Shi
 <xuelin.shi@nxp.com>
Subject: [PATCH] dmaengine:fsldma: fix memory leak
Date: Tue, 8 Mar 2016 14:02:01 +0800
Message-ID: <1457416921-29147-1-git-send-email-xuelin.shi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@nxp.com>

adding unmap of sources and destinations while doing dequeue.

Signed-off-by: Xuelin Shi <xuelin.shi@nxp.com>
---
 drivers/dma/fsldma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2209f75..aac85c3 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -522,6 +522,8 @@ static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
 			chan_dbg(chan, "LD %p callback\n", desc);
 			txd->callback(txd->callback_param);
 		}
+
+		dma_descriptor_unmap(txd);
 	}
 
 	/* Run any dependencies */
-- 
1.8.4

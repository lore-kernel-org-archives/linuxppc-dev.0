Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 087121A1B0D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:59 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 5/6] dmaengine: freescale: remove FSLDMA_EXTERNAL_START
 control method
Date: Sat, 11 Oct 2014 21:16:47 +0530
Message-Id: <1413042408-28491-6-git-send-email-vinod.koul@intel.com>
In-Reply-To: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
References: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

since users have been move to fsl_dma_external_start() API, so remove this
now

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/fsldma.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0cded86..994bcb2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1012,15 +1012,6 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
 		chan->set_request_count(chan, size);
 		return 0;
 
-	case FSLDMA_EXTERNAL_START:
-
-		/* make sure the channel supports external start */
-		if (!chan->toggle_ext_start)
-			return -ENXIO;
-
-		chan->toggle_ext_start(chan, arg);
-		return 0;
-
 	default:
 		return -ENXIO;
 	}
-- 
1.7.0.4

Return-Path: <hongbo.zhang@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70F502C0323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 17:11:15 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH] DMA: Freescale: change BWC from 256 bytes to 1024 bytes
Date: Thu, 16 Jan 2014 14:10:53 +0800
Message-ID: <1389852653-8806-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Hongbo Zhang <hongbo.zhang@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Freescale DMA has a feature of BandWidth Control (ab. BWC), which is currently
256 bytes and should be changed to 1024 bytes for best DMA throughput.
Changing BWC from 256 to 1024 will improve DMA performance much, in cases
whatever one channel is running or multi channels are running simultanously,
large or small buffers are copied.  And this change doesn't impact memory
access performance remarkably, lmbench tests show that for some cases the
memory performance are decreased very slightly, while the others are even
better.
Tested on T4240.

Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
---
 drivers/dma/fsldma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 1ffc244..d56e835 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -41,7 +41,7 @@
  * channel is allowed to transfer before the DMA engine pauses
  * the current channel and switches to the next channel
  */
-#define FSL_DMA_MR_BWC         0x08000000
+#define FSL_DMA_MR_BWC         0x0A000000
 
 /* Special MR definition for MPC8349 */
 #define FSL_DMA_MR_EOTIE	0x00000080
-- 
1.7.9.5

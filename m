Return-Path: <weo@reccoware.de>
Received: from mailgate0.reccoware.net (tommyflood.reccoware.net
 [82.165.61.254])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrv4z15RXzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:49:23 +1000 (AEST)
From: Thomas Breitung <thomas.breitung@izt-labs.de>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Li Yang <leoli@freescale.com>, Zhang Wei <zw@zh-kernel.org>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Thomas Breitung <thomas.breitung@izt-labs.de>,
 Wolfgang Ocker <weo@reccoware.de>
Subject: [PATCH] dmaengine: fsldma: set BWC, DAHTS and SAHTS values correctly
Date: Mon, 19 Jun 2017 16:40:04 +0200
Message-Id: <20170619144004.18224-1-thomas.breitung@izt-labs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bits of BWC, DAHTS and SAHTS in the DMA mode register must be cleared
before a new value can be or-ed in.

Signed-off-by: Thomas Breitung <thomas.breitung@izt-labs.de>
Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
 drivers/dma/fsldma.c | 5 ++++-
 drivers/dma/fsldma.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 51c75bf2b9b6..3b8b752ede2d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -269,6 +269,7 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *chan, int size)
 	case 2:
 	case 4:
 	case 8:
+		mode &= ~FSL_DMA_MR_SAHTS_MASK;
 		mode |= FSL_DMA_MR_SAHE | (__ilog2(size) << 14);
 		break;
 	}
@@ -301,6 +302,7 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *chan, int size)
 	case 2:
 	case 4:
 	case 8:
+		mode &= ~FSL_DMA_MR_DAHTS_MASK;
 		mode |= FSL_DMA_MR_DAHE | (__ilog2(size) << 16);
 		break;
 	}
@@ -327,7 +329,8 @@ static void fsl_chan_set_request_count(struct fsldma_chan *chan, int size)
 	BUG_ON(size > 1024);
 
 	mode = get_mr(chan);
-	mode |= (__ilog2(size) << 24) & 0x0f000000;
+	mode &= ~FSL_DMA_MR_BWC_MASK;
+	mode |= (__ilog2(size) << 24) & FSL_DMA_MR_BWC_MASK;
 
 	set_mr(chan, mode);
 }
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 31bffccdcc75..4787d485dd76 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -36,6 +36,10 @@
 #define FSL_DMA_MR_DAHE		0x00002000
 #define FSL_DMA_MR_SAHE		0x00001000
 
+#define FSL_DMA_MR_SAHTS_MASK	0x0000C000
+#define FSL_DMA_MR_DAHTS_MASK	0x00030000
+#define FSL_DMA_MR_BWC_MASK	0x0f000000
+
 /*
  * Bandwidth/pause control determines how many bytes a given
  * channel is allowed to transfer before the DMA engine pauses
-- 
2.13.0

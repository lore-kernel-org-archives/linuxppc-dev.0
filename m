Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id C27D31A1A11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:52 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 2/6] dmaengine: freescale: add and export
 fsl_dma_external_start()
Date: Sat, 11 Oct 2014 21:16:44 +0530
Message-Id: <1413042408-28491-3-git-send-email-vinod.koul@intel.com>
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

The freescale driver uses custom device control FSLDMA_EXTERNAL_START to
put the controller in external start mode.
Since we are planning to deprecate the device control, move this to exported
API. Subsequent patches will remove the FSLDMA_EXTERNAL_START

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/fsldma.c   |   16 +++++++++++++++-
 include/linux/fsldma.h |   13 +++++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/fsldma.h

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index d5d6885..0cded86 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -36,7 +36,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-
+#include <linux/fsldma.h>
 #include "dmaengine.h"
 #include "fsldma.h"
 
@@ -367,6 +367,20 @@ static void fsl_chan_toggle_ext_start(struct fsldma_chan *chan, int enable)
 		chan->feature &= ~FSL_DMA_CHAN_START_EXT;
 }
 
+int fsl_dma_external_start(struct dma_chan *dchan, int enable)
+{
+	struct fsldma_chan *chan;
+
+	if (!dchan)
+		return -EINVAL;
+
+	chan = to_fsl_chan(dchan);
+
+	fsl_chan_toggle_ext_start(chan, enable);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsl_dma_external_start);
+
 static void append_ld_queue(struct fsldma_chan *chan, struct fsl_desc_sw *desc)
 {
 	struct fsl_desc_sw *tail = to_fsl_desc(chan->ld_pending.prev);
diff --git a/include/linux/fsldma.h b/include/linux/fsldma.h
new file mode 100644
index 0000000..b213c02
--- /dev/null
+++ b/include/linux/fsldma.h
@@ -0,0 +1,13 @@
+/*
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef FSL_DMA_H
+#define FSL_DMA_H
+/* fsl dma API for enxternal start */
+int fsl_dma_external_start(struct dma_chan *dchan, int enable);
+
+#endif
-- 
1.7.0.4

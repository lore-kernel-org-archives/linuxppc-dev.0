Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 53D1F1A1A49
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:57 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 4/6] carma-fpga: move to fsl_dma_external_start()
Date: Sat, 11 Oct 2014 21:16:46 +0530
Message-Id: <1413042408-28491-5-git-send-email-vinod.koul@intel.com>
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

carma-fpga driver uses device control with custom FSLDMA_EXTERNAL_START
command. Since we wnat to deprecate the device control, move this driver to
use new fsl_dma_external_start() API

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/misc/carma/carma-fpga-program.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
index fd0cb8b..298f912 100644
--- a/drivers/misc/carma/carma-fpga-program.c
+++ b/drivers/misc/carma/carma-fpga-program.c
@@ -16,6 +16,7 @@
 #include <linux/completion.h>
 #include <linux/miscdevice.h>
 #include <linux/dmaengine.h>
+#include <linux/fsldma.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
@@ -524,7 +525,7 @@ static noinline int fpga_program_dma(struct fpga_dev *priv)
 		goto out_dma_unmap;
 	}
 
-	ret = chan->device->device_control(chan, FSLDMA_EXTERNAL_START, 1);
+	ret = fsl_dma_external_start(chan, 1)
 	if (ret) {
 		dev_err(priv->dev, "DMA external control setup failed\n");
 		goto out_dma_unmap;
-- 
1.7.0.4

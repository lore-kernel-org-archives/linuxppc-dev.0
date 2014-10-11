Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id BF8691A1AC4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:54 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 3/6] carma-fpga: use dmaengine_xxx() API
Date: Sat, 11 Oct 2014 21:16:45 +0530
Message-Id: <1413042408-28491-4-git-send-email-vinod.koul@intel.com>
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

The drivers should use dmaengine_slave_config() and dmaengine_prep_dma_sg()
API instead of accessing the device_control which will be deprecated soon

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/misc/carma/carma-fpga-program.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
index 7be8983..fd0cb8b 100644
--- a/drivers/misc/carma/carma-fpga-program.c
+++ b/drivers/misc/carma/carma-fpga-program.c
@@ -518,8 +518,7 @@ static noinline int fpga_program_dma(struct fpga_dev *priv)
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	config.dst_maxburst = fpga_fifo_size(priv->regs) / 2 / 4;
-	ret = chan->device->device_control(chan, DMA_SLAVE_CONFIG,
-					   (unsigned long)&config);
+	ret = dmaengine_slave_config(chan, &config);
 	if (ret) {
 		dev_err(priv->dev, "DMA slave configuration failed\n");
 		goto out_dma_unmap;
@@ -532,9 +531,9 @@ static noinline int fpga_program_dma(struct fpga_dev *priv)
 	}
 
 	/* setup and submit the DMA transaction */
-	tx = chan->device->device_prep_dma_sg(chan,
-					      table.sgl, num_pages,
-					      vb->sglist, vb->sglen, 0);
+
+	tx = dmaengine_prep_dma_sg(chan, table.sgl, num_pages,
+			vb->sglist, vb->sglen, 0);
 	if (!tx) {
 		dev_err(priv->dev, "Unable to prep DMA transaction\n");
 		ret = -ENOMEM;
-- 
1.7.0.4

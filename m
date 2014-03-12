Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x230.google.com (mail-la0-x230.google.com
 [IPv6:2a00:1450:4010:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A80A2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 22:48:20 +1100 (EST)
Received: by mail-la0-f48.google.com with SMTP id gf5so6435063lab.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 04:48:16 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v9 3/6] dma: mpc512x: replace devm_request_irq() with
 request_irq()
Date: Wed, 12 Mar 2014 15:47:52 +0400
Message-Id: <1394624875-24411-4-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace devm_request_irq() with request_irq() since there is no need
to use it because the original code always frees IRQ manually with
devm_free_irq(). Replace devm_free_irq() with free_irq() accordingly.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 drivers/dma/mpc512x_dma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index b1e430c..ff7f678 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -921,16 +921,15 @@ static int mpc_dma_probe(struct platform_device *op)
 	mdma->tcd = (struct mpc_dma_tcd *)((u8 *)(mdma->regs)
 							+ MPC_DMA_TCD_OFFSET);
 
-	retval = devm_request_irq(dev, mdma->irq, &mpc_dma_irq, 0, DRV_NAME,
-									mdma);
+	retval = request_irq(mdma->irq, &mpc_dma_irq, 0, DRV_NAME, mdma);
 	if (retval) {
 		dev_err(dev, "Error requesting IRQ!\n");
 		return -EINVAL;
 	}
 
 	if (mdma->is_mpc8308) {
-		retval = devm_request_irq(dev, mdma->irq2, &mpc_dma_irq, 0,
-				DRV_NAME, mdma);
+		retval = request_irq(mdma->irq2, &mpc_dma_irq, 0,
+							DRV_NAME, mdma);
 		if (retval) {
 			dev_err(dev, "Error requesting IRQ2!\n");
 			return -EINVAL;
@@ -1020,7 +1019,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	dev_set_drvdata(dev, mdma);
 	retval = dma_async_device_register(dma);
 	if (retval) {
-		devm_free_irq(dev, mdma->irq, mdma);
+		free_irq(mdma->irq, mdma);
 		irq_dispose_mapping(mdma->irq);
 	}
 
@@ -1033,7 +1032,7 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
 	dma_async_device_unregister(&mdma->dma);
-	devm_free_irq(dev, mdma->irq, mdma);
+	free_irq(mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
 
 	return 0;
-- 
1.8.4.2

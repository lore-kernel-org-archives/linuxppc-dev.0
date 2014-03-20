Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E73A2C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 01:48:23 +1100 (EST)
Received: by mail-lb0-f170.google.com with SMTP id s7so697276lbd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 07:48:19 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v10 3/6] dma: mpc512x: fix freeing resources in
 mpc_dma_probe() and mpc_dma_remove()
Date: Thu, 20 Mar 2014 18:47:55 +0400
Message-Id: <1395326878-25243-4-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix mpc_dma_probe() error path and mpc_dma_remove(): manually free IRQs and
dispose IRQ mappings before devm_* takes care of other resources.
Moreover replace devm_request_irq() with request_irq() since there is no need
to use it because the original code always frees IRQ manually with
devm_free_irq(). Replace devm_free_irq() with free_irq() accordingly.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 drivers/dma/mpc512x_dma.c | 55 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 68231d9..1b90b3b 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -883,13 +883,15 @@ static int mpc_dma_probe(struct platform_device *op)
 	mdma = devm_kzalloc(dev, sizeof(struct mpc_dma), GFP_KERNEL);
 	if (!mdma) {
 		dev_err(dev, "Memory exhausted!\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err;
 	}
 
 	mdma->irq = irq_of_parse_and_map(dn, 0);
 	if (mdma->irq == NO_IRQ) {
 		dev_err(dev, "Error mapping IRQ!\n");
-		return -EINVAL;
+		retval = -EINVAL;
+		goto err;
 	}
 
 	if (of_device_is_compatible(dn, "fsl,mpc8308-dma")) {
@@ -897,14 +899,15 @@ static int mpc_dma_probe(struct platform_device *op)
 		mdma->irq2 = irq_of_parse_and_map(dn, 1);
 		if (mdma->irq2 == NO_IRQ) {
 			dev_err(dev, "Error mapping IRQ!\n");
-			return -EINVAL;
+			retval = -EINVAL;
+			goto err_dispose1;
 		}
 	}
 
 	retval = of_address_to_resource(dn, 0, &res);
 	if (retval) {
 		dev_err(dev, "Error parsing memory region!\n");
-		return retval;
+		goto err_dispose2;
 	}
 
 	regs_start = res.start;
@@ -912,31 +915,34 @@ static int mpc_dma_probe(struct platform_device *op)
 
 	if (!devm_request_mem_region(dev, regs_start, regs_size, DRV_NAME)) {
 		dev_err(dev, "Error requesting memory region!\n");
-		return -EBUSY;
+		retval = -EBUSY;
+		goto err_dispose2;
 	}
 
 	mdma->regs = devm_ioremap(dev, regs_start, regs_size);
 	if (!mdma->regs) {
 		dev_err(dev, "Error mapping memory region!\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_dispose2;
 	}
 
 	mdma->tcd = (struct mpc_dma_tcd *)((u8 *)(mdma->regs)
 							+ MPC_DMA_TCD_OFFSET);
 
-	retval = devm_request_irq(dev, mdma->irq, &mpc_dma_irq, 0, DRV_NAME,
-									mdma);
+	retval = request_irq(mdma->irq, &mpc_dma_irq, 0, DRV_NAME, mdma);
 	if (retval) {
 		dev_err(dev, "Error requesting IRQ!\n");
-		return -EINVAL;
+		retval = -EINVAL;
+		goto err_dispose2;
 	}
 
 	if (mdma->is_mpc8308) {
-		retval = devm_request_irq(dev, mdma->irq2, &mpc_dma_irq, 0,
-				DRV_NAME, mdma);
+		retval = request_irq(mdma->irq2, &mpc_dma_irq, 0,
+							DRV_NAME, mdma);
 		if (retval) {
 			dev_err(dev, "Error requesting IRQ2!\n");
-			return -EINVAL;
+			retval = -EINVAL;
+			goto err_free1;
 		}
 	}
 
@@ -1022,12 +1028,23 @@ static int mpc_dma_probe(struct platform_device *op)
 	/* Register DMA engine */
 	dev_set_drvdata(dev, mdma);
 	retval = dma_async_device_register(dma);
-	if (retval) {
-		devm_free_irq(dev, mdma->irq, mdma);
-		irq_dispose_mapping(mdma->irq);
-	}
+	if (retval)
+		goto err_free2;
 
 	return retval;
+
+err_free2:
+	if (mdma->is_mpc8308)
+		free_irq(mdma->irq2, mdma);
+err_free1:
+	free_irq(mdma->irq, mdma);
+err_dispose2:
+	if (mdma->is_mpc8308)
+		irq_dispose_mapping(mdma->irq2);
+err_dispose1:
+	irq_dispose_mapping(mdma->irq);
+err:
+	return retval;
 }
 
 static int mpc_dma_remove(struct platform_device *op)
@@ -1036,7 +1053,11 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
 	dma_async_device_unregister(&mdma->dma);
-	devm_free_irq(dev, mdma->irq, mdma);
+	if (mdma->is_mpc8308) {
+		free_irq(mdma->irq2, mdma);
+		irq_dispose_mapping(mdma->irq2);
+	}
+	free_irq(mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
 
 	return 0;
-- 
1.8.4.2

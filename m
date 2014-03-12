Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22f.google.com (mail-lb0-x22f.google.com
 [IPv6:2a00:1450:4010:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D8902C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 22:48:24 +1100 (EST)
Received: by mail-lb0-f175.google.com with SMTP id w7so6451056lbi.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 04:48:20 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v9 6/6] dma: mpc512x: register for device tree channel
 lookup
Date: Wed, 12 Mar 2014 15:47:55 +0400
Message-Id: <1394624875-24411-7-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register the controller for device tree based lookup of DMA channels
(non-fatal for backwards compatibility with older device trees) and
provide the '#dma-cells' property in the shared mpc5121.dtsi file

Signed-off-by: Gerhard Sittig <gsi@denx.de>
Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 arch/powerpc/boot/dts/mpc5121.dtsi |  1 +
 drivers/dma/mpc512x_dma.c          | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 2c0e155..7f9d14f 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -498,6 +498,7 @@
 			compatible = "fsl,mpc5121-dma";
 			reg = <0x14000 0x1800>;
 			interrupts = <65 0x8>;
+			#dma-cells = <1>;
 		};
 	};
 
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index ff7f678..453b1cb 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -52,6 +52,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_dma.h>
 #include <linux/of_platform.h>
 
 #include <linux/random.h>
@@ -1018,11 +1019,23 @@ static int mpc_dma_probe(struct platform_device *op)
 	/* Register DMA engine */
 	dev_set_drvdata(dev, mdma);
 	retval = dma_async_device_register(dma);
-	if (retval) {
-		free_irq(mdma->irq, mdma);
-		irq_dispose_mapping(mdma->irq);
+	if (retval)
+		goto out_irq;
+
+	/* Register with OF helpers for DMA lookups (nonfatal) */
+	if (dev->of_node) {
+		retval = of_dma_controller_register(dev->of_node,
+						of_dma_xlate_by_chan_id, mdma);
+		if (retval)
+			dev_warn(dev, "could not register for OF lookup\n");
 	}
 
+	return 0;
+
+out_irq:
+	free_irq(mdma->irq, mdma);
+	irq_dispose_mapping(mdma->irq);
+
 	return retval;
 }
 
@@ -1031,6 +1044,8 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&mdma->dma);
 	free_irq(mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
-- 
1.8.4.2

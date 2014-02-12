Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x231.google.com (mail-la0-x231.google.com
 [IPv6:2a00:1450:4010:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 399F72C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 00:25:44 +1100 (EST)
Received: by mail-la0-f49.google.com with SMTP id y1so6898248lam.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 05:25:40 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH RFC v7 5/6] dma: mpc512x: register for device tree channel
 lookup
Date: Wed, 12 Feb 2014 17:25:07 +0400
Message-Id: <1392211508-23615-6-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gerhard Sittig <gsi@denx.de>

register the controller for device tree based lookup of DMA channels
(non-fatal for backwards compatibility with older device trees) and
provide the '#dma-cells' property in the shared mpc5121.dtsi file

Signed-off-by: Gerhard Sittig <gsi@denx.de>
[ a13xp0p0v88@gmail.com: resolve little patch conflict and put
  MPC512x DMA controller bindings document to a separate patch ]
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
index b978ef1..1e0b8cf 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -50,6 +50,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_dma.h>
 #include <linux/of_platform.h>
 
 #include <linux/random.h>
@@ -1013,11 +1014,23 @@ static int mpc_dma_probe(struct platform_device *op)
 	/* Register DMA engine */
 	dev_set_drvdata(dev, mdma);
 	retval = dma_async_device_register(dma);
-	if (retval) {
-		devm_free_irq(dev, mdma->irq, mdma);
-		irq_dispose_mapping(mdma->irq);
+	if (retval)
+		goto out_irq;
+
+	/* register with OF helpers for DMA lookups (nonfatal) */
+	if (dev->of_node) {
+		retval = of_dma_controller_register(dev->of_node,
+						    of_dma_xlate_by_chan_id,
+						    mdma);
+		if (retval)
+			dev_warn(dev, "could not register for OF lookup\n");
 	}
 
+	return 0;
+
+out_irq:
+	devm_free_irq(dev, mdma->irq, mdma);
+	irq_dispose_mapping(mdma->irq);
 	return retval;
 }
 
@@ -1026,6 +1039,8 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&mdma->dma);
 	devm_free_irq(dev, mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
-- 
1.8.4.2

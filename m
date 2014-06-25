Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x231.google.com (mail-lb0-x231.google.com
 [IPv6:2a00:1450:4010:c04::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6B31A0015
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 20:53:19 +1000 (EST)
Received: by mail-lb0-f177.google.com with SMTP id u10so1665990lbd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 03:53:15 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] dmaengine: mpc512x: register for device tree channel
 lookup
Date: Wed, 25 Jun 2014 14:53:00 +0400
Message-Id: <1403693580-9449-4-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
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

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 arch/powerpc/boot/dts/mpc5121.dtsi |  1 +
 drivers/dma/mpc512x_dma.c          | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index 2ad4373..881db2b 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -53,6 +53,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_dma.h>
 #include <linux/of_platform.h>
 
 #include <linux/random.h>
@@ -1036,7 +1037,15 @@ static int mpc_dma_probe(struct platform_device *op)
 	if (retval)
 		goto err_free2;
 
-	return retval;
+	/* Register with OF helpers for DMA lookups (nonfatal) */
+	if (dev->of_node) {
+		retval = of_dma_controller_register(dev->of_node,
+						of_dma_xlate_by_chan_id, mdma);
+		if (retval)
+			dev_warn(dev, "Could not register for OF lookup\n");
+	}
+
+	return 0;
 
 err_free2:
 	if (mdma->is_mpc8308)
@@ -1057,6 +1066,8 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&mdma->dma);
 	if (mdma->is_mpc8308) {
 		free_irq(mdma->irq2, mdma);
-- 
1.8.4.2

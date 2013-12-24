Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com
 [IPv6:2a00:1450:4010:c04::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 674E72C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 23:02:55 +1100 (EST)
Received: by mail-lb0-f182.google.com with SMTP id l4so2873280lbv.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 04:02:50 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree channel
 lookup
Date: Tue, 24 Dec 2013 16:06:28 +0400
Message-Id: <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
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
(non-fatal for backwards compatibility with older device trees), provide
the '#dma-cells' property in the shared mpc5121.dtsi file, and introduce
a bindings document for the MPC512x DMA controller

Signed-off-by: Gerhard Sittig <gsi@denx.de>
[ a13xp0p0v88@gmail.com: resolve little patch conflict ]
[ a13xp0p0v88@gmail.com: set DMA_PRIVATE flag for MPC512x DMA controller ]
Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 .../devicetree/bindings/dma/mpc512x-dma.txt        | 55 ++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  1 +
 drivers/dma/mpc512x_dma.c                          | 22 +++++++--
 3 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
new file mode 100644
index 0000000..a4867d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
@@ -0,0 +1,55 @@
+* Freescale MPC512x DMA Controller
+
+The DMA controller in the Freescale MPC512x SoC can move blocks of
+memory contents between memory and peripherals or memory to memory.
+
+Refer to the "Generic DMA Controller and DMA request bindings" description
+in the dma.txt file for a more detailled discussion of the binding.  The
+MPC512x DMA engine binding follows the common scheme, but doesn't provide
+support for the optional channels and requests counters (those values are
+derived from the detected hardware features) and has a fixed client
+specifier length of 1 integer cell (the value is the DMA channel, since
+the DMA controller uses a fixed assignment of request lines per channel).
+
+
+DMA controller node properties:
+
+Required properties:
+- compatible:		should be "fsl,mpc5121-dma"
+- reg:			address and size of the DMA controller's register set
+- interrupts:		interrupt spec for the DMA controller
+
+Optional properties:
+- #dma-cells:		must be <1>, describes the number of integer cells
+			needed to specify the 'dmas' property in client nodes,
+			strongly recommended since common client helper code
+			uses this property
+
+Example:
+
+	dma0: dma@14000 {
+		compatible = "fsl,mpc5121-dma";
+		reg = <0x14000 0x1800>;
+		interrupts = <65 0x8>;
+		#dma-cells = <1>;
+	};
+
+
+Client node properties:
+
+Required properties:
+- dmas:			list of DMA specifiers, consisting each of a handle
+			for the DMA controller and integer cells to specify
+			the channel used within the DMA controller
+- dma-names:		list of identifier strings for the DMA specifiers,
+			client device driver code uses these strings to
+			have DMA channels looked up at the controller
+
+Example:
+
+	sdhc@1500 {
+		compatible = "fsl,mpc5121-sdhc";
+		/* ... */
+		dmas = <&dma0 30>;
+		dma-names = "rx-tx";
+	};
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 2d7cb04..15b7860 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -389,6 +389,7 @@
 			compatible = "fsl,mpc5121-dma";
 			reg = <0x14000 0x1800>;
 			interrupts = <65 0x8>;
+			#dma-cells = <1>;
 		};
 	};
 
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index a7e7749..8fabb52 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -50,6 +50,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_dma.h>
 #include <linux/of_platform.h>
 
 #include <linux/random.h>
@@ -950,6 +951,7 @@ static int mpc_dma_probe(struct platform_device *op)
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 
 	for (i = 0; i < dma->chancnt; i++) {
 		mchan = &mdma->channels[i];
@@ -1013,11 +1015,23 @@ static int mpc_dma_probe(struct platform_device *op)
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
 
@@ -1026,6 +1040,8 @@ static int mpc_dma_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct mpc_dma *mdma = dev_get_drvdata(dev);
 
+	if (dev->of_node)
+		of_dma_controller_free(dev->of_node);
 	dma_async_device_unregister(&mdma->dma);
 	devm_free_irq(dev, mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
-- 
1.8.4.2

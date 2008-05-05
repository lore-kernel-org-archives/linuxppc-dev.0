Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E5980DDF0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 03:56:50 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: jwboyer@linux.vnet.ibm.com, benh@kernel.crashing.org,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] [POWERPC] Xilinx: Framebuffer: remove platform device
	support.
Date: Mon,  5 May 2008 10:56:40 -0700
In-Reply-To: <1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080505175646.EE9DF10F8056@mail72-va3.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With ARCH=ppc going away, we don't really need platform device support
anymore.  In fact it is hard, if we want to use the generic dcr
infrastructure.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 drivers/video/xilinxfb.c |   63 +---------------------------------------------
 1 files changed, 1 insertions(+), 62 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 7b3a842..4d64402 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -31,7 +31,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
 #if defined(CONFIG_OF)
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -356,56 +355,6 @@ static int xilinxfb_release(struct device *dev)
 }
 
 /* ---------------------------------------------------------------------
- * Platform bus binding
- */
-
-static int
-xilinxfb_platform_probe(struct platform_device *pdev)
-{
-	struct xilinxfb_platform_data *pdata;
-	struct resource *res;
-
-	/* Find the registers address */
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Couldn't get registers resource\n");
-		return -ENODEV;
-	}
-
-	/* If a pdata structure is provided, then extract the parameters */
-	pdata = &xilinx_fb_default_pdata;
-	if (pdev->dev.platform_data) {
-		pdata = pdev->dev.platform_data;
-		if (!pdata->xres)
-			pdata->xres = xilinx_fb_default_pdata.xres;
-		if (!pdata->yres)
-			pdata->yres = xilinx_fb_default_pdata.yres;
-		if (!pdata->xvirt)
-			pdata->xvirt = xilinx_fb_default_pdata.xvirt;
-		if (!pdata->yvirt)
-			pdata->yvirt = xilinx_fb_default_pdata.yvirt;
-	}
-
-	return xilinxfb_assign(&pdev->dev, res->start, pdata);
-}
-
-static int
-xilinxfb_platform_remove(struct platform_device *pdev)
-{
-	return xilinxfb_release(&pdev->dev);
-}
-
-
-static struct platform_driver xilinxfb_platform_driver = {
-	.probe		= xilinxfb_platform_probe,
-	.remove		= xilinxfb_platform_remove,
-	.driver = {
-		.owner = THIS_MODULE,
-		.name = DRIVER_NAME,
-	},
-};
-
-/* ---------------------------------------------------------------------
  * OF bus binding
  */
 
@@ -500,22 +449,12 @@ static inline void __exit xilinxfb_of_unregister(void) { }
 static int __init
 xilinxfb_init(void)
 {
-	int rc;
-	rc = xilinxfb_of_register();
-	if (rc)
-		return rc;
-
-	rc = platform_driver_register(&xilinxfb_platform_driver);
-	if (rc)
-		xilinxfb_of_unregister();
-
-	return rc;
+	return xilinxfb_of_register();
 }
 
 static void __exit
 xilinxfb_cleanup(void)
 {
-	platform_driver_unregister(&xilinxfb_platform_driver);
 	xilinxfb_of_unregister();
 }
 
-- 
1.5.3.4-dirty

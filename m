Return-Path: <linnj@xilinx.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 2D874DE0AC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 02:45:36 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com,
	adaplas@gmail.com, jwboyer@linux.vnet.ibm.com
Subject: [PATCH] [V4] Xilinx : Framebuffer Driver: Add PLB support and cleanup
	DCR
Date: Thu, 16 Apr 2009 10:26:23 -0600
Message-ID: <20090416163021.023DC770050@mail77-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Suneel <suneelg@xilinx.com>, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added support for the new xps tft controller. The new core
has PLB interface support in addition to existing DCR interface.

Removed platform device support as both MicroBlaze and PowerPC
use device tree.

Previously, the dcr interface was assumed to be used in mmio mode,
and the register space of the dcr interface was precomputed and stuffed
into the device tree. This driver now makes use of the new dcr
infrastructure to represent the dcr interface. This enables the dcr
interface to be connected directly to a native dcr interface in a clean
way.

Added compatibility for ml507 dvi core.

Signed-off-by: Suneel <suneelg@xilinx.com>
Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---

V2 - cleanup based on review
V3 - update to be based on top of tree rather than Xilinx tree, sorry for the
 confusion with this, update the name of the patch slightly to be more accurate
V4 - update based on Grant's comments to simplify it, the binding wasn't changed
 as the conversation seemed to verify it's acceptable

 drivers/video/xilinxfb.c |  282 +++++++++++++++++++++++-----------------------
 1 files changed, 142 insertions(+), 140 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 40a3a2a..ebb9d1c 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -1,13 +1,13 @@
 /*
- * xilinxfb.c
  *
- * Xilinx TFT LCD frame buffer driver
+ * Xilinx TFT frame buffer driver
  *
  * Author: MontaVista Software, Inc.
  *         source@mvista.com
  *
  * 2002-2007 (c) MontaVista Software, Inc.
  * 2007 (c) Secret Lab Technologies, Ltd.
+ * 2009 (c) Xilinx Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -24,33 +24,38 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#if defined(CONFIG_OF)
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
-#endif
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/xilinxfb.h>
+#include <asm/dcr.h>
 
 #define DRIVER_NAME		"xilinxfb"
-#define DRIVER_DESCRIPTION	"Xilinx TFT LCD frame buffer driver"
+
 
 /*
  * Xilinx calls it "PLB TFT LCD Controller" though it can also be used for
- * the VGA port on the Xilinx ML40x board. This is a hardware display controller
- * for a 640x480 resolution TFT or VGA screen.
+ * the VGA port on the Xilinx ML40x board. This is a hardware display
+ * controller for a TFT or VGA screen.
  *
  * The interface to the framebuffer is nice and simple.  There are two
  * control registers.  The first tells the LCD interface where in memory
  * the frame buffer is (only the 11 most significant bits are used, so
  * don't start thinking about scrolling).  The second allows the LCD to
  * be turned on or off as well as rotated 180 degrees.
+ *
+ * In case of direct PLB access the second control register will be at
+ * an offset of 4 as compared to the DCR access where the offset is 1
+ * i.e. REG_CTRL. So this is taken care in the function
+ * xilinx_fb_out_be32 where it left shifts the offset 2 times in case of
+ * direct PLB access.
  */
 #define NUM_REGS	2
 #define REG_FB_ADDR	0
@@ -107,12 +112,21 @@ static struct fb_var_screeninfo xilinx_fb_var = {
 	.activate =	FB_ACTIVATE_NOW
 };
 
+
+#define PLB_ACCESS_FLAG	0x1		/* 1 = PLB, 0 = DCR */
+
 struct xilinxfb_drvdata {
 
 	struct fb_info	info;		/* FB driver info record */
 
-	u32		regs_phys;	/* phys. address of the control registers */
-	u32 __iomem	*regs;		/* virt. address of the control registers */
+	phys_addr_t	regs_phys;	/* phys. address of the control
+						registers */
+	void __iomem	*regs;		/* virt. address of the control
+						registers */
+
+	dcr_host_t      dcr_host;
+	unsigned int    dcr_start;
+	unsigned int    dcr_len;
 
 	void		*fb_virt;	/* virt. address of the frame buffer */
 	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
@@ -128,14 +142,18 @@ struct xilinxfb_drvdata {
 	container_of(_info, struct xilinxfb_drvdata, info)
 
 /*
- * The LCD controller has DCR interface to its registers, but all
- * the boards and configurations the driver has been tested with
- * use opb2dcr bridge. So the registers are seen as memory mapped.
- * This macro is to make it simple to add the direct DCR access
- * when it's needed.
+ * The XPS TFT Controller can be accessed through PLB or DCR interface.
+ * To perform the read/write on the registers we need to check on
+ * which bus its connected and call the appropriate write API.
  */
-#define xilinx_fb_out_be32(driverdata, offset, val) \
-	out_be32(driverdata->regs + offset, val)
+static void xilinx_fb_out_be32(struct xilinxfb_drvdata *drvdata, u32 offset,
+				u32 val)
+{
+	if (drvdata->regs)
+		out_be32(drvdata->regs + (offset << 2), val);
+	else
+		dcr_write(drvdata->dcr_host, offset, val);
+}
 
 static int
 xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
@@ -173,7 +191,8 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		/* turn on panel */
-		xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+		xilinx_fb_out_be32(drvdata, REG_CTRL,
+					drvdata->reg_ctrl_default);
 		break;
 
 	case FB_BLANK_NORMAL:
@@ -189,8 +208,7 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
 	return 0; /* success */
 }
 
-static struct fb_ops xilinxfb_ops =
-{
+static struct fb_ops xilinxfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= xilinx_fb_setcolreg,
 	.fb_blank		= xilinx_fb_blank,
@@ -203,35 +221,34 @@ static struct fb_ops xilinxfb_ops =
  * Bus independent setup/teardown
  */
 
-static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
+static int xilinxfb_assign(struct device *dev,
+			   struct xilinxfb_drvdata *drvdata,
+			   unsigned long physaddr,
 			   struct xilinxfb_platform_data *pdata)
 {
-	struct xilinxfb_drvdata *drvdata;
 	int rc;
 	int fbsize = pdata->xvirt * pdata->yvirt * BYTES_PER_PIXEL;
 
-	/* Allocate the driver data region */
-	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata) {
-		dev_err(dev, "Couldn't allocate device private record\n");
-		return -ENOMEM;
-	}
-	dev_set_drvdata(dev, drvdata);
-
-	/* Map the control registers in */
-	if (!request_mem_region(physaddr, 8, DRIVER_NAME)) {
-		dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
-			physaddr);
-		rc = -ENODEV;
-		goto err_region;
-	}
-	drvdata->regs_phys = physaddr;
-	drvdata->regs = ioremap(physaddr, 8);
-	if (!drvdata->regs) {
-		dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
-			physaddr);
-		rc = -ENODEV;
-		goto err_map;
+	if (physaddr) {
+		/*
+		 * Map the control registers in if the controller
+		 * is on direct PLB interface.
+		 */
+		if (!request_mem_region(physaddr, 8, DRIVER_NAME)) {
+			dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
+				physaddr);
+			rc = -ENODEV;
+			goto err_region;
+		}
+
+		drvdata->regs_phys = physaddr;
+		drvdata->regs = ioremap(physaddr, 8);
+		if (!drvdata->regs) {
+			dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
+				physaddr);
+			rc = -ENODEV;
+			goto err_map;
+		}
 	}
 
 	/* Allocate the framebuffer memory */
@@ -260,7 +277,8 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
 	if (pdata->rotate_screen)
 		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
-	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+	xilinx_fb_out_be32(drvdata, REG_CTRL,
+					drvdata->reg_ctrl_default);
 
 	/* Fill struct fb_info */
 	drvdata->info.device = dev;
@@ -296,11 +314,14 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 		goto err_regfb;
 	}
 
+	if (drvdata->regs) {
+		/* Put a banner in the log (for DEBUG) */
+		dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr,
+					drvdata->regs);
+	}
 	/* Put a banner in the log (for DEBUG) */
-	dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr, drvdata->regs);
-	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
-		(unsigned long long) drvdata->fb_phys, drvdata->fb_virt,
-		fbsize);
+	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
+		(void *)drvdata->fb_phys, drvdata->fb_virt, fbsize);
 
 	return 0;	/* success */
 
@@ -311,14 +332,19 @@ err_cmap:
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
 			drvdata->fb_phys);
+	else
+		iounmap(drvdata->fb_virt);
+
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
 
 err_fbmem:
-	iounmap(drvdata->regs);
+	if (drvdata->regs)
+		iounmap(drvdata->regs);
 
 err_map:
-	release_mem_region(physaddr, 8);
+	if (physaddr)
+		release_mem_region(physaddr, 8);
 
 err_region:
 	kfree(drvdata);
@@ -342,12 +368,18 @@ static int xilinxfb_release(struct device *dev)
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
 				  drvdata->fb_virt, drvdata->fb_phys);
+	else
+		iounmap(drvdata->fb_virt);
 
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
-	iounmap(drvdata->regs);
 
-	release_mem_region(drvdata->regs_phys, 8);
+	/* Release the resources, as allocated based on interface */
+	if (drvdata->regs) {
+		iounmap(drvdata->regs);
+		release_mem_region(drvdata->regs_phys, 8);
+	} else
+		dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
 
 	kfree(drvdata);
 	dev_set_drvdata(dev, NULL);
@@ -356,77 +388,55 @@ static int xilinxfb_release(struct device *dev)
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
 
-#if defined(CONFIG_OF)
 static int __devinit
 xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct resource res;
 	const u32 *prop;
+	u32 *p;
+	u32 tft_access;
 	struct xilinxfb_platform_data pdata;
+	struct resource res;
 	int size, rc;
+	int start = 0, len = 0;
+	dcr_host_t dcr_host;
+	struct xilinxfb_drvdata *drvdata;
 
 	/* Copy with the default pdata (not a ptr reference!) */
 	pdata = xilinx_fb_default_pdata;
 
 	dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match);
 
-	rc = of_address_to_resource(op->node, 0, &res);
-	if (rc) {
-		dev_err(&op->dev, "invalid address\n");
-		return rc;
+	/*
+	 * Determine if the core is connected directly to DCR or PLB
+	 * interface and initialize the tft_access accordingly keeping
+	 * backward compatibility with DCR access.
+	 */
+	p = (u32 *)of_get_property(op->node, "xlnx,dcr-splb-slave-if", NULL);
+
+	tft_access = p ? *p : 0;
+
+	/*
+	 * Fill the resource structure if its direct PLB interface
+	 * otherwise fill the dcr_host structure.
+	 */
+	if (tft_access) {
+		rc = of_address_to_resource(op->node, 0, &res);
+		if (rc) {
+			dev_err(&op->dev, "invalid address\n");
+			return -ENODEV;
+		}
+
+	} else {
+		start = dcr_resource_start(op->node, 0);
+		len = dcr_resource_len(op->node, 0);
+		dcr_host = dcr_map(op->node, start, len);
+		if (!DCR_MAP_OK(dcr_host)) {
+			dev_err(&op->dev, "invalid address\n");
+			return -ENODEV;
+		}
 	}
 
 	prop = of_get_property(op->node, "phys-size", &size);
@@ -450,7 +460,23 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (of_find_property(op->node, "rotate-display", NULL))
 		pdata.rotate_screen = 1;
 
-	return xilinxfb_assign(&op->dev, res.start, &pdata);
+	/* Allocate the driver data region */
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		dev_err(&op->dev, "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(&op->dev, drvdata);
+
+	/* Arguments are passed based on the interface */
+	if (tft_access) {
+		return xilinxfb_assign(&op->dev, drvdata, res.start, &pdata);
+	} else {
+		drvdata->dcr_start = start;
+		drvdata->dcr_len = len;
+		drvdata->dcr_host = dcr_host;
+		return xilinxfb_assign(&op->dev, drvdata, 0, &pdata);
+	}
 }
 
 static int __devexit xilinxfb_of_remove(struct of_device *op)
@@ -460,7 +486,9 @@ static int __devexit xilinxfb_of_remove(struct of_device *op)
 
 /* Match table for of_platform binding */
 static struct of_device_id xilinxfb_of_match[] __devinitdata = {
+	{ .compatible = "xlnx,xps-tft-1.00.a", },
 	{ .compatible = "xlnx,plb-tft-cntlr-ref-1.00.a", },
+	{ .compatible = "xlnx,plb-dvi-cntlr-ref-1.00.c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, xilinxfb_of_match);
@@ -476,22 +504,6 @@ static struct of_platform_driver xilinxfb_of_driver = {
 	},
 };
 
-/* Registration helpers to keep the number of #ifdefs to a minimum */
-static inline int __init xilinxfb_of_register(void)
-{
-	pr_debug("xilinxfb: calling of_register_platform_driver()\n");
-	return of_register_platform_driver(&xilinxfb_of_driver);
-}
-
-static inline void __exit xilinxfb_of_unregister(void)
-{
-	of_unregister_platform_driver(&xilinxfb_of_driver);
-}
-#else /* CONFIG_OF */
-/* CONFIG_OF not enabled; do nothing helpers */
-static inline int __init xilinxfb_of_register(void) { return 0; }
-static inline void __exit xilinxfb_of_unregister(void) { }
-#endif /* CONFIG_OF */
 
 /* ---------------------------------------------------------------------
  * Module setup and teardown
@@ -500,28 +512,18 @@ static inline void __exit xilinxfb_of_unregister(void) { }
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
+	return of_register_platform_driver(&xilinxfb_of_driver);
 }
 
 static void __exit
 xilinxfb_cleanup(void)
 {
-	platform_driver_unregister(&xilinxfb_platform_driver);
-	xilinxfb_of_unregister();
+	of_unregister_platform_driver(&xilinxfb_of_driver);
 }
 
 module_init(xilinxfb_init);
 module_exit(xilinxfb_cleanup);
 
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
-MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_DESCRIPTION("Xilinx TFT frame buffer driver");
 MODULE_LICENSE("GPL");
-- 
1.6.2.1


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

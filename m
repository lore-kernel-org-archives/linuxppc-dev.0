Return-Path: <linnj@xilinx.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 7D68ADE0A6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 07:15:35 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	akonovalov@ru.mvista.com, adaplas@gmail.com
Subject: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Date: Wed, 8 Apr 2009 15:11:25 -0600
Message-ID: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Suneel <suneelg@xilinx.com>,
	Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Suneel <[mailto:suneel.garapati@xilinx.com]>

Added support for the new xps tft controller.

The new core has PLB interface support in addition to existing
DCR interface.

The driver has been modified to support this new core which
can be connected on PLB or DCR bus.

Signed-off-by: Suneel <suneelg@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/video/xilinxfb.c |  227 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 160 insertions(+), 67 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index a82c530..a28a834 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -1,17 +1,24 @@
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
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
+ * This program is free software; you can redistribute it
+ * and/or modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation;
+ * either version 2 of the License, or (at your option) any
+ * later version.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
+ * 02139, USA.
  */
 
 /*
@@ -31,27 +38,31 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
-#if defined(CONFIG_OF)
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
-#endif
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/xilinxfb.h>
 #include <asm/dcr.h>
 
 #define DRIVER_NAME		"xilinxfb"
-#define DRIVER_DESCRIPTION	"Xilinx TFT LCD frame buffer driver"
+
 
 /*
  * Xilinx calls it "PLB TFT LCD Controller" though it can also be used for
- * the VGA port on the Xilinx ML40x board. This is a hardware display controller
- * for a 640x480 resolution TFT or VGA screen.
+ * the VGA port on the Xilinx ML40x board. This is a hardware display
+ * controller for a 640x480 resolution TFT or VGA screen.
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
@@ -112,6 +123,11 @@ struct xilinxfb_drvdata {
 
 	struct fb_info	info;		/* FB driver info record */
 
+	u32		regs_phys;	/* phys. address of the control
+						registers */
+	void __iomem	*regs;		/* virt. address of the control
+						registers */
+
 	dcr_host_t      dcr_host;
 	unsigned int    dcr_start;
 	unsigned int    dcr_len;
@@ -120,6 +136,10 @@ struct xilinxfb_drvdata {
 	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
 	int		fb_alloced;	/* Flag, was the fb memory alloced? */
 
+	u32 		dcr_splb_slave_if;
+					/* True, if control interface is
+						connected through plb */
+
 	u32		reg_ctrl_default;
 
 	u32		pseudo_palette[PALETTE_ENTRIES_NO];
@@ -130,14 +150,19 @@ struct xilinxfb_drvdata {
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
-	dcr_write(driverdata->dcr_host, offset, val)
+static void xilinx_fb_out_be32(struct xilinxfb_drvdata *drvdata, u32 offset,
+				u32 val)
+{
+	if (drvdata->dcr_splb_slave_if == 1)
+		out_be32(drvdata->regs + (offset << 2), val);
+	else
+		dcr_write(drvdata->dcr_host, offset, val);
+
+}
 
 static int
 xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
@@ -175,7 +200,8 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		/* turn on panel */
-		xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+		xilinx_fb_out_be32(drvdata, REG_CTRL,
+					drvdata->reg_ctrl_default);
 		break;
 
 	case FB_BLANK_NORMAL:
@@ -191,8 +217,7 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
 	return 0; /* success */
 }
 
-static struct fb_ops xilinxfb_ops =
-{
+static struct fb_ops xilinxfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= xilinx_fb_setcolreg,
 	.fb_blank		= xilinx_fb_blank,
@@ -205,25 +230,35 @@ static struct fb_ops xilinxfb_ops =
  * Bus independent setup/teardown
  */
 
-static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
-			   unsigned int dcr_start, unsigned int dcr_len,
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
+	if (drvdata->dcr_splb_slave_if) {
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
-	dev_set_drvdata(dev, drvdata);
-
-	drvdata->dcr_start = dcr_start;
-	drvdata->dcr_len = dcr_len;
-	drvdata->dcr_host = dcr_host;
 
 	/* Allocate the framebuffer memory */
 	if (pdata->fb_phys) {
@@ -238,7 +273,10 @@ static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
 	if (!drvdata->fb_virt) {
 		dev_err(dev, "Could not allocate frame buffer memory\n");
 		rc = -ENOMEM;
-		goto err_region;
+		if (drvdata->dcr_splb_slave_if)
+			goto err_fbmem;
+		else
+			goto err_region;
 	}
 
 	/* Clear (turn to black) the framebuffer */
@@ -251,7 +289,8 @@ static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
 	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
 	if (pdata->rotate_screen)
 		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
-	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+	xilinx_fb_out_be32(drvdata, REG_CTRL,
+					drvdata->reg_ctrl_default);
 
 	/* Fill struct fb_info */
 	drvdata->info.device = dev;
@@ -287,9 +326,14 @@ static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
 		goto err_regfb;
 	}
 
+	if (drvdata->dcr_splb_slave_if) {
+		/* Put a banner in the log (for DEBUG) */
+		dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr,
+					drvdata->regs);
+	}
 	/* Put a banner in the log (for DEBUG) */
 	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
-		(void*)drvdata->fb_phys, drvdata->fb_virt, fbsize);
+		(void *)drvdata->fb_phys, drvdata->fb_virt, fbsize);
 
 	return 0;	/* success */
 
@@ -300,9 +344,20 @@ err_cmap:
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
 			drvdata->fb_phys);
+	else
+		iounmap(drvdata->fb_virt);
+
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
 
+err_fbmem:
+	if (drvdata->dcr_splb_slave_if)
+		iounmap(drvdata->regs);
+
+err_map:
+	if (drvdata->dcr_splb_slave_if)
+		release_mem_region(physaddr, 8);
+
 err_region:
 	kfree(drvdata);
 	dev_set_drvdata(dev, NULL);
@@ -325,11 +380,18 @@ static int xilinxfb_release(struct device *dev)
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
 				  drvdata->fb_virt, drvdata->fb_phys);
+	else
+		iounmap(drvdata->fb_virt);
 
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
 
-	dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
+	/* Release the resources, as allocated based on interface */
+	if (drvdata->dcr_splb_slave_if) {
+		iounmap(drvdata->regs);
+		release_mem_region(drvdata->regs_phys, 8);
+	} else
+		dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
 
 	kfree(drvdata);
 	dev_set_drvdata(dev, NULL);
@@ -341,27 +403,54 @@ static int xilinxfb_release(struct device *dev)
  * OF bus binding
  */
 
-#if defined(CONFIG_OF)
 static int __devinit
 xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	const u32 *prop;
+	u32 *p;
+	u32 tft_access;
 	struct xilinxfb_platform_data pdata;
+	struct resource res;
 	int size, rc;
-	int start, len;
+	int start = 0, len = 0;
 	dcr_host_t dcr_host;
+	struct xilinxfb_drvdata *drvdata;
 
 	/* Copy with the default pdata (not a ptr reference!) */
 	pdata = xilinx_fb_default_pdata;
 
 	dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match);
 
-	start = dcr_resource_start(op->node, 0);
-	len = dcr_resource_len(op->node, 0);
-	dcr_host = dcr_map(op->node, start, len);
-	if (!DCR_MAP_OK(dcr_host)) {
-		dev_err(&op->dev, "invalid address\n");
-		return -ENODEV;
+	/*
+	 * To check whether the core is connected directly to DCR or PLB
+	 * interface and initialize the tft_access accordingly.
+	 */
+	p = (u32 *)of_get_property(op->node, "xlnx,dcr-splb-slave-if", NULL);
+
+	if (p)
+		tft_access = *p;
+	else
+		tft_access = 0;		/* For backward compatibility */
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
@@ -385,7 +474,26 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (of_find_property(op->node, "rotate-display", NULL))
 		pdata.rotate_screen = 1;
 
-	return xilinxfb_assign(&op->dev, dcr_host, start, len, &pdata);
+	/* Allocate the driver data region */
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		dev_err(&op->dev, "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(&op->dev, drvdata);
+
+	/* Store the tft_access value into the driverdata structure member */
+	drvdata->dcr_splb_slave_if = tft_access;
+
+	/* Arguments are passed based on the interface */
+	if (drvdata->dcr_splb_slave_if == 1) {
+		return xilinxfb_assign(&op->dev, drvdata, res.start, &pdata);
+	} else {
+		drvdata->dcr_start = start;
+		drvdata->dcr_len = len;
+		drvdata->dcr_host = dcr_host;
+		return xilinxfb_assign(&op->dev, drvdata, 0, &pdata);
+	}
 }
 
 static int __devexit xilinxfb_of_remove(struct of_device *op)
@@ -395,6 +503,7 @@ static int __devexit xilinxfb_of_remove(struct of_device *op)
 
 /* Match table for of_platform binding */
 static struct of_device_id xilinxfb_of_match[] __devinitdata = {
+	{ .compatible = "xlnx,xps-tft-1.00.a", },
 	{ .compatible = "xlnx,plb-tft-cntlr-ref-1.00.a", },
 	{ .compatible = "xlnx,plb-dvi-cntlr-ref-1.00.c", },
 	{},
@@ -412,22 +521,6 @@ static struct of_platform_driver xilinxfb_of_driver = {
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
@@ -436,18 +529,18 @@ static inline void __exit xilinxfb_of_unregister(void) { }
 static int __init
 xilinxfb_init(void)
 {
-	return xilinxfb_of_register();
+	return of_register_platform_driver(&xilinxfb_of_driver);
 }
 
 static void __exit
 xilinxfb_cleanup(void)
 {
-	xilinxfb_of_unregister();
+	of_unregister_platform_driver(&xilinxfb_of_driver);
 }
 
 module_init(xilinxfb_init);
 module_exit(xilinxfb_cleanup);
 
-MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
-MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_AUTHOR("Xilinx Inc.");
+MODULE_DESCRIPTION("Xilinx TFT frame buffer driver");
 MODULE_LICENSE("GPL");
-- 
1.6.2.1


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

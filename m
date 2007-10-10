Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 93375DDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:32:08 +1000 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00ILPKT0JF60@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:48 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP0014QKSZ5V30@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:31:48 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP003KGKSYY8G0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:46 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:31:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/3] Xilinxfb: Add support for custom screen resolution
In-reply-to: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
To: linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com,
	linuxppc-dev@ozlabs.org, adaplas@gmail.com, jwboyer@linux.vnet.ibm.com
Message-id: <20071010183151.12852.71310.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Some custom implementations of the xilinx fb can use resolutions other
than 640x480.  This patch allows the resolution to be specified in the
device tree or the xilinx_platform_data structure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   71 +++++++++++++++++++++++++++++-----------------
 include/linux/xilinxfb.h |    6 +++-
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index b3b57f4..c617412 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -70,12 +70,6 @@
  */
 #define BYTES_PER_PIXEL	4
 #define BITS_PER_PIXEL	(BYTES_PER_PIXEL * 8)
-#define XRES		640
-#define YRES		480
-#define XRES_VIRTUAL	1024
-#define YRES_VIRTUAL	YRES
-#define LINE_LENGTH	(XRES_VIRTUAL * BYTES_PER_PIXEL)
-#define FB_SIZE		(YRES_VIRTUAL * LINE_LENGTH)
 
 #define RED_SHIFT	16
 #define GREEN_SHIFT	8
@@ -87,6 +81,10 @@
  * Default xilinxfb configuration
  */
 static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
+	.xres = 640,
+	.yres = 480,
+	.xvirt = 1024,
+	.yvirt = 480;
 };
 
 /*
@@ -96,17 +94,10 @@ static struct fb_fix_screeninfo xilinx_fb_fix = {
 	.id =		"Xilinx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
-	.smem_len =	FB_SIZE,
-	.line_length =	LINE_LENGTH,
 	.accel =	FB_ACCEL_NONE
 };
 
 static struct fb_var_screeninfo xilinx_fb_var = {
-	.xres =			XRES,
-	.yres =			YRES,
-	.xres_virtual =		XRES_VIRTUAL,
-	.yres_virtual =		YRES_VIRTUAL,
-
 	.bits_per_pixel =	BITS_PER_PIXEL,
 
 	.red =		{ RED_SHIFT, 8, 0 },
@@ -217,6 +208,7 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 {
 	struct xilinxfb_drvdata *drvdata;
 	int rc;
+	int fbsize = pdata->xvirt * pdata->yvirt * BYTES_PER_PIXEL;
 
 	/* Allocate the driver data region */
 	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
@@ -243,7 +235,7 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	}
 
 	/* Allocate the framebuffer memory */
-	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
+	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
 				&drvdata->fb_phys, GFP_KERNEL);
 	if (!drvdata->fb_virt) {
 		dev_err(dev, "Could not allocate frame buffer memory\n");
@@ -252,7 +244,7 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	}
 
 	/* Clear (turn to black) the framebuffer */
-	memset_io((void __iomem *)drvdata->fb_virt, 0, FB_SIZE);
+	memset_io((void __iomem *)drvdata->fb_virt, 0, fbsize);
 
 	/* Tell the hardware where the frame buffer is */
 	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
@@ -269,12 +261,18 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	drvdata->info.fbops = &xilinxfb_ops;
 	drvdata->info.fix = xilinx_fb_fix;
 	drvdata->info.fix.smem_start = drvdata->fb_phys;
+	drvdata->info.fix.smem_len = fbsize;
+	drvdata->info.fix.line_length = pdata->xvirt * BYTES_PER_PIXEL;
+
 	drvdata->info.pseudo_palette = drvdata->pseudo_palette;
 	drvdata->info.flags = FBINFO_DEFAULT;
 	drvdata->info.var = xilinx_fb_var;
-
-	xilinx_fb_var.height = pdata->screen_height_mm;
-	xilinx_fb_var.width = pdata->screen_width_mm;
+	drvdata->info.var.height = pdata->screen_height_mm;
+	drvdata->info.var.width = pdata->screen_width_mm;
+	drvdata->info.var.xres = pdata->xres;
+	drvdata->info.var.yres = pdata->yres;
+	drvdata->info.var.xres_virtual = pdata->xvirt;
+	drvdata->info.var.yres_virtual = pdata->yvirt;
 
 	/* Allocate a colour map */
 	rc = fb_alloc_cmap(&drvdata->info.cmap, PALETTE_ENTRIES_NO, 0);
@@ -294,14 +292,15 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	/* Put a banner in the log (for DEBUG) */
 	dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr, drvdata->regs);
 	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
-		(void*)drvdata->fb_phys, drvdata->fb_virt, FB_SIZE);
+		(void*)drvdata->fb_phys, drvdata->fb_virt, fbsize);
+
 	return 0;	/* success */
 
 err_regfb:
 	fb_dealloc_cmap(&drvdata->info.cmap);
 
 err_cmap:
-	dma_free_coherent(dev, PAGE_ALIGN(FB_SIZE), drvdata->fb_virt,
+	dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
 		drvdata->fb_phys);
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
@@ -331,8 +330,8 @@ static int xilinxfb_release(struct device *dev)
 
 	fb_dealloc_cmap(&drvdata->info.cmap);
 
-	dma_free_coherent(dev, PAGE_ALIGN(FB_SIZE), drvdata->fb_virt,
-		drvdata->fb_phys);
+	dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
+			  drvdata->fb_virt, drvdata->fb_phys);
 
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
@@ -364,10 +363,18 @@ xilinxfb_platform_probe(struct platform_device *pdev)
 	}
 
 	/* If a pdata structure is provided, then extract the parameters */
-	if (pdev->dev.platform_data)
+	pdata = &xilinx_fb_default_pdata;
+	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
-	else
-		pdata = &xilinx_fb_default_pdata;
+		if (!pdata->xres)
+			pdata->xres = xilinx_fb_default_pdata.xres;
+		if (!pdata->yres)
+			pdata->yres = xilinx_fb_default_pdata.yres;
+		if (!pdata->xvirt)
+			pdata->xvirt = xilinx_fb_default_pdata.xvirt;
+		if (!pdata->yvirt)
+			pdata->yvirt = xilinx_fb_default_pdata.yvirt;
+	}
 
 	return xilinxfb_assign(&pdev->dev, res->start, pdata);
 }
@@ -412,12 +419,24 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 		return rc;
 	}
 
-	prop = of_get_property(op->node, "display-number", &size);
+	prop = of_get_property(op->node, "phys-size", &size);
 	if ((prop) && (size >= sizeof(u32)*2)) {
 		pdata.screen_width_mm = prop[0];
 		pdata.screen_height_mm = prop[1];
 	}
 
+	prop = of_get_property(op->node, "resolution", &size);
+	if ((prop) && (size >= sizeof(u32)*2)) {
+		pdata.xres = prop[0];
+		pdata.yres = prop[1];
+	}
+
+	prop = of_get_property(op->node, "virtual-resolution", &size);
+	if ((prop) && (size >= sizeof(u32)*2)) {
+		pdata.xvirt = prop[0];
+		pdata.yvirt = prop[1];
+	}
+
 	if (of_find_property(op->node, "rotate-display", NULL))
 		pdata.rotate_screen = 1;
 
diff --git a/include/linux/xilinxfb.h b/include/linux/xilinxfb.h
index 9ad984d..199a1ee 100644
--- a/include/linux/xilinxfb.h
+++ b/include/linux/xilinxfb.h
@@ -15,9 +15,11 @@
 
 /* ML300/403 reference design framebuffer driver platform data struct */
 struct xilinxfb_platform_data {
-	u32 rotate_screen;
-	u32 screen_height_mm;
+	u32 rotate_screen;	/* Flag to rotate display 180 degrees */
+	u32 screen_height_mm;	/* Physical dimentions of screen in mm */
 	u32 screen_width_mm;
+	u32 xres, yres;		/* resolution of screen in pixels */
+	u32 xvirt, yvirt;	/* resolution of memory buffer */
 };
 
 #endif  /* __XILINXFB_H__ */

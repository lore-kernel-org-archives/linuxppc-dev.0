Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 23F76DE4B1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:33:17 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP00567KTACPD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:58 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP009KNKT9KT50@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:31:58 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00C83KST8K51@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:41 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:31:46 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/3] XilinxFB: use pdata to pass around framebuffer parameters.
In-reply-to: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
To: linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com,
	linuxppc-dev@ozlabs.org, adaplas@gmail.com, jwboyer@linux.vnet.ibm.com
Message-id: <20071010183146.12852.73383.stgit@trillian.cg.shawcable.net>
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

The call to xilinxfb_assign is getting unwieldy when adding features
to the Xilinx framebuffer driver.  Change xilinxfb_assign() to accept
a pointer to a xilinxfb_platform_data structure to prepare for adding
additition configuration options.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   43 +++++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index dec602c..b3b57f4 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -84,6 +84,12 @@
 #define PALETTE_ENTRIES_NO	16	/* passed to fb_alloc_cmap() */
 
 /*
+ * Default xilinxfb configuration
+ */
+static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
+};
+
+/*
  * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
  */
 static struct fb_fix_screeninfo xilinx_fb_fix = {
@@ -207,7 +213,7 @@ static struct fb_ops xilinxfb_ops =
  */
 
 static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
-			   int width_mm, int height_mm, int rotate)
+			   struct xilinxfb_platform_data *pdata)
 {
 	struct xilinxfb_drvdata *drvdata;
 	int rc;
@@ -253,7 +259,7 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 
 	/* Turn on the display */
 	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
-	if (rotate)
+	if (pdata->rotate_screen)
 		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
 	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
 
@@ -267,8 +273,8 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	drvdata->info.flags = FBINFO_DEFAULT;
 	drvdata->info.var = xilinx_fb_var;
 
-	xilinx_fb_var.height = height_mm;
-	xilinx_fb_var.width = width_mm;
+	xilinx_fb_var.height = pdata->screen_height_mm;
+	xilinx_fb_var.width = pdata->screen_width_mm;
 
 	/* Allocate a colour map */
 	rc = fb_alloc_cmap(&drvdata->info.cmap, PALETTE_ENTRIES_NO, 0);
@@ -349,9 +355,6 @@ xilinxfb_platform_probe(struct platform_device *pdev)
 {
 	struct xilinxfb_platform_data *pdata;
 	struct resource *res;
-	int width_mm = 0;
-	int height_mm = 0;
-	int rotate = 0;
 
 	/* Find the registers address */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -361,15 +364,12 @@ xilinxfb_platform_probe(struct platform_device *pdev)
 	}
 
 	/* If a pdata structure is provided, then extract the parameters */
-	pdata = pdev->dev.platform_data;
-	if (pdata) {
-		height_mm = pdata->screen_height_mm;
-		width_mm = pdata->screen_width_mm;
-		rotate = pdata->rotate_screen ? 1 : 0;
-	}
+	if (pdev->dev.platform_data)
+		pdata = pdev->dev.platform_data;
+	else
+		pdata = &xilinx_fb_default_pdata;
 
-	return xilinxfb_assign(&pdev->dev, res->start, width_mm, height_mm,
-			       rotate);
+	return xilinxfb_assign(&pdev->dev, res->start, pdata);
 }
 
 static int
@@ -398,9 +398,12 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct resource res;
 	const u32 *prop;
-	int width = 0, height = 0, rotate = 0;
+	struct xilinxfb_platform_data pdata;
 	int size, rc;
 
+	/* Copy with the default pdata (not a ptr reference!) */
+	pdata = xilinx_fb_default_pdata;
+
 	dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match);
 
 	rc = of_address_to_resource(op->node, 0, &res);
@@ -411,14 +414,14 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	prop = of_get_property(op->node, "display-number", &size);
 	if ((prop) && (size >= sizeof(u32)*2)) {
-		width = prop[0];
-		height = prop[1];
+		pdata.screen_width_mm = prop[0];
+		pdata.screen_height_mm = prop[1];
 	}
 
 	if (of_find_property(op->node, "rotate-display", NULL))
-		rotate = 1;
+		pdata.rotate_screen = 1;
 
-	return xilinxfb_assign(&op->dev, res.start, width, height, rotate);
+	return xilinxfb_assign(&op->dev, res.start, &pdata);
 }
 
 static int __devexit xilinxfb_of_remove(struct of_device *op)

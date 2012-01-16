Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
Subject: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Date: Mon, 16 Jan 2012 11:29:48 +1100
Message-ID: <19504.1326673788@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a bunch of compiler errors and warnings introduced in:
  commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
  Author: Timur Tabi <timur@freescale.com>
  drivers/video: fsl-diu-fb: merge all allocated data into one block

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Timur: you do compile test your patches, right? :-P

This is effecting mpc85xx_defconfig on mainline (and has been in
linux-next for while already).

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index acf292b..78cac52 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -366,7 +366,7 @@ struct mfb_info {
  */
 struct fsl_diu_data {
 	dma_addr_t dma_addr;
-	struct fb_info fsl_diu_info[NUM_AOIS];
+	struct fb_info *fsl_diu_info[NUM_AOIS];
 	struct mfb_info mfb[NUM_AOIS];
 	struct device_attribute dev_attr;
 	unsigned int irq;
@@ -608,8 +608,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 	int lower_aoi_is_open, upper_aoi_is_open;
 	__u32 base_plane_width, base_plane_height, upper_aoi_height;
 
-	base_plane_width = data->fsl_diu_info[0].var.xres;
-	base_plane_height = data->fsl_diu_info[0].var.yres;
+	base_plane_width = data->fsl_diu_info[0]->var.xres;
+	base_plane_height = data->fsl_diu_info[0]->var.yres;
 
 	if (mfbi->x_aoi_d < 0)
 		mfbi->x_aoi_d = 0;
@@ -624,7 +624,7 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI0:
 	case PLANE2_AOI0:
-		lower_aoi_mfbi = data->fsl_diu_info[index+1].par;
+		lower_aoi_mfbi = data->fsl_diu_info[index+1]->par;
 		lower_aoi_is_open = lower_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
 			var->xres = base_plane_width;
@@ -642,8 +642,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		break;
 	case PLANE1_AOI1:
 	case PLANE2_AOI1:
-		upper_aoi_mfbi = data->fsl_diu_info[index-1].par;
-		upper_aoi_height = data->fsl_diu_info[index-1].var.yres;
+		upper_aoi_mfbi = data->fsl_diu_info[index-1]->par;
+		upper_aoi_height = data->fsl_diu_info[index-1]->var.yres;
 		upper_aoi_bottom = upper_aoi_mfbi->y_aoi_d + upper_aoi_height;
 		upper_aoi_is_open = upper_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
@@ -1469,7 +1469,7 @@ static ssize_t store_monitor(struct device *device,
 		unsigned int i;
 
 		for (i=0; i < NUM_AOIS; i++)
-			fsl_diu_set_par(&data->fsl_diu_info[i]);
+			fsl_diu_set_par(data->fsl_diu_info[i]);
 	}
 	return count;
 }
@@ -1524,7 +1524,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	spin_lock_init(&data->reg_lock);
 
 	for (i = 0; i < NUM_AOIS; i++) {
-		struct fb_info *info = &data->fsl_diu_info[i];
+		struct fb_info *info = data->fsl_diu_info[i];
 
 		info->device = &pdev->dev;
 		info->par = &data->mfb[i];
@@ -1597,7 +1597,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	out_be32(&data->diu_reg->desc[2], data->dummy_ad.paddr);
 
 	for (i = 0; i < NUM_AOIS; i++) {
-		ret = install_fb(&data->fsl_diu_info[i]);
+		ret = install_fb(data->fsl_diu_info[i]);
 		if (ret) {
 			dev_err(&pdev->dev, "could not register fb %d\n", i);
 			goto error;
@@ -1625,7 +1625,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 
 error:
 	for (i = 0; i < NUM_AOIS; i++)
-		uninstall_fb(&data->fsl_diu_info[i]);
+		uninstall_fb(data->fsl_diu_info[i]);
 
 	iounmap(data->diu_reg);
 
@@ -1641,11 +1641,11 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
-	disable_lcdc(&data->fsl_diu_info[0]);
+	disable_lcdc(data->fsl_diu_info[0]);
 	free_irq_local(data);
 
 	for (i = 0; i < NUM_AOIS; i++)
-		uninstall_fb(&data->fsl_diu_info[i]);
+		uninstall_fb(data->fsl_diu_info[i]);
 
 	iounmap(data->diu_reg);
 

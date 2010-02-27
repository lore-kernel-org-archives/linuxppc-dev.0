Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 74194B813A
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 08:59:49 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] fbdev: fsl-diu-fb.c: allow setting panel video mode from
	DT
Date: Sat, 27 Feb 2010 22:58:21 +0100
Message-Id: <1267307902-31939-3-git-send-email-agust@denx.de>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for specifying display panel data in the device
tree. If no panel data is provided in the device tree, default
video mode will be used as usual.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/Kconfig      |    1 +
 drivers/video/fsl-diu-fb.c |   63 +++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index dc1beb0..c805ecd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1850,6 +1850,7 @@ config FB_FSL_DIU
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select PPC_LIB_RHEAP
+	select FB_OF_MODE
 	---help---
 	  Framebuffer driver for the Freescale SoC DIU
 
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 4637bcb..19ca1da 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -36,6 +36,8 @@
 #include <sysdev/fsl_soc.h>
 #include "fsl-diu-fb.h"
 
+#include "ofmode.h"
+
 /*
  * These parameters give default parameters
  * for video output 1024x768,
@@ -1168,7 +1170,7 @@ static int init_fbinfo(struct fb_info *info)
 	return 0;
 }
 
-static int __devinit install_fb(struct fb_info *info)
+static int __devinit install_fb(struct device_node *np, struct fb_info *info)
 {
 	int rc;
 	struct mfb_info *mfbi = info->par;
@@ -1177,33 +1179,40 @@ static int __devinit install_fb(struct fb_info *info)
 	if (init_fbinfo(info))
 		return -EINVAL;
 
-	if (mfbi->index == 0)	/* plane 0 */
-		aoi_mode = fb_mode;
-	else
+	if (mfbi->index == 0) {	/* plane 0 */
+		/* use default mode for plane0 if there is no mode in DTB */
+		if (of_get_video_mode(np, info) < 0)
+			aoi_mode = fb_mode;
+		else
+			aoi_mode = NULL;
+	} else
 		aoi_mode = init_aoi_mode;
-	pr_debug("mode used = %s\n", aoi_mode);
-	rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
-	     ARRAY_SIZE(fsl_diu_mode_db), &fsl_diu_default_mode, default_bpp);
 
-	switch (rc) {
-	case 1:
-		pr_debug("using mode specified in @mode\n");
-		break;
-	case 2:
-		pr_debug("using mode specified in @mode "
-			"with ignored refresh rate\n");
-		break;
-	case 3:
-		pr_debug("using mode default mode\n");
-		break;
-	case 4:
-		pr_debug("using mode from list\n");
-		break;
-	default:
-		pr_debug("rc = %d\n", rc);
-		pr_debug("failed to find mode\n");
-		return -EINVAL;
-		break;
+	if (aoi_mode) {
+		pr_debug("mode used = %s\n", aoi_mode);
+		rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
+				  ARRAY_SIZE(fsl_diu_mode_db),
+				  &fsl_diu_default_mode, default_bpp);
+		switch (rc) {
+		case 1:
+			pr_debug("using mode specified in @mode\n");
+			break;
+		case 2:
+			pr_debug("using mode specified in @mode "
+				"with ignored refresh rate\n");
+			break;
+		case 3:
+			pr_debug("using mode default mode\n");
+			break;
+		case 4:
+			pr_debug("using mode from list\n");
+			break;
+		default:
+			pr_debug("rc = %d\n", rc);
+			pr_debug("failed to find mode\n");
+			return -EINVAL;
+			break;
+		}
 	}
 
 	pr_debug("xres_virtual %d\n", info->var.xres_virtual);
@@ -1521,7 +1530,7 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 		mfbi->ad = (struct diu_ad *)((u32)pool.ad.vaddr
 					+ pool.ad.offset) + i;
 		mfbi->ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
-		ret = install_fb(machine_data->fsl_diu_info[i]);
+		ret = install_fb(np, machine_data->fsl_diu_info[i]);
 		if (ret) {
 			dev_err(&ofdev->dev,
 				"Failed to register framebuffer %d\n",
-- 
1.6.3.3

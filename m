Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C3BA5B7D1C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 18:09:21 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 5/5] fsl-diu-fb: Support setting display mode using EDID
Date: Fri, 30 Apr 2010 10:09:19 +0200
Message-Id: <1272614959-22734-1-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-6-git-send-email-agust@denx.de>
References: <1272584978-19063-6-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for encoding display mode information
in the device tree using verbatim EDID block.

If the EDID entry in the DIU node is present, the
driver will build mode database using EDID data
and allow setting the display modes from this database.
Otherwise display mode will be set using mode
entries from driver's internal database as usual.

This patch also updates device tree bindings.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v1 -> v2:
 - fix EDID property to be lower-case
 - use u8 * type for EDID block pointer
 - simplify "info->monspecs.modedb != NULL" condition test

 Documentation/powerpc/dts-bindings/fsl/diu.txt |    6 ++
 drivers/video/Kconfig                          |    1 +
 drivers/video/fsl-diu-fb.c                     |   80 ++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/diu.txt b/Documentation/powerpc/dts-bindings/fsl/diu.txt
index 326cddf..47e777e 100644
--- a/Documentation/powerpc/dts-bindings/fsl/diu.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/diu.txt
@@ -11,6 +11,11 @@ Required properties:
 - interrupt-parent : the phandle for the interrupt controller that
   services interrupts for this device.
 
+Optional properties:
+- edid : verbatim EDID data block describing attached display.
+  Data from the detailed timing descriptor will be used to
+  program the display controller.
+
 Example (MPC8610HPCD):
 	display@2c000 {
 		compatible = "fsl,diu";
@@ -25,4 +30,5 @@ Example for MPC5121:
 		reg = <0x2100 0x100>;
 		interrupts = <64 0x8>;
 		interrupt-parent = <&ipic>;
+		edid = [edid-data];
 	};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6e16244..eca1e49 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1855,6 +1855,7 @@ config FB_MBX_DEBUG
 config FB_FSL_DIU
 	tristate "Freescale DIU framebuffer support"
 	depends on FB && FSL_SOC
+	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 81dec09..2b99f29 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -35,6 +35,7 @@
 
 #include <sysdev/fsl_soc.h>
 #include <linux/fsl-diu-fb.h>
+#include "edid.h"
 
 /*
  * These parameters give default parameters
@@ -217,6 +218,7 @@ struct mfb_info {
 	int x_aoi_d;		/* aoi display x offset to physical screen */
 	int y_aoi_d;		/* aoi display y offset to physical screen */
 	struct fsl_diu_data *parent;
+	u8 *edid_data;
 };
 
 
@@ -1180,18 +1182,30 @@ static int __devinit install_fb(struct fb_info *info)
 	int rc;
 	struct mfb_info *mfbi = info->par;
 	const char *aoi_mode, *init_aoi_mode = "320x240";
+	struct fb_videomode *db = fsl_diu_mode_db;
+	unsigned int dbsize = ARRAY_SIZE(fsl_diu_mode_db);
+	int has_default_mode = 1;
 
 	if (init_fbinfo(info))
 		return -EINVAL;
 
-	if (mfbi->index == 0)	/* plane 0 */
+	if (mfbi->index == 0) {	/* plane 0 */
+		if (mfbi->edid_data) {
+			/* Now build modedb from EDID */
+			fb_edid_to_monspecs(mfbi->edid_data, &info->monspecs);
+			fb_videomode_to_modelist(info->monspecs.modedb,
+						 info->monspecs.modedb_len,
+						 &info->modelist);
+			db = info->monspecs.modedb;
+			dbsize = info->monspecs.modedb_len;
+		}
 		aoi_mode = fb_mode;
-	else
+	} else {
 		aoi_mode = init_aoi_mode;
+	}
 	pr_debug("mode used = %s\n", aoi_mode);
-	rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
-	     ARRAY_SIZE(fsl_diu_mode_db), &fsl_diu_default_mode, default_bpp);
-
+	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize,
+			  &fsl_diu_default_mode, default_bpp);
 	switch (rc) {
 	case 1:
 		pr_debug("using mode specified in @mode\n");
@@ -1209,10 +1223,50 @@ static int __devinit install_fb(struct fb_info *info)
 	default:
 		pr_debug("rc = %d\n", rc);
 		pr_debug("failed to find mode\n");
-		return -EINVAL;
+		/*
+		 * For plane 0 we continue and look into
+		 * driver's internal modedb.
+		 */
+		if (mfbi->index == 0 && mfbi->edid_data)
+			has_default_mode = 0;
+		else
+			return -EINVAL;
 		break;
 	}
 
+	if (!has_default_mode) {
+		rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
+				  ARRAY_SIZE(fsl_diu_mode_db),
+				  &fsl_diu_default_mode,
+				  default_bpp);
+		if (rc > 0 && rc < 5)
+			has_default_mode = 1;
+	}
+
+	/* Still not found, use preferred mode from database if any */
+	if (!has_default_mode && info->monspecs.modedb) {
+		struct fb_monspecs *specs = &info->monspecs;
+		struct fb_videomode *modedb = &specs->modedb[0];
+
+		/*
+		 * Get preferred timing. If not found,
+		 * first mode in database will be used.
+		 */
+		if (specs->misc & FB_MISC_1ST_DETAIL) {
+			int i;
+
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
+					modedb = &specs->modedb[i];
+					break;
+				}
+			}
+		}
+
+		info->var.bits_per_pixel = default_bpp;
+		fb_videomode_to_var(&info->var, modedb);
+	}
+
 	pr_debug("xres_virtual %d\n", info->var.xres_virtual);
 	pr_debug("bits_per_pixel %d\n", info->var.bits_per_pixel);
 
@@ -1251,6 +1305,9 @@ static void uninstall_fb(struct fb_info *info)
 	if (!mfbi->registered)
 		return;
 
+	if (mfbi->index == 0)
+		kfree(mfbi->edid_data);
+
 	unregister_framebuffer(info);
 	unmap_video_memory(info);
 	if (&info->cmap)
@@ -1451,6 +1508,17 @@ static int __devinit fsl_diu_probe(struct of_device *ofdev,
 		mfbi = machine_data->fsl_diu_info[i]->par;
 		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
 		mfbi->parent = machine_data;
+
+		if (mfbi->index == 0) {
+			const u8 *prop;
+			int len;
+
+			/* Get EDID */
+			prop = of_get_property(np, "edid", &len);
+			if (prop && len == EDID_LENGTH)
+				mfbi->edid_data = kmemdup(prop, EDID_LENGTH,
+							  GFP_KERNEL);
+		}
 	}
 
 	ret = of_address_to_resource(np, 0, &res);
-- 
1.6.3.3

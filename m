Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FA0EB6F8A
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 07:29:03 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <lethal@linux-sh.org>, <linux-fbdev@vger.kernel.org>, <agust@denx.de>,
	<yorksun@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] fsl-diu-fb: remove the ioctl interface
Date: Tue, 21 Jun 2011 16:27:35 -0500
Message-ID: <1308691655-3416-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ioctl interface in the Freescale DIU framebuffer driver is just a
collection of miscellaneous functions which were only used in a one-time
demo application that was never distributed.  Plus, the ioctls were spread
across two types (both conflicting), and the demo app didn't even use all
of them.

Removing the ioctl interface also allows us to clean up the header file and
remove other unusued stuff.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

There's a warning about dummy_ad_addr that will be fixed in a future patch.

 Documentation/ioctl/ioctl-number.txt |    2 -
 drivers/video/fsl-diu-fb.c           |  157 ++++++++++------------------------
 include/linux/fsl-diu-fb.h           |   94 --------------------
 3 files changed, 44 insertions(+), 209 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 3a46e36..6c83c07 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -108,7 +108,6 @@ Code  Seq#(hex)	Include File		Comments
 'E'	00-0F	xen/evtchn.h		conflict!
 'F'	all	linux/fb.h		conflict!
 'F'	01-02	drivers/scsi/pmcraid.h	conflict!
-'F'	20	drivers/video/fsl-diu-fb.h	conflict!
 'F'	20	drivers/video/intelfb/intelfb.h	conflict!
 'F'	20	linux/ivtvfb.h		conflict!
 'F'	20	linux/matroxfb.h	conflict!
@@ -147,7 +146,6 @@ Code  Seq#(hex)	Include File		Comments
 'M'	01-16	mtd/mtd-abi.h		conflict!
 		and drivers/mtd/mtdchar.c
 'M'	01-03	drivers/scsi/megaraid/megaraid_sas.h
-'M'	00-0F	drivers/video/fsl-diu-fb.h	conflict!
 'N'	00-1F	drivers/usb/scanner.h
 'O'     00-06   mtd/ubi-user.h		UBI
 'P'	all	linux/soundcard.h	conflict!
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index bedf5be..db2abaf 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -37,6 +37,50 @@
 #include <linux/fsl-diu-fb.h>
 #include "edid.h"
 
+/* Minimum value that the pixel clock can be set to in pico seconds
+ * This is determined by platform clock/3 where the minimum platform
+ * clock is 533MHz. This gives 5629 pico seconds.
+ */
+#define MIN_PIX_CLK	5629
+#define MAX_PIX_CLK	96096
+
+#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
+
+/* INT_STATUS/INT_MASK field descriptions */
+#define INT_VSYNC	0x01	/* Vsync interrupt  */
+#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
+#define INT_UNDRUN	0x04	/* Under run exception interrupt */
+#define INT_PARERR	0x08	/* Display parameters error interrupt */
+#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
+
+/* Panels'operation modes */
+#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
+#define MFB_TYPE_OFF	1	/* Panel off */
+#define MFB_TYPE_WB	2	/* Panel written back to memory */
+#define MFB_TYPE_TEST	3	/* Panel generate color bar */
+
+/* HW cursor parameters */
+#define MAX_CURS	32
+
+struct diu_hw {
+	struct diu *diu_reg;
+	spinlock_t reg_lock;
+	__u32 mode;		/* DIU operation mode */
+};
+
+struct diu_addr {
+	__u8 __iomem *vaddr;	/* Virtual address */
+	dma_addr_t paddr;	/* Physical address */
+	__u32 offset;
+};
+
+struct diu_pool {
+	struct diu_addr ad;
+	struct diu_addr gamma;
+	struct diu_addr pallete;
+	struct diu_addr cursor;
+};
+
 /*
  * These parameters give default parameters
  * for video output 1024x768,
@@ -991,118 +1035,6 @@ static int fsl_diu_blank(int blank_mode, struct fb_info *info)
 	return 0;
 }
 
-static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
-		       unsigned long arg)
-{
-	struct mfb_info *mfbi = info->par;
-	struct diu_ad *ad = mfbi->ad;
-	struct mfb_chroma_key ck;
-	unsigned char global_alpha;
-	struct aoi_display_offset aoi_d;
-	__u32 pix_fmt;
-	void __user *buf = (void __user *)arg;
-
-	if (!arg)
-		return -EINVAL;
-	switch (cmd) {
-	case MFB_SET_PIXFMT:
-		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
-			return -EFAULT;
-		ad->pix_fmt = pix_fmt;
-		pr_debug("Set pixel format to 0x%08x\n", ad->pix_fmt);
-		break;
-	case MFB_GET_PIXFMT:
-		pix_fmt = ad->pix_fmt;
-		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
-			return -EFAULT;
-		pr_debug("get pixel format 0x%08x\n", ad->pix_fmt);
-		break;
-	case MFB_SET_AOID:
-		if (copy_from_user(&aoi_d, buf, sizeof(aoi_d)))
-			return -EFAULT;
-		mfbi->x_aoi_d = aoi_d.x_aoi_d;
-		mfbi->y_aoi_d = aoi_d.y_aoi_d;
-		pr_debug("set AOI display offset of index %d to (%d,%d)\n",
-				 mfbi->index, aoi_d.x_aoi_d, aoi_d.y_aoi_d);
-		fsl_diu_check_var(&info->var, info);
-		fsl_diu_set_aoi(info);
-		break;
-	case MFB_GET_AOID:
-		aoi_d.x_aoi_d = mfbi->x_aoi_d;
-		aoi_d.y_aoi_d = mfbi->y_aoi_d;
-		if (copy_to_user(buf, &aoi_d, sizeof(aoi_d)))
-			return -EFAULT;
-		pr_debug("get AOI display offset of index %d (%d,%d)\n",
-				mfbi->index, aoi_d.x_aoi_d, aoi_d.y_aoi_d);
-		break;
-	case MFB_GET_ALPHA:
-		global_alpha = mfbi->g_alpha;
-		if (copy_to_user(buf, &global_alpha, sizeof(global_alpha)))
-			return -EFAULT;
-		pr_debug("get global alpha of index %d\n", mfbi->index);
-		break;
-	case MFB_SET_ALPHA:
-		/* set panel information */
-		if (copy_from_user(&global_alpha, buf, sizeof(global_alpha)))
-			return -EFAULT;
-		ad->src_size_g_alpha = (ad->src_size_g_alpha & (~0xff)) |
-							(global_alpha & 0xff);
-		mfbi->g_alpha = global_alpha;
-		pr_debug("set global alpha for index %d\n", mfbi->index);
-		break;
-	case MFB_SET_CHROMA_KEY:
-		/* set panel winformation */
-		if (copy_from_user(&ck, buf, sizeof(ck)))
-			return -EFAULT;
-
-		if (ck.enable &&
-		   (ck.red_max < ck.red_min ||
-		    ck.green_max < ck.green_min ||
-		    ck.blue_max < ck.blue_min))
-			return -EINVAL;
-
-		if (!ck.enable) {
-			ad->ckmax_r = 0;
-			ad->ckmax_g = 0;
-			ad->ckmax_b = 0;
-			ad->ckmin_r = 255;
-			ad->ckmin_g = 255;
-			ad->ckmin_b = 255;
-		} else {
-			ad->ckmax_r = ck.red_max;
-			ad->ckmax_g = ck.green_max;
-			ad->ckmax_b = ck.blue_max;
-			ad->ckmin_r = ck.red_min;
-			ad->ckmin_g = ck.green_min;
-			ad->ckmin_b = ck.blue_min;
-		}
-		pr_debug("set chroma key\n");
-		break;
-	case FBIOGET_GWINFO:
-		if (mfbi->type == MFB_TYPE_OFF)
-			return -ENODEV;
-		/* get graphic window information */
-		if (copy_to_user(buf, ad, sizeof(*ad)))
-			return -EFAULT;
-		break;
-	case FBIOGET_HWCINFO:
-		pr_debug("FBIOGET_HWCINFO:0x%08x\n", FBIOGET_HWCINFO);
-		break;
-	case FBIOPUT_MODEINFO:
-		pr_debug("FBIOPUT_MODEINFO:0x%08x\n", FBIOPUT_MODEINFO);
-		break;
-	case FBIOGET_DISPINFO:
-		pr_debug("FBIOGET_DISPINFO:0x%08x\n", FBIOGET_DISPINFO);
-		break;
-
-	default:
-		printk(KERN_ERR "Unknown ioctl command (0x%08X)\n", cmd);
-		return -ENOIOCTLCMD;
-	}
-
-	return 0;
-}
-
 /* turn on fb if count == 1
  */
 static int fsl_diu_open(struct fb_info *info, int user)
@@ -1162,7 +1094,6 @@ static struct fb_ops fsl_diu_ops = {
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_ioctl = fsl_diu_ioctl,
 	.fb_open = fsl_diu_open,
 	.fb_release = fsl_diu_release,
 };
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index 781d467..234c38e 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -20,55 +20,8 @@
 #ifndef __FSL_DIU_FB_H__
 #define __FSL_DIU_FB_H__
 
-/* Arbitrary threshold to determine the allocation method
- * See mpc8610fb_set_par(), map_video_memory(), and unmap_video_memory()
- */
-#define MEM_ALLOC_THRESHOLD (1024*768*4+32)
-/* Minimum value that the pixel clock can be set to in pico seconds
- * This is determined by platform clock/3 where the minimum platform
- * clock is 533MHz. This gives 5629 pico seconds.
- */
-#define MIN_PIX_CLK 5629
-#define MAX_PIX_CLK 96096
-
 #include <linux/types.h>
 
-struct mfb_alpha {
-	int enable;
-	int alpha;
-};
-
-struct mfb_chroma_key {
-	int enable;
-	__u8  red_max;
-	__u8  green_max;
-	__u8  blue_max;
-	__u8  red_min;
-	__u8  green_min;
-	__u8  blue_min;
-};
-
-struct aoi_display_offset {
-	int x_aoi_d;
-	int y_aoi_d;
-};
-
-#define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
-#define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
-
-#define MFB_SET_ALPHA		0x80014d00
-#define MFB_GET_ALPHA		0x40014d00
-#define MFB_SET_AOID		0x80084d04
-#define MFB_GET_AOID		0x40084d04
-#define MFB_SET_PIXFMT		0x80014d08
-#define MFB_GET_PIXFMT		0x40014d08
-
-#define FBIOGET_GWINFO		0x46E0
-#define FBIOPUT_GWINFO		0x46E1
-
-#ifdef __KERNEL__
-#include <linux/spinlock.h>
-
 /*
  * These are the fields of area descriptor(in DDR memory) for every plane
  */
@@ -165,39 +118,6 @@ struct diu {
 	__be32 plut;
 } __attribute__ ((packed));
 
-struct diu_hw {
-	struct diu *diu_reg;
-	spinlock_t reg_lock;
-
-	__u32 mode;		/* DIU operation mode */
-};
-
-struct diu_addr {
-	__u8 __iomem *vaddr;	/* Virtual address */
-	dma_addr_t paddr;	/* Physical address */
-	__u32 	   offset;
-};
-
-struct diu_pool {
-	struct diu_addr ad;
-	struct diu_addr gamma;
-	struct diu_addr pallete;
-	struct diu_addr cursor;
-};
-
-#define FSL_DIU_BASE_OFFSET	0x2C000	/* Offset of DIU */
-#define INT_LCDC		64	/* DIU interrupt number */
-
-#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
-				/* 1 for plane 0, 2 for plane 1&2 each */
-
-/* Minimum X and Y resolutions */
-#define MIN_XRES	64
-#define MIN_YRES	64
-
-/* HW cursor parameters */
-#define MAX_CURS		32
-
 /* Modes of operation of DIU */
 #define MFB_MODE0	0	/* DIU off */
 #define MFB_MODE1	1	/* All three planes output to display */
@@ -205,18 +125,4 @@ struct diu_pool {
 #define MFB_MODE3	3	/* All three planes written back to memory */
 #define MFB_MODE4	4	/* Color bar generation */
 
-/* INT_STATUS/INT_MASK field descriptions */
-#define INT_VSYNC	0x01	/* Vsync interrupt  */
-#define INT_VSYNC_WB	0x02	/* Vsync interrupt for write back operation */
-#define INT_UNDRUN	0x04	/* Under run exception interrupt */
-#define INT_PARERR	0x08	/* Display parameters error interrupt */
-#define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
-
-/* Panels'operation modes */
-#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
-#define MFB_TYPE_OFF	1	/* Panel off */
-#define MFB_TYPE_WB	2	/* Panel written back to memory */
-#define MFB_TYPE_TEST	3	/* Panel generate color bar */
-
-#endif /* __KERNEL__ */
 #endif /* __FSL_DIU_FB_H__ */
-- 
1.7.3.4

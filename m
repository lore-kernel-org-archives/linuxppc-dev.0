Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 17:48:35 +1100
Message-Id: <1134456515.6989.180.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix platinumfb for some modes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The platinumfb driver used only on some powermacs has an issue with some
video modes & limited VRAM. This patch fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/platinumfb.h
===================================================================
--- linux-work.orig/drivers/video/platinumfb.h	2005-09-22 14:07:19.000000000 +1000
+++ linux-work/drivers/video/platinumfb.h	2005-11-25 17:17:17.000000000 +1100
@@ -158,7 +158,9 @@
 /* 832x624, 75Hz (13) */
 static struct platinum_regvals platinum_reg_init_13 = {
 	0x70,
-	{ 864, 1680, 3360 },	/* MacOS does 1680 instead of 1696 to fit 16bpp in 1MB */
+	{ 864, 1680, 3344 },	/* MacOS does 1680 instead of 1696 to fit 16bpp in 1MB,
+				 * and we use 3344 instead of 3360 to fit in 2Mb
+				 */
 	{ 0xff0, 4, 0, 0, 0, 0, 0x299, 0,
 	  0, 0x21e, 0x120, 0x10, 0x23f, 0x1f, 0x25, 0x37,
 	  0x8a, 0x22a, 0x23e, 0x536, 0x534, 4, 9, 0x52,
Index: linux-work/drivers/video/platinumfb.c
===================================================================
--- linux-work.orig/drivers/video/platinumfb.c	2005-11-10 08:20:23.000000000 +1100
+++ linux-work/drivers/video/platinumfb.c	2005-11-25 17:17:17.000000000 +1100
@@ -138,13 +138,15 @@
 
 	init = platinum_reg_init[pinfo->vmode-1];
 	
-	if (pinfo->vmode == 13 && pinfo->cmode > 0)
-		offset = 0x10;
+ 	if ((pinfo->vmode == VMODE_832_624_75) && (pinfo->cmode > CMODE_8))
+  		offset = 0x10;
+
 	info->screen_base = pinfo->frame_buffer + init->fb_offset + offset;
 	info->fix.smem_start = (pinfo->frame_buffer_phys) + init->fb_offset + offset;
 	info->fix.visual = (pinfo->cmode == CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-	info->fix.line_length = vmode_attrs[pinfo->vmode-1].hres * (1<<pinfo->cmode) + offset;
+ 	info->fix.line_length = vmode_attrs[pinfo->vmode-1].hres * (1<<pinfo->cmode)
+		+ offset;
 	printk("line_length: %x\n", info->fix.line_length);
 	return 0;
 }
@@ -221,7 +223,9 @@
 static inline int platinum_vram_reqd(int video_mode, int color_mode)
 {
 	return vmode_attrs[video_mode-1].vres *
-	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) + 0x20) +0x1000;
+	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
+		((video_mode == VMODE_832_624_75) &&
+		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
 }
 
 #define STORE_D2(a, d) { \

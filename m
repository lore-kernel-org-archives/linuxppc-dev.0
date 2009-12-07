Return-Path: <airlied@gmail.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 98D8AB6F1B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Dec 2009 17:02:55 +1100 (EST)
From: Dave Airlie <airlied@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] offb: add support for framebuffer handoff to offb.
Date: Mon,  7 Dec 2009 16:01:26 +1000
Message-Id: <1260165686-29951-1-git-send-email-airlied@gmail.com>
Cc: Dave Airlie <airlied@ppcg5.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Airlie <airlied@ppcg5.localdomain>

This allows offb to be used for initial framebuffer,
and a kms driver to take over later in the boot sequence.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/video/offb.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 4d8c54c..b043ac8 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -282,8 +282,17 @@ static int offb_set_par(struct fb_info *info)
 	return 0;
 }
 
+static void offb_destroy(struct fb_info *info)
+{
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(info->aperture_base, info->aperture_size);
+	framebuffer_release(info);
+}
+
 static struct fb_ops offb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_destroy	= offb_destroy,
 	.fb_setcolreg	= offb_setcolreg,
 	.fb_set_par	= offb_set_par,
 	.fb_blank	= offb_blank,
@@ -482,10 +491,14 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 	var->sync = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
+	/* set offb aperture size for generic probing */
+	info->aperture_base = address;
+	info->aperture_size = fix->smem_len;
+
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->pseudo_palette = (void *) (info + 1);
-	info->flags = FBINFO_DEFAULT | foreign_endian;
+	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE | foreign_endian;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-- 
1.6.5.rc2

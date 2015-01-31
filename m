Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com
 [IPv6:2607:f8b0:4002:c07::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B02F1A0EB3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:38 +1100 (AEDT)
Received: by mail-yk0-f180.google.com with SMTP id 131so19053687ykp.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:36 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 07/15] fbdev: riva: remove the dependency on PPC_OF
Date: Sat, 31 Jan 2015 21:47:37 +0800
Message-Id: <1422712065-9403-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Antonino Daplas <adaplas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OF functionality has moved to a common place and be used by many
archs. So we don't need to include the ppc arch specific header files
and depend on PPC_OF option any more. This is a preparation for
killing PPC_OF.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/riva/fbdev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index be73727c7227..294a80908c8c 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -44,10 +44,6 @@
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
-#ifdef CONFIG_PPC_OF
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/machdep.h>
 #include <asm/backlight.h>
@@ -1735,7 +1731,6 @@ static int riva_set_fbinfo(struct fb_info *info)
 	return (rivafb_check_var(&info->var, info));
 }
 
-#ifdef CONFIG_PPC_OF
 static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
 	struct riva_par *par = info->par;
@@ -1766,9 +1761,8 @@ static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 	NVTRACE_LEAVE();
 	return 0;
 }
-#endif /* CONFIG_PPC_OF */
 
-#if defined(CONFIG_FB_RIVA_I2C) && !defined(CONFIG_PPC_OF)
+#if defined(CONFIG_FB_RIVA_I2C)
 static int riva_get_EDID_i2c(struct fb_info *info)
 {
 	struct riva_par *par = info->par;
@@ -1828,10 +1822,13 @@ static void riva_update_default_var(struct fb_var_screeninfo *var,
 static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
 	NVTRACE_ENTER();
-#ifdef CONFIG_PPC_OF
-	if (!riva_get_EDID_OF(info, pdev))
+	if (riva_get_EDID_OF(info, pdev)) {
+		NVTRACE_LEAVE();
+		return;
+	}
+	if (IS_ENABLED(CONFIG_OF))
 		printk(PFX "could not retrieve EDID from OF\n");
-#elif defined(CONFIG_FB_RIVA_I2C)
+#if defined(CONFIG_FB_RIVA_I2C)
 	if (!riva_get_EDID_i2c(info))
 		printk(PFX "could not retrieve EDID from DDC/I2C\n");
 #endif
-- 
1.9.3

Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com
 [IPv6:2607:f8b0:4002:c07::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6268E1A0981
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:27 +1100 (AEDT)
Received: by ykbq200 with SMTP id q200so7170439ykb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:25 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 6/9] fbdev: riva: remove the dependency on PPC_OF
Date: Thu, 12 Mar 2015 20:32:47 +0800
Message-Id: <1426163570-10281-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
References: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
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
2.1.0

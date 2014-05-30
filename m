Return-Path: <a.hajda@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 056481A06DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 20:21:45 +1000 (EST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N6D00LDZTNG7W60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 30 May 2014 11:11:40 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>,
 Bryan Wu <cooloney@gmail.com>
Subject: [PATCH 2/2] backlight: remove trivial get_brightness implementations
Date: Fri, 30 May 2014 12:10:50 +0200
Message-id: <1401444650-12267-3-git-send-email-a.hajda@samsung.com>
In-reply-to: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Cc: Milo Kim <milo.kim@ti.com>,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Yijing Wang <wangyijing@huawei.com>,
 Matthew Garrett <matthew.garrett@nebula.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "moderated list:ARM/S5P EXYNOS AR..." <linux-arm-kernel@lists.infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Jon Mason <jdmason@kudzu.us>,
 Joe Perches <joe@perches.com>,
 "open list:LINUX FOR POWER M..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since backlight core returns props.brightness in case get_brightness
is not implemented trivial implementations are not needed anymore.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/macintosh/via-pmu-backlight.c      | 6 ------
 drivers/platform/x86/samsung-q10.c         | 6 ------
 drivers/video/backlight/aat2870_bl.c       | 6 ------
 drivers/video/backlight/ams369fg06.c       | 6 ------
 drivers/video/backlight/bd6107.c           | 6 ------
 drivers/video/backlight/gpio_backlight.c   | 6 ------
 drivers/video/backlight/ld9040.c           | 6 ------
 drivers/video/backlight/lp855x_bl.c        | 6 ------
 drivers/video/backlight/lp8788_bl.c        | 6 ------
 drivers/video/backlight/lv5207lp.c         | 6 ------
 drivers/video/backlight/pandora_bl.c       | 6 ------
 drivers/video/backlight/pwm_bl.c           | 6 ------
 drivers/video/backlight/s6e63m0.c          | 6 ------
 drivers/video/backlight/tps65217_bl.c      | 6 ------
 drivers/video/fbdev/aty/aty128fb.c         | 6 ------
 drivers/video/fbdev/aty/atyfb_base.c       | 6 ------
 drivers/video/fbdev/aty/radeon_backlight.c | 6 ------
 drivers/video/fbdev/exynos/s6e8ax0.c       | 6 ------
 drivers/video/fbdev/nvidia/nv_backlight.c  | 6 ------
 drivers/video/fbdev/riva/fbdev.c           | 6 ------
 20 files changed, 120 deletions(-)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index b1d9117..6f68537 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -110,13 +110,7 @@ static int pmu_backlight_update_status(struct backlight_device *bd)
 }
 
 
-static int pmu_backlight_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops pmu_backlight_data = {
-	.get_brightness	= pmu_backlight_get_brightness,
 	.update_status	= pmu_backlight_update_status,
 
 };
diff --git a/drivers/platform/x86/samsung-q10.c b/drivers/platform/x86/samsung-q10.c
index 5413f62..28d12bd 100644
--- a/drivers/platform/x86/samsung-q10.c
+++ b/drivers/platform/x86/samsung-q10.c
@@ -46,13 +46,7 @@ static int samsungq10_bl_set_intensity(struct backlight_device *bd)
 	return 0;
 }
 
-static int samsungq10_bl_get_intensity(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops samsungq10_bl_ops = {
-	.get_brightness = samsungq10_bl_get_intensity,
 	.update_status	= samsungq10_bl_set_intensity,
 };
 
diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index ec5350f..86234c3 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -67,11 +67,6 @@ static inline int aat2870_bl_disable(struct aat2870_bl_driver_data *aat2870_bl)
 	return aat2870->write(aat2870, AAT2870_BL_CH_EN, 0x0);
 }
 
-static int aat2870_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static int aat2870_bl_update_status(struct backlight_device *bd)
 {
 	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
@@ -120,7 +115,6 @@ static int aat2870_bl_check_fb(struct backlight_device *bd, struct fb_info *fi)
 
 static const struct backlight_ops aat2870_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
-	.get_brightness = aat2870_bl_get_brightness,
 	.update_status = aat2870_bl_update_status,
 	.check_fb = aat2870_bl_check_fb,
 };
diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index d8952c4..4726c8b 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -410,11 +410,6 @@ static int ams369fg06_set_power(struct lcd_device *ld, int power)
 	return ams369fg06_power(lcd, power);
 }
 
-static int ams369fg06_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static int ams369fg06_set_brightness(struct backlight_device *bd)
 {
 	int ret = 0;
@@ -443,7 +438,6 @@ static struct lcd_ops ams369fg06_lcd_ops = {
 };
 
 static const struct backlight_ops ams369fg06_backlight_ops = {
-	.get_brightness = ams369fg06_get_brightness,
 	.update_status = ams369fg06_set_brightness,
 };
 
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 16dd9bc..fdb2f7e 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -105,11 +105,6 @@ static int bd6107_backlight_update_status(struct backlight_device *backlight)
 	return 0;
 }
 
-static int bd6107_backlight_get_brightness(struct backlight_device *backlight)
-{
-	return backlight->props.brightness;
-}
-
 static int bd6107_backlight_check_fb(struct backlight_device *backlight,
 				       struct fb_info *info)
 {
@@ -121,7 +116,6 @@ static int bd6107_backlight_check_fb(struct backlight_device *backlight,
 static const struct backlight_ops bd6107_backlight_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= bd6107_backlight_update_status,
-	.get_brightness	= bd6107_backlight_get_brightness,
 	.check_fb	= bd6107_backlight_check_fb,
 };
 
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index a2eba12..c3ad803 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -43,11 +43,6 @@ static int gpio_backlight_update_status(struct backlight_device *bl)
 	return 0;
 }
 
-static int gpio_backlight_get_brightness(struct backlight_device *bl)
-{
-	return bl->props.brightness;
-}
-
 static int gpio_backlight_check_fb(struct backlight_device *bl,
 				   struct fb_info *info)
 {
@@ -59,7 +54,6 @@ static int gpio_backlight_check_fb(struct backlight_device *bl,
 static const struct backlight_ops gpio_backlight_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= gpio_backlight_update_status,
-	.get_brightness	= gpio_backlight_get_brightness,
 	.check_fb	= gpio_backlight_check_fb,
 };
 
diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index 506a6c2..ccb44e8 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -642,11 +642,6 @@ static int ld9040_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static int ld9040_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static int ld9040_set_brightness(struct backlight_device *bd)
 {
 	int ret = 0, brightness = bd->props.brightness;
@@ -674,7 +669,6 @@ static struct lcd_ops ld9040_lcd_ops = {
 };
 
 static const struct backlight_ops ld9040_backlight_ops  = {
-	.get_brightness = ld9040_get_brightness,
 	.update_status = ld9040_set_brightness,
 };
 
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 2ca3a04..dcdd544 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -274,15 +274,9 @@ static int lp855x_bl_update_status(struct backlight_device *bl)
 	return 0;
 }
 
-static int lp855x_bl_get_brightness(struct backlight_device *bl)
-{
-	return bl->props.brightness;
-}
-
 static const struct backlight_ops lp855x_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = lp855x_bl_update_status,
-	.get_brightness = lp855x_bl_get_brightness,
 };
 
 static int lp855x_backlight_register(struct lp855x *lp)
diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index daba34d..d6c4f6a 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -176,15 +176,9 @@ static int lp8788_bl_update_status(struct backlight_device *bl_dev)
 	return 0;
 }
 
-static int lp8788_bl_get_brightness(struct backlight_device *bl_dev)
-{
-	return bl_dev->props.brightness;
-}
-
 static const struct backlight_ops lp8788_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = lp8788_bl_update_status,
-	.get_brightness = lp8788_bl_get_brightness,
 };
 
 static int lp8788_backlight_register(struct lp8788_bl *bl)
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index 1802b2d..8ab7297 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -70,11 +70,6 @@ static int lv5207lp_backlight_update_status(struct backlight_device *backlight)
 	return 0;
 }
 
-static int lv5207lp_backlight_get_brightness(struct backlight_device *backlight)
-{
-	return backlight->props.brightness;
-}
-
 static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
 				       struct fb_info *info)
 {
@@ -86,7 +81,6 @@ static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
 static const struct backlight_ops lv5207lp_backlight_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= lv5207lp_backlight_update_status,
-	.get_brightness	= lv5207lp_backlight_get_brightness,
 	.check_fb	= lv5207lp_backlight_check_fb,
 };
 
diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
index 2098c5d..2e3f820 100644
--- a/drivers/video/backlight/pandora_bl.c
+++ b/drivers/video/backlight/pandora_bl.c
@@ -100,15 +100,9 @@ done:
 	return 0;
 }
 
-static int pandora_backlight_get_brightness(struct backlight_device *bl)
-{
-	return bl->props.brightness;
-}
-
 static const struct backlight_ops pandora_backlight_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= pandora_backlight_update_status,
-	.get_brightness	= pandora_backlight_get_brightness,
 };
 
 static int pandora_backlight_probe(struct platform_device *pdev)
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 38ca88b..c9c8496 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -115,11 +115,6 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	return 0;
 }
 
-static int pwm_backlight_get_brightness(struct backlight_device *bl)
-{
-	return bl->props.brightness;
-}
-
 static int pwm_backlight_check_fb(struct backlight_device *bl,
 				  struct fb_info *info)
 {
@@ -130,7 +125,6 @@ static int pwm_backlight_check_fb(struct backlight_device *bl,
 
 static const struct backlight_ops pwm_backlight_ops = {
 	.update_status	= pwm_backlight_update_status,
-	.get_brightness	= pwm_backlight_get_brightness,
 	.check_fb	= pwm_backlight_check_fb,
 };
 
diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 510a1bc..94399f8 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -597,11 +597,6 @@ static int s6e63m0_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static int s6e63m0_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static int s6e63m0_set_brightness(struct backlight_device *bd)
 {
 	int ret = 0, brightness = bd->props.brightness;
@@ -629,7 +624,6 @@ static struct lcd_ops s6e63m0_lcd_ops = {
 };
 
 static const struct backlight_ops s6e63m0_backlight_ops  = {
-	.get_brightness = s6e63m0_get_brightness,
 	.update_status = s6e63m0_set_brightness,
 };
 
diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
index 595dcf5..2e04d93 100644
--- a/drivers/video/backlight/tps65217_bl.c
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -109,15 +109,9 @@ static int tps65217_bl_update_status(struct backlight_device *bl)
 	return rc;
 }
 
-static int tps65217_bl_get_brightness(struct backlight_device *bl)
-{
-	return bl->props.brightness;
-}
-
 static const struct backlight_ops tps65217_bl_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= tps65217_bl_update_status,
-	.get_brightness	= tps65217_bl_get_brightness
 };
 
 static int tps65217_bl_hw_init(struct tps65217_bl *tps65217_bl,
diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 52108be..ff60701 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -1802,13 +1802,7 @@ static int aty128_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int aty128_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops aty128_bl_data = {
-	.get_brightness	= aty128_bl_get_brightness,
 	.update_status	= aty128_bl_update_status,
 };
 
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index c3d0074..37ec09b 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2211,13 +2211,7 @@ static int aty_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int aty_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops aty_bl_data = {
-	.get_brightness = aty_bl_get_brightness,
 	.update_status	= aty_bl_update_status,
 };
 
diff --git a/drivers/video/fbdev/aty/radeon_backlight.c b/drivers/video/fbdev/aty/radeon_backlight.c
index db572df..301d6d6 100644
--- a/drivers/video/fbdev/aty/radeon_backlight.c
+++ b/drivers/video/fbdev/aty/radeon_backlight.c
@@ -123,13 +123,7 @@ static int radeon_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int radeon_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops radeon_bl_data = {
-	.get_brightness = radeon_bl_get_brightness,
 	.update_status	= radeon_bl_update_status,
 };
 
diff --git a/drivers/video/fbdev/exynos/s6e8ax0.c b/drivers/video/fbdev/exynos/s6e8ax0.c
index 29e70ed..95873f2 100644
--- a/drivers/video/fbdev/exynos/s6e8ax0.c
+++ b/drivers/video/fbdev/exynos/s6e8ax0.c
@@ -704,11 +704,6 @@ static int s6e8ax0_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static int s6e8ax0_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static int s6e8ax0_set_brightness(struct backlight_device *bd)
 {
 	int ret = 0, brightness = bd->props.brightness;
@@ -736,7 +731,6 @@ static struct lcd_ops s6e8ax0_lcd_ops = {
 };
 
 static const struct backlight_ops s6e8ax0_backlight_ops = {
-	.get_brightness = s6e8ax0_get_brightness,
 	.update_status = s6e8ax0_set_brightness,
 };
 
diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/video/fbdev/nvidia/nv_backlight.c
index 8471008..5c151b2 100644
--- a/drivers/video/fbdev/nvidia/nv_backlight.c
+++ b/drivers/video/fbdev/nvidia/nv_backlight.c
@@ -82,13 +82,7 @@ static int nvidia_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int nvidia_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops nvidia_bl_ops = {
-	.get_brightness = nvidia_bl_get_brightness,
 	.update_status	= nvidia_bl_update_status,
 };
 
diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 8a8d7f0..be73727 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -326,13 +326,7 @@ static int riva_bl_update_status(struct backlight_device *bd)
 	return 0;
 }
 
-static int riva_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props.brightness;
-}
-
 static const struct backlight_ops riva_bl_ops = {
-	.get_brightness = riva_bl_get_brightness,
 	.update_status	= riva_bl_update_status,
 };
 
-- 
1.9.1

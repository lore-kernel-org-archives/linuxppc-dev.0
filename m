Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 018B867B32
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 03:35:55 +1000 (EST)
Date: Sat, 8 Jul 2006 19:35:49 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: akpm@osdl.org
Subject: powermac: Combined fixes for backlight code
Message-ID: <20060708173549.GC26186@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, aris@valeta.org,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Andrew

Sorry, I already had two other patches earlier today. Now Michael Buesch
pointed out that I should have used inline's instead of #define. Thus I
decided to combine all the patches and ask you to ignore the other ones.
The subjects were "Locking fixes for powermac backlight infrastructure"
and "powermac: defer work in backlight key press (and export fixes)".

Here's the description for the combined patch:

This patch fixes several problems:
- pmac_backlight_key() is called under interrupt context, and therefore
  can't use mutexes or semaphores, so defer the backlight level for
  later, as it's not critical (original code by Aristeu S. Rozanski F.
  <aris@valeta.org>).
- Add exports for functions that might be called from modules
- Fix Kconfig depdencies on PMAC_BACKLIGHT.
- Fix locking issues on calls from inside the driver (reported by
  Aristeu S. Rozanski F., too)
- Fix wrong calculation of backlight values in some of the drivers
- Replace pmac_backlight_key_up/down by inline functions

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Aristeu S. Rozanski F. <aris@valeta.org>
Acked-by: René Nussbaumer <linux-kernel@killerfox.forkbomb.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/arch/powerpc/platforms/powermac/backlight.c linux-2.6.18-rc1/arch/powerpc/platforms/powermac/backlight.c
--- linux-2.6.18-rc1.orig/arch/powerpc/platforms/powermac/backlight.c	2006-07-08 18:04:49.000000000 +0200
+++ linux-2.6.18-rc1/arch/powerpc/platforms/powermac/backlight.c	2006-07-08 19:11:52.000000000 +0200
@@ -15,6 +15,15 @@
 
 #define OLD_BACKLIGHT_MAX 15
 
+static void pmac_backlight_key_worker(void *data);
+static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
+
+/* Although this variable is used in interrupt context, it makes no sense to
+ * protect it. No user is able to produce enough key events per second and
+ * notice the errors that might happen.
+ */
+static int pmac_backlight_key_queued;
+
 /* Protect the pmac_backlight variable */
 DEFINE_MUTEX(pmac_backlight_mutex);
 
@@ -71,7 +80,7 @@ int pmac_backlight_curve_lookup(struct f
 	return level;
 }
 
-static void pmac_backlight_key(int direction)
+static void pmac_backlight_key_worker(void *data)
 {
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
@@ -82,7 +91,8 @@ static void pmac_backlight_key(int direc
 		props = pmac_backlight->props;
 
 		brightness = props->brightness +
-			((direction?-1:1) * (props->max_brightness / 15));
+			((pmac_backlight_key_queued?-1:1) *
+			 (props->max_brightness / 15));
 
 		if (brightness < 0)
 			brightness = 0;
@@ -97,14 +107,13 @@ static void pmac_backlight_key(int direc
 	mutex_unlock(&pmac_backlight_mutex);
 }
 
-void pmac_backlight_key_up()
+void pmac_backlight_key(int direction)
 {
-	pmac_backlight_key(0);
-}
-
-void pmac_backlight_key_down()
-{
-	pmac_backlight_key(1);
+	/* we can receive multiple interrupts here, but the scheduled work
+	 * will run only once, with the last value
+	 */
+	pmac_backlight_key_queued = direction;
+	schedule_work(&pmac_backlight_key_work);
 }
 
 int pmac_backlight_set_legacy_brightness(int brightness)
@@ -157,3 +166,7 @@ int pmac_backlight_get_legacy_brightness
 
 	return result;
 }
+
+EXPORT_SYMBOL_GPL(pmac_backlight);
+EXPORT_SYMBOL_GPL(pmac_backlight_mutex);
+EXPORT_SYMBOL_GPL(pmac_has_backlight_type);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/macintosh/Kconfig linux-2.6.18-rc1/drivers/macintosh/Kconfig
--- linux-2.6.18-rc1.orig/drivers/macintosh/Kconfig	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/macintosh/Kconfig	2006-07-08 19:11:52.000000000 +0200
@@ -113,7 +113,10 @@ config PMAC_MEDIABAY
 
 config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
-	depends on ADB_PMU && (BROKEN || !PPC64)
+	depends on ADB_PMU && FB = y && (BROKEN || !PPC64)
+	select FB_BACKLIGHT
+	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
 	help
 	  Say Y here to enable Macintosh specific extensions of the generic
 	  backlight code. With this enabled, the brightness keys on older
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/aty/aty128fb.c linux-2.6.18-rc1/drivers/video/aty/aty128fb.c
--- linux-2.6.18-rc1.orig/drivers/video/aty/aty128fb.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/aty/aty128fb.c	2006-07-08 19:11:50.000000000 +0200
@@ -456,6 +456,7 @@ static void do_wait_for_fifo(u16 entries
 static void wait_for_fifo(u16 entries, struct aty128fb_par *par);
 static void wait_for_idle(struct aty128fb_par *par);
 static u32 depth_to_dst(u32 depth);
+static void aty128_bl_set_power(struct fb_info *info, int power);
 
 #define BIOS_IN8(v)  	(readb(bios + (v)))
 #define BIOS_IN16(v) 	(readb(bios + (v)) | \
@@ -1258,25 +1259,11 @@ static void aty128_set_lcd_enable(struct
 		reg &= ~LVDS_DISPLAY_DIS;
 		aty_st_le32(LVDS_GEN_CNTL, reg);
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
-		mutex_lock(&info->bl_mutex);
-		if (info->bl_dev) {
-			down(&info->bl_dev->sem);
-			info->bl_dev->props->update_status(info->bl_dev);
-			up(&info->bl_dev->sem);
-		}
-		mutex_unlock(&info->bl_mutex);
+		aty128_bl_set_power(info, FB_BLANK_UNBLANK);
 #endif	
 	} else {
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
-		mutex_lock(&info->bl_mutex);
-		if (info->bl_dev) {
-			down(&info->bl_dev->sem);
-			info->bl_dev->props->brightness = 0;
-			info->bl_dev->props->power = FB_BLANK_POWERDOWN;
-			info->bl_dev->props->update_status(info->bl_dev);
-			up(&info->bl_dev->sem);
-		}
-		mutex_unlock(&info->bl_mutex);
+		aty128_bl_set_power(info, FB_BLANK_POWERDOWN);
 #endif	
 		reg = aty_ld_le32(LVDS_GEN_CNTL);
 		reg |= LVDS_DISPLAY_DIS;
@@ -1703,6 +1690,7 @@ static int __devinit aty128fb_setup(char
 
 static struct backlight_properties aty128_bl_data;
 
+/* Call with fb_info->bl_mutex held */
 static int aty128_bl_get_level_brightness(struct aty128fb_par *par,
 		int level)
 {
@@ -1710,10 +1698,8 @@ static int aty128_bl_get_level_brightnes
 	int atylevel;
 
 	/* Get and convert the value */
-	mutex_lock(&info->bl_mutex);
 	atylevel = MAX_LEVEL -
 		(info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL);
-	mutex_unlock(&info->bl_mutex);
 
 	if (atylevel < 0)
 		atylevel = 0;
@@ -1731,7 +1717,8 @@ static int aty128_bl_get_level_brightnes
 /* That one prevents proper CRT output with LCD off */
 #undef BACKLIGHT_DAC_OFF
 
-static int aty128_bl_update_status(struct backlight_device *bd)
+/* Call with fb_info->bl_mutex held */
+static int __aty128_bl_update_status(struct backlight_device *bd)
 {
 	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
 	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
@@ -1784,6 +1771,19 @@ static int aty128_bl_update_status(struc
 	return 0;
 }
 
+static int aty128_bl_update_status(struct backlight_device *bd)
+{
+	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	int ret;
+
+	mutex_lock(&info->bl_mutex);
+	ret = __aty128_bl_update_status(bd);
+	mutex_unlock(&info->bl_mutex);
+
+	return ret;
+}
+
 static int aty128_bl_get_brightness(struct backlight_device *bd)
 {
 	return bd->props->brightness;
@@ -1796,6 +1796,16 @@ static struct backlight_properties aty12
 	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
 };
 
+static void aty128_bl_set_power(struct fb_info *info, int power)
+{
+	mutex_lock(&info->bl_mutex);
+	up(&info->bl_dev->sem);
+	info->bl_dev->props->power = power;
+	__aty128_bl_update_status(info->bl_dev);
+	down(&info->bl_dev->sem);
+	mutex_unlock(&info->bl_mutex);
+}
+
 static void aty128_bl_init(struct aty128fb_par *par)
 {
 	struct fb_info *info = pci_get_drvdata(par->pdev);
@@ -2198,12 +2208,8 @@ static int aty128fb_blank(int blank, str
 		return 0;
 
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
-	if (machine_is(powermac) && blank) {
-		down(&fb->bl_dev->sem);
-		fb->bl_dev->props->power = FB_BLANK_POWERDOWN;
-		fb->bl_dev->props->update_status(fb->bl_dev);
-		up(&fb->bl_dev->sem);
-	}
+	if (machine_is(powermac) && blank)
+		aty128_bl_set_power(fb, FB_BLANK_POWERDOWN);
 #endif
 
 	if (blank & FB_BLANK_VSYNC_SUSPEND)
@@ -2219,14 +2225,12 @@ static int aty128fb_blank(int blank, str
 		aty128_set_crt_enable(par, par->crt_on && !blank);
 		aty128_set_lcd_enable(par, par->lcd_on && !blank);
 	}
+
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
-	if (machine_is(powermac) && !blank) {
-		down(&fb->bl_dev->sem);
-		fb->bl_dev->props->power = FB_BLANK_UNBLANK;
-		fb->bl_dev->props->update_status(fb->bl_dev);
-		up(&fb->bl_dev->sem);
-	}
+	if (machine_is(powermac) && !blank)
+		aty128_bl_set_power(fb, FB_BLANK_UNBLANK);
 #endif
+
 	return 0;
 }
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/aty/atyfb_base.c linux-2.6.18-rc1/drivers/video/aty/atyfb_base.c
--- linux-2.6.18-rc1.orig/drivers/video/aty/atyfb_base.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/aty/atyfb_base.c	2006-07-08 19:11:50.000000000 +0200
@@ -2129,15 +2129,14 @@ static int atyfb_pci_resume(struct pci_d
 
 static struct backlight_properties aty_bl_data;
 
+/* Call with fb_info->bl_mutex held */
 static int aty_bl_get_level_brightness(struct atyfb_par *par, int level)
 {
 	struct fb_info *info = pci_get_drvdata(par->pdev);
 	int atylevel;
 
 	/* Get and convert the value */
-	mutex_lock(&info->bl_mutex);
 	atylevel = info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL;
-	mutex_unlock(&info->bl_mutex);
 
 	if (atylevel < 0)
 		atylevel = 0;
@@ -2147,7 +2146,8 @@ static int aty_bl_get_level_brightness(s
 	return atylevel;
 }
 
-static int aty_bl_update_status(struct backlight_device *bd)
+/* Call with fb_info->bl_mutex held */
+static int __aty_bl_update_status(struct backlight_device *bd)
 {
 	struct atyfb_par *par = class_get_devdata(&bd->class_dev);
 	unsigned int reg = aty_ld_lcd(LCD_MISC_CNTL, par);
@@ -2172,6 +2172,19 @@ static int aty_bl_update_status(struct b
 	return 0;
 }
 
+static int aty_bl_update_status(struct backlight_device *bd)
+{
+	struct atyfb_par *par = class_get_devdata(&bd->class_dev);
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	int ret;
+
+	mutex_lock(&info->bl_mutex);
+	ret = __aty_bl_update_status(bd);
+	mutex_unlock(&info->bl_mutex);
+
+	return ret;
+}
+
 static int aty_bl_get_brightness(struct backlight_device *bd)
 {
 	return bd->props->brightness;
@@ -2184,6 +2197,16 @@ static struct backlight_properties aty_b
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
 };
 
+static void aty_bl_set_power(struct fb_info *info, int power)
+{
+	mutex_lock(&info->bl_mutex);
+	up(&info->bl_dev->sem);
+	info->bl_dev->props->power = power;
+	__aty_bl_update_status(info->bl_dev);
+	down(&info->bl_dev->sem);
+	mutex_unlock(&info->bl_mutex);
+}
+
 static void aty_bl_init(struct atyfb_par *par)
 {
 	struct fb_info *info = pci_get_drvdata(par->pdev);
@@ -2790,16 +2813,8 @@ static int atyfb_blank(int blank, struct
 		return 0;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (machine_is(powermac) && blank > FB_BLANK_NORMAL) {
-		mutex_lock(&info->bl_mutex);
-		if (info->bl_dev) {
-			down(&info->bl_dev->sem);
-			info->bl_dev->props->power = FB_BLANK_POWERDOWN;
-			info->bl_dev->props->update_status(info->bl_dev);
-			up(&info->bl_dev->sem);
-		}
-		mutex_unlock(&info->bl_mutex);
-	}
+	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
+		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
 	if (par->lcd_table && blank > FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
@@ -2830,16 +2845,8 @@ static int atyfb_blank(int blank, struct
 	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL) {
-		mutex_lock(&info->bl_mutex);
-		if (info->bl_dev) {
-			down(&info->bl_dev->sem);
-			info->bl_dev->props->power = FB_BLANK_UNBLANK;
-			info->bl_dev->props->update_status(info->bl_dev);
-			up(&info->bl_dev->sem);
-		}
-		mutex_unlock(&info->bl_mutex);
-	}
+	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL)
+		aty_bl_set_power(info, FB_BLANK_UNBLANK);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
 	if (par->lcd_table && blank <= FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/chipsfb.c linux-2.6.18-rc1/drivers/video/chipsfb.c
--- linux-2.6.18-rc1.orig/drivers/video/chipsfb.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/chipsfb.c	2006-07-08 19:11:50.000000000 +0200
@@ -150,12 +150,11 @@ static int chipsfb_blank(int blank, stru
 	mutex_lock(&pmac_backlight_mutex);
 
 	if (pmac_backlight) {
-		down(&pmac_backlight->sem);
-
 		/* used to disable backlight only for blank > 1, but it seems
 		 * useful at blank = 1 too (saves battery, extends backlight
 		 * life)
 	 	 */
+		down(&pmac_backlight->sem);
 		if (blank)
 			pmac_backlight->props->power = FB_BLANK_POWERDOWN;
 		else
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/nvidia/nv_backlight.c linux-2.6.18-rc1/drivers/video/nvidia/nv_backlight.c
--- linux-2.6.18-rc1.orig/drivers/video/nvidia/nv_backlight.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/nvidia/nv_backlight.c	2006-07-08 19:11:50.000000000 +0200
@@ -26,9 +26,11 @@
  */
 #define MIN_LEVEL 0x158
 #define MAX_LEVEL 0x534
+#define LEVEL_STEP ((MAX_LEVEL - MIN_LEVEL) / FB_BACKLIGHT_MAX)
 
 static struct backlight_properties nvidia_bl_data;
 
+/* Call with fb_info->bl_mutex held */
 static int nvidia_bl_get_level_brightness(struct nvidia_par *par,
 		int level)
 {
@@ -36,9 +38,7 @@ static int nvidia_bl_get_level_brightnes
 	int nlevel;
 
 	/* Get and convert the value */
-	mutex_lock(&info->bl_mutex);
-	nlevel = info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL;
-	mutex_unlock(&info->bl_mutex);
+	nlevel = MIN_LEVEL + info->bl_curve[level] * LEVEL_STEP;
 
 	if (nlevel < 0)
 		nlevel = 0;
@@ -50,7 +50,8 @@ static int nvidia_bl_get_level_brightnes
 	return nlevel;
 }
 
-static int nvidia_bl_update_status(struct backlight_device *bd)
+/* Call with fb_info->bl_mutex held */
+static int __nvidia_bl_update_status(struct backlight_device *bd)
 {
 	struct nvidia_par *par = class_get_devdata(&bd->class_dev);
 	u32 tmp_pcrt, tmp_pmc, fpcontrol;
@@ -84,6 +85,19 @@ static int nvidia_bl_update_status(struc
 	return 0;
 }
 
+static int nvidia_bl_update_status(struct backlight_device *bd)
+{
+	struct nvidia_par *par = class_get_devdata(&bd->class_dev);
+	struct fb_info *info = pci_get_drvdata(par->pci_dev);
+	int ret;
+
+	mutex_lock(&info->bl_mutex);
+	ret = __nvidia_bl_update_status(bd);
+	mutex_unlock(&info->bl_mutex);
+
+	return ret;
+}
+
 static int nvidia_bl_get_brightness(struct backlight_device *bd)
 {
 	return bd->props->brightness;
@@ -96,6 +110,16 @@ static struct backlight_properties nvidi
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
 };
 
+void nvidia_bl_set_power(struct fb_info *info, int power)
+{
+	mutex_lock(&info->bl_mutex);
+	up(&info->bl_dev->sem);
+	info->bl_dev->props->power = power;
+	__nvidia_bl_update_status(info->bl_dev);
+	down(&info->bl_dev->sem);
+	mutex_unlock(&info->bl_mutex);
+}
+
 void nvidia_bl_init(struct nvidia_par *par)
 {
 	struct fb_info *info = pci_get_drvdata(par->pci_dev);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/nvidia/nvidia.c linux-2.6.18-rc1/drivers/video/nvidia/nvidia.c
--- linux-2.6.18-rc1.orig/drivers/video/nvidia/nvidia.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/nvidia/nvidia.c	2006-07-08 19:11:50.000000000 +0200
@@ -933,16 +933,7 @@ static int nvidiafb_blank(int blank, str
 	NVWriteSeq(par, 0x01, tmp);
 	NVWriteCrtc(par, 0x1a, vesa);
 
-#ifdef CONFIG_FB_NVIDIA_BACKLIGHT
-	mutex_lock(&info->bl_mutex);
-	if (info->bl_dev) {
-		down(&info->bl_dev->sem);
-		info->bl_dev->props->power = blank;
-		info->bl_dev->props->update_status(info->bl_dev);
-		up(&info->bl_dev->sem);
-	}
-	mutex_unlock(&info->bl_mutex);
-#endif
+	nvidia_bl_set_power(info, blank);
 
 	NVTRACE_LEAVE();
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/nvidia/nv_proto.h linux-2.6.18-rc1/drivers/video/nvidia/nv_proto.h
--- linux-2.6.18-rc1.orig/drivers/video/nvidia/nv_proto.h	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/nvidia/nv_proto.h	2006-07-08 19:11:50.000000000 +0200
@@ -68,9 +68,11 @@ extern u8 byte_rev[256];
 #ifdef CONFIG_FB_NVIDIA_BACKLIGHT
 extern void nvidia_bl_init(struct nvidia_par *par);
 extern void nvidia_bl_exit(struct nvidia_par *par);
+extern void nvidia_bl_set_power(struct fb_info *info, int power);
 #else
 static inline void nvidia_bl_init(struct nvidia_par *par) {}
 static inline void nvidia_bl_exit(struct nvidia_par *par) {}
+static inline void nvidia_bl_set_power(struct fb_info *info, int power) {}
 #endif
 
 #endif				/* __NV_PROTO_H__ */
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/drivers/video/riva/fbdev.c linux-2.6.18-rc1/drivers/video/riva/fbdev.c
--- linux-2.6.18-rc1.orig/drivers/video/riva/fbdev.c	2006-07-08 18:04:50.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/riva/fbdev.c	2006-07-08 19:11:50.000000000 +0200
@@ -278,9 +278,11 @@ static const struct riva_regs reg_templa
  */
 #define MIN_LEVEL 0x158
 #define MAX_LEVEL 0x534
+#define LEVEL_STEP ((MAX_LEVEL - MIN_LEVEL) / FB_BACKLIGHT_MAX)
 
 static struct backlight_properties riva_bl_data;
 
+/* Call with fb_info->bl_mutex held */
 static int riva_bl_get_level_brightness(struct riva_par *par,
 		int level)
 {
@@ -288,9 +290,7 @@ static int riva_bl_get_level_brightness(
 	int nlevel;
 
 	/* Get and convert the value */
-	mutex_lock(&info->bl_mutex);
-	nlevel = info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL;
-	mutex_unlock(&info->bl_mutex);
+	nlevel = MIN_LEVEL + info->bl_curve[level] * LEVEL_STEP;
 
 	if (nlevel < 0)
 		nlevel = 0;
@@ -302,7 +302,8 @@ static int riva_bl_get_level_brightness(
 	return nlevel;
 }
 
-static int riva_bl_update_status(struct backlight_device *bd)
+/* Call with fb_info->bl_mutex held */
+static int __riva_bl_update_status(struct backlight_device *bd)
 {
 	struct riva_par *par = class_get_devdata(&bd->class_dev);
 	U032 tmp_pcrt, tmp_pmc;
@@ -327,6 +328,19 @@ static int riva_bl_update_status(struct 
 	return 0;
 }
 
+static int riva_bl_update_status(struct backlight_device *bd)
+{
+	struct riva_par *par = class_get_devdata(&bd->class_dev);
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	int ret;
+
+	mutex_lock(&info->bl_mutex);
+	ret = __riva_bl_update_status(bd);
+	mutex_unlock(&info->bl_mutex);
+
+	return ret;
+}
+
 static int riva_bl_get_brightness(struct backlight_device *bd)
 {
 	return bd->props->brightness;
@@ -339,6 +353,16 @@ static struct backlight_properties riva_
 	.max_brightness = (FB_BACKLIGHT_LEVELS - 1),
 };
 
+static void riva_bl_set_power(struct fb_info *info, int power)
+{
+	mutex_lock(&info->bl_mutex);
+	up(&info->bl_dev->sem);
+	info->bl_dev->props->power = power;
+	__riva_bl_update_status(info->bl_dev);
+	down(&info->bl_dev->sem);
+	mutex_unlock(&info->bl_mutex);
+}
+
 static void riva_bl_init(struct riva_par *par)
 {
 	struct fb_info *info = pci_get_drvdata(par->pdev);
@@ -419,6 +443,7 @@ static void riva_bl_exit(struct riva_par
 #else
 static inline void riva_bl_init(struct riva_par *par) {}
 static inline void riva_bl_exit(struct riva_par *par) {}
+static inline void riva_bl_set_power(struct fb_info *info, int power) {}
 #endif /* CONFIG_FB_RIVA_BACKLIGHT */
 
 /* ------------------------------------------------------------------------- *
@@ -1337,16 +1362,7 @@ static int rivafb_blank(int blank, struc
 	SEQout(par, 0x01, tmp);
 	CRTCout(par, 0x1a, vesa);
 
-#ifdef CONFIG_FB_RIVA_BACKLIGHT
-	mutex_lock(&info->bl_mutex);
-	if (info->bl_dev) {
-		down(&info->bl_dev->sem);
-		info->bl_dev->props->power = blank;
-		info->bl_dev->props->update_status(info->bl_dev);
-		up(&info->bl_dev->sem);
-	}
-	mutex_unlock(&info->bl_mutex);
-#endif
+	riva_bl_set_power(info, blank);
 
 	NVTRACE_LEAVE();
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1.orig/include/asm-powerpc/backlight.h linux-2.6.18-rc1/include/asm-powerpc/backlight.h
--- linux-2.6.18-rc1.orig/include/asm-powerpc/backlight.h	2006-07-08 18:04:51.000000000 +0200
+++ linux-2.6.18-rc1/include/asm-powerpc/backlight.h	2006-07-08 19:13:53.000000000 +0200
@@ -16,13 +16,13 @@
 extern struct backlight_device *pmac_backlight;
 extern struct mutex pmac_backlight_mutex;
 
-extern void pmac_backlight_calc_curve(struct fb_info*);
 extern int pmac_backlight_curve_lookup(struct fb_info *info, int value);
 
 extern int pmac_has_backlight_type(const char *type);
 
-extern void pmac_backlight_key_up(void);
-extern void pmac_backlight_key_down(void);
+extern void pmac_backlight_key(int direction);
+static inline void pmac_backlight_key_up() { pmac_backlight_key(0); }
+static inline void pmac_backlight_key_down() { pmac_backlight_key(1); }
 
 extern int pmac_backlight_set_legacy_brightness(int brightness);
 extern int pmac_backlight_get_legacy_brightness(void);

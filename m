Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 52C6067B74
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 23:09:16 +1000 (EST)
Date: Sat, 15 Jul 2006 15:09:00 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: akpm@osdl.org
Subject: powermac: More powermac backlight fixes
Message-ID: <20060715130900.GA29287@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

This patch fixes several problems:
- The legacy backlight value might be set at interrupt time. Introduced
  a worker to prevent it from directly calling the backlight code.
- via-pmu allows the backlight to be grabbed, in which case we need to
  prevent other kernel code from changing the brightness.
- Don't send PMU requests in via-pmu-backlight when the machine is about
  to sleep or waking up.
- More Kconfig fixes.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/arch/powerpc/platforms/powermac/backlight.c linux-2.6.18-rc1-git8/arch/powerpc/platforms/powermac/backlight.c
--- linux-2.6.18-rc1-git8.orig/arch/powerpc/platforms/powermac/backlight.c	2006-07-14 22:24:02.000000000 +0200
+++ linux-2.6.18-rc1-git8/arch/powerpc/platforms/powermac/backlight.c	2006-07-14 22:41:39.000000000 +0200
@@ -10,19 +10,32 @@
 #include <linux/kernel.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <asm/atomic.h>
 #include <asm/prom.h>
 #include <asm/backlight.h>
 
 #define OLD_BACKLIGHT_MAX 15
 
 static void pmac_backlight_key_worker(void *data);
+static void pmac_backlight_set_legacy_worker(void *data);
+
 static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
+static DECLARE_WORK(pmac_backlight_set_legacy_work, pmac_backlight_set_legacy_worker, NULL);
 
-/* Although this variable is used in interrupt context, it makes no sense to
- * protect it. No user is able to produce enough key events per second and
+/* Although these variables are used in interrupt context, it makes no sense to
+ * protect them. No user is able to produce enough key events per second and
  * notice the errors that might happen.
  */
 static int pmac_backlight_key_queued;
+static int pmac_backlight_set_legacy_queued;
+
+/* The via-pmu code allows the backlight to be grabbed, in which case the
+ * in-kernel control of the brightness needs to be disabled. This should
+ * only be used by really old PowerBooks.
+ */
+static atomic_t kernel_backlight_disabled = ATOMIC_INIT(0);
 
 /* Protect the pmac_backlight variable */
 DEFINE_MUTEX(pmac_backlight_mutex);
@@ -82,6 +95,9 @@ int pmac_backlight_curve_lookup(struct f
 
 static void pmac_backlight_key_worker(void *data)
 {
+	if (atomic_read(&kernel_backlight_disabled))
+		return;
+
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
 		struct backlight_properties *props;
@@ -107,8 +123,12 @@ static void pmac_backlight_key_worker(vo
 	mutex_unlock(&pmac_backlight_mutex);
 }
 
+/* This function is called in interrupt context */
 void pmac_backlight_key(int direction)
 {
+	if (atomic_read(&kernel_backlight_disabled))
+		return;
+
 	/* we can receive multiple interrupts here, but the scheduled work
 	 * will run only once, with the last value
 	 */
@@ -116,10 +136,13 @@ void pmac_backlight_key(int direction)
 	schedule_work(&pmac_backlight_key_work);
 }
 
-int pmac_backlight_set_legacy_brightness(int brightness)
+static int __pmac_backlight_set_legacy_brightness(int brightness)
 {
 	int error = -ENXIO;
 
+	if (atomic_read(&kernel_backlight_disabled))
+		return -EBUSY;
+
 	mutex_lock(&pmac_backlight_mutex);
 	if (pmac_backlight) {
 		struct backlight_properties *props;
@@ -145,6 +168,22 @@ int pmac_backlight_set_legacy_brightness
 	return error;
 }
 
+static void pmac_backlight_set_legacy_worker(void *data)
+{
+	__pmac_backlight_set_legacy_brightness(pmac_backlight_set_legacy_queued);
+}
+
+/* This function is called in interrupt context */
+void pmac_backlight_set_legacy_brightness_pmu(int brightness) {
+	pmac_backlight_set_legacy_queued = brightness;
+	schedule_work(&pmac_backlight_set_legacy_work);
+}
+
+int pmac_backlight_set_legacy_brightness(int brightness)
+{
+	return __pmac_backlight_set_legacy_brightness(brightness);
+}
+
 int pmac_backlight_get_legacy_brightness()
 {
 	int result = -ENXIO;
@@ -167,6 +206,16 @@ int pmac_backlight_get_legacy_brightness
 	return result;
 }
 
+void pmac_backlight_disable()
+{
+	atomic_inc(&kernel_backlight_disabled);
+}
+
+void pmac_backlight_enable()
+{
+	atomic_dec(&kernel_backlight_disabled);
+}
+
 EXPORT_SYMBOL_GPL(pmac_backlight);
 EXPORT_SYMBOL_GPL(pmac_backlight_mutex);
 EXPORT_SYMBOL_GPL(pmac_has_backlight_type);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/macintosh/adbhid.c linux-2.6.18-rc1-git8/drivers/macintosh/adbhid.c
--- linux-2.6.18-rc1-git8.orig/drivers/macintosh/adbhid.c	2006-07-14 22:24:11.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/macintosh/adbhid.c	2006-07-14 22:41:10.000000000 +0200
@@ -45,14 +45,11 @@
 #include <linux/pmu.h>
 
 #include <asm/machdep.h>
+#include <asm/backlight.h>
 #ifdef CONFIG_PPC_PMAC
 #include <asm/pmac_feature.h>
 #endif
 
-#ifdef CONFIG_PMAC_BACKLIGHT
-#include <asm/backlight.h>
-#endif
-
 MODULE_AUTHOR("Franz Sirl <Franz.Sirl-kernel@lauterbach.com>");
 
 #define KEYB_KEYREG	0	/* register # for key up/down data */
@@ -237,11 +234,6 @@ static struct adb_ids keyboard_ids;
 static struct adb_ids mouse_ids;
 static struct adb_ids buttons_ids;
 
-#ifdef CONFIG_PMAC_BACKLIGHT
-/* Exported to via-pmu.c */
-int disable_kernel_backlight = 0;
-#endif /* CONFIG_PMAC_BACKLIGHT */
-
 /* Kind of keyboard, see Apple technote 1152  */
 #define ADB_KEYBOARD_UNKNOWN	0
 #define ADB_KEYBOARD_ANSI	0x0100
@@ -527,7 +519,7 @@ adbhid_buttons_input(unsigned char *data
 
 		case 0xa:	/* brightness decrease */
 #ifdef CONFIG_PMAC_BACKLIGHT
-			if (!disable_kernel_backlight && down)
+			if (down)
 				pmac_backlight_key_down();
 #endif
 			input_report_key(adbhid[id]->input, KEY_BRIGHTNESSDOWN, down);
@@ -535,7 +527,7 @@ adbhid_buttons_input(unsigned char *data
 
 		case 0x9:	/* brightness increase */
 #ifdef CONFIG_PMAC_BACKLIGHT
-			if (!disable_kernel_backlight && down)
+			if (down)
 				pmac_backlight_key_up();
 #endif
 			input_report_key(adbhid[id]->input, KEY_BRIGHTNESSUP, down);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/macintosh/Kconfig linux-2.6.18-rc1-git8/drivers/macintosh/Kconfig
--- linux-2.6.18-rc1-git8.orig/drivers/macintosh/Kconfig	2006-07-14 22:24:11.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/macintosh/Kconfig	2006-07-14 22:41:10.000000000 +0200
@@ -115,8 +115,6 @@ config PMAC_BACKLIGHT
 	bool "Backlight control for LCD screens"
 	depends on ADB_PMU && FB = y && (BROKEN || !PPC64)
 	select FB_BACKLIGHT
-	select BACKLIGHT_CLASS_DEVICE
-	select BACKLIGHT_LCD_SUPPORT
 	help
 	  Say Y here to enable Macintosh specific extensions of the generic
 	  backlight code. With this enabled, the brightness keys on older
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/macintosh/via-pmu-backlight.c linux-2.6.18-rc1-git8/drivers/macintosh/via-pmu-backlight.c
--- linux-2.6.18-rc1-git8.orig/drivers/macintosh/via-pmu-backlight.c	2006-07-14 22:24:11.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/macintosh/via-pmu-backlight.c	2006-07-14 22:41:10.000000000 +0200
@@ -15,8 +15,9 @@
 
 #define MAX_PMU_LEVEL 0xFF
 
-static struct device_node *vias;
 static struct backlight_properties pmu_backlight_data;
+static spinlock_t pmu_backlight_lock;
+static int sleeping;
 
 static int pmu_backlight_get_level_brightness(struct fb_info *info,
 		int level)
@@ -40,23 +41,36 @@ static int pmu_backlight_update_status(s
 {
 	struct fb_info *info = class_get_devdata(&bd->class_dev);
 	struct adb_request req;
-	int pmulevel, level = bd->props->brightness;
+	unsigned long flags;
+	int level = bd->props->brightness;
 
-	if (vias == NULL)
-		return -ENODEV;
+	spin_lock_irqsave(&pmu_backlight_lock, flags);
+
+	/* Don't update brightness when sleeping */
+	if (sleeping)
+		goto out;
 
 	if (bd->props->power != FB_BLANK_UNBLANK ||
 	    bd->props->fb_blank != FB_BLANK_UNBLANK)
 		level = 0;
 
-	pmulevel = pmu_backlight_get_level_brightness(info, level);
+	if (level > 0) {
+		int pmulevel = pmu_backlight_get_level_brightness(info, level);
 
-	pmu_request(&req, NULL, 2, PMU_BACKLIGHT_BRIGHT, pmulevel);
-	pmu_wait_complete(&req);
+		pmu_request(&req, NULL, 2, PMU_BACKLIGHT_BRIGHT, pmulevel);
+		pmu_wait_complete(&req);
 
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-		PMU_POW_BACKLIGHT | (level > 0 ? PMU_POW_ON : PMU_POW_OFF));
-	pmu_wait_complete(&req);
+		pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+			PMU_POW_BACKLIGHT | PMU_POW_ON);
+		pmu_wait_complete(&req);
+	} else {
+		pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+			PMU_POW_BACKLIGHT | PMU_POW_OFF);
+		pmu_wait_complete(&req);
+	}
+
+out:
+	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
 
 	return 0;
 }
@@ -73,15 +87,39 @@ static struct backlight_properties pmu_b
 	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
 };
 
-void __init pmu_backlight_init(struct device_node *in_vias)
+#ifdef CONFIG_PM
+static int pmu_backlight_sleep_call(struct pmu_sleep_notifier *self, int when)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_backlight_lock, flags);
+
+	switch (when) {
+	case PBOOK_SLEEP_REQUEST:
+		sleeping = 1;
+		break;
+	case PBOOK_WAKE:
+		sleeping = 0;
+		break;
+	}
+
+	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
+
+	return PBOOK_SLEEP_OK;
+}
+
+static struct pmu_sleep_notifier pmu_backlight_sleep_notif = {
+	.notifier_call = pmu_backlight_sleep_call,
+};
+#endif
+
+void __init pmu_backlight_init()
 {
 	struct backlight_device *bd;
 	struct fb_info *info;
 	char name[10];
 	int level, autosave;
 
-	vias = in_vias;
-
 	/* Special case for the old PowerBook since I can't test on it */
 	autosave =
 		machine_is_compatible("AAPL,3400/2400") ||
@@ -141,6 +179,10 @@ void __init pmu_backlight_init(struct de
 		pmac_backlight = bd;
 	mutex_unlock(&pmac_backlight_mutex);
 
+#ifdef CONFIG_PM
+	pmu_register_sleep_notifier(&pmu_backlight_sleep_notif);
+#endif 
+
 	printk("pmubl: Backlight initialized (%s)\n", name);
 
 	return;
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/macintosh/via-pmu.c linux-2.6.18-rc1-git8/drivers/macintosh/via-pmu.c
--- linux-2.6.18-rc1-git8.orig/drivers/macintosh/via-pmu.c	2006-07-14 22:24:11.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/macintosh/via-pmu.c	2006-07-14 22:41:10.000000000 +0200
@@ -16,7 +16,6 @@
  *    a sleep or a freq. switch
  *  - Move sleep code out of here to pmac_pm, merge into new
  *    common PM infrastructure
- *  - Move backlight code out as well
  *  - Save/Restore PCI space properly
  *
  */
@@ -60,9 +59,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
-#ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
-#endif
 
 #include "via-pmu-event.h"
 
@@ -177,10 +174,6 @@ static int query_batt_timer = BATTERY_PO
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
 
-#if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
-extern int disable_kernel_backlight;
-#endif /* defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT) */
-
 int __fake_sleep;
 int asleep;
 BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
@@ -466,7 +459,7 @@ static int __init via_pmu_dev_init(void)
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* Initialize backlight */
-	pmu_backlight_init(vias);
+	pmu_backlight_init();
 #endif
 
 #ifdef CONFIG_PPC32
@@ -1403,11 +1396,8 @@ next:
 	else if ((1 << pirq) & PMU_INT_SNDBRT) {
 #ifdef CONFIG_PMAC_BACKLIGHT
 		if (len == 3)
-#ifdef CONFIG_INPUT_ADBHID
-			if (!disable_kernel_backlight)
-#endif /* CONFIG_INPUT_ADBHID */
-				pmac_backlight_set_legacy_brightness(data[1] >> 4);
-#endif /* CONFIG_PMAC_BACKLIGHT */
+			pmac_backlight_set_legacy_brightness_pmu(data[1] >> 4);
+#endif
 	}
 	/* Tick interrupt */
 	else if ((1 << pirq) & PMU_INT_TICK) {
@@ -2414,7 +2404,7 @@ struct pmu_private {
 	spinlock_t lock;
 #if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
 	int	backlight_locker;
-#endif /* defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT) */	
+#endif
 };
 
 static LIST_HEAD(all_pmu_pvt);
@@ -2464,7 +2454,7 @@ pmu_open(struct inode *inode, struct fil
 	spin_lock_irqsave(&all_pvt_lock, flags);
 #if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
 	pp->backlight_locker = 0;
-#endif /* defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT) */	
+#endif
 	list_add(&pp->list, &all_pmu_pvt);
 	spin_unlock_irqrestore(&all_pvt_lock, flags);
 	file->private_data = pp;
@@ -2559,13 +2549,12 @@ pmu_release(struct inode *inode, struct 
 		spin_lock_irqsave(&all_pvt_lock, flags);
 		list_del(&pp->list);
 		spin_unlock_irqrestore(&all_pvt_lock, flags);
+
 #if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
-		if (pp->backlight_locker) {
-			spin_lock_irqsave(&pmu_lock, flags);
-			disable_kernel_backlight--;
-			spin_unlock_irqrestore(&pmu_lock, flags);
-		}
-#endif /* defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT) */
+		if (pp->backlight_locker)
+			pmac_backlight_enable();
+#endif
+
 		kfree(pp);
 	}
 	unlock_kernel();
@@ -2642,18 +2631,18 @@ pmu_ioctl(struct inode * inode, struct f
 #ifdef CONFIG_INPUT_ADBHID
 	case PMU_IOC_GRAB_BACKLIGHT: {
 		struct pmu_private *pp = filp->private_data;
-		unsigned long flags;
 
 		if (pp->backlight_locker)
 			return 0;
+
 		pp->backlight_locker = 1;
-		spin_lock_irqsave(&pmu_lock, flags);
-		disable_kernel_backlight++;
-		spin_unlock_irqrestore(&pmu_lock, flags);
+		pmac_backlight_disable();
+
 		return 0;
 	}
 #endif /* CONFIG_INPUT_ADBHID */
 #endif /* CONFIG_PMAC_BACKLIGHT_LEGACY */
+
 	case PMU_IOC_GET_MODEL:
 	    	return put_user(pmu_kind, argp);
 	case PMU_IOC_HAS_ADB:
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/video/aty/aty128fb.c linux-2.6.18-rc1-git8/drivers/video/aty/aty128fb.c
--- linux-2.6.18-rc1-git8.orig/drivers/video/aty/aty128fb.c	2006-07-14 22:24:07.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/video/aty/aty128fb.c	2006-07-14 22:41:10.000000000 +0200
@@ -455,7 +455,10 @@ static void do_wait_for_fifo(u16 entries
 static void wait_for_fifo(u16 entries, struct aty128fb_par *par);
 static void wait_for_idle(struct aty128fb_par *par);
 static u32 depth_to_dst(u32 depth);
+
+#ifdef CONFIG_FB_ATY128_BACKLIGHT
 static void aty128_bl_set_power(struct fb_info *info, int power);
+#endif
 
 #define BIOS_IN8(v)  	(readb(bios + (v)))
 #define BIOS_IN16(v) 	(readb(bios + (v)) | \
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/video/aty/atyfb_base.c linux-2.6.18-rc1-git8/drivers/video/aty/atyfb_base.c
--- linux-2.6.18-rc1-git8.orig/drivers/video/aty/atyfb_base.c	2006-07-14 22:24:07.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/video/aty/atyfb_base.c	2006-07-14 22:41:10.000000000 +0200
@@ -2812,7 +2812,7 @@ static int atyfb_blank(int blank, struct
 	if (par->lock_blank || par->asleep)
 		return 0;
 
-#ifdef CONFIG_PMAC_BACKLIGHT
+#ifdef CONFIG_FB_ATY_BACKLIGHT
 	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
 		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
@@ -2844,7 +2844,7 @@ static int atyfb_blank(int blank, struct
 	}
 	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
 
-#ifdef CONFIG_PMAC_BACKLIGHT
+#ifdef CONFIG_FB_ATY_BACKLIGHT
 	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL)
 		aty_bl_set_power(info, FB_BLANK_UNBLANK);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/drivers/video/Kconfig linux-2.6.18-rc1-git8/drivers/video/Kconfig
--- linux-2.6.18-rc1-git8.orig/drivers/video/Kconfig	2006-07-14 22:24:07.000000000 +0200
+++ linux-2.6.18-rc1-git8/drivers/video/Kconfig	2006-07-14 22:41:10.000000000 +0200
@@ -86,9 +86,11 @@ config FB_MACMODES
        default n
 
 config FB_BACKLIGHT
-       bool
-       depends on FB
-       default n
+	bool
+	depends on FB
+	select BACKLIGHT_LCD_SUPPORT
+	select BACKLIGHT_CLASS_DEVICE
+	default n
 
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
@@ -721,10 +723,8 @@ config FB_NVIDIA_I2C
 
 config FB_NVIDIA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_NVIDIA && PPC_PMAC
+	depends on FB_NVIDIA && PMAC_BACKLIGHT
 	select FB_BACKLIGHT
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -769,10 +769,8 @@ config FB_RIVA_DEBUG
 
 config FB_RIVA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RIVA && PPC_PMAC
+	depends on FB_RIVA && PMAC_BACKLIGHT
 	select FB_BACKLIGHT
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1025,10 +1023,8 @@ config FB_RADEON_I2C
 
 config FB_RADEON_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RADEON && PPC_PMAC
+	depends on FB_RADEON && PMAC_BACKLIGHT
 	select FB_BACKLIGHT
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1059,10 +1055,8 @@ config FB_ATY128
 
 config FB_ATY128_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY128 && PPC_PMAC
+	depends on FB_ATY128 && PMAC_BACKLIGHT
 	select FB_BACKLIGHT
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1111,10 +1105,8 @@ config FB_ATY_GX
 
 config FB_ATY_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY && PPC_PMAC
+	depends on FB_ATY && PMAC_BACKLIGHT
 	select FB_BACKLIGHT
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/include/asm-powerpc/backlight.h linux-2.6.18-rc1-git8/include/asm-powerpc/backlight.h
--- linux-2.6.18-rc1-git8.orig/include/asm-powerpc/backlight.h	2006-07-14 22:24:29.000000000 +0200
+++ linux-2.6.18-rc1-git8/include/asm-powerpc/backlight.h	2006-07-14 22:41:10.000000000 +0200
@@ -30,8 +30,12 @@ static inline void pmac_backlight_key_do
 	pmac_backlight_key(1);
 }
 
+extern void pmac_backlight_set_legacy_brightness_pmu(int brightness);
 extern int pmac_backlight_set_legacy_brightness(int brightness);
 extern int pmac_backlight_get_legacy_brightness(void);
 
+extern void pmac_backlight_enable(void);
+extern void pmac_backlight_disable(void);
+
 #endif /* __KERNEL__ */
 #endif
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc1-git8.orig/include/linux/pmu.h linux-2.6.18-rc1-git8/include/linux/pmu.h
--- linux-2.6.18-rc1-git8.orig/include/linux/pmu.h	2006-07-14 22:24:25.000000000 +0200
+++ linux-2.6.18-rc1-git8/include/linux/pmu.h	2006-07-14 22:41:10.000000000 +0200
@@ -231,7 +231,6 @@ extern struct pmu_battery_info pmu_batte
 extern unsigned int pmu_power_flags;
 
 /* Backlight */
-extern int disable_kernel_backlight;
-extern void pmu_backlight_init(struct device_node*);
+extern void pmu_backlight_init(void);
 
 #endif	/* __KERNEL__ */

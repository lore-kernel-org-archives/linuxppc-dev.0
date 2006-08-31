Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9516E67B5C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 16:43:23 +1000 (EST)
Subject: [PATCH] powerpc: More via-pmu backlight fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 16:42:56 +1000
Message-Id: <1157006577.12526.116.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The via-pmu backlight code (introduced in 2.6.18) has various design
issues causing crashes on machines using it like the old Wallstreet
powerbook (Michael, the author, never managed to test on these and I
just got my hand on one of those old beasts).

This fixes them by no longer trying to hijack the backlight device of
the frontmost framebuffer (causing that framebuffer to crash) but having
it's own local bits instead. Might look weird but it's better that way
on those old machines, at least as a last-minute fix for 2.6.18. We
might rework the whole thing later. This patch also changes the way it
gets notified of sleep and wakeup in order to properly shut the
backlight down on sleep and bring it back on wakeup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

To be applied to 2.6.18 as the current code crashes on some models.

Index: linux-work/drivers/macintosh/via-pmu-backlight.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu-backlight.c	2006-08-17 09:26:20.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu-backlight.c	2006-08-31 15:49:27.000000000 +1000
@@ -18,17 +18,48 @@
 static struct backlight_properties pmu_backlight_data;
 static spinlock_t pmu_backlight_lock;
 static int sleeping;
+static u8 bl_curve[FB_BACKLIGHT_LEVELS];
 
-static int pmu_backlight_get_level_brightness(struct fb_info *info,
-		int level)
+static void pmu_backlight_init_curve(u8 off, u8 min, u8 max)
+{
+	unsigned int i, flat, count, range = (max - min);
+
+	bl_curve[0] = off;
+
+	for (flat = 1; flat < (FB_BACKLIGHT_LEVELS / 16); ++flat)
+		bl_curve[flat] = min;
+
+	count = FB_BACKLIGHT_LEVELS * 15 / 16;
+	for (i = 0; i < count; ++i)
+		bl_curve[flat + i] = min + (range * (i + 1) / count);
+}
+
+static int pmu_backlight_curve_lookup(int value)
+{
+	int level = (FB_BACKLIGHT_LEVELS - 1);
+	int i, max = 0;
+
+	/* Look for biggest value */
+	for (i = 0; i < FB_BACKLIGHT_LEVELS; i++)
+		max = max((int)bl_curve[i], max);
+
+	/* Look for nearest value */
+	for (i = 0; i < FB_BACKLIGHT_LEVELS; i++) {
+		int diff = abs(bl_curve[i] - value);
+		if (diff < max) {
+			max = diff;
+			level = i;
+		}
+	}
+	return level;
+}
+
+static int pmu_backlight_get_level_brightness(int level)
 {
 	int pmulevel;
 
 	/* Get and convert the value */
-	mutex_lock(&info->bl_mutex);
-	pmulevel = info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_PMU_LEVEL;
-	mutex_unlock(&info->bl_mutex);
-
+	pmulevel = bl_curve[level] * FB_BACKLIGHT_MAX / MAX_PMU_LEVEL;
 	if (pmulevel < 0)
 		pmulevel = 0;
 	else if (pmulevel > MAX_PMU_LEVEL)
@@ -39,7 +70,6 @@ static int pmu_backlight_get_level_brigh
 
 static int pmu_backlight_update_status(struct backlight_device *bd)
 {
-	struct fb_info *info = class_get_devdata(&bd->class_dev);
 	struct adb_request req;
 	unsigned long flags;
 	int level = bd->props->brightness;
@@ -55,7 +85,7 @@ static int pmu_backlight_update_status(s
 		level = 0;
 
 	if (level > 0) {
-		int pmulevel = pmu_backlight_get_level_brightness(info, level);
+		int pmulevel = pmu_backlight_get_level_brightness(level);
 
 		pmu_request(&req, NULL, 2, PMU_BACKLIGHT_BRIGHT, pmulevel);
 		pmu_wait_complete(&req);
@@ -88,35 +118,19 @@ static struct backlight_properties pmu_b
 };
 
 #ifdef CONFIG_PM
-static int pmu_backlight_sleep_call(struct pmu_sleep_notifier *self, int when)
+void pmu_backlight_set_sleep(int sleep)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&pmu_backlight_lock, flags);
-
-	switch (when) {
-	case PBOOK_SLEEP_REQUEST:
-		sleeping = 1;
-		break;
-	case PBOOK_WAKE:
-		sleeping = 0;
-		break;
-	}
-
+	sleeping = sleep;
 	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
-
-	return PBOOK_SLEEP_OK;
 }
-
-static struct pmu_sleep_notifier pmu_backlight_sleep_notif = {
-	.notifier_call = pmu_backlight_sleep_call,
-};
-#endif
+#endif /* CONFIG_PM */
 
 void __init pmu_backlight_init()
 {
 	struct backlight_device *bd;
-	struct fb_info *info;
 	char name[10];
 	int level, autosave;
 
@@ -131,27 +145,14 @@ void __init pmu_backlight_init()
 	    !machine_is_compatible("PowerBook1,1"))
 		return;
 
-	/* Actually, this is a hack, but I don't know of a better way
-	 * to get the first framebuffer device.
-	 */
-	info = registered_fb[0];
-	if (!info) {
-		printk("pmubl: No framebuffer found\n");
-		goto error;
-	}
-
-	snprintf(name, sizeof(name), "pmubl%d", info->node);
+	snprintf(name, sizeof(name), "pmubl");
 
-	bd = backlight_device_register(name, info, &pmu_backlight_data);
+	bd = backlight_device_register(name, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
 		printk("pmubl: Backlight registration failed\n");
 		goto error;
 	}
-
-	mutex_lock(&info->bl_mutex);
-	info->bl_dev = bd;
-	fb_bl_default_curve(info, 0x7F, 0x46, 0x0E);
-	mutex_unlock(&info->bl_mutex);
+	pmu_backlight_init_curve(0x7F, 0x46, 0x0E);
 
 	level = pmu_backlight_data.max_brightness;
 
@@ -161,11 +162,9 @@ void __init pmu_backlight_init()
 		pmu_request(&req, NULL, 2, 0xd9, 0);
 		pmu_wait_complete(&req);
 
-		mutex_lock(&info->bl_mutex);
-		level = pmac_backlight_curve_lookup(info,
+		level = pmu_backlight_curve_lookup(
 				(req.reply[0] >> 4) *
 				pmu_backlight_data.max_brightness / 15);
-		mutex_unlock(&info->bl_mutex);
 	}
 
 	up(&bd->sem);
@@ -179,10 +178,6 @@ void __init pmu_backlight_init()
 		pmac_backlight = bd;
 	mutex_unlock(&pmac_backlight_mutex);
 
-#ifdef CONFIG_PM
-	pmu_register_sleep_notifier(&pmu_backlight_sleep_notif);
-#endif
-
 	printk("pmubl: Backlight initialized (%s)\n", name);
 
 	return;
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2006-08-17 09:26:20.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2006-08-31 15:14:33.000000000 +1000
@@ -1995,6 +1995,8 @@ restore_via_state(void)
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
+extern void pmu_backlight_set_sleep(int sleep);
+
 static int
 pmac_suspend_devices(void)
 {
@@ -2032,6 +2034,11 @@ pmac_suspend_devices(void)
 		return -EBUSY;
 	}
 
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code not to muck around with the chip anymore */
+	pmu_backlight_set_sleep(1);
+#endif
+
 	/* Call platform functions marked "on sleep" */
 	pmac_pfunc_i2c_suspend();
 	pmac_pfunc_base_suspend();
@@ -2090,6 +2097,11 @@ pmac_wakeup_devices(void)
 {
 	mdelay(100);
 
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code it can use the chip again */
+	pmu_backlight_set_sleep(0);
+#endif
+
 	/* Power back up system devices (including the PIC) */
 	device_power_up();
 

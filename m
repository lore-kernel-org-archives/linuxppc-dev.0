Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63D7067B2E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 21:42:10 +1000 (EST)
Subject: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149635136.32002.49.camel@johannes>
References: <1149635136.32002.49.camel@johannes>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 12:11:16 +0200
Message-Id: <1150884676.23386.6.camel@johannes>
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

This should address all the objections you voiced: it now is backward
compatible with the old (and now deprecated) Kconfig option by using a
bunch of select Kconfig statements and adding a single line of code in
#ifdef :)

Please pass on for 2.6.18.

---
This patch removes the old pmac ide led blink code and
adds generic LED subsystem support for the LED.

It maintains backward compatibility with the old
BLK_DEV_IDE_PMAC_BLINK Kconfig option which now
simply selects the new code and influences the
default trigger.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.orig/drivers/ide/Kconfig	2006-06-20 16:56:01.589161721 +0200
+++ linux-2.6/drivers/ide/Kconfig	2006-06-21 12:02:08.878721123 +0200
@@ -774,11 +774,18 @@ config BLK_DEV_IDEDMA_PMAC
 	  performance.
 
 config BLK_DEV_IDE_PMAC_BLINK
-	bool "Blink laptop LED on drive activity"
+	bool "Blink laptop LED on drive activity (DEPRECATED)"
 	depends on BLK_DEV_IDE_PMAC && ADB_PMU
+	select ADB_PMU_LED
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_IDE_DISK
 	help
 	  This option enables the use of the sleep LED as a hard drive
 	  activity LED.
+	  This option is deprecated, it only selects ADB_PMU_LED and
+	  LEDS_TRIGGER_IDE_DISK and changes the code in the new led class
+	  device to default to the ide-disk trigger (which should be set
+	  from userspace via sysfs).
 
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
--- linux-2.6.orig/drivers/ide/ppc/pmac.c	2006-06-20 16:56:01.659161721 +0200
+++ linux-2.6/drivers/ide/ppc/pmac.c	2006-06-20 16:56:03.219161721 +0200
@@ -421,107 +421,6 @@ static void pmac_ide_kauai_selectproc(id
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
 /*
- * Below is the code for blinking the laptop LED along with hard
- * disk activity.
- */
-
-#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
-
-/* Set to 50ms minimum led-on time (also used to limit frequency
- * of requests sent to the PMU
- */
-#define PMU_HD_BLINK_TIME	(HZ/50)
-
-static struct adb_request pmu_blink_on, pmu_blink_off;
-static spinlock_t pmu_blink_lock;
-static unsigned long pmu_blink_stoptime;
-static int pmu_blink_ledstate;
-static struct timer_list pmu_blink_timer;
-static int pmu_ide_blink_enabled;
-
-
-static void
-pmu_hd_blink_timeout(unsigned long data)
-{
-	unsigned long flags;
-	
-	spin_lock_irqsave(&pmu_blink_lock, flags);
-
-	/* We may have been triggered again in a racy way, check
-	 * that we really want to switch it off
-	 */
-	if (time_after(pmu_blink_stoptime, jiffies))
-		goto done;
-
-	/* Previous req. not complete, try 100ms more */
-	if (pmu_blink_off.complete == 0)
-		mod_timer(&pmu_blink_timer, jiffies + PMU_HD_BLINK_TIME);
-	else if (pmu_blink_ledstate) {
-		pmu_request(&pmu_blink_off, NULL, 4, 0xee, 4, 0, 0);
-		pmu_blink_ledstate = 0;
-	}
-done:
-	spin_unlock_irqrestore(&pmu_blink_lock, flags);
-}
-
-static void
-pmu_hd_kick_blink(void *data, int rw)
-{
-	unsigned long flags;
-	
-	pmu_blink_stoptime = jiffies + PMU_HD_BLINK_TIME;
-	wmb();
-	mod_timer(&pmu_blink_timer, pmu_blink_stoptime);
-	/* Fast path when LED is already ON */
-	if (pmu_blink_ledstate == 1)
-		return;
-	spin_lock_irqsave(&pmu_blink_lock, flags);
-	if (pmu_blink_on.complete && !pmu_blink_ledstate) {
-		pmu_request(&pmu_blink_on, NULL, 4, 0xee, 4, 0, 1);
-		pmu_blink_ledstate = 1;
-	}
-	spin_unlock_irqrestore(&pmu_blink_lock, flags);
-}
-
-static int
-pmu_hd_blink_init(void)
-{
-	struct device_node *dt;
-	const char *model;
-
-	/* Currently, I only enable this feature on KeyLargo based laptops,
-	 * older laptops may support it (at least heathrow/paddington) but
-	 * I don't feel like loading those venerable old machines with so
-	 * much additional interrupt & PMU activity...
-	 */
-	if (pmu_get_model() != PMU_KEYLARGO_BASED)
-		return 0;
-	
-	dt = of_find_node_by_path("/");
-	if (dt == NULL)
-		return 0;
-	model = (const char *)get_property(dt, "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
-	    strncmp(model, "iBook", strlen("iBook")) != 0) {
-		of_node_put(dt);
-	    	return 0;
-	}
-	of_node_put(dt);
-
-	pmu_blink_on.complete = 1;
-	pmu_blink_off.complete = 1;
-	spin_lock_init(&pmu_blink_lock);
-	init_timer(&pmu_blink_timer);
-	pmu_blink_timer.function = pmu_hd_blink_timeout;
-
-	return 1;
-}
-
-#endif /* CONFIG_BLK_DEV_IDE_PMAC_BLINK */
-
-/*
  * N.B. this can't be an initfunc, because the media-bay task can
  * call ide_[un]register at any time.
  */
@@ -1192,23 +1091,6 @@ pmac_ide_do_suspend(ide_hwif_t *hwif)
 	pmif->timings[0] = 0;
 	pmif->timings[1] = 0;
 	
-#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
-	/* Note: This code will be called for every hwif, thus we'll
-	 * try several time to stop the LED blinker timer,  but that
-	 * should be harmless
-	 */
-	if (pmu_ide_blink_enabled) {
-		unsigned long flags;
-
-		/* Make sure we don't hit the PMU blink */
-		spin_lock_irqsave(&pmu_blink_lock, flags);
-		if (pmu_blink_ledstate)
-			del_timer(&pmu_blink_timer);
-		pmu_blink_ledstate = 0;
-		spin_unlock_irqrestore(&pmu_blink_lock, flags);
-	}
-#endif /* CONFIG_BLK_DEV_IDE_PMAC_BLINK */
-
 	disable_irq(pmif->irq);
 
 	/* The media bay will handle itself just fine */
@@ -1376,13 +1258,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 		hwif->selectproc = pmac_ide_selectproc;
 	hwif->speedproc = pmac_ide_tune_chipset;
 
-#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
-	pmu_ide_blink_enabled = pmu_hd_blink_init();
-
-	if (pmu_ide_blink_enabled)
-		hwif->led_act = pmu_hd_kick_blink;
-#endif
-
 	printk(KERN_INFO "ide%d: Found Apple %s controller, bus ID %d%s, irq %d\n",
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
 	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
--- linux-2.6.orig/drivers/macintosh/Kconfig	2006-06-20 16:56:01.689161721 +0200
+++ linux-2.6/drivers/macintosh/Kconfig	2006-06-20 16:56:03.219161721 +0200
@@ -78,6 +78,17 @@ config ADB_PMU
 	  this device; you should do so if your machine is one of those
 	  mentioned above.
 
+config ADB_PMU_LED
+	bool "Support for the Power/iBook front LED"
+	depends on ADB_PMU
+	select LEDS_CLASS
+	help
+	  Support the front LED on Power/iBooks as a generic LED that can
+	  be triggered by any of the supported triggers. To get the
+	  behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
+	  and the ide-disk LED trigger and configure appropriately through
+	  sysfs.
+
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
 	depends on PPC_PMAC64
--- linux-2.6.orig/drivers/macintosh/Makefile	2006-06-20 16:56:01.729161721 +0200
+++ linux-2.6/drivers/macintosh/Makefile	2006-06-21 11:49:11.698721123 +0200
@@ -12,6 +12,7 @@ obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
 obj-$(CONFIG_PMAC_SMU)		+= smu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2006-06-21 12:09:50.778721123 +0200
@@ -0,0 +1,144 @@
+/*
+ * via-pmu LED class device
+ *
+ * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <asm/prom.h>
+
+static spinlock_t pmu_blink_lock;
+static struct adb_request pmu_blink_req;
+/* -1: no change, 0: request off, 1: request on */
+static int requested_change;
+static int sleeping;
+
+static void pmu_req_done(struct adb_request * req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_blink_lock, flags);
+	/* if someone requested a change in the meantime
+	 * (we only see the last one which is fine)
+	 * then apply it now */
+	if (requested_change != -1 && !sleeping)
+		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
+	/* reset requested change */
+	requested_change = -1;
+	spin_unlock_irqrestore(&pmu_blink_lock, flags);
+}
+
+static void pmu_led_set(struct led_classdev *led_cdev,
+			enum led_brightness brightness)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_blink_lock, flags);
+	switch (brightness) {
+	case LED_OFF:
+		requested_change = 0;
+		break;
+	case LED_FULL:
+		requested_change = 1;
+		break;
+	default:
+		goto out;
+		break;
+	}
+	/* if request isn't done, then don't do anything */
+	if (pmu_blink_req.complete && !sleeping)
+		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
+ out:
+ 	spin_unlock_irqrestore(&pmu_blink_lock, flags);
+}
+
+static struct led_classdev pmu_led = {
+	.name = "pmu-front-led",
+#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
+	.default_trigger = "ide-disk",
+#endif
+	.brightness_set = pmu_led_set,
+};
+
+#ifdef CONFIG_PM
+static int pmu_led_sleep_call(struct pmu_sleep_notifier *self, int when)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_blink_lock, flags);
+
+	switch (when) {
+	case PBOOK_SLEEP_REQUEST:
+		sleeping = 1;
+		break;
+	case PBOOK_WAKE:
+		sleeping = 0;
+		break;
+	default:
+		/* do nothing */
+		break;
+	}
+	spin_unlock_irqrestore(&pmu_blink_lock, flags);
+
+	return PBOOK_SLEEP_OK;
+}
+
+static struct pmu_sleep_notifier via_pmu_led_sleep_notif = {
+	.notifier_call = pmu_led_sleep_call,
+};
+#endif
+
+static int __init via_pmu_led_init(void)
+{
+	struct device_node *dt;
+	const char *model;
+
+	/* only do this on keylargo based models */
+	if (pmu_get_model() != PMU_KEYLARGO_BASED)
+		return -ENODEV;
+
+	dt = of_find_node_by_path("/");
+	if (dt == NULL)
+		return -ENODEV;
+	model = (const char *)get_property(dt, "model", NULL);
+	if (model == NULL)
+		return -ENODEV;
+	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
+	    strncmp(model, "iBook", strlen("iBook")) != 0) {
+		of_node_put(dt);
+		/* ignore */
+		return -ENODEV;
+	}
+	of_node_put(dt);
+
+	spin_lock_init(&pmu_blink_lock);
+	/* no outstanding req */
+	pmu_blink_req.complete = 1;
+	pmu_blink_req.done = pmu_req_done;
+#ifdef CONFIG_PM
+	pmu_register_sleep_notifier(&via_pmu_led_sleep_notif);
+#endif
+	return led_classdev_register(NULL, &pmu_led);
+}
+
+late_initcall(via_pmu_led_init);

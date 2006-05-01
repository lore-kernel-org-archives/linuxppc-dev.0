Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E62ED679A6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 07:20:03 +1000 (EST)
Subject: Re: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146476158.30710.51.camel@localhost.localdomain>
References: <1146235779.19164.109.camel@localhost>
	<1146237326.19164.111.camel@localhost>
	<1146466608.30710.36.camel@localhost.localdomain>
	<1146473959.24172.4.camel@localhost>
	<1146474648.30710.48.camel@localhost.localdomain>
	<1146475513.24172.10.camel@localhost>
	<1146476158.30710.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 May 2006 23:19:50 +0200
Message-Id: <1146518390.27351.62.camel@localhost>
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

On Mon, 2006-05-01 at 19:35 +1000, Benjamin Herrenschmidt wrote:

> No need to schedule work, it should work fine to re-queue

Untested because I haven't rebooted. Does this look good to you?
I don't see how I could get away without locking, especially with
handling the outstanding requests (though loosing one there might not be
too bad).

johannes

Index: wireless-dev/drivers/ide/Kconfig
===================================================================
--- wireless-dev.orig/drivers/ide/Kconfig	2006-04-30 22:17:49.201535187 +0200
+++ wireless-dev/drivers/ide/Kconfig	2006-04-30 22:17:51.911535187 +0200
@@ -773,13 +773,6 @@ config BLK_DEV_IDEDMA_PMAC
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
 
-config BLK_DEV_IDE_PMAC_BLINK
-	bool "Blink laptop LED on drive activity"
-	depends on BLK_DEV_IDE_PMAC && ADB_PMU
-	help
-	  This option enables the use of the sleep LED as a hard drive
-	  activity LED.
-
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
 	depends on SIBYTE_SB1xxx_SOC
Index: wireless-dev/drivers/ide/ppc/pmac.c
===================================================================
--- wireless-dev.orig/drivers/ide/ppc/pmac.c	2006-04-30 22:17:49.221535187 +0200
+++ wireless-dev/drivers/ide/ppc/pmac.c	2006-04-30 22:17:51.911535187 +0200
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
@@ -1190,23 +1089,6 @@ pmac_ide_do_suspend(ide_hwif_t *hwif)
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
@@ -1374,13 +1256,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
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
Index: wireless-dev/drivers/macintosh/Kconfig
===================================================================
--- wireless-dev.orig/drivers/macintosh/Kconfig	2006-04-30 22:17:49.301535187 +0200
+++ wireless-dev/drivers/macintosh/Kconfig	2006-05-01 22:39:34.951534234 +0200
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
Index: wireless-dev/drivers/macintosh/Makefile
===================================================================
--- wireless-dev.orig/drivers/macintosh/Makefile	2006-04-30 22:17:49.311535187 +0200
+++ wireless-dev/drivers/macintosh/Makefile	2006-05-01 22:36:32.871534234 +0200
@@ -12,6 +12,7 @@ obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
 obj-$(CONFIG_PMAC_SMU)		+= smu.o
Index: wireless-dev/drivers/macintosh/via-pmu-led.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-led.c	2006-05-01 23:18:41.001534234 +0200
@@ -0,0 +1,120 @@
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
+			 enum led_brightness brightness)
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
+static struct pmu_sleep_notifier pmu_led_sleep_notif = {
+	.notifier_call = pmu_led_sleep_call,
+};
+#endif
+
+static __init int pmu_led_init(void)
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
+		/* silently ignore */
+		return 0;
+	}
+	of_node_put(dt);
+
+	spin_lock_init(&pmu_blink_lock);
+	/* no outstanding req */
+	pmu_blink_req.complete = 1;
+	pmu_blink_req.done = pmu_req_done;
+#ifdef CONFIG_PM
+	pmu_register_sleep_notifier(&pmu_led_sleep_notif);
+#endif
+	return led_classdev_register(NULL, &pmu_led);
+}
+
+late_initcall(pmu_led_init);

Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14362679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 01:24:23 +1000 (EST)
Subject: [PATCH] convert powermac ide blink to new led infrastructure
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 16:49:39 +0200
Message-Id: <1146235779.19164.109.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the old pmac ide led blink code and adds generic LED
subsystem support for the LED.

Ben: I removed the retry code that was present in the original. I guess
LEDs aren't really too important but if it really is necessary please
tell me and I'll add it back.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.orig/drivers/ide/Kconfig	2006-04-28 13:13:38.777288704 +0200
+++ linux-2.6/drivers/ide/Kconfig	2006-04-28 13:13:48.797288704 +0200
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
--- linux-2.6.orig/drivers/ide/ppc/pmac.c	2006-04-28 13:13:58.967288704 +0200
+++ linux-2.6/drivers/ide/ppc/pmac.c	2006-04-28 13:17:01.657288704 +0200
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
--- linux-2.6.orig/drivers/macintosh/Kconfig	2006-04-28 13:31:24.347288704 +0200
+++ linux-2.6/drivers/macintosh/Kconfig	2006-04-28 13:31:43.677288704 +0200
@@ -78,6 +78,16 @@ config ADB_PMU
 	  this device; you should do so if your machine is one of those
 	  mentioned above.
 
+config ADB_PMU_LED
+	bool "Support for the Power/iBook front LED"
+	depends on LEDS_CLASS && ADB_PMU
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
--- linux-2.6.orig/drivers/macintosh/Makefile	2006-04-28 13:35:17.977288704 +0200
+++ linux-2.6/drivers/macintosh/Makefile	2006-04-28 13:46:44.887288704 +0200
@@ -12,6 +12,7 @@ obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
 obj-$(CONFIG_PMAC_SMU)		+= smu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2006-04-28 13:56:28.537288704 +0200
@@ -0,0 +1,80 @@
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <asm/prom.h>
+#include "via-pmu-led.h"
+
+static spinlock_t pmu_blink_lock;
+static struct adb_request pmu_blink_req;
+
+static void pmu_led_off(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_blink_lock, flags);
+	/* I currently ignore the result of this request */
+	pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, 0);
+	spin_unlock_irqrestore(&pmu_blink_lock, flags);
+}
+
+static void pmu_led_on(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_blink_lock, flags);
+	pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, 1);
+	spin_unlock_irqrestore(&pmu_blink_lock, flags);
+}
+
+static void pmu_led_set(struct led_classdev *led_cdev,
+			 enum led_brightness brightness)
+{
+	switch (brightness) {
+	case LED_OFF:
+		pmu_led_off();
+		break;
+	case LED_FULL:
+		pmu_led_on();
+		break;
+	default:
+		/* ignore other levels */
+		break;
+	}
+}
+
+static struct led_classdev pmu_led = {
+	.name = "pmu-front-led",
+	.brightness_set = pmu_led_set,
+};
+
+int pmu_led_init(void)
+{
+	/* this is only called for keylargo based systems */
+	struct device_node *dt;
+	const char *model;
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
+	return led_classdev_register(NULL, &pmu_led);
+}
+
+void pmu_led_exit(void)
+{
+	led_classdev_unregister(&pmu_led);
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-led.h	2006-04-28 13:48:19.177288704 +0200
@@ -0,0 +1,18 @@
+#ifndef __VIA_PMU_LED_H
+#define __VIA_PMU_LED_H
+#include <config/adb/pmu/led.h>
+
+#ifdef CONFIG_ADB_PMU_LED
+extern int pmu_led_init(void);
+extern void pmu_led_exit(void);
+#else
+static inline int pmu_led_init(void)
+{
+	return 0;
+}
+static inline void pmu_led_exit(void)
+{
+}
+#endif /* CONFIG_ADB_PMU_LED */
+
+#endif /* __VIA_PMU_LED_H */
--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2006-04-28 13:09:02.197288704 +0200
+++ linux-2.6/drivers/macintosh/via-pmu.c	2006-04-28 15:58:45.497288704 +0200
@@ -69,6 +69,8 @@
 #include <asm/open_pic.h>
 #endif
 
+#include "via-pmu-led.h"
+
 /* Some compile options */
 #undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
@@ -2896,11 +2898,25 @@ static int __init init_pmu_sysfs(void)
 		printk(KERN_ERR "Failed registering PMU sys driver\n");
 		return -ENODEV;
 	}
+
 	return 0;
 }
 
 subsys_initcall(init_pmu_sysfs);
 
+static int __init init_pmu_led(void)
+{
+	if (pmu_kind == PMU_KEYLARGO_BASED) {
+		if (pmu_led_init()) {
+			printk(KERN_WARNING "via-pmu: LED failed to init\n");
+		}
+	}
+
+	return 0;
+}
+
+late_initcall(init_pmu_led);
+
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_queue_request);
 EXPORT_SYMBOL(pmu_poll);

Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8591F67C5B
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Aug 2006 22:30:32 +1000 (EST)
Date: Sun, 27 Aug 2006 14:30:15 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Keyboard backlight driver for Oct 2005 PowerBooks
Message-ID: <20060827123015.GA4697@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: johannes@sipsolutions.net, rpurdie@rpsys.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This driver provides an interface to the keyboard backlight on Oct 2005
PowerBooks, which have the backlight behind the PMU. This driver doesn't
support the I²C variant used in earlier PowerBooks.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc4-git1.orig/drivers/macintosh/Kconfig linux-2.6.18-rc4-git1/drivers/macintosh/Kconfig
--- linux-2.6.18-rc4-git1.orig/drivers/macintosh/Kconfig	2006-08-26 22:24:36.000000000 +0200
+++ linux-2.6.18-rc4-git1/drivers/macintosh/Kconfig	2006-08-27 02:39:05.000000000 +0200
@@ -99,6 +99,14 @@ config ADB_PMU_LED_IDE
 	  This option makes the front LED default to the IDE trigger
 	  so that it blinks on IDE activity.
 
+config ADB_PMU_ALS_LED
+	bool "Support for keyboard backlight"
+	depends on ADB_PMU
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  Support for the keyboard backlight on Oct 2005 PowerBooks.
+
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
 	depends on PPC_PMAC64
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc4-git1.orig/drivers/macintosh/Makefile linux-2.6.18-rc4-git1/drivers/macintosh/Makefile
--- linux-2.6.18-rc4-git1.orig/drivers/macintosh/Makefile	2006-08-26 22:24:36.000000000 +0200
+++ linux-2.6.18-rc4-git1/drivers/macintosh/Makefile	2006-08-27 02:39:55.000000000 +0200
@@ -13,6 +13,7 @@ obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
+obj-$(CONFIG_ADB_PMU_ALS_LED)	+= via-pmu-als-led.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-backlight.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc4-git1.orig/drivers/macintosh/via-pmu-als-led.c linux-2.6.18-rc4-git1/drivers/macintosh/via-pmu-als-led.c
--- linux-2.6.18-rc4-git1.orig/drivers/macintosh/via-pmu-als-led.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-rc4-git1/drivers/macintosh/via-pmu-als-led.c	2006-08-27 04:01:16.000000000 +0200
@@ -0,0 +1,107 @@
+/*
+ * Driver for keyboard backlight on Oct 2005 PowerBooks
+ *
+ * Copyright 2006 Michael Hanselmann <linux-kernel@hansmi.ch>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <asm/prom.h>
+
+static spinlock_t ams_led_pmu_lock;
+static struct adb_request pmu_req = {
+	.complete = 1,
+};
+static int sleeping;
+static int pmu_cmd;
+
+static void als_led_pmu_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ams_led_pmu_lock, flags);
+
+	if (pmu_req.complete && !sleeping) {
+		if (brightness < 0)
+			brightness = 0;
+		else if (brightness > 255)
+			brightness = 255;
+
+		pmu_request(&pmu_req, NULL, 4, pmu_cmd, 0, 0, brightness);
+	}
+
+ 	spin_unlock_irqrestore(&ams_led_pmu_lock, flags);
+}
+
+static struct led_classdev als_led = {
+	.name = "als-led-pmu",
+	.brightness_set = als_led_pmu_set,
+};
+
+#ifdef CONFIG_PM
+static int als_led_pmu_sleep_call(struct pmu_sleep_notifier *self, int when)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ams_led_pmu_lock, flags);
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
+
+	spin_unlock_irqrestore(&ams_led_pmu_lock, flags);
+
+	return PBOOK_SLEEP_OK;
+}
+
+static struct pmu_sleep_notifier als_led_pmu_sleep_notif = {
+	.notifier_call = als_led_pmu_sleep_call,
+};
+#endif
+
+static int __init als_led_pmu_init(void)
+{
+	struct device_node *np;
+	u32 *reg;
+
+	np = of_find_node_by_name(NULL, "als-controls");
+	if (!np)
+		return -ENODEV;
+
+	reg = (u32*)get_property(np, "reg", NULL);
+	if (!reg || !*reg)
+		return -ENODEV;
+
+	pmu_cmd = ((*reg) >> 8) & 0xff;
+
+	of_node_put(np);
+
+	spin_lock_init(&ams_led_pmu_lock);
+
+#ifdef CONFIG_PM
+	pmu_register_sleep_notifier(&als_led_pmu_sleep_notif);
+#endif
+
+	return led_classdev_register(NULL, &als_led);
+}
+
+late_initcall(als_led_pmu_init);

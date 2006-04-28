Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA703679F5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 05:15:18 +1000 (EST)
Subject: [PATCH] via-pmu: report powerbutton as proper input event
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 21:15:13 +0200
Message-Id: <1146251713.5019.4.camel@localhost>
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

This patch adds an input device for the power button so that userspace gets
notified about the user pressing it via the standard input layer.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.orig/drivers/macintosh/Makefile	2006-04-28 19:07:27.057288704 +0200
+++ linux-2.6/drivers/macintosh/Makefile	2006-04-28 19:07:49.987288704 +0200
@@ -11,7 +11,7 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-event.c	2006-04-28 20:35:12.277288704 +0200
@@ -0,0 +1,35 @@
+#include <linux/input.h>
+#include "via-pmu-event.h"
+
+static struct input_dev *pmu_input_dev;
+
+int pmu_event_init(void)
+{
+	pmu_input_dev = input_allocate_device();
+	if (unlikely(!pmu_input_dev))
+		return -ENODEV;
+
+	pmu_input_dev->name = "PMU powerbutton";
+	pmu_input_dev->id.bustype = BUS_PMU;
+	pmu_input_dev->id.vendor = 0x0001;
+	pmu_input_dev->id.product = 0x0001;
+	pmu_input_dev->id.version = 0x0100;
+
+	pmu_input_dev->evbit[0] = BIT(EV_KEY);
+	pmu_input_dev->keybit[LONG(KEY_POWER)] = BIT(KEY_POWER);
+
+	return input_register_device(pmu_input_dev);
+}
+
+void pmu_event_powerbutton(int down)
+{
+	static int powerbutton_pressed;
+
+	if (unlikely(!pmu_input_dev))
+		return;
+	if (powerbutton_pressed == down)
+		return;
+	powerbutton_pressed = down;
+	input_report_key(pmu_input_dev, KEY_POWER, down);
+	input_sync(pmu_input_dev);
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/macintosh/via-pmu-event.h	2006-04-28 20:09:34.967288704 +0200
@@ -0,0 +1,8 @@
+#ifndef __VIA_PMU_EVENT_H
+#define __VIA_PMU_EVENT_H
+
+extern int pmu_event_init(void);
+
+extern void pmu_event_powerbutton(int down);
+
+#endif /* __VIA_PMU_EVENT_H */
--- linux-2.6.orig/include/linux/input.h	2006-04-28 20:00:37.417288704 +0200
+++ linux-2.6/include/linux/input.h	2006-04-28 20:00:48.157288704 +0200
@@ -658,6 +658,7 @@ struct input_absinfo {
 #define BUS_I2C			0x18
 #define BUS_HOST		0x19
 #define BUS_GSC			0x1A
+#define BUS_PMU			0x20
 
 /*
  * Values describing the status of an effect
--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2006-04-28 19:07:19.207288704 +0200
+++ linux-2.6/drivers/macintosh/via-pmu.c	2006-04-28 20:35:23.417288704 +0200
@@ -70,6 +70,7 @@
 #endif
 
 #include "via-pmu-led.h"
+#include "via-pmu-event.h"
 
 /* Some compile options */
 #undef SUSPEND_USES_PMU
@@ -1443,6 +1444,11 @@ next:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
+		/* if the thing has the powerbutton bit set then
+		 * update the powerbutton key status */
+		if (len == 6) {
+			pmu_event_powerbutton(!!(data[1]&8));
+		}
 	} else {
 	       pmu_pass_intr(data, len);
 	}
@@ -2915,6 +2921,10 @@ static int __init init_pmu_led(void)
 		if (pmu_led_init()) {
 			printk(KERN_WARNING "via-pmu: LED failed to init\n");
 		}
+
+		/* only on keylargo can the power button be on the pmu ... */
+		if (pmu_event_init())
+			printk(KERN_WARNING "via-pmu: couldn't add event device");
 	}
 
 	return 0;

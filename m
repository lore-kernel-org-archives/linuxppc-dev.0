Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0C0C67D58
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 21:39:28 +1000 (EST)
Subject: [PATCH] via-pmu: add input device
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <1149245659.11092.1.camel@johannes.berg>
References: <200606020322.k523Mpe4028607@shell0.pdx.osdl.net>
	<200606012344.13751.dtor_core@ameritech.net>
	<1149245659.11092.1.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 00:58:33 +0200
Message-Id: <1149634713.32002.44.camel@johannes>
Mime-Version: 1.0
Cc: akpm@osdl.org, mjg59@srcf.ucam.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, pavel@suse.cz,
	rpurdie@rpsys.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Almost forgot to make a new patch. Bah. Here it is, also containing the
cleanups by Andrew, thanks.
---
This patch adds an input device for the button and lid switch
so that userspace gets notified about the user pressing them
via the standard input layer.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/drivers/macintosh/Makefile	2006-06-07 00:50:11.351517067 +0200
+++ wireless-dev/drivers/macintosh/Makefile	2006-06-07 00:50:11.531517067 +0200
@@ -11,7 +11,7 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
+obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
 obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-event.c	2006-06-07 00:52:40.821517067 +0200
@@ -0,0 +1,80 @@
+/*
+ * via-pmu event device for reporting some events that come through the PMU
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
+
+#include <linux/input.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include "via-pmu-event.h"
+
+static struct input_dev *pmu_input_dev;
+
+static int __init via_pmu_event_init(void)
+{
+	int err;
+
+	/* do other models report button/lid status? */
+	if (pmu_get_model() != PMU_KEYLARGO_BASED)
+		return -ENODEV;
+
+	pmu_input_dev = input_allocate_device();
+	if (!pmu_input_dev)
+		return -ENOMEM;
+
+	pmu_input_dev->name = "PMU";
+	pmu_input_dev->id.bustype = BUS_HOST;
+	pmu_input_dev->id.vendor = 0x0001;
+	pmu_input_dev->id.product = 0x0001;
+	pmu_input_dev->id.version = 0x0100;
+
+	set_bit(EV_KEY, pmu_input_dev->evbit);
+	set_bit(EV_SW, pmu_input_dev->evbit);
+	set_bit(KEY_POWER, pmu_input_dev->keybit);
+	set_bit(SW_LID, pmu_input_dev->swbit);
+
+	err = input_register_device(pmu_input_dev);
+	if (err)
+		input_free_device(pmu_input_dev);
+	return err;
+}
+
+void via_pmu_event(int key, int down)
+{
+
+	if (unlikely(!pmu_input_dev))
+		return;
+
+	switch (key) {
+	case PMU_EVT_POWER:
+		input_report_key(pmu_input_dev, KEY_POWER, down);
+		break;
+	case PMU_EVT_LID:
+		input_report_switch(pmu_input_dev, SW_LID, down);
+		break;
+	default:
+		/* no such key handled */
+		return;
+	}
+
+	input_sync(pmu_input_dev);
+}
+
+late_initcall(via_pmu_event_init);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wireless-dev/drivers/macintosh/via-pmu-event.h	2006-06-07 00:51:09.821517067 +0200
@@ -0,0 +1,8 @@
+#ifndef __VIA_PMU_EVENT_H
+#define __VIA_PMU_EVENT_H
+
+#define PMU_EVT_POWER	0
+#define PMU_EVT_LID	1
+extern void via_pmu_event(int key, int down);
+
+#endif /* __VIA_PMU_EVENT_H */
--- wireless-dev.orig/drivers/macintosh/via-pmu.c	2006-05-26 15:42:44.622052079 +0200
+++ wireless-dev/drivers/macintosh/via-pmu.c	2006-06-07 00:51:01.991517067 +0200
@@ -69,6 +69,8 @@
 #include <asm/open_pic.h>
 #endif
 
+#include "via-pmu-event.h"
+
 /* Some compile options */
 #undef SUSPEND_USES_PMU
 #define DEBUG_SLEEP
@@ -1441,6 +1443,12 @@ next:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
+		/* len == 6 is probably a bad check. But how do I
+		 * know what PMU versions send what events here? */
+		if (len == 6) {
+			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
+			via_pmu_event(PMU_EVT_LID, data[1]&1);
+		}
 	} else {
 	       pmu_pass_intr(data, len);
 	}

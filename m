Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C91C9DDE9E
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Dec 2006 22:29:32 +1100 (EST)
Date: Sun, 24 Dec 2006 12:23:51 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: benh@kernel.crashing.org
Subject: [PATCH] SMU LED driver
Message-ID: <20061224112351.GA27260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a driver for the front LED in recent PowerMacs which
have an SMU.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/macintosh/Kconfig linux-2.6.19.1/drivers/macintosh/Kconfig
--- linux-2.6.19.1.orig/drivers/macintosh/Kconfig	2006-12-24 12:19:05.000000000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Kconfig	2006-12-24 12:19:41.000000000 +0100
@@ -107,6 +107,15 @@ config PMAC_SMU
 	  on the "SMU" system control chip which replaces the old PMU.
 	  If you don't know, say Y.
 
+config PMAC_SMU_LED
+	tristate "Support for the PowerMac front LED"
+	depends on PMAC_SMU
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  Support the front LED on PowerMacs as a generic LED that can be
+	  triggered by any of the supported triggers.
+
 config PMAC_APM_EMU
 	tristate "APM emulation"
 	depends on PPC_PMAC && PPC32 && PM && ADB_PMU
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/macintosh/Makefile linux-2.6.19.1/drivers/macintosh/Makefile
--- linux-2.6.19.1.orig/drivers/macintosh/Makefile	2006-12-24 12:19:05.000000000 +0100
+++ linux-2.6.19.1/drivers/macintosh/Makefile	2006-12-24 12:19:24.000000000 +0100
@@ -17,6 +17,7 @@ obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
 obj-$(CONFIG_PMAC_SMU)		+= smu.o
+obj-$(CONFIG_PMAC_SMU_LED)	+= smu-led.o
 
 obj-$(CONFIG_ADB)		+= adb.o
 obj-$(CONFIG_ADB_MACII)		+= via-macii.o
diff -Nrup --exclude-from linux-exclude-from linux-2.6.19.1.orig/drivers/macintosh/smu-led.c linux-2.6.19.1/drivers/macintosh/smu-led.c
--- linux-2.6.19.1.orig/drivers/macintosh/smu-led.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19.1/drivers/macintosh/smu-led.c	2006-12-24 12:19:24.000000000 +0100
@@ -0,0 +1,91 @@
+/*
+ * smu LED class device
+ *
+ * Copyright 2006 Michael Hanselmann <linux-kernel@hansmi.ch>
+ *
+ * This code is based upon via-pmu-led, written by Johannes Berg, and a sample
+ * program written by Benjamin Herrenschmidt.
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
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/leds.h>
+#include <asm/smu.h>
+
+static void smu_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	struct smu_simple_cmd cmd;
+	DECLARE_COMPLETION_ONSTACK(comp);
+	unsigned int value;
+	int rc;
+
+	switch (brightness) {
+	case LED_OFF:
+		value = 0;
+		break;
+
+	case LED_FULL:
+		value = 1;
+		break;
+
+	default:
+		return;
+	}
+
+	rc = smu_queue_simple(&cmd, SMU_CMD_MISC_ee_COMMAND, 3,
+		smu_done_complete, &comp,
+		SMU_CMD_MISC_ee_LEDS_CTRL, 0x00, value);
+	if (rc) {
+		printk(KERN_ERR "smu-led: "
+			"Queueing failed, error %d\n", rc);
+		return;
+	}
+
+	wait_for_completion(&comp);
+
+	if (cmd.cmd.status != 0) {
+		printk(KERN_ERR "smu-led: Setting LED value failed\n");
+		return;
+	}
+}
+
+static struct led_classdev smu_led = {
+	.name = "smu-front-led",
+	.brightness_set = smu_led_set,
+};
+
+static int __init smu_led_init(void)
+{
+	if (!smu_present())
+		return -ENODEV;
+
+	return led_classdev_register(NULL, &smu_led);
+}
+
+static void __exit smu_led_exit(void)
+{
+}
+
+module_init(smu_led_init);
+module_exit(smu_led_exit);
+
+MODULE_AUTHOR("Michael Hanselmann <linux-kernel@hansmi.ch>");
+MODULE_DESCRIPTION("Front LED support for SMU based PowerMacs");
+MODULE_LICENSE("GPL");

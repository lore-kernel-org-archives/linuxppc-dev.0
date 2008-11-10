Return-Path: <a.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id AB7A2DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 02:47:21 +1100 (EST)
From: Alessandro Zummo <a.zummo@towertech.it>
Subject: [RFC PATCH] rtc: add rtc_systohc for ntp use
To: rtc-linux@googlegroups.com
Date: Mon, 10 Nov 2008 16:40:27 +0100
Message-ID: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, David Woodhouse <dwmw2@infradead.org>,
	Alessandro Zummo <a.zummo@towertech.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds in-kernel hctosys functionality that can
be used by ntp sync code.

This is an RFC and has not been tested, I just want
to check if something similar could solve the problems
of those who want the NTP sync mode.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: David Brownell <david-b@pacbell.net>
Cc: David Woodhouse <dwmw2@infradead.org>
---

 drivers/rtc/Kconfig   |   19 ++++++++++++++++++-
 drivers/rtc/Makefile  |    1 +
 drivers/rtc/systohc.c |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100644 drivers/rtc/systohc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8abbb20..1ff9427 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -30,7 +30,7 @@ config RTC_HCTOSYS
 	  unnecessary fsck runs at boot time, and to network better.
 
 config RTC_HCTOSYS_DEVICE
-	string "RTC used to set the system time"
+	string "RTC used to set the system time on startup and resume"
 	depends on RTC_HCTOSYS = y
 	default "rtc0"
 	help
@@ -52,6 +52,23 @@ config RTC_HCTOSYS_DEVICE
 	  sleep states. Do not specify an RTC here unless it stays powered
 	  during all this system's supported sleep states.
 
+config RTC_SYSTOHC
+	bool "Set RTC from system time in NTP sync mode"
+	depends on RTC_CLASS = y
+	default y
+	help
+	  If you say yes here, the system time (wall clock) will be written
+	  to the hardware clock every 11 minutes, if the kernel is in NTP
+	  mode and your platforms supports it.
+
+config RTC_SYSTOHC_DEVICE
+	string "RTC used to save the system time in NTP sync mode"
+	depends on RTC_SYSTOHC = y
+	default "rtc0"
+	help
+	  The RTC device that will get written with the system time
+	  in NTP mode.
+
 config RTC_DEBUG
 	bool "RTC debug support"
 	depends on RTC_CLASS = y
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e9e8474..6d1c519 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -8,6 +8,7 @@ endif
 
 obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
+obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 rtc-core-y			:= class.o interface.o
 
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
new file mode 100644
index 0000000..41ec77b
--- /dev/null
+++ b/drivers/rtc/systohc.c
@@ -0,0 +1,35 @@
+/*
+ * RTC subsystem, systohc for ntp use
+ *
+ * Copyright (C) 2008 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/rtc.h>
+
+static int rtc_systohc(struct rtc_time *tm)
+{
+	int err;
+	struct rtc_time tm;
+	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
+
+	if (rtc == NULL) {
+		printk("%s: unable to open rtc device (%s)\n",
+			__FILE__, CONFIG_RTC_SYSTOHC_DEVICE);
+		return -ENODEV;
+	}
+
+	err = rtc_set_time(rtc, tm);
+	if (err != 0)
+		dev_err(rtc->dev.parent,
+			"systohc: unable to set the hardware clock\n");
+
+	rtc_class_close(rtc);
+
+	return err;
+}
+EXPORT_SYMBOL(rtc_systohc);

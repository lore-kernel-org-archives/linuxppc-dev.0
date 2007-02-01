Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 419E1DDF74
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 23:13:51 +1100 (EST)
Subject: [PATCH] powermac: proper time of day after resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1169620444.18754.66.camel@localhost.localdomain>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Feb 2007 20:16:30 +0100
Message-Id: <1170357390.4036.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch converts the time restore code from a PMU notifier to a regular
sys device so any powerpc platform will use it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/Kconfig                           |    5 +
 arch/powerpc/kernel/Makefile                   |    1
 arch/powerpc/platforms/powermac/time.c         |   38 -------------
 mb-wireless/arch/powerpc/kernel/time_suspend.c |   70 +++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 38 deletions(-)

Tested on my powerbook.

The rtc library is necessary for rtc_tm_to_time, I could of course copy
it instead.

--- mb-wireless.orig/arch/powerpc/platforms/powermac/time.c	2007-01-25 14:09:12.288927117 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/time.c	2007-01-26 14:16:18.598954773 +0100
@@ -297,49 +297,11 @@ int __init via_calibrate_decr(void)
 }
 #endif
 
-#ifdef CONFIG_PM
-/*
- * Reset the time after a sleep.
- */
-static int
-time_sleep_notify(struct pmu_sleep_notifier *self, int when)
-{
-	static unsigned long time_diff;
-	unsigned long flags;
-	unsigned long seq;
-	struct timespec tv;
-
-	switch (when) {
-	case PBOOK_SLEEP_NOW:
-		do {
-			seq = read_seqbegin_irqsave(&xtime_lock, flags);
-			time_diff = xtime.tv_sec - pmac_get_boot_time();
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-		break;
-	case PBOOK_WAKE:
-		tv.tv_sec = pmac_get_boot_time() + time_diff;
-		tv.tv_nsec = 0;
-		do_settimeofday(&tv);
-		break;
-	}
-	return PBOOK_SLEEP_OK;
-}
-
-static struct pmu_sleep_notifier time_sleep_notifier = {
-	time_sleep_notify, SLEEP_LEVEL_MISC,
-};
-#endif /* CONFIG_PM */
-
 /*
  * Query the OF and get the decr frequency.
  */
 void __init pmac_calibrate_decr(void)
 {
-#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
-	/* XXX why here? */
-	pmu_register_sleep_notifier(&time_sleep_notifier);
-#endif
-
 	generic_calibrate_decr();
 
 #ifdef CONFIG_PPC32
--- mb-wireless.orig/arch/powerpc/kernel/Makefile	2007-01-26 14:16:35.838954773 +0100
+++ mb-wireless/arch/powerpc/kernel/Makefile	2007-01-26 14:16:47.918954773 +0100
@@ -50,6 +50,7 @@ extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o
+obj-$(CONFIG_PM)		+= time_suspend.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/kernel/time_suspend.c	2007-02-01 19:38:59.818907090 +0100
@@ -0,0 +1,70 @@
+/*
+ * Common code to keep time when machine suspends.
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <linux/time.h>
+#include <asm/rtc.h>
+
+static unsigned long suspend_rtc_time;
+
+/*
+ * Reset the time after a sleep.
+ */
+static int timer_resume(struct sys_device *dev)
+{
+	struct timeval tv;
+	struct timespec ts;
+	struct rtc_time cur_rtc_tm;
+	unsigned long cur_rtc_time, diff;
+
+	/* get current RTC time and convert to seconds */
+	get_rtc_time(&cur_rtc_tm);
+	rtc_tm_to_time(&cur_rtc_tm, &cur_rtc_time);
+
+	diff = cur_rtc_time - suspend_rtc_time;
+
+	/* adjust time of day by seconds that elapsed while
+	 * we were suspended */
+	do_gettimeofday(&tv);
+	ts.tv_sec = tv.tv_sec + diff;
+	ts.tv_nsec = tv.tv_usec * NSEC_PER_USEC;
+	do_settimeofday(&ts);
+
+	return 0;
+}
+
+static int timer_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct rtc_time suspend_rtc_tm;
+	WARN_ON(!ppc_md.get_rtc_time);
+
+	get_rtc_time(&suspend_rtc_tm);
+	rtc_tm_to_time(&suspend_rtc_tm, &suspend_rtc_time);
+
+	return 0;
+}
+
+static struct sysdev_class timer_sysclass = {
+	.resume = timer_resume,
+	.suspend = timer_suspend,
+	set_kset_name("timer"),
+};
+
+static struct sys_device device_timer = {
+	.id = 0,
+	.cls = &timer_sysclass,
+};
+
+static int time_init_device(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(time_init_device);
--- mb-wireless.orig/arch/powerpc/Kconfig	2007-02-01 19:43:27.478907090 +0100
+++ mb-wireless/arch/powerpc/Kconfig	2007-02-01 19:44:09.138907090 +0100
@@ -11,6 +11,11 @@ config PPC64
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
 
+config PPC_PM_NEEDS_RTC_LIB
+	bool
+	select RTC_LIB
+	default y if PM
+
 config PPC32
 	bool
 	default y if !PPC64

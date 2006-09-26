Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 954AC67B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 08:46:47 +1000 (EST)
Date: Tue, 26 Sep 2006 17:46:37 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Add powerpc get/set_rtc_time interface to new generic
	rtc class
Message-Id: <20060926174637.1f70938d.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add powerpc get/set_rtc_time interface to new generic rtc class. This
abstracts rtc chip specific code from the platform code for rtc-over-i2c
platforms.  Specific RTC chip support is now configured under
Device Drivers -> Real Time Clock. Setting time of day from the RTC
on startup is also configurable.

this time without the potentially platform breaking initcall.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/kernel/time.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/time.h |    6 +++++-
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7a3c3f7..b4ed362 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1048,6 +1048,48 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 }
 
+#ifdef CONFIG_RTC_CLASS
+static int set_rtc_class_time(struct rtc_time *tm)
+{
+	int err;
+	struct class_device *class_dev =
+		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+
+	if (class_dev == NULL)
+		return -ENODEV;
+
+	err = rtc_set_time(class_dev, tm);
+
+	rtc_class_close(class_dev);
+
+	return 0;
+}
+
+static void get_rtc_class_time(struct rtc_time *tm)
+{
+	int err;
+	struct class_device *class_dev =
+		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
+
+	if (class_dev == NULL)
+		return;
+
+	err = rtc_read_time(class_dev, tm);
+
+	rtc_class_close(class_dev);
+
+	return;
+}
+
+int __init rtc_class_hookup(void)
+{
+	ppc_md.get_rtc_time = get_rtc_class_time;
+	ppc_md.set_rtc_time = set_rtc_class_time;
+
+	return 0;
+}
+#endif /* CONFIG_RTC_CLASS */
+
 
 #define FEBRUARY	2
 #define	STARTOFTIME	1970
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index 5785ac4..b051d4c 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -39,6 +39,10 @@ extern void generic_calibrate_decr(void)
 extern void wakeup_decrementer(void);
 extern void snapshot_timebase(void);
 
+#ifdef CONFIG_RTC_CLASS
+extern int __init rtc_class_hookup(void);
+#endif
+
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
 #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
@@ -234,4 +238,4 @@ #define snapshot_timebases()			do { } wh
 #endif
 
 #endif /* __KERNEL__ */
-#endif /* __PPC64_TIME_H */
+#endif /* __POWERPC_TIME_H */
-- 
1.4.2.1

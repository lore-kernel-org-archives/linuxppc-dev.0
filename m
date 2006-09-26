Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 07FDE67CC0
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:55:39 +1000 (EST)
Date: Mon, 25 Sep 2006 21:55:31 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add powerpc get/set_rtc_time interface to new generic rtc
	class
Message-Id: <20060925215531.3e43be36.kim.phillips@freescale.com>
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

Currently, the only default config in powerpc arch is the 8349 itx.
Other platforms wanting to consolidate code may also use this.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/kernel/time.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7a3c3f7..a231b6d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1048,6 +1048,50 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 }
 
+#ifdef CONFIG_RTC_CLASS
+int set_rtc_class_time(struct rtc_time *tm)
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
+void get_rtc_class_time(struct rtc_time *tm)
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
+static int __init rtc_class_hookup(void)
+{
+	ppc_md.get_rtc_time = get_rtc_class_time;
+	ppc_md.set_rtc_time = set_rtc_class_time;
+
+	return 0;
+}
+
+late_initcall(rtc_class_hookup);
+#endif /* CONFIG_RTC_CLASS */
+
 
 #define FEBRUARY	2
 #define	STARTOFTIME	1970
-- 
1.4.2.1

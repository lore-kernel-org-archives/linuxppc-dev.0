Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFCt1hmMzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:35:37 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 07/16] rtc: parisc: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 00:34:21 +0200
Message-Id: <1461796470-1291527-8-git-send-email-arnd@arndb.de>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and on pa-risc, that is implemented using an open-coded
version of rtc_time_to_tm/rtc_tm_to_time.

This changes the parisc rtc-generic device to provide its
rtc_class_ops directly, using the normal helper functions,
which makes this y2038 safe (on 32-bit) and simplifies
the implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/kernel/time.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/rtc/rtc-generic.c |  3 +--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 58dd6801f5be..744878789752 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -12,6 +12,7 @@
  */
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/rtc.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
@@ -248,14 +249,47 @@ void __init start_cpu_itimer(void)
 	per_cpu(cpu_data, cpu).it_value = next_tick;
 }
 
+#if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pdc_tod tod_data;
+
+	memset(tm, 0, sizeof(*tm));
+	if (pdc_tod_read(&tod_data) < 0)
+		return -EOPNOTSUPP;
+
+	/* we treat tod_sec as unsigned, so this can work until year 2106 */
+	rtc_time64_to_tm(tod_data.tod_sec, tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	time64_t secs = rtc_tm_to_time64(tm);
+
+	if (pdc_tod_set(secs, 0) < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
+
 static int __init rtc_init(void)
 {
 	struct platform_device *pdev;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
 	return PTR_ERR_OR_ZERO(pdev);
 }
 device_initcall(rtc_init);
+#endif
 
 void read_persistent_clock(struct timespec *ts)
 {
diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index 3958e87a05fa..92b5e02a3750 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,8 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
-    defined(CONFIG_PPC)
+#if defined(CONFIG_M68K) || defined(CONFIG_PPC)
 #include <asm/rtc.h>
 
 static int generic_get_time(struct device *dev, struct rtc_time *tm)
-- 
2.7.0

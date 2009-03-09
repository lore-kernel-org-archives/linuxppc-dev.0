Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D5509DDFB4
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 00:26:28 +1100 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH 5/7] m68k: Hook up rtc-generic
Date: Mon,  9 Mar 2009 14:26:21 +0100
Message-Id: <1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: linux-m68k@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m68k has been a long time user of the generic RTC abstraction, so hook up
rtc-generic:
  - Create the "rtc-generic" platform device if mach_hwclk is set,
  - Add checks for mach_hwclk, in anticipation of RTC chip drivers being moved
    to drivers/rtc/.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/m68k/include/asm/rtc.h |    7 +++++--
 arch/m68k/kernel/time.c     |   18 ++++++++++++++++++
 drivers/rtc/Kconfig         |    2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/rtc.h b/arch/m68k/include/asm/rtc.h
index 5d3e038..a4d08ea 100644
--- a/arch/m68k/include/asm/rtc.h
+++ b/arch/m68k/include/asm/rtc.h
@@ -36,13 +36,16 @@ static inline unsigned int get_rtc_time(struct rtc_time *time)
 	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
 	 * by the RTC when initially set to a non-zero value.
 	 */
-	mach_hwclk(0, time);
+	if (mach_hwclk)
+		mach_hwclk(0, time);
 	return RTC_24H;
 }
 
 static inline int set_rtc_time(struct rtc_time *time)
 {
-	return mach_hwclk(1, time);
+	if (mach_hwclk)
+		return mach_hwclk(1, time);
+	return -EINVAL;
 }
 
 static inline unsigned int get_rtc_ss(void)
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 7db4159..54d9807 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/rtc.h>
+#include <linux/platform_device.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -159,3 +160,20 @@ int do_settimeofday(struct timespec *tv)
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+
+
+static int __init rtc_init(void)
+{
+	struct platform_device *pdev;
+
+	if (!mach_hwclk)
+		return -ENODEV;
+
+	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+module_init(rtc_init);
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d0aeff2..c8ead87 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -681,7 +681,7 @@ config RTC_DRV_GENERIC
 	tristate "Generic RTC support"
 	# Please consider writing a new RTC driver instead of using the generic
 	# RTC abstraction
-	depends on PARISC
+	depends on PARISC || M68K
 	help
 	  Say Y or M here to enable RTC support on systems using the generic
 	  RTC abstraction. If you do not know what you are doing, you should
-- 
1.6.0.4

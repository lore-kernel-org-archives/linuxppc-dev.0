Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFDV4wj2zDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:36:09 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 02/16] rtc: cmos: move mc146818rtc code out of
 asm-generic/rtc.h
Date: Thu, 28 Apr 2016 00:34:16 +0200
Message-Id: <1461796470-1291527-3-git-send-email-arnd@arndb.de>
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

Drivers should not really include stuff from asm-generic directly,
and the PC-style cmos rtc driver does this in order to reuse the
mc146818 implementation of get_rtc_time/set_rtc_time rather than
the architecture specific one for the architecture it gets built for.

To make it more obvious what is going on, this moves and renames the
two functions into include/linux/mc146818rtc.h, which holds the
other mc146818 specific code. Ideally it would be in a .c file,
but that would require extra infrastructure as the functions are
called by multiple drivers with conflicting dependencies.

With this change, the asm-generic/rtc.h header also becomes much
more generic, so it can be reused more easily across any architecture
that still relies on the genrtc driver.

The only caller of the internal __get_rtc_time/__set_rtc_time
functions is in arch/alpha/kernel/rtc.c, and we just change those
over to the new naming.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/alpha/kernel/rtc.c            |   6 +-
 arch/x86/include/asm/mc146818rtc.h |   1 -
 drivers/rtc/rtc-cmos.c             |  12 +--
 include/asm-generic/rtc.h          | 206 +------------------------------------
 include/linux/mc146818rtc.h        | 194 ++++++++++++++++++++++++++++++++++
 5 files changed, 207 insertions(+), 212 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index f535a3fd0f60..ceed68c7500b 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -15,8 +15,6 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-#include <asm/rtc.h>
-
 #include "proto.h"
 
 
@@ -81,7 +79,7 @@ init_rtc_epoch(void)
 static int
 alpha_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	__get_rtc_time(tm);
+	mc146818_get_time(tm);
 
 	/* Adjust for non-default epochs.  It's easier to depend on the
 	   generic __get_rtc_time and adjust the epoch here than create
@@ -112,7 +110,7 @@ alpha_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		tm = &xtm;
 	}
 
-	return __set_rtc_time(tm);
+	return mc146818_set_time(tm);
 }
 
 static int
diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 0f555cc31984..24acd9ba7837 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -6,7 +6,6 @@
 
 #include <asm/io.h>
 #include <asm/processor.h>
-#include <linux/mc146818rtc.h>
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 84fb541038be..c7993f18edfa 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -43,7 +43,7 @@
 #include <linux/of_platform.h>
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
-#include <asm-generic/rtc.h>
+#include <linux/mc146818rtc.h>
 
 struct cmos_rtc {
 	struct rtc_device	*rtc;
@@ -190,10 +190,10 @@ static inline void cmos_write_bank2(unsigned char val, unsigned char addr)
 static int cmos_read_time(struct device *dev, struct rtc_time *t)
 {
 	/* REVISIT:  if the clock has a "century" register, use
-	 * that instead of the heuristic in get_rtc_time().
+	 * that instead of the heuristic in mc146818_get_time().
 	 * That'll make Y3K compatility (year > 2070) easy!
 	 */
-	get_rtc_time(t);
+	mc146818_get_time(t);
 	return 0;
 }
 
@@ -205,7 +205,7 @@ static int cmos_set_time(struct device *dev, struct rtc_time *t)
 	 * takes effect exactly 500ms after we write the register.
 	 * (Also queueing and other delays before we get this far.)
 	 */
-	return set_rtc_time(t);
+	return mc146818_set_time(t);
 }
 
 static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
@@ -1142,14 +1142,14 @@ static __init void cmos_of_init(struct platform_device *pdev)
 	if (val)
 		CMOS_WRITE(be32_to_cpup(val), RTC_FREQ_SELECT);
 
-	get_rtc_time(&time);
+	cmos_read_time(&pdev->dev, &time);
 	ret = rtc_valid_tm(&time);
 	if (ret) {
 		struct rtc_time def_time = {
 			.tm_year = 1,
 			.tm_mday = 1,
 		};
-		set_rtc_time(&def_time);
+		cmos_set_time(&pdev->dev, &def_time);
 	}
 }
 #else
diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
index 4e3b6558331e..4fcff22cd707 100644
--- a/include/asm-generic/rtc.h
+++ b/include/asm-generic/rtc.h
@@ -12,12 +12,12 @@
 #ifndef __ASM_RTC_H__
 #define __ASM_RTC_H__
 
-#include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/delay.h>
-#ifdef CONFIG_ACPI
-#include <linux/acpi.h>
+
+#ifndef get_rtc_time
+#include <linux/mc146818rtc.h>
+#define get_rtc_time mc146818_get_time
+#define set_rtc_time mc146818_set_time
 #endif
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
@@ -31,202 +31,6 @@
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
-/*
- * Returns true if a clock update is in progress
- */
-static inline unsigned char rtc_is_updating(void)
-{
-	unsigned char uip;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return uip;
-}
-
-static inline unsigned int __get_rtc_time(struct rtc_time *time)
-{
-	unsigned char ctrl;
-	unsigned long flags;
-	unsigned char century = 0;
-
-#ifdef CONFIG_MACH_DECSTATION
-	unsigned int real_year;
-#endif
-
-	/*
-	 * read RTC once any update in progress is done. The update
-	 * can take just over 2ms. We wait 20ms. There is no need to
-	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
-	 * If you need to know *exactly* when a second has started, enable
-	 * periodic update complete interrupts, (via ioctl) and then 
-	 * immediately read /dev/rtc which will block until you get the IRQ.
-	 * Once the read clears, read the RTC time (again via ioctl). Easy.
-	 */
-	if (rtc_is_updating())
-		mdelay(20);
-
-	/*
-	 * Only the values that we read from the RTC are set. We leave
-	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
-	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
-	 * by the RTC when initially set to a non-zero value.
-	 */
-	spin_lock_irqsave(&rtc_lock, flags);
-	time->tm_sec = CMOS_READ(RTC_SECONDS);
-	time->tm_min = CMOS_READ(RTC_MINUTES);
-	time->tm_hour = CMOS_READ(RTC_HOURS);
-	time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
-	time->tm_mon = CMOS_READ(RTC_MONTH);
-	time->tm_year = CMOS_READ(RTC_YEAR);
-#ifdef CONFIG_MACH_DECSTATION
-	real_year = CMOS_READ(RTC_DEC_YEAR);
-#endif
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century)
-		century = CMOS_READ(acpi_gbl_FADT.century);
-#endif
-	ctrl = CMOS_READ(RTC_CONTROL);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	{
-		time->tm_sec = bcd2bin(time->tm_sec);
-		time->tm_min = bcd2bin(time->tm_min);
-		time->tm_hour = bcd2bin(time->tm_hour);
-		time->tm_mday = bcd2bin(time->tm_mday);
-		time->tm_mon = bcd2bin(time->tm_mon);
-		time->tm_year = bcd2bin(time->tm_year);
-		century = bcd2bin(century);
-	}
-
-#ifdef CONFIG_MACH_DECSTATION
-	time->tm_year += real_year - 72;
-#endif
-
-	if (century)
-		time->tm_year += (century - 19) * 100;
-
-	/*
-	 * Account for differences between how the RTC uses the values
-	 * and how they are defined in a struct rtc_time;
-	 */
-	if (time->tm_year <= 69)
-		time->tm_year += 100;
-
-	time->tm_mon--;
-
-	return RTC_24H;
-}
-
-#ifndef get_rtc_time
-#define get_rtc_time	__get_rtc_time
-#endif
-
-/* Set the current date and time in the real time clock. */
-static inline int __set_rtc_time(struct rtc_time *time)
-{
-	unsigned long flags;
-	unsigned char mon, day, hrs, min, sec;
-	unsigned char save_control, save_freq_select;
-	unsigned int yrs;
-#ifdef CONFIG_MACH_DECSTATION
-	unsigned int real_yrs, leap_yr;
-#endif
-	unsigned char century = 0;
-
-	yrs = time->tm_year;
-	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
-	day = time->tm_mday;
-	hrs = time->tm_hour;
-	min = time->tm_min;
-	sec = time->tm_sec;
-
-	if (yrs > 255)	/* They are unsigned */
-		return -EINVAL;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-#ifdef CONFIG_MACH_DECSTATION
-	real_yrs = yrs;
-	leap_yr = ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
-			!((yrs + 1900) % 400));
-	yrs = 72;
-
-	/*
-	 * We want to keep the year set to 73 until March
-	 * for non-leap years, so that Feb, 29th is handled
-	 * correctly.
-	 */
-	if (!leap_yr && mon < 3) {
-		real_yrs--;
-		yrs = 73;
-	}
-#endif
-
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century) {
-		century = (yrs + 1900) / 100;
-		yrs %= 100;
-	}
-#endif
-
-	/* These limits and adjustments are independent of
-	 * whether the chip is in binary mode or not.
-	 */
-	if (yrs > 169) {
-		spin_unlock_irqrestore(&rtc_lock, flags);
-		return -EINVAL;
-	}
-
-	if (yrs >= 100)
-		yrs -= 100;
-
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
-	    || RTC_ALWAYS_BCD) {
-		sec = bin2bcd(sec);
-		min = bin2bcd(min);
-		hrs = bin2bcd(hrs);
-		day = bin2bcd(day);
-		mon = bin2bcd(mon);
-		yrs = bin2bcd(yrs);
-		century = bin2bcd(century);
-	}
-
-	save_control = CMOS_READ(RTC_CONTROL);
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-#ifdef CONFIG_MACH_DECSTATION
-	CMOS_WRITE(real_yrs, RTC_DEC_YEAR);
-#endif
-	CMOS_WRITE(yrs, RTC_YEAR);
-	CMOS_WRITE(mon, RTC_MONTH);
-	CMOS_WRITE(day, RTC_DAY_OF_MONTH);
-	CMOS_WRITE(hrs, RTC_HOURS);
-	CMOS_WRITE(min, RTC_MINUTES);
-	CMOS_WRITE(sec, RTC_SECONDS);
-#ifdef CONFIG_ACPI
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-	    acpi_gbl_FADT.century)
-		CMOS_WRITE(century, acpi_gbl_FADT.century);
-#endif
-
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	return 0;
-}
-
-#ifndef set_rtc_time
-#define set_rtc_time	__set_rtc_time
-#endif
-
 static inline unsigned int get_rtc_ss(void)
 {
 	struct rtc_time h;
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index 433e0c74d643..e9e346b37846 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -14,6 +14,12 @@
 #include <asm/io.h>
 #include <linux/rtc.h>			/* get the user-level API */
 #include <asm/mc146818rtc.h>		/* register access macros */
+#include <linux/bcd.h>
+#include <linux/delay.h>
+
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
@@ -120,4 +126,192 @@ struct cmos_rtc_board_info {
 #define RTC_IO_EXTENT_USED      RTC_IO_EXTENT
 #endif /* ARCH_RTC_LOCATION */
 
+/*
+ * Returns true if a clock update is in progress
+ */
+static inline unsigned char mc146818_is_updating(void)
+{
+	unsigned char uip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return uip;
+}
+
+static inline unsigned int mc146818_get_time(struct rtc_time *time)
+{
+	unsigned char ctrl;
+	unsigned long flags;
+	unsigned char century = 0;
+
+#ifdef CONFIG_MACH_DECSTATION
+	unsigned int real_year;
+#endif
+
+	/*
+	 * read RTC once any update in progress is done. The update
+	 * can take just over 2ms. We wait 20ms. There is no need to
+	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
+	 * If you need to know *exactly* when a second has started, enable
+	 * periodic update complete interrupts, (via ioctl) and then 
+	 * immediately read /dev/rtc which will block until you get the IRQ.
+	 * Once the read clears, read the RTC time (again via ioctl). Easy.
+	 */
+	if (mc146818_is_updating())
+		mdelay(20);
+
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	spin_lock_irqsave(&rtc_lock, flags);
+	time->tm_sec = CMOS_READ(RTC_SECONDS);
+	time->tm_min = CMOS_READ(RTC_MINUTES);
+	time->tm_hour = CMOS_READ(RTC_HOURS);
+	time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
+	time->tm_mon = CMOS_READ(RTC_MONTH);
+	time->tm_year = CMOS_READ(RTC_YEAR);
+#ifdef CONFIG_MACH_DECSTATION
+	real_year = CMOS_READ(RTC_DEC_YEAR);
+#endif
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		century = CMOS_READ(acpi_gbl_FADT.century);
+#endif
+	ctrl = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	{
+		time->tm_sec = bcd2bin(time->tm_sec);
+		time->tm_min = bcd2bin(time->tm_min);
+		time->tm_hour = bcd2bin(time->tm_hour);
+		time->tm_mday = bcd2bin(time->tm_mday);
+		time->tm_mon = bcd2bin(time->tm_mon);
+		time->tm_year = bcd2bin(time->tm_year);
+		century = bcd2bin(century);
+	}
+
+#ifdef CONFIG_MACH_DECSTATION
+	time->tm_year += real_year - 72;
+#endif
+
+	if (century)
+		time->tm_year += (century - 19) * 100;
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	if (time->tm_year <= 69)
+		time->tm_year += 100;
+
+	time->tm_mon--;
+
+	return RTC_24H;
+}
+
+/* Set the current date and time in the real time clock. */
+static inline int mc146818_set_time(struct rtc_time *time)
+{
+	unsigned long flags;
+	unsigned char mon, day, hrs, min, sec;
+	unsigned char save_control, save_freq_select;
+	unsigned int yrs;
+#ifdef CONFIG_MACH_DECSTATION
+	unsigned int real_yrs, leap_yr;
+#endif
+	unsigned char century = 0;
+
+	yrs = time->tm_year;
+	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
+	day = time->tm_mday;
+	hrs = time->tm_hour;
+	min = time->tm_min;
+	sec = time->tm_sec;
+
+	if (yrs > 255)	/* They are unsigned */
+		return -EINVAL;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+#ifdef CONFIG_MACH_DECSTATION
+	real_yrs = yrs;
+	leap_yr = ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
+			!((yrs + 1900) % 400));
+	yrs = 72;
+
+	/*
+	 * We want to keep the year set to 73 until March
+	 * for non-leap years, so that Feb, 29th is handled
+	 * correctly.
+	 */
+	if (!leap_yr && mon < 3) {
+		real_yrs--;
+		yrs = 73;
+	}
+#endif
+
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century) {
+		century = (yrs + 1900) / 100;
+		yrs %= 100;
+	}
+#endif
+
+	/* These limits and adjustments are independent of
+	 * whether the chip is in binary mode or not.
+	 */
+	if (yrs > 169) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		return -EINVAL;
+	}
+
+	if (yrs >= 100)
+		yrs -= 100;
+
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
+	    || RTC_ALWAYS_BCD) {
+		sec = bin2bcd(sec);
+		min = bin2bcd(min);
+		hrs = bin2bcd(hrs);
+		day = bin2bcd(day);
+		mon = bin2bcd(mon);
+		yrs = bin2bcd(yrs);
+		century = bin2bcd(century);
+	}
+
+	save_control = CMOS_READ(RTC_CONTROL);
+	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
+	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
+	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+#ifdef CONFIG_MACH_DECSTATION
+	CMOS_WRITE(real_yrs, RTC_DEC_YEAR);
+#endif
+	CMOS_WRITE(yrs, RTC_YEAR);
+	CMOS_WRITE(mon, RTC_MONTH);
+	CMOS_WRITE(day, RTC_DAY_OF_MONTH);
+	CMOS_WRITE(hrs, RTC_HOURS);
+	CMOS_WRITE(min, RTC_MINUTES);
+	CMOS_WRITE(sec, RTC_SECONDS);
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
+	    acpi_gbl_FADT.century)
+		CMOS_WRITE(century, acpi_gbl_FADT.century);
+#endif
+
+	CMOS_WRITE(save_control, RTC_CONTROL);
+	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return 0;
+}
+
 #endif /* _MC146818RTC_H */
-- 
2.7.0

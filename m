Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B52A31A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 18:10:00 +1100 (AEDT)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 38F66140311
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 18:09:59 +1100 (AEDT)
Received: by pacwq6 with SMTP id wq6so117632271pac.1
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 23:09:56 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, akpm@linux-foundation.org,
 Daniel Axtens <dja@axtens.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
Subject: [PATCH] powerpc: Remove broken GregorianDay()
Date: Tue, 15 Dec 2015 18:09:14 +1100
Message-Id: <1450163354-16894-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GregorianDay() is supposed to calculate the day of the week
(tm->tm_wday) for a given day/month/year. In that calcuation it
indexed into an array called MonthOffset using tm->tm_mon-1. However
tm_mon is zero-based, not one-based, so this is off-by-one. It also
means that every January, GregoiranDay() will access element -1 of
the MonthOffset array.

It also doesn't appear to be a correct algorithm either: see in
contrast kernel/time/timeconv.c's time_to_tm function.

It's been broken forever, which suggests no-one in userland uses
this. It looks like no-one in the kernel uses tm->tm_wday either
(see e.g. drivers/rtc/rtc-ds1305.c:319).

tm->tm_wday is conventionally set to -1 when not available in
hardware so we can simply set it to -1 and drop the function.
(There are over a dozen other drivers in drivers/rtc that do
this.)

Found using UBSAN.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org> # as an example of what UBSan finds.
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Signed-off-by: Daniel Axtens <dja@axtens.net>

---
This is almost entirely a powerpc patch, but it also touches
the OPAL rtc driver. Alessandro, Alexandre, RTC folk, would
you be OK with mpe taking this through the powerpc tree?

I don't think there's any point in sending it to stable
because obviously nothing uses it.

There are a couple of situations where this bug could cause access
before the start of the array:

 - Every January, GregoiranDay() will access element -1.

 - In drivers/rtc/rtc-opal.c, it's called in via opal_get_tpo_time.
   In the case where a timed power on (TPO) is not set, 0 will be
   passed to opal_to_tm, which will lead to a month of -1, which will
   lead to an access of element -2. (This is how I first found it.)

These are fixed out-of-bounds reads. There are some near misses for
attacker-controlled out-of-bounds reads via to_tm(). It's called in:

 - RTAS power on clock - init only
 - RTAS clock write - should require you to be root

 - ntp's update_persistent_clock. I think we're safe from being given
   an arbitrary value here because of ntp_validate_timex in
   do_adjtimex, which is ultimately the only callsite, but it's a bit
   of a near miss.

 - RTC reads in platforms/{8xx,powermac}
 - an unused debug function in platforms/ps3

I've done some objdumping on both a -next kernel and a distro kernel,
and it looks like the data immediately before the array is NULL, so
it seems that by good fortune that we aren't going to leak any data
anyway.
---
 arch/powerpc/include/asm/time.h           |  1 -
 arch/powerpc/kernel/time.c                | 36 ++-----------------------------
 arch/powerpc/platforms/maple/time.c       |  2 +-
 arch/powerpc/platforms/powernv/opal-rtc.c |  3 +--
 drivers/rtc/rtc-opal.c                    |  2 +-
 5 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 10fc784a2ad4..2d7109a8d296 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -27,7 +27,6 @@ extern struct clock_event_device decrementer_clockevent;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
-extern void GregorianDay(struct rtc_time *tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 1be1092c7204..81b0900a39ee 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1002,38 +1002,6 @@ static int month_days[12] = {
 	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
 };
 
-/*
- * This only works for the Gregorian calendar - i.e. after 1752 (in the UK)
- */
-void GregorianDay(struct rtc_time * tm)
-{
-	int leapsToDate;
-	int lastYear;
-	int day;
-	int MonthOffset[] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
-
-	lastYear = tm->tm_year - 1;
-
-	/*
-	 * Number of leap corrections to apply up to end of last year
-	 */
-	leapsToDate = lastYear / 4 - lastYear / 100 + lastYear / 400;
-
-	/*
-	 * This year is a leap year if it is divisible by 4 except when it is
-	 * divisible by 100 unless it is divisible by 400
-	 *
-	 * e.g. 1904 was a leap year, 1900 was not, 1996 is, and 2000 was
-	 */
-	day = tm->tm_mon > 2 && leapyear(tm->tm_year);
-
-	day += lastYear*365 + leapsToDate + MonthOffset[tm->tm_mon-1] +
-		   tm->tm_mday;
-
-	tm->tm_wday = day % 7;
-}
-EXPORT_SYMBOL_GPL(GregorianDay);
-
 void to_tm(int tim, struct rtc_time * tm)
 {
 	register int    i;
@@ -1064,9 +1032,9 @@ void to_tm(int tim, struct rtc_time * tm)
 	tm->tm_mday = day + 1;
 
 	/*
-	 * Determine the day of week
+	 * No-one uses the day of the week.
 	 */
-	GregorianDay(tm);
+	tm->tm_wday = -1;
 }
 EXPORT_SYMBOL(to_tm);
 
diff --git a/arch/powerpc/platforms/maple/time.c b/arch/powerpc/platforms/maple/time.c
index b4a369dac3a8..81799d70a1ee 100644
--- a/arch/powerpc/platforms/maple/time.c
+++ b/arch/powerpc/platforms/maple/time.c
@@ -77,7 +77,7 @@ void maple_get_rtc_time(struct rtc_time *tm)
 	if ((tm->tm_year + 1900) < 1970)
 		tm->tm_year += 100;
 
-	GregorianDay(tm);
+	tm->tm_wday = -1;
 }
 
 int maple_set_rtc_time(struct rtc_time *tm)
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index 37dbee15769f..1b149c92fca1 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -31,8 +31,7 @@ static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
 	tm->tm_hour	= bcd2bin((h_m_s_ms >> 56) & 0xff);
 	tm->tm_min	= bcd2bin((h_m_s_ms >> 48) & 0xff);
 	tm->tm_sec	= bcd2bin((h_m_s_ms >> 40) & 0xff);
-
-        GregorianDay(tm);
+	tm->tm_wday     = -1;
 }
 
 unsigned long __init opal_get_boot_time(void)
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index df39ce02a99d..9c18d6fd8107 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -40,7 +40,7 @@ static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
 	tm->tm_min  = bcd2bin((h_m_s_ms >> 48) & 0xff);
 	tm->tm_sec  = bcd2bin((h_m_s_ms >> 40) & 0xff);
 
-	GregorianDay(tm);
+	tm->tm_wday = -1;
 }
 
 static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
-- 
2.6.2

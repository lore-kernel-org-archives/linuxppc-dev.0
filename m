Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V0Fl75RdzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:37:31 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 5/5] powerpc: remove unused to_tm() helper
Date: Mon, 23 Apr 2018 10:36:42 +0200
Message-Id: <20180423083642.2608886-5-arnd@arndb.de>
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
References: <20180423083642.2608886-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

to_tm() is now completely unused, the only reference being in the
_dump_time() helper that is also unused. This removes both, leaving
the rest of the powerpc RTC code y2038 safe to as far as the hardware
supports.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/time.h   |  2 --
 arch/powerpc/kernel/time.c        | 50 ---------------------------------------
 arch/powerpc/platforms/ps3/time.c | 24 -------------------
 3 files changed, 76 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index db546c034905..79bc9c3e4325 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -26,8 +26,6 @@ extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
 extern struct clock_event_device decrementer_clockevent;
 
-struct rtc_time;
-extern void to_tm(int tim, struct rtc_time * tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f9b0baa3fa2b..79bdeea85ab4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1138,56 +1138,6 @@ void __init time_init(void)
 #endif
 }
 
-
-#define FEBRUARY	2
-#define	STARTOFTIME	1970
-#define SECDAY		86400L
-#define SECYR		(SECDAY * 365)
-#define	leapyear(year)		((year) % 4 == 0 && \
-				 ((year) % 100 != 0 || (year) % 400 == 0))
-#define	days_in_year(a) 	(leapyear(a) ? 366 : 365)
-#define	days_in_month(a) 	(month_days[(a) - 1])
-
-static int month_days[12] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-void to_tm(int tim, struct rtc_time * tm)
-{
-	register int    i;
-	register long   hms, day;
-
-	day = tim / SECDAY;
-	hms = tim % SECDAY;
-
-	/* Hours, minutes, seconds are easy */
-	tm->tm_hour = hms / 3600;
-	tm->tm_min = (hms % 3600) / 60;
-	tm->tm_sec = (hms % 3600) % 60;
-
-	/* Number of years in days */
-	for (i = STARTOFTIME; day >= days_in_year(i); i++)
-		day -= days_in_year(i);
-	tm->tm_year = i;
-
-	/* Number of months in days left */
-	if (leapyear(tm->tm_year))
-		days_in_month(FEBRUARY) = 29;
-	for (i = 1; day >= days_in_month(i); i++)
-		day -= days_in_month(i);
-	days_in_month(FEBRUARY) = 28;
-	tm->tm_mon = i;
-
-	/* Days are what is left over (+1) from all that. */
-	tm->tm_mday = day + 1;
-
-	/*
-	 * No-one uses the day of the week.
-	 */
-	tm->tm_wday = -1;
-}
-EXPORT_SYMBOL(to_tm);
-
 /*
  * Divide a 128-bit dividend by a 32-bit divisor, leaving a 128 bit
  * result.
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 9dac125c997e..08ca76e23d09 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -28,30 +28,6 @@
 
 #include "platform.h"
 
-#define dump_tm(_a) _dump_tm(_a, __func__, __LINE__)
-static void _dump_tm(const struct rtc_time *tm, const char* func, int line)
-{
-	pr_debug("%s:%d tm_sec  %d\n", func, line, tm->tm_sec);
-	pr_debug("%s:%d tm_min  %d\n", func, line, tm->tm_min);
-	pr_debug("%s:%d tm_hour %d\n", func, line, tm->tm_hour);
-	pr_debug("%s:%d tm_mday %d\n", func, line, tm->tm_mday);
-	pr_debug("%s:%d tm_mon  %d\n", func, line, tm->tm_mon);
-	pr_debug("%s:%d tm_year %d\n", func, line, tm->tm_year);
-	pr_debug("%s:%d tm_wday %d\n", func, line, tm->tm_wday);
-}
-
-#define dump_time(_a) _dump_time(_a, __func__, __LINE__)
-static void __maybe_unused _dump_time(int time, const char *func,
-	int line)
-{
-	struct rtc_time tm;
-
-	to_tm(time, &tm);
-
-	pr_debug("%s:%d time    %d\n", func, line, time);
-	_dump_tm(&tm, func, line);
-}
-
 void __init ps3_calibrate_decr(void)
 {
 	int result;
-- 
2.9.0

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QQQK5VPhzF1Rl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 23:02:33 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/time: remove to_tm and use RTC_LIB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Geoff Levand <geoff@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180417130228.819936C0B7@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 15:02:28 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RTC_LIB includes a generic function to convert
RTC data into struct rtc_time. Use it and remove to_tm().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                    |  1 +
 arch/powerpc/include/asm/time.h         |  1 -
 arch/powerpc/kernel/rtas-proc.c         |  4 +--
 arch/powerpc/kernel/time.c              | 52 +--------------------------------
 arch/powerpc/platforms/8xx/m8xx_setup.c |  2 +-
 arch/powerpc/platforms/powermac/time.c  |  2 +-
 arch/powerpc/platforms/ps3/time.c       |  2 +-
 7 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index edbbd2ea1298..e1fac49cf465 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
+	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS			if !PPC64
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index db546c034905..0ad1cf2285b1 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -27,7 +27,6 @@ extern unsigned long tb_ticks_per_sec;
 extern struct clock_event_device decrementer_clockevent;
 
 struct rtc_time;
-extern void to_tm(int tim, struct rtc_time * tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index fb070d8cad07..6de77f9434b0 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -314,7 +314,7 @@ static ssize_t ppc_rtas_poweron_write(struct file *file,
 
 	power_on_time = nowtime; /* save the time */
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, &tm);
 
 	error = rtas_call(rtas_token("set-time-for-power-on"), 7, 1, NULL, 
 			tm.tm_year, tm.tm_mon, tm.tm_mday, 
@@ -378,7 +378,7 @@ static ssize_t ppc_rtas_clock_write(struct file *file,
 	if (error)
 		return error;
 
-	to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, &tm);
 	error = rtas_call(rtas_token("set-time-of-day"), 7, 1, NULL, 
 			tm.tm_year, tm.tm_mon, tm.tm_mday, 
 			tm.tm_hour, tm.tm_min, tm.tm_sec, 0);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 56869fd879ed..362673cc09f2 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -788,7 +788,7 @@ int update_persistent_clock(struct timespec now)
 	if (!ppc_md.set_rtc_time)
 		return -ENODEV;
 
-	to_tm(now.tv_sec + 1 + timezone_offset, &tm);
+	rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);
 	tm.tm_year -= 1900;
 	tm.tm_mon -= 1;
 
@@ -1141,56 +1141,6 @@ void __init time_init(void)
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
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 2188d691a40f..0f9740185eb9 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -192,7 +192,7 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 
 	/* Get time from the RTC. */
 	data = in_be32(&sys_tmr->sit_rtc);
-	to_tm(data, tm);
+	rtc_time64_to_tm(data, tm);
 	tm->tm_year -= 1900;
 	tm->tm_mon -= 1;
 	immr_unmap(sys_tmr);
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..6db8cdacbf3d 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -87,7 +87,7 @@ long __init pmac_time_init(void)
 #if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
 static void to_rtc_time(unsigned long now, struct rtc_time *tm)
 {
-	to_tm(now, tm);
+	rtc_time64_to_tm(now, tm);
 	tm->tm_year -= 1900;
 	tm->tm_mon -= 1;
 }
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 11b45b58c81b..4455abf707ae 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -46,7 +46,7 @@ static void __maybe_unused _dump_time(int time, const char *func,
 {
 	struct rtc_time tm;
 
-	to_tm(time, &tm);
+	rtc_time64_to_tm(time, &tm);
 
 	pr_debug("%s:%d time    %d\n", func, line, time);
 	_dump_tm(&tm, func, line);
-- 
2.13.3

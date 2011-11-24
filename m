Return-Path: <anton@samba.org>
Message-Id: <20111124060847.282144743@samba.org>
Date: Thu, 24 Nov 2011 17:07:19 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, johnstul@us.ibm.com,
 miltonm@bga.com
Subject: [PATCH 3/6] powerpc/time: Use clocksource_register_hz
References: <20111124060716.362614789@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use clocksource_register_hz which calculates the shift/mult
factors for us. Also remove the shift = 22 assumption in
vsyscall_update - thanks to Paul Mackerras and John Stultz for
catching that.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 10:11:51.175038860 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 10:11:55.547114957 +1100
@@ -86,8 +86,6 @@ static struct clocksource clocksource_rt
 	.rating       = 400,
 	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
 	.mask         = CLOCKSOURCE_MASK(64),
-	.shift        = 22,
-	.mult         = 0,	/* To be filled in */
 	.read         = rtc_read,
 };
 
@@ -97,8 +95,6 @@ static struct clocksource clocksource_ti
 	.rating       = 400,
 	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
 	.mask         = CLOCKSOURCE_MASK(64),
-	.shift        = 22,
-	.mult         = 0,	/* To be filled in */
 	.read         = timebase_read,
 };
 
@@ -822,9 +818,8 @@ void update_vsyscall(struct timespec *wa
 	++vdso_data->tb_update_count;
 	smp_mb();
 
-	/* XXX this assumes clock->shift == 22 */
-	/* 4611686018 ~= 2^(20+64-22) / 1e9 */
-	new_tb_to_xs = (u64) mult * 4611686018ULL;
+	/* 19342813113834067 ~= 2^(20+64) / 1e9 */
+	new_tb_to_xs = (u64) mult * (19342813113834067ULL >> clock->shift);
 	new_stamp_xsec = (u64) wall_time->tv_nsec * XSEC_PER_SEC;
 	do_div(new_stamp_xsec, 1000000000);
 	new_stamp_xsec += (u64) wall_time->tv_sec * XSEC_PER_SEC;
@@ -875,9 +870,7 @@ static void __init clocksource_init(void
 	else
 		clock = &clocksource_timebase;
 
-	clock->mult = clocksource_hz2mult(tb_ticks_per_sec, clock->shift);
-
-	if (clocksource_register(clock)) {
+	if (clocksource_register_hz(clock, tb_ticks_per_sec)) {
 		printk(KERN_ERR "clocksource: %s is already registered\n",
 		       clock->name);
 		return;

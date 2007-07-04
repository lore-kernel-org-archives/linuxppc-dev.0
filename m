Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 0D36ADDF24
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 14:04:16 +1000 (EST)
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id 7FCA613BB1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 12:04:15 +0800 (WST)
To: <linuxppc-dev@ozlabs.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 04 Jul 2007 14:04:31 +1000
Subject: [PATCH 2/3] Modify sched_clock() to make CONFIG_PRINTK_TIME more sane.
In-Reply-To: <1183521871.36329.499255149967.qpush@thor>
Message-Id: <20070704040431.1A13432C46D@thor>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When booting a current kernel with CONFIG_PRINTK_TIME enabled you'll
see messages like:

[    0.000000] time_init: decrementer frequency = 188.044000 MHz
[    0.000000] time_init: processor frequency   = 1504.352000 MHz
[3712914.436297] Console: colour dummy device 80x25

This cause by the initialisation of tb_to_ns_scale in time_init(), suddenly the
multiplication in sched_clock() now does something :).  This patch modifies
sched_clock() to report the offset since the machine booted so the same
printk's now look like:

[    0.000000] time_init: decrementer frequency = 188.044000 MHz
[    0.000000] time_init: processor frequency   = 1504.352000 MHz
[    0.000135] Console: colour dummy device 80x25

Effectivly including the uptime in printk()s.

This patch makes tb_to_ns_scale and tb_to_ns_shift static and read_mostly for
good meassure.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
There looks to be other variables that could be made static, I think
that's a job for another day though.

 arch/powerpc/kernel/time.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -113,8 +113,9 @@ u64 ticklen_to_xs;	/* 0.64 fraction */
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
-u64 tb_to_ns_scale;
-unsigned tb_to_ns_shift;
+static u64 tb_to_ns_scale __read_mostly;
+static unsigned tb_to_ns_shift __read_mostly;
+static unsigned long boot_tb __read_mostly;
 
 struct gettimeofday_struct do_gtod;
 
@@ -735,7 +736,7 @@ unsigned long long sched_clock(void)
 {
 	if (__USE_RTC())
 		return get_rtc();
-	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
+	return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
 }
 
 int do_settimeofday(struct timespec *tv)
@@ -960,6 +961,8 @@ void __init time_init(void)
 	}
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
+	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
+	boot_tb = get_tb();
 
 	tm = get_boot_time();
 

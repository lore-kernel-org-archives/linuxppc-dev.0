Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 82AD0DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 12:02:11 +1000 (EST)
Date: Wed, 20 Jun 2007 12:02:11 +1000
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
Message-ID: <20070620020211.GO9768@bakeyournoodle.com>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070619145356.GA20382@lixom.net>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2007 at 09:53:56AM -0500, Olof Johansson wrote:
 
> It only seems to be used in this file, so it can be static, right?

True, I was following suit with tb_to_ns_scale, tb_to_ns_shift which
could also be static.

Here's an updated patch that makes them all static and updates the
commit message as well.

From: Tony Breeds <tony@bakeyournoodle.com>

Modify sched_clock() to make CONFIG_PRINTK_TIME more sane.

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

Effectively including the uptime in printk()s.

Also this patch makes tb_to_ns_scale and tb_to_ns_shift static for good
measure.

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
+static u64 tb_to_ns_scale;
+static unsigned tb_to_ns_shift;
+static unsigned long boot_tb;
 
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
 
Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!

Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7505EDDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:36:02 +1000 (EST)
Date: Tue, 19 Jun 2007 16:35:57 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more sane.
Message-ID: <20070619063557.GK9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
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

This patch modifies sched_clock() to report the offset since the machine booted
so the same printk's now look like:

[    0.000000] time_init: decrementer frequency = 188.044000 MHz
[    0.000000] time_init: processor frequency   = 1504.352000 MHz
[    0.000135] Console: colour dummy device 80x25

Effectivly including the uptime in printk()s.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/kernel/time.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -115,6 +115,7 @@ EXPORT_SYMBOL_GPL(rtc_lock);
 
 u64 tb_to_ns_scale;
 unsigned tb_to_ns_shift;
+unsigned long boot_tb;
 
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

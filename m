Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Sep 2007 14:21:56 +1000
Subject: [PATCH 2/2] powerpc: Fix timekeeping on PowerPC 601
Message-Id: <20070919042157.A4E4ADDE20@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recent changes to the timekeeping code broke support for the PowerPC 601
processor which doesn't have the usual timebase facility but a slightly
different thing called (yuck) the RTC.

This fixes it, boot tested on an old 601 based PowerMac 7200

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/time.c |    8 +++++---
 include/asm-powerpc/time.h |    5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-work/arch/powerpc/kernel/time.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/time.c	2007-09-19 10:53:28.000000000 +1000
+++ linux-work/arch/powerpc/kernel/time.c	2007-09-19 11:28:14.000000000 +1000
@@ -239,7 +239,7 @@ static void snapshot_tb_and_purr(void *d
 	struct cpu_purr_data *p = &__get_cpu_var(cpu_purr_data);
 
 	local_irq_save(flags);
-	p->tb = mftb();
+	p->tb = get_tb_or_rtc();
 	p->purr = mfspr(SPRN_PURR);
 	wmb();
 	p->initialized = 1;
@@ -317,7 +317,7 @@ static void snapshot_purr(void)
  */
 void snapshot_timebase(void)
 {
-	__get_cpu_var(last_jiffy) = get_tb();
+	__get_cpu_var(last_jiffy) = get_tb_or_rtc();
 	snapshot_purr();
 }
 
@@ -684,6 +684,8 @@ void timer_interrupt(struct pt_regs * re
 
 		write_seqlock(&xtime_lock);
 		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
+		if (__USE_RTC() && tb_next_jiffy >= 1000000000)
+			tb_next_jiffy -= 1000000000;
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
 			do_timer(1);
@@ -977,7 +979,7 @@ void __init time_init(void)
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
 	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
-	boot_tb = get_tb();
+	boot_tb = get_tb_or_rtc();
 
 	tm = get_boot_time();
 
Index: linux-work/include/asm-powerpc/time.h
===================================================================
--- linux-work.orig/include/asm-powerpc/time.h	2007-09-19 10:53:28.000000000 +1000
+++ linux-work/include/asm-powerpc/time.h	2007-09-19 10:53:37.000000000 +1000
@@ -149,6 +149,11 @@ static inline u64 get_tb(void)
 }
 #endif /* !CONFIG_PPC64 */
 
+static inline u64 get_tb_or_rtc(void)
+{
+	return __USE_RTC() ? get_rtc() : get_tb();
+}
+
 static inline void set_tb(unsigned int upper, unsigned int lower)
 {
 	mtspr(SPRN_TBWL, 0);

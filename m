Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id C004367C7C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 11:36:18 +1000 (EST)
Date: Tue, 22 Aug 2006 20:36:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix gettimeofday inaccuracies
Message-ID: <20060823013605.GC11309@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are two problems in the powerpc gettimeofday code which can
cause incorrect results to be returned.

The first is that there is a race between do_gettimeofday and the
timer interrupt:

1. do_gettimeofday does get_tb()

2. decrementer exception on boot cpu which runs timer_recalc_offset,
   which also samples the timebase and updates the do_gtod structure
   with a greater timebase value.

3. do_gettimeofday calls __do_gettimeofday, which leads to the
   negative result from tb_val - temp_varp->tb_orig_stamp.

The second is caused by taking the boot cpu offline, which can cause
the value of tb_last_jiffy to be increased past the currently
available timebase, causing the same underflow as above.


Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -417,7 +417,7 @@ static __inline__ void timer_check_rtc(v
 /*
  * This version of gettimeofday has microsecond resolution.
  */
-static inline void __do_gettimeofday(struct timeval *tv, u64 tb_val)
+static inline void __do_gettimeofday(struct timeval *tv)
 {
 	unsigned long sec, usec;
 	u64 tb_ticks, xsec;
@@ -431,7 +431,12 @@ static inline void __do_gettimeofday(str
 	 * without a divide (and in fact, without a multiply)
 	 */
 	temp_varp = do_gtod.varp;
-	tb_ticks = tb_val - temp_varp->tb_orig_stamp;
+
+	/* Sampling the time base must be done after loading
+	 * do_gtod.varp in order to avoid racing with update_gtod.
+	 */
+	mb();
+	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;
 	temp_tb_to_xs = temp_varp->tb_to_xs;
 	temp_stamp_xsec = temp_varp->stamp_xsec;
 	xsec = temp_stamp_xsec + mulhdu(tb_ticks, temp_tb_to_xs);
@@ -464,7 +469,7 @@ void do_gettimeofday(struct timeval *tv)
 		tv->tv_usec = usec;
 		return;
 	}
-	__do_gettimeofday(tv, get_tb());
+	__do_gettimeofday(tv);
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
@@ -650,6 +655,7 @@ void timer_interrupt(struct pt_regs * re
 	int next_dec;
 	int cpu = smp_processor_id();
 	unsigned long ticks;
+	u64 tb_next_jiffy;
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -691,11 +697,14 @@ void timer_interrupt(struct pt_regs * re
 			continue;
 
 		write_seqlock(&xtime_lock);
-		tb_last_jiffy += tb_ticks_per_jiffy;
-		tb_last_stamp = per_cpu(last_jiffy, cpu);
-		do_timer(regs);
-		timer_recalc_offset(tb_last_jiffy);
-		timer_check_rtc();
+		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
+		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
+			tb_last_jiffy = tb_next_jiffy;
+			tb_last_stamp = per_cpu(last_jiffy, cpu);
+			do_timer(regs);
+			timer_recalc_offset(tb_last_jiffy);
+			timer_check_rtc();
+		}
 		write_sequnlock(&xtime_lock);
 	}
 	

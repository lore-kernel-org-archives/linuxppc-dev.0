Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B19872BDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Nov 2004 21:44:18 +1100 (EST)
Date: Mon, 15 Nov 2004 04:21:00 -0600 (CST)
Message-Id: <200411151021.iAFAL0ds070897@sullivan.realtime.net>
To: linuxppc-dev@ozlabs.org
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH][PPC] update_process_times simplification
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the update_process_times call was moved out of do_timer for the UP case,
the replicator didn't track down the hiding and just added ifndef SMP.

This removes the ifdefs and the indirection of calling another file for
one function in a third file.

I also removed the per-cpu multipler and counter.  On some architectures
(x86 and sparc64) these are set via /proc/profile setup_profiling_timer
to increase the timer interrupt by a factor over HZ.   However, this was
not not implemented for ppc (like several other architectures), so it
was just decrementing, testing, and setting per-cpu variables back to 1.

Untested.
Signed-off-by: Milton Miller <miltonm@bga.com>

===== arch/ppc/kernel/smp.c 1.46 vs edited =====
--- 1.46/arch/ppc/kernel/smp.c	2004-09-08 08:32:57 +02:00
+++ edited/arch/ppc/kernel/smp.c	2004-11-15 10:59:24 +01:00
@@ -42,8 +42,6 @@ struct cpuinfo_PPC cpu_data[NR_CPUS];
 struct klock_info_struct klock_info = { KLOCK_CLEAR, 0 };
 atomic_t ipi_recv;
 atomic_t ipi_sent;
-DEFINE_PER_CPU(unsigned int, prof_multiplier);
-DEFINE_PER_CPU(unsigned int, prof_counter);
 unsigned long cache_decay_ticks = HZ/100;
 cpumask_t cpu_online_map;
 cpumask_t cpu_possible_map;
@@ -89,16 +87,6 @@ smp_message_pass(int target, int msg, un
 /*
  * Common functions
  */
-void smp_local_timer_interrupt(struct pt_regs * regs)
-{
-	int cpu = smp_processor_id();
-
-	if (!--per_cpu(prof_counter, cpu)) {
-		update_process_times(user_mode(regs));
-		per_cpu(prof_counter, cpu) = per_cpu(prof_multiplier, cpu);
-	}
-}
-
 void smp_message_recv(int msg, struct pt_regs *regs)
 {
 	atomic_inc(&ipi_recv);
@@ -297,8 +285,6 @@ static void __devinit smp_store_cpu_info
 	/* assume bogomips are same for everything */
         c->loops_per_jiffy = loops_per_jiffy;
         c->pvr = mfspr(PVR);
-	per_cpu(prof_counter, id) = 1;
-	per_cpu(prof_multiplier, id) = 1;
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
===== arch/ppc/kernel/time.c 1.35 vs edited =====
--- 1.35/arch/ppc/kernel/time.c	2004-10-19 11:40:28 +02:00
+++ edited/arch/ppc/kernel/time.c	2004-11-15 11:01:52 +01:00
@@ -142,6 +142,7 @@ void timer_interrupt(struct pt_regs * re
 		jiffy_stamp += tb_ticks_per_jiffy;
 		
 		profile_tick(CPU_PROFILING, regs);
+		update_process_times(user_mode(regs));
 
 	  	if (smp_processor_id())
 			continue;
@@ -150,9 +151,6 @@ void timer_interrupt(struct pt_regs * re
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
-#ifndef CONFIG_SMP
-		update_process_times(user_mode(regs));
-#endif
 
 		/*
 		 * update the rtc when needed, this should be performed on the
@@ -185,10 +183,6 @@ void timer_interrupt(struct pt_regs * re
 	if ( !disarm_decr[smp_processor_id()] )
 		set_dec(next_dec);
 	last_jiffy_stamp(cpu) = jiffy_stamp;
-
-#ifdef CONFIG_SMP
-	smp_local_timer_interrupt(regs);
-#endif /* CONFIG_SMP */
 
 	if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
 		ppc_md.heartbeat();
===== include/asm-ppc/smp.h 1.16 vs edited =====
--- 1.16/include/asm-ppc/smp.h	2004-06-25 14:51:47 +02:00
+++ edited/include/asm-ppc/smp.h	2004-11-15 10:23:01 +01:00
@@ -40,7 +40,6 @@ extern void smp_send_tlb_invalidate(int)
 extern void smp_send_xmon_break(int cpu);
 struct pt_regs;
 extern void smp_message_recv(int, struct pt_regs *);
-extern void smp_local_timer_interrupt(struct pt_regs *);
 
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 #define PROC_CHANGE_PENALTY	20

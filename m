Return-Path: <vatsa@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D23967AC7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 22:21:37 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ACLXlf019978
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 08:21:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ACI6fN260816
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 06:18:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3ACLX1i007105
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 06:21:33 -0600
Date: Mon, 10 Apr 2006 17:49:35 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] tickless idle cpus: allow boot cpu to skip ticks
Message-ID: <20060410121935.GC5564@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17462.61423.42032.559627@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch (version 2) lets boot cpu to skip ticks. Tested against
2.6.17-rc1-mm1.

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c |   71 ++++++++++++++++++++---
 1 file changed, 63 insertions(+), 8 deletions(-)

diff -puN arch/powerpc/kernel/time.c~boot_cpu_fix arch/powerpc/kernel/time.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/time.c~boot_cpu_fix	2006-04-10 17:43:11.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c	2006-04-10 17:44:32.000000000 +0530
@@ -637,6 +637,39 @@ static void iSeries_tb_recal(void)
 
 static void account_ticks(struct pt_regs *regs);
 
+static spinlock_t do_timer_cpulock = SPIN_LOCK_UNLOCKED;
+static int do_timer_cpu;	/* Which CPU should call do_timer? */
+
+static int __devinit do_timer_cpucallback(struct notifier_block *self,
+					  unsigned long action, void *hcpu)
+{
+	int cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_DOWN_PREPARE:
+		spin_lock(&do_timer_cpulock);
+		if (do_timer_cpu == cpu) {
+			cpumask_t tmpmask;
+			int new_cpu;
+
+			cpus_complement(tmpmask, nohz_cpu_mask);
+			cpu_clear(cpu, tmpmask);
+			new_cpu = any_online_cpu(tmpmask);
+			if (new_cpu != NR_CPUS)
+				do_timer_cpu = new_cpu;
+		}
+		spin_unlock(&do_timer_cpulock);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata do_timer_notifier =
+{
+	.notifier_call = do_timer_cpucallback
+};
+
 /* Returns 1 if this CPU was set in the mask */
 static inline int clear_hzless_mask(void)
 {
@@ -645,8 +678,12 @@ static inline int clear_hzless_mask(void
 
 	if (unlikely(cpu_isset(cpu, nohz_cpu_mask))) {
 		cpu_clear(cpu, nohz_cpu_mask);
-		rc = 1;
-	}
+		spin_lock(&do_timer_cpulock);
+		if (do_timer_cpu == NR_CPUS)
+			do_timer_cpu = cpu;
+		spin_unlock(&do_timer_cpulock);
+  		rc = 1;
+  	}
 
 	return rc;
 }
@@ -684,6 +721,15 @@ void stop_hz_timer(void)
 		return;
 	}
 
+	spin_lock(&do_timer_cpulock);
+	if (do_timer_cpu == cpu) {
+		cpumask_t tmpmask;
+
+		cpus_complement(tmpmask, nohz_cpu_mask);
+		do_timer_cpu = any_online_cpu(tmpmask);
+	}
+	spin_unlock(&do_timer_cpulock);
+
 	do {
 		seq = read_seqbegin(&xtime_lock);
 
@@ -716,6 +762,7 @@ void start_hz_timer(struct pt_regs *regs
 
 #else
 static inline int clear_hzless_mask(void) { return 0;}
+#define do_timer_cpu	boot_cpuid
 #endif
 
 static void account_ticks(struct pt_regs *regs)
@@ -742,16 +789,15 @@ static void account_ticks(struct pt_regs
 		if (!cpu_is_offline(cpu))
 			account_process_time(regs);
 
-		/*
-		 * No need to check whether cpu is offline here; boot_cpuid
-		 * should have been fixed up by now.
-		 */
-		if (cpu != boot_cpuid)
+		if (cpu != do_timer_cpu)
 			continue;
 
 		write_seqlock(&xtime_lock);
 		tb_last_jiffy += tb_ticks_per_jiffy;
-		tb_last_stamp = per_cpu(last_jiffy, cpu);
+		tb_last_stamp += tb_ticks_per_jiffy;
+		/* Handle RTCL overflow on 601 */
+		if (__USE_RTC() && tb_last_stamp >= 1000000000)
+			tb_last_stamp -= 1000000000;
 		do_timer(regs);
 		timer_recalc_offset(tb_last_jiffy);
 		timer_check_rtc();
@@ -836,6 +882,13 @@ void __init smp_space_timers(unsigned in
 	unsigned long offset = tb_ticks_per_jiffy / max_cpus;
 	unsigned long previous_tb = per_cpu(last_jiffy, boot_cpuid);
 
+#ifdef CONFIG_NO_IDLE_HZ
+	/* Don't space timers - we want to let any CPU call do_timer to
+	 * increment xtime.
+	 */
+	half = offset = 0;
+#endif
+
 	/* make sure tb > per_cpu(last_jiffy, cpu) for all cpus always */
 	previous_tb -= tb_ticks_per_jiffy;
 	/*
@@ -1051,6 +1104,8 @@ void __init time_init(void)
 	calc_cputime_factors();
 #ifdef CONFIG_NO_IDLE_HZ
 	max_skip = __USE_RTC() ? HZ : MAX_DEC_COUNT / tb_ticks_per_jiffy;
+	do_timer_cpu = boot_cpuid;
+	register_cpu_notifier(&do_timer_notifier);
 #endif
 
 	/*

_
-- 
Regards,
vatsa

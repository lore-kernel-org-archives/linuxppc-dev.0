Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dL624hnDzDrcY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 17:26:18 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p12so19085255pff.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 May 2018 00:26:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 2/2] powerpc/watchdog: provide more data in watchdog
 messages
Date: Sat,  5 May 2018 17:26:00 +1000
Message-Id: <20180505072600.13270-3-npiggin@gmail.com>
In-Reply-To: <20180505072600.13270-1-npiggin@gmail.com>
References: <20180505072600.13270-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide timebase and timebase of last heartbeat in watchdog lockup
messages. Also provide a stack trace of when a CPU becomes un-stuck,
which can be useful -- it could be where irqs are re-enabled, so it
may be the end of the critical section which is responsible for the
latency which is useful information.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 0bc701f9ab35..a99951e8199e 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -111,7 +111,13 @@ static inline void wd_smp_unlock(unsigned long *flags)
 
 static void wd_lockup_ipi(struct pt_regs *regs)
 {
-	pr_emerg("CPU %d Hard LOCKUP\n", raw_smp_processor_id());
+	int cpu = raw_smp_processor_id();
+	u64 tb = get_tb();
+
+	pr_emerg("CPU %d Hard LOCKUP\n", cpu);
+	pr_emerg("CPU %d TB:%lld, last heartbeat TB:%lld (%lldms ago)\n",
+		 cpu, tb, per_cpu(wd_timer_tb, cpu),
+		 tb_to_ns(tb - per_cpu(wd_timer_tb, cpu)) / 1000000);
 	print_modules();
 	print_irqtrace_events(current);
 	if (regs)
@@ -154,6 +160,9 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	pr_emerg("CPU %d detected hard LOCKUP on other CPUs %*pbl\n",
 		 cpu, cpumask_pr_args(&wd_smp_cpus_pending));
+	pr_emerg("CPU %d TB:%lld, last SMP heartbeat TB:%lld (%lldms ago)\n",
+		 cpu, tb, wd_smp_last_reset_tb,
+		 tb_to_ns(tb - wd_smp_last_reset_tb) / 1000000);
 
 	if (!sysctl_hardlockup_all_cpu_backtrace) {
 		/*
@@ -194,10 +203,19 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
 {
 	if (!cpumask_test_cpu(cpu, &wd_smp_cpus_pending)) {
 		if (unlikely(cpumask_test_cpu(cpu, &wd_smp_cpus_stuck))) {
+			struct pt_regs *regs = get_irq_regs();
 			unsigned long flags;
 
-			pr_emerg("CPU %d became unstuck\n", cpu);
 			wd_smp_lock(&flags);
+
+			pr_emerg("CPU %d became unstuck TB:%lld\n",
+				 cpu, tb);
+			print_irqtrace_events(current);
+			if (regs)
+				show_regs(regs);
+			else
+				dump_stack();
+
 			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
 			wd_smp_unlock(&flags);
 		}
@@ -252,7 +270,11 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 		}
 		set_cpu_stuck(cpu, tb);
 
-		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n", cpu, (void *)regs->nip);
+		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n",
+			 cpu, (void *)regs->nip);
+		pr_emerg("CPU %d TB:%lld, last heartbeat TB:%lld (%lldms ago)\n",
+			 cpu, tb, per_cpu(wd_timer_tb, cpu),
+			 tb_to_ns(tb - per_cpu(wd_timer_tb, cpu)) / 1000000);
 		print_modules();
 		print_irqtrace_events(current);
 		show_regs(regs);
-- 
2.17.0

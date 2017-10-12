Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCJD64qxbzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:44:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/3] powerpc/watchdog: Tweak watchdog printks
Date: Thu, 12 Oct 2017 15:44:32 +1100
Message-Id: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use pr_fmt() in the watchdog code, so we don't have to say "Watchdog"
so many times.

Rather than "CPU:%d" just spell it "CPU %d", "Hard" doesn't need a
capital in the middle of a sentence, and "LOCKUP other CPUS" should be
"LOCKUP on other CPUS".

Also make it clear when a CPU self detects a lockup by spelling it
out.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/watchdog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 15e209a37c2d..937cb92374c7 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -5,6 +5,9 @@
  *
  * This uses code from arch/sparc/kernel/nmi.c and kernel/watchdog.c
  */
+
+#define pr_fmt(fmt) "watchdog: " fmt
+
 #include <linux/kernel.h>
 #include <linux/param.h>
 #include <linux/init.h>
@@ -89,7 +92,7 @@ static inline void wd_smp_unlock(unsigned long *flags)
 
 static void wd_lockup_ipi(struct pt_regs *regs)
 {
-	pr_emerg("Watchdog CPU:%d Hard LOCKUP\n", raw_smp_processor_id());
+	pr_emerg("CPU %d Hard LOCKUP\n", raw_smp_processor_id());
 	print_modules();
 	print_irqtrace_events(current);
 	if (regs)
@@ -130,8 +133,8 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 	if (cpumask_weight(&wd_smp_cpus_pending) == 0)
 		goto out;
 
-	pr_emerg("Watchdog CPU:%d detected Hard LOCKUP other CPUS:%*pbl\n",
-			cpu, cpumask_pr_args(&wd_smp_cpus_pending));
+	pr_emerg("CPU %d detected hard LOCKUP on other CPUs %*pbl\n",
+		 cpu, cpumask_pr_args(&wd_smp_cpus_pending));
 
 	if (!sysctl_hardlockup_all_cpu_backtrace) {
 		/*
@@ -174,7 +177,7 @@ static void wd_smp_clear_cpu_pending(int cpu, u64 tb)
 		if (unlikely(cpumask_test_cpu(cpu, &wd_smp_cpus_stuck))) {
 			unsigned long flags;
 
-			pr_emerg("Watchdog CPU:%d became unstuck\n", cpu);
+			pr_emerg("CPU %d became unstuck\n", cpu);
 			wd_smp_lock(&flags);
 			cpumask_clear_cpu(cpu, &wd_smp_cpus_stuck);
 			wd_smp_unlock(&flags);
@@ -232,7 +235,7 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 		}
 		set_cpu_stuck(cpu, tb);
 
-		pr_emerg("Watchdog CPU:%d Hard LOCKUP\n", cpu);
+		pr_emerg("CPU %d self-detected hard LOCKUP\n", cpu);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
@@ -388,7 +391,7 @@ int __init watchdog_nmi_probe(void)
 					"powerpc/watchdog:online",
 					start_wd_on_cpu, stop_wd_on_cpu);
 	if (err < 0) {
-		pr_warn("Watchdog could not be initialized");
+		pr_warn("could not be initialized");
 		return err;
 	}
 	return 0;
-- 
2.7.4

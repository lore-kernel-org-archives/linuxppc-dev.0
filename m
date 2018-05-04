Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKg1qpBzDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:07 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id v63so17919043pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/11] powerpc/pseries: lparcfg calculate PURR on demand
Date: Sat,  5 May 2018 03:19:30 +1000
Message-Id: <20180504171935.25410-7-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For SPLPAR, lparcfg provides a sum of PURR registers for all CPUs.
Currently this is done by reading PURR in context switch and timer
interrupt, and storing that into a per-CPU variable. These are summed
to provide the value.

This does not work with all timer schemes (e.g., NO_HZ_FULL), and it
is sub-optimal for performance because it reads the PURR register on
every context switch, although that's been difficult to distinguish
from noise in the contxt_switch microbenchmark.

This patch implements the sum by calling a function on each CPU, to
read and add PURR values of each CPU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/time.h          |  8 --------
 arch/powerpc/kernel/process.c            | 14 --------------
 arch/powerpc/kernel/time.c               |  8 --------
 arch/powerpc/platforms/pseries/lparcfg.c | 18 ++++++++++--------
 4 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index db546c034905..c965c79765c4 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -196,14 +196,6 @@ extern u64 mulhdu(u64, u64);
 extern void div128_by_32(u64 dividend_high, u64 dividend_low,
 			 unsigned divisor, struct div_result *dr);
 
-/* Used to store Processor Utilization register (purr) values */
-
-struct cpu_usage {
-        u64 current_tb;  /* Holds the current purr register values */
-};
-
-DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
-
 extern void secondary_cpu_time_init(void);
 extern void __init time_init(void);
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ff7344d996e3..e6ff36923d84 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -845,10 +845,6 @@ bool ppc_breakpoint_available(void)
 }
 EXPORT_SYMBOL_GPL(ppc_breakpoint_available);
 
-#ifdef CONFIG_PPC64
-DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
-#endif
-
 static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
 			      struct arch_hw_breakpoint *b)
 {
@@ -1181,16 +1177,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	WARN_ON(!irqs_disabled());
 
-#ifdef CONFIG_PPC64
-	/*
-	 * Collect processor utilization data per process
-	 */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		struct cpu_usage *cu = this_cpu_ptr(&cpu_usage_array);
-		cu->current_tb = mfspr(SPRN_PURR);
-	}
-#endif /* CONFIG_PPC64 */
-
 #ifdef CONFIG_PPC_BOOK3S_64
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
 	if (batch->active) {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e7e8611e8863..1fe6a24357e7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -597,14 +597,6 @@ static void __timer_interrupt(void)
 		__this_cpu_inc(irq_stat.timer_irqs_others);
 	}
 
-#ifdef CONFIG_PPC64
-	/* collect purr register values often, for accurate calculations */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		struct cpu_usage *cu = this_cpu_ptr(&cpu_usage_array);
-		cu->current_tb = mfspr(SPRN_PURR);
-	}
-#endif
-
 	trace_timer_interrupt_exit(regs);
 }
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index c508c938dc71..7c872dc01bdb 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -52,18 +52,20 @@
  * Track sum of all purrs across all processors. This is used to further
  * calculate usage values by different applications
  */
+static void cpu_get_purr(void *arg)
+{
+	atomic64_t *sum = arg;
+
+	atomic64_add(mfspr(SPRN_PURR), sum);
+}
+
 static unsigned long get_purr(void)
 {
-	unsigned long sum_purr = 0;
-	int cpu;
+	atomic64_t purr = ATOMIC64_INIT(0);
 
-	for_each_possible_cpu(cpu) {
-		struct cpu_usage *cu;
+	on_each_cpu(cpu_get_purr, &purr, 1);
 
-		cu = &per_cpu(cpu_usage_array, cpu);
-		sum_purr += cu->current_tb;
-	}
-	return sum_purr;
+	return atomic64_read(&purr);
 }
 
 /*
-- 
2.17.0

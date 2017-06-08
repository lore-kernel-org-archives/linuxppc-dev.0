Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8zp0cXZzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:34 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id u1so5581544pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 02/14] powerpc/64s: idle hotplug lazy-irq simplification
Date: Fri,  9 Jun 2017 01:51:01 +1000
Message-Id: <20170608155113.21300-3-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than concern ourselves with any soft-mask logic in the CPU
hotplug handler, just hard disable interrupts. This ensures there
are no lazy-irqs pending, which means we can call directly to idle
instruction in order to sleep.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/idle.c | 23 +++++++++++++++--------
 arch/powerpc/platforms/powernv/smp.c  | 29 ++++++++++++++---------------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index b82f3be23de4..8562916b8cf7 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -325,25 +325,31 @@ void power9_idle(void)
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
+ * interrupts hard disabled and no lazy irq pending.
  */
 unsigned long pnv_cpu_offline(unsigned int cpu)
 {
 	unsigned long srr1;
-
 	u32 idle_states = pnv_get_supported_cpuidle_states();
 
+	ppc64_runlatch_off();
+
 	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
-		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
-					pnv_deepest_stop_psscr_mask);
+		unsigned long psscr;
+
+		psscr = mfspr(SPRN_PSSCR);
+		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
+						pnv_deepest_stop_psscr_val;
+		srr1 = power9_idle_stop(psscr);
+
 	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
-		srr1 = power7_idle_type(PNV_THREAD_WINKLE);
+		srr1 = power7_idle_insn(PNV_THREAD_WINKLE);
 	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-		srr1 = power7_idle_type(PNV_THREAD_SLEEP);
+		srr1 = power7_idle_insn(PNV_THREAD_SLEEP);
 	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
-		srr1 = power7_idle_type(PNV_THREAD_NAP);
+		srr1 = power7_idle_insn(PNV_THREAD_NAP);
 	} else {
-		ppc64_runlatch_off();
 		/* This is the fallback method. We emulate snooze */
 		while (!generic_check_cpu_restart(cpu)) {
 			HMT_low();
@@ -351,9 +357,10 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		}
 		srr1 = 0;
 		HMT_medium();
-		ppc64_runlatch_on();
 	}
 
+	ppc64_runlatch_on();
+
 	return srr1;
 }
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index f8752795decf..c04c87adad94 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -144,7 +144,14 @@ static void pnv_smp_cpu_kill_self(void)
 	unsigned long srr1, wmask;
 
 	/* Standard hot unplug procedure */
-	local_irq_disable();
+	/*
+	 * This hard disables local interurpts, ensuring we have no lazy
+	 * irqs pending.
+	 */
+	WARN_ON(irqs_disabled());
+	hard_irq_disable();
+	WARN_ON(lazy_irq_pending());
+
 	idle_task_exit();
 	current->active_mm = NULL; /* for sanity */
 	cpu = smp_processor_id();
@@ -162,16 +169,6 @@ static void pnv_smp_cpu_kill_self(void)
 	 */
 	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
 
-	/*
-	 * Hard-disable interrupts, and then clear irq_happened flags
-	 * that we can safely ignore while off-line, since they
-	 * are for things for which we do no processing when off-line
-	 * (or in the case of HMI, all the processing we need to do
-	 * is done in lower-level real-mode code).
-	 */
-	hard_irq_disable();
-	local_paca->irq_happened &= ~(PACA_IRQ_DEC | PACA_IRQ_HMI);
-
 	while (!generic_check_cpu_restart(cpu)) {
 		/*
 		 * Clear IPI flag, since we don't handle IPIs while
@@ -184,6 +181,8 @@ static void pnv_smp_cpu_kill_self(void)
 
 		srr1 = pnv_cpu_offline(cpu);
 
+		WARN_ON(lazy_irq_pending());
+
 		/*
 		 * If the SRR1 value indicates that we woke up due to
 		 * an external interrupt, then clear the interrupt.
@@ -196,8 +195,7 @@ static void pnv_smp_cpu_kill_self(void)
 		 * contains 0.
 		 */
 		if (((srr1 & wmask) == SRR1_WAKEEE) ||
-		    ((srr1 & wmask) == SRR1_WAKEHVI) ||
-		    (local_paca->irq_happened & PACA_IRQ_EE)) {
+		    ((srr1 & wmask) == SRR1_WAKEHVI)) {
 			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 				if (xive_enabled())
 					xive_flush_interrupt();
@@ -209,14 +207,15 @@ static void pnv_smp_cpu_kill_self(void)
 			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 			asm volatile(PPC_MSGCLR(%0) : : "r" (msg));
 		}
-		local_paca->irq_happened &= ~(PACA_IRQ_EE | PACA_IRQ_DBELL);
 		smp_mb();
 
 		if (cpu_core_split_required())
 			continue;
 
 		if (srr1 && !generic_check_cpu_restart(cpu))
-			DBG("CPU%d Unexpected exit while offline !\n", cpu);
+			DBG("CPU%d Unexpected exit while offline srr1=%lx!\n",
+					cpu, srr1);
+
 	}
 
 	/* Re-enable decrementer interrupts */
-- 
2.11.0

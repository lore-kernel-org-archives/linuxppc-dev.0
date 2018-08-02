Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gyT83FrDzF1dL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 14:52:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w724lvIb083140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2018 00:52:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kku7x83cw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 00:52:09 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 2 Aug 2018 05:52:07 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3] powernv/cpuidle: Pass pointers instead of values to
 stop loop
Date: Thu,  2 Aug 2018 10:21:31 +0530
In-Reply-To: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180802045132.12432-3-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Passing pointer to the pnv_idle_state instead of psscr value and mask.
This helps us to pass more information to the stop loop. This will help to
figure out the method to enter/exit idle state.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h  |  3 +-
 arch/powerpc/platforms/powernv/idle.c | 58 ++++++++++++---------------
 drivers/cpuidle/cpuidle-powernv.c     | 16 +++-----
 3 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 5debe337ea9d..34f572056add 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -515,8 +515,7 @@ extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc
 extern void power7_idle_type(unsigned long type);
 extern unsigned long power9_idle_stop(unsigned long psscr_val);
 extern unsigned long power9_offline_stop(unsigned long psscr_val);
-extern void power9_idle_type(unsigned long stop_psscr_val,
-			      unsigned long stop_psscr_mask);
+extern void power9_idle_type(int index);
 
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 93accece92e3..a6ef9b68e27b 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -43,8 +43,7 @@ int nr_pnv_idle_states;
  * The default stop state that will be used by ppc_md.power_save
  * function on platforms that support stop instruction.
  */
-static u64 pnv_default_stop_val;
-static u64 pnv_default_stop_mask;
+struct pnv_idle_states_t *pnv_default_state;
 static bool default_stop_found;
 
 static int parse_dt_v1(struct device_node *np);
@@ -70,9 +69,7 @@ u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
  * psscr value and mask of the deepest stop idle state.
  * Used when a cpu is offlined.
  */
-static u64 pnv_deepest_stop_psscr_val;
-static u64 pnv_deepest_stop_psscr_mask;
-static u64 pnv_deepest_stop_flag;
+static struct pnv_idle_states_t *pnv_deepest_state;
 static bool deepest_stop_found;
 
 static int pnv_save_sprs_for_deep_states(void)
@@ -92,7 +89,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t hid5_val = mfspr(SPRN_HID5);
 	uint64_t hmeer_val = mfspr(SPRN_HMEER);
 	uint64_t msr_val = MSR_IDLE;
-	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
+	uint64_t psscr_val = pnv_deepest_state->psscr_val;
 
 	for_each_present_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
@@ -218,18 +215,15 @@ static void pnv_alloc_idle_core_states(void)
 		pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
 
 		if (cpu_has_feature(CPU_FTR_ARCH_300) &&
-		    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
+		    (pnv_deepest_state->flags & OPAL_PM_LOSE_FULL_CONTEXT)) {
 			/*
 			 * Use the default stop state for CPU-Hotplug
 			 * if available.
 			 */
 			if (default_stop_found) {
-				pnv_deepest_stop_psscr_val =
-					pnv_default_stop_val;
-				pnv_deepest_stop_psscr_mask =
-					pnv_default_stop_mask;
+				pnv_deepest_state = pnv_default_state;
 				pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
-					pnv_deepest_stop_psscr_val);
+					pnv_deepest_state->psscr_val);
 			} else { /* Fallback to snooze loop for CPU-Hotplug */
 				deepest_stop_found = false;
 				pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
@@ -365,20 +359,20 @@ void power7_idle(void)
 	power7_idle_type(PNV_THREAD_NAP);
 }
 
-static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
-				      unsigned long stop_psscr_mask)
+static unsigned long __power9_idle_type(struct pnv_idle_states_t *state)
 {
-	unsigned long psscr;
+	unsigned long psscr, stop_psscr_mask, stop_psscr_val;
 	unsigned long srr1;
 
+	stop_psscr_mask = state->psscr_mask;
+	stop_psscr_val = state->psscr_val;
 	if (!prep_irq_for_idle_irqsoff())
 		return 0;
 
 	psscr = mfspr(SPRN_PSSCR);
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
-
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr);
+	srr1 = power9_idle_stop(psscr, state->opal_supported);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -386,12 +380,11 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 	return srr1;
 }
 
-void power9_idle_type(unsigned long stop_psscr_val,
-				      unsigned long stop_psscr_mask)
+void power9_idle_type(struct pnv_idle_states_t *state)
 {
 	unsigned long srr1;
+	srr1 = __power9_idle_type(state);
 
-	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
 	irq_set_pending_from_srr1(srr1);
 }
 
@@ -400,7 +393,10 @@ void power9_idle_type(unsigned long stop_psscr_val,
  */
 void power9_idle(void)
 {
-	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
+	unsigned long srr1;
+
+	srr1 = __power9_idle_type(pnv_default_state);
+	irq_set_pending_from_srr1(srr1);
 }
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -500,6 +496,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 	unsigned long srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
 	u64 lpcr_val;
+	struct pnv_idle_states_t *state = pnv_deepest_state;
 
 	/*
 	 * We don't want to take decrementer interrupts while we are
@@ -520,9 +517,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		unsigned long psscr;
 
 		psscr = mfspr(SPRN_PSSCR);
-		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
-						pnv_deepest_stop_psscr_val;
-		srr1 = power9_offline_stop(psscr);
+		psscr = (psscr & ~state->psscr_mask) |	state->psscr_val;
+		srr1 = power9_offline_stop(psscr, state->opal_supported);
 
 	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
 		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
@@ -682,16 +678,13 @@ static int __init pnv_power9_idle_init(void)
 		 */
 		if (max_residency_ns < state->residency_ns) {
 			max_residency_ns = state->residency_ns;
-			pnv_deepest_stop_psscr_val = state->psscr_val;
-			pnv_deepest_stop_psscr_mask = state->psscr_mask;
-			pnv_deepest_stop_flag = state->flags;
+			pnv_deepest_state = state;
 			deepest_stop_found = true;
 		}
 
 		if (!default_stop_found &&
 		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
-			pnv_default_stop_val = state->psscr_val;
-			pnv_default_stop_mask = state->psscr_mask;
+			pnv_default_state = state;
 			default_stop_found = true;
 		}
 	}
@@ -701,15 +694,16 @@ static int __init pnv_power9_idle_init(void)
 	} else {
 		ppc_md.power_save = power9_idle;
 		pr_info("cpuidle-powernv: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
-			pnv_default_stop_val, pnv_default_stop_mask);
+			pnv_default_state->psscr_val,
+			pnv_default_state->psscr_mask);
 	}
 
 	if (unlikely(!deepest_stop_found)) {
 		pr_warn("cpuidle-powernv: No suitable stop state for CPU-Hotplug. Offlined CPUs will busy wait");
 	} else {
 		pr_info("cpuidle-powernv: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
-			pnv_deepest_stop_psscr_val,
-			pnv_deepest_stop_psscr_mask);
+			pnv_deepest_state->psscr_val,
+			pnv_deepest_state->psscr_mask);
 	}
 
 	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index f5579f0369d1..b8cb377b774b 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -35,13 +35,7 @@ static struct cpuidle_driver powernv_idle_driver = {
 static int max_idle_state __read_mostly;
 static struct cpuidle_state *cpuidle_state_table __read_mostly;
 
-struct stop_psscr_table {
-	u64 val;
-	u64 mask;
-};
-
-static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
-
+struct pnv_idle_states_t idx_to_state_ptr[CPUIDLE_STATE_MAX] __read_mostly;
 static u64 default_snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
@@ -143,8 +137,9 @@ static int stop_loop(struct cpuidle_device *dev,
 		     struct cpuidle_driver *drv,
 		     int index)
 {
-	power9_idle_type(stop_psscr_table[index].val,
-			 stop_psscr_table[index].mask);
+	struct pnv_idle_states_t state;
+	state = idx_to_state_ptr[index];
+	power9_idle_type(state);
 	return index;
 }
 
@@ -243,8 +238,6 @@ static inline void add_powernv_state(int index, const char *name,
 	powernv_states[index].exit_latency = exit_latency;
 	powernv_states[index].enter = idle_fn;
 	/* For power8 and below psscr_* will be 0 */
-	stop_psscr_table[index].val = psscr_val;
-	stop_psscr_table[index].mask = psscr_mask;
 }
 
 /*
@@ -371,6 +364,7 @@ static int powernv_add_idle_states(void)
 					  target_residency, exit_latency,
 					  state->psscr_val,
 					  state->psscr_mask);
+			idx_to_state_ptr[nr_idle_states] = state;
 		}
 #endif
 		else {
-- 
2.18.0.rc2.85.g1fb9df7

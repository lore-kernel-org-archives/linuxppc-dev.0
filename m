Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8zk3ngKzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:51:30 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f27so5592273pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:51:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 01/14] powerpc/64s: idle move soft interrupt mask logic into C
 code
Date: Fri,  9 Jun 2017 01:51:00 +1000
Message-Id: <20170608155113.21300-2-npiggin@gmail.com>
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

This simplifies the asm and fixes irq-off tracing over sleep
instructions.

Also move powersave_nap check for POWER8 into C code, and move
PSSCR register value calculation for POWER9 into C.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/machdep.h       |  1 +
 arch/powerpc/include/asm/processor.h     | 10 ++--
 arch/powerpc/kernel/idle_book3s.S        | 84 ++++++-------------------------
 arch/powerpc/kernel/irq.c                |  3 +-
 arch/powerpc/platforms/powernv/idle.c    | 85 +++++++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/smp.c     |  2 -
 arch/powerpc/platforms/powernv/subcore.c |  3 +-
 drivers/cpuidle/cpuidle-powernv.c        | 12 ++---
 8 files changed, 105 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f90b22c722e1..cd2fc1cc1cc7 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -226,6 +226,7 @@ struct machdep_calls {
 extern void e500_idle(void);
 extern void power4_idle(void);
 extern void power7_idle(void);
+extern void power9_idle(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 586c0b72a155..832775771bd3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -501,11 +501,11 @@ extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
-extern unsigned long power7_nap(int check_irq);
-extern unsigned long power7_sleep(void);
-extern unsigned long power7_winkle(void);
-extern unsigned long power9_idle_stop(unsigned long stop_psscr_val,
-				      unsigned long stop_psscr_mask);
+extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
+extern void power7_idle_type(unsigned long type);
+extern unsigned long power9_idle_stop(unsigned long psscr_val);
+extern void power9_idle_type(unsigned long stop_psscr_val,
+			      unsigned long stop_psscr_mask);
 
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 4898d676dcae..c7edb374d1aa 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -106,13 +106,9 @@ core_idle_lock_held:
 /*
  * Pass requested state in r3:
  *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
- *	   - Requested STOP state in POWER9
+ *	   - Requested PSSCR value in POWER9
  *
- * To check IRQ_HAPPENED in r4
- * 	0 - don't check
- * 	1 - check
- *
- * Address to 'rfid' to in r5
+ * Address of idle handler to 'rfid' to in r4
  */
 pnv_powersave_common:
 	/* Use r3 to pass state nap/sleep/winkle */
@@ -128,30 +124,7 @@ pnv_powersave_common:
 	std	r0,_LINK(r1)
 	std	r0,_NIP(r1)
 
-	/* Hard disable interrupts */
-	mfmsr	r9
-	rldicl	r9,r9,48,1
-	rotldi	r9,r9,16
-	mtmsrd	r9,1			/* hard-disable interrupts */
-
-	/* Check if something happened while soft-disabled */
-	lbz	r0,PACAIRQHAPPENED(r13)
-	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
-	beq	1f
-	cmpwi	cr0,r4,0
-	beq	1f
-	addi	r1,r1,INT_FRAME_SIZE
-	ld	r0,16(r1)
-	li	r3,0			/* Return 0 (no nap) */
-	mtlr	r0
-	blr
-
-1:	/* We mark irqs hard disabled as this is the state we'll
-	 * be in when returning and we need to tell arch_local_irq_restore()
-	 * about it
-	 */
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
+	mfmsr   r9
 
 	/* We haven't lost state ... yet */
 	li	r0,0
@@ -160,8 +133,8 @@ pnv_powersave_common:
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
 	SAVE_NVGPRS(r1)
-	mfcr	r4
-	std	r4,_CCR(r1)
+	mfcr	r5
+	std	r5,_CCR(r1)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
@@ -175,7 +148,7 @@ pnv_powersave_common:
 	li	r6, MSR_RI
 	andc	r6, r9, r6
 	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
-	mtspr	SPRN_SRR0, r5
+	mtspr	SPRN_SRR0, r4
 	mtspr	SPRN_SRR1, r7
 	rfid
 
@@ -319,35 +292,14 @@ lwarx_loop_stop:
 
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 
-_GLOBAL(power7_idle)
+/*
+ * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
+ * r3 contains desired idle state (PNV_THREAD_NAP/SLEEP/WINKLE).
+ */
+_GLOBAL(power7_idle_insn)
 	/* Now check if user or arch enabled NAP mode */
-	LOAD_REG_ADDRBASE(r3,powersave_nap)
-	lwz	r4,ADDROFF(powersave_nap)(r3)
-	cmpwi	0,r4,0
-	beqlr
-	li	r3, 1
-	/* fall through */
-
-_GLOBAL(power7_nap)
-	mr	r4,r3
-	li	r3,PNV_THREAD_NAP
-	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
-	b	pnv_powersave_common
-	/* No return */
-
-_GLOBAL(power7_sleep)
-	li	r3,PNV_THREAD_SLEEP
-	li	r4,1
-	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
+	LOAD_REG_ADDR(r4, pnv_enter_arch207_idle_mode)
 	b	pnv_powersave_common
-	/* No return */
-
-_GLOBAL(power7_winkle)
-	li	r3,PNV_THREAD_WINKLE
-	li	r4,1
-	LOAD_REG_ADDR(r5, pnv_enter_arch207_idle_mode)
-	b	pnv_powersave_common
-	/* No return */
 
 #define CHECK_HMI_INTERRUPT						\
 	mfspr	r0,SPRN_SRR1;						\
@@ -369,16 +321,12 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 20:	nop;
 
 /*
- * r3 - The PSSCR value corresponding to the stop state.
- * r4 - The PSSCR mask corrresonding to the stop state.
+ * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
+ * r3 contains desired PSSCR register value.
  */
 _GLOBAL(power9_idle_stop)
-	mfspr   r5,SPRN_PSSCR
-	andc    r5,r5,r4
-	or      r3,r3,r5
-	mtspr 	SPRN_PSSCR,r3
-	LOAD_REG_ADDR(r5,power_enter_stop)
-	li	r4,1
+	mtspr	SPRN_PSSCR,r3
+	LOAD_REG_ADDR(r4,power_enter_stop)
 	b	pnv_powersave_common
 	/* No return */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5c291df30fe3..cfa29ddcb215 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -322,7 +322,8 @@ bool prep_irq_for_idle(void)
 	 * First we need to hard disable to ensure no interrupt
 	 * occurs before we effectively enter the low power state
 	 */
-	hard_irq_disable();
+	__hard_irq_disable();
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 
 	/*
 	 * If anything happened while we were soft-disabled,
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 445f30a2c5ef..b82f3be23de4 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -23,6 +23,7 @@
 #include <asm/cpuidle.h>
 #include <asm/code-patching.h>
 #include <asm/smp.h>
+#include <asm/runlatch.h>
 
 #include "powernv.h"
 #include "subcore.h"
@@ -240,14 +241,6 @@ static u64 pnv_default_stop_mask;
 static bool default_stop_found;
 
 /*
- * Used for ppc_md.power_save which needs a function with no parameters
- */
-static void power9_idle(void)
-{
-	power9_idle_stop(pnv_default_stop_val, pnv_default_stop_mask);
-}
-
-/*
  * First deep stop state. Used to figure out when to save/restore
  * hypervisor context.
  */
@@ -261,6 +254,74 @@ static u64 pnv_deepest_stop_psscr_val;
 static u64 pnv_deepest_stop_psscr_mask;
 static bool deepest_stop_found;
 
+static unsigned long __power7_idle_type(unsigned long type)
+{
+	unsigned long srr1;
+
+	WARN_ON(!irqs_disabled());
+
+	if (!prep_irq_for_idle())
+		return 0;
+
+	ppc64_runlatch_off();
+	srr1 = power7_idle_insn(type);
+	ppc64_runlatch_on();
+
+	return srr1;
+}
+
+void power7_idle_type(unsigned long type)
+{
+	__power7_idle_type(type);
+	__hard_irq_enable();
+}
+
+void power7_idle(void)
+{
+	if (!powersave_nap)
+		return;
+
+	power7_idle_type(PNV_THREAD_NAP);
+}
+
+static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
+				      unsigned long stop_psscr_mask)
+{
+	unsigned long psscr;
+	unsigned long srr1;
+
+	WARN_ON(!irqs_disabled());
+
+	if (!prep_irq_for_idle())
+		return 0;
+
+	psscr = mfspr(SPRN_PSSCR);
+	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
+
+	ppc64_runlatch_off();
+	srr1 = power9_idle_stop(psscr);
+	ppc64_runlatch_on();
+
+	trace_hardirqs_off();
+
+	return srr1;
+}
+
+void power9_idle_type(unsigned long stop_psscr_val,
+				      unsigned long stop_psscr_mask)
+{
+	__power9_idle_type(stop_psscr_val, stop_psscr_mask);
+	__hard_irq_enable();
+}
+
+/*
+ * Used for ppc_md.power_save which needs a function with no parameters
+ */
+void power9_idle(void)
+{
+	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
+}
+
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
@@ -275,13 +336,14 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
 					pnv_deepest_stop_psscr_mask);
 	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
-		srr1 = power7_winkle();
+		srr1 = power7_idle_type(PNV_THREAD_WINKLE);
 	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-		srr1 = power7_sleep();
+		srr1 = power7_idle_type(PNV_THREAD_SLEEP);
 	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
-		srr1 = power7_nap(1);
+		srr1 = power7_idle_type(PNV_THREAD_NAP);
 	} else {
+		ppc64_runlatch_off();
 		/* This is the fallback method. We emulate snooze */
 		while (!generic_check_cpu_restart(cpu)) {
 			HMT_low();
@@ -289,6 +351,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		}
 		srr1 = 0;
 		HMT_medium();
+		ppc64_runlatch_on();
 	}
 
 	return srr1;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 4aff754b6f2c..f8752795decf 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -182,9 +182,7 @@ static void pnv_smp_cpu_kill_self(void)
 		 */
 		kvmppc_set_host_ipi(cpu, 0);
 
-		ppc64_runlatch_off();
 		srr1 = pnv_cpu_offline(cpu);
-		ppc64_runlatch_on();
 
 		/*
 		 * If the SRR1 value indicates that we woke up due to
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 0babef11136f..d975d78188a9 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -18,6 +18,7 @@
 #include <linux/stop_machine.h>
 
 #include <asm/cputhreads.h>
+#include <asm/cpuidle.h>
 #include <asm/kvm_ppc.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -182,7 +183,7 @@ static void unsplit_core(void)
 	cpu = smp_processor_id();
 	if (cpu_thread_in_core(cpu) != 0) {
 		while (mfspr(SPRN_HID0) & mask)
-			power7_nap(0);
+			power7_idle_insn(PNV_THREAD_NAP);
 
 		per_cpu(split_state, cpu).step = SYNC_STEP_UNSPLIT;
 		return;
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 12409a519cc5..150b971c303b 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -73,9 +73,8 @@ static int nap_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	ppc64_runlatch_off();
-	power7_idle();
-	ppc64_runlatch_on();
+	power7_idle_type(PNV_THREAD_NAP);
+
 	return index;
 }
 
@@ -98,7 +97,8 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	new_lpcr &= ~LPCR_PECE1;
 
 	mtspr(SPRN_LPCR, new_lpcr);
-	power7_sleep();
+
+	power7_idle_type(PNV_THREAD_SLEEP);
 
 	mtspr(SPRN_LPCR, old_lpcr);
 
@@ -110,10 +110,8 @@ static int stop_loop(struct cpuidle_device *dev,
 		     struct cpuidle_driver *drv,
 		     int index)
 {
-	ppc64_runlatch_off();
-	power9_idle_stop(stop_psscr_table[index].val,
+	power9_idle_type(stop_psscr_table[index].val,
 			 stop_psscr_table[index].mask);
-	ppc64_runlatch_on();
 	return index;
 }
 
-- 
2.11.0

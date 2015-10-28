Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A2861A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:28 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/19] powerpc: Move part of giveup_fpu,altivec,spe into c
Date: Wed, 28 Oct 2015 11:50:57 +1100
Message-Id: <1445993467-667-9-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the MSR modification into new c functions. Removing it from
the low level functions will allow us to avoid costly MSR writes
by batching them up.

Move the check_if_tm_restore_required() check into these new functions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h | 12 ++++-----
 arch/powerpc/kernel/fpu.S            | 16 ++---------
 arch/powerpc/kernel/head_fsl_booke.S |  8 ++----
 arch/powerpc/kernel/ppc_ksyms.c      |  6 -----
 arch/powerpc/kernel/process.c        | 52 +++++++++++++++++++++++++++++++++---
 arch/powerpc/kernel/vector.S         | 10 ++-----
 6 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 042aaf0..6bcfb89 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -30,21 +30,21 @@ extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 #ifdef CONFIG_PPC_FPU
 extern void flush_fp_to_thread(struct task_struct *);
 extern void giveup_fpu(struct task_struct *);
+extern void __giveup_fpu(struct task_struct *);
 #else
 static inline void flush_fp_to_thread(struct task_struct *t) { }
 static inline void giveup_fpu(struct task_struct *t) { }
+static inline void __giveup_fpu(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
+extern void __giveup_altivec(struct task_struct *);
 #else
-static inline void flush_altivec_to_thread(struct task_struct *t)
-{
-}
-static inline void giveup_altivec(struct task_struct *t)
-{
-}
+static inline void flush_altivec_to_thread(struct task_struct *t) { }
+static inline void giveup_altivec(struct task_struct *t) { }
+static inline void __giveup_altivec(struct task_struct *t) { }
 #endif
 
 #ifdef CONFIG_VSX
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 71bdce2..431ab57 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -155,24 +155,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	blr
 
 /*
- * giveup_fpu(tsk)
+ * __giveup_fpu(tsk)
  * Disable FP for the task given as the argument,
  * and save the floating-point registers in its thread_struct.
  * Enables the FPU for use in the kernel on return.
  */
-_GLOBAL(giveup_fpu)
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	oris	r5,r5,MSR_VSX@h
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif
-	SYNC_601
-	ISYNC_601
-	MTMSRD(r5)			/* enable use of fpu now */
-	SYNC_601
-	isync
+_GLOBAL(__giveup_fpu)
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r6,THREAD_FPSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d6980bb..f705171 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -984,14 +984,10 @@ _GLOBAL(__setup_ehv_ivors)
 
 #ifdef CONFIG_SPE
 /*
- * extern void giveup_spe(struct task_struct *prev)
+ * extern void __giveup_spe(struct task_struct *prev)
  *
  */
-_GLOBAL(giveup_spe)
-	mfmsr	r5
-	oris	r5,r5,MSR_SPE@h
-	mtmsr	r5			/* enable use of SPE now */
-	isync
+_GLOBAL(__giveup_spe)
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	lwz	r5,PT_REGS(r3)
 	cmpi	0,r5,0
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 202963e..41e1607 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -19,13 +19,11 @@ EXPORT_SYMBOL(_mcount);
 #endif
 
 #ifdef CONFIG_PPC_FPU
-EXPORT_SYMBOL(giveup_fpu);
 EXPORT_SYMBOL(load_fp_state);
 EXPORT_SYMBOL(store_fp_state);
 #endif
 
 #ifdef CONFIG_ALTIVEC
-EXPORT_SYMBOL(giveup_altivec);
 EXPORT_SYMBOL(load_vr_state);
 EXPORT_SYMBOL(store_vr_state);
 #endif
@@ -34,10 +32,6 @@ EXPORT_SYMBOL(store_vr_state);
 EXPORT_SYMBOL_GPL(__giveup_vsx);
 #endif
 
-#ifdef CONFIG_SPE
-EXPORT_SYMBOL(giveup_spe);
-#endif
-
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5bf8ec2..ca8b36f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -88,6 +88,25 @@ static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 #ifdef CONFIG_PPC_FPU
+void giveup_fpu(struct task_struct *tsk)
+{
+	u64 oldmsr = mfmsr();
+	u64 newmsr;
+
+	check_if_tm_restore_required(tsk);
+
+	newmsr = oldmsr | MSR_FP;
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX))
+		newmsr |= MSR_VSX;
+#endif
+	if (oldmsr != newmsr)
+		mtmsr_isync(newmsr);
+
+	__giveup_fpu(tsk);
+}
+EXPORT_SYMBOL(giveup_fpu);
+
 /*
  * Make sure the floating-point register state in the
  * the thread_struct is up to date for task tsk.
@@ -113,7 +132,6 @@ void flush_fp_to_thread(struct task_struct *tsk)
 			 * to still have its FP state in the CPU registers.
 			 */
 			BUG_ON(tsk != current);
-			check_if_tm_restore_required(tsk);
 			giveup_fpu(tsk);
 		}
 		preempt_enable();
@@ -127,7 +145,6 @@ void enable_kernel_fp(void)
 	WARN_ON(preemptible());
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
-		check_if_tm_restore_required(current);
 		giveup_fpu(current);
 	} else {
 		u64 oldmsr = mfmsr();
@@ -139,12 +156,26 @@ void enable_kernel_fp(void)
 EXPORT_SYMBOL(enable_kernel_fp);
 
 #ifdef CONFIG_ALTIVEC
+void giveup_altivec(struct task_struct *tsk)
+{
+	u64 oldmsr = mfmsr();
+	u64 newmsr;
+
+	check_if_tm_restore_required(tsk);
+
+	newmsr = oldmsr | MSR_VEC;
+	if (oldmsr != newmsr)
+		mtmsr_isync(newmsr);
+
+	__giveup_altivec(tsk);
+}
+EXPORT_SYMBOL(giveup_altivec);
+
 void enable_kernel_altivec(void)
 {
 	WARN_ON(preemptible());
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
-		check_if_tm_restore_required(current);
 		giveup_altivec(current);
 	} else {
 		u64 oldmsr = mfmsr();
@@ -165,7 +196,6 @@ void flush_altivec_to_thread(struct task_struct *tsk)
 		preempt_disable();
 		if (tsk->thread.regs->msr & MSR_VEC) {
 			BUG_ON(tsk != current);
-			check_if_tm_restore_required(tsk);
 			giveup_altivec(tsk);
 		}
 		preempt_enable();
@@ -214,6 +244,20 @@ EXPORT_SYMBOL_GPL(flush_vsx_to_thread);
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_SPE
+void giveup_spe(struct task_struct *)
+{
+	u64 oldmsr = mfmsr();
+	u64 newmsr;
+
+	check_if_tm_restore_required(tsk);
+
+	newmsr = oldmsr | MSR_SPE;
+	if (oldmsr != newmsr)
+		mtmsr_isync(newmsr);
+
+	__giveup_spe(tsk);
+}
+EXPORT_SYMBOL(giveup_spe);
 
 void enable_kernel_spe(void)
 {
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index b31528c..6e925b4 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -112,17 +112,11 @@ _GLOBAL(load_up_altivec)
 	blr
 
 /*
- * giveup_altivec(tsk)
+ * __giveup_altivec(tsk)
  * Disable VMX for the task given as the argument,
  * and save the vector registers in its thread_struct.
- * Enables the VMX for use in the kernel on return.
  */
-_GLOBAL(giveup_altivec)
-	mfmsr	r5
-	oris	r5,r5,MSR_VEC@h
-	SYNC
-	MTMSRD(r5)			/* enable use of VMX now */
-	isync
+_GLOBAL(__giveup_altivec)
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	PPC_LL	r7,THREAD_VRSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
-- 
2.5.0

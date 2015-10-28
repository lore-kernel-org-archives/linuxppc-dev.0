Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99DAE1A0296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:34 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/19] powerpc: Create msr_check_and_{set,clear}()
Date: Wed, 28 Oct 2015 11:51:00 +1100
Message-Id: <1445993467-667-12-git-send-email-anton@samba.org>
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

Create helper functions to set and clear MSR bits after first
checking if they are already set. Grouping them will make it
easy to avoid the MSR writes in a subsequent optimisation.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 107 ++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c39aa5a..5f244d0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -87,23 +87,46 @@ static void check_if_tm_restore_required(struct task_struct *tsk)
 static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-#ifdef CONFIG_PPC_FPU
-void giveup_fpu(struct task_struct *tsk)
+static void msr_check_and_set(unsigned long bits)
 {
-	u64 oldmsr = mfmsr();
-	u64 newmsr;
+	unsigned long oldmsr = mfmsr();
+	unsigned long newmsr;
 
-	check_if_tm_restore_required(tsk);
+	newmsr = oldmsr | bits;
 
-	newmsr = oldmsr | MSR_FP;
 #ifdef CONFIG_VSX
-	if (cpu_has_feature(CPU_FTR_VSX))
+	if (cpu_has_feature(CPU_FTR_VSX) && (bits & MSR_FP))
 		newmsr |= MSR_VSX;
 #endif
+
 	if (oldmsr != newmsr)
 		mtmsr_isync(newmsr);
+}
+
+static void msr_check_and_clear(unsigned long bits)
+{
+	unsigned long oldmsr = mfmsr();
+	unsigned long newmsr;
+
+	newmsr = oldmsr & ~bits;
+
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX) && (bits & MSR_FP))
+		newmsr &= ~MSR_VSX;
+#endif
 
+	if (oldmsr != newmsr)
+		mtmsr_isync(newmsr);
+}
+
+#ifdef CONFIG_PPC_FPU
+void giveup_fpu(struct task_struct *tsk)
+{
+	check_if_tm_restore_required(tsk);
+
+	msr_check_and_set(MSR_FP);
 	__giveup_fpu(tsk);
+	msr_check_and_clear(MSR_FP);
 }
 EXPORT_SYMBOL(giveup_fpu);
 
@@ -144,30 +167,21 @@ void enable_kernel_fp(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
-		giveup_fpu(current);
-	} else {
-		u64 oldmsr = mfmsr();
+	msr_check_and_set(MSR_FP);
 
-		if (!(oldmsr & MSR_FP))
-			mtmsr_isync(oldmsr | MSR_FP);
-	}
+	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
+		__giveup_fpu(current);
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
 #ifdef CONFIG_ALTIVEC
 void giveup_altivec(struct task_struct *tsk)
 {
-	u64 oldmsr = mfmsr();
-	u64 newmsr;
-
 	check_if_tm_restore_required(tsk);
 
-	newmsr = oldmsr | MSR_VEC;
-	if (oldmsr != newmsr)
-		mtmsr_isync(newmsr);
-
+	msr_check_and_set(MSR_VEC);
 	__giveup_altivec(tsk);
+	msr_check_and_clear(MSR_VEC);
 }
 EXPORT_SYMBOL(giveup_altivec);
 
@@ -175,14 +189,10 @@ void enable_kernel_altivec(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
-		giveup_altivec(current);
-	} else {
-		u64 oldmsr = mfmsr();
+	msr_check_and_set(MSR_VEC);
 
-		if (!(oldmsr & MSR_VEC))
-			mtmsr_isync(oldmsr | MSR_VEC);
-	}
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
+		__giveup_altivec(current);
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
 
@@ -207,20 +217,15 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
 #ifdef CONFIG_VSX
 void giveup_vsx(struct task_struct *tsk)
 {
-	u64 oldmsr = mfmsr();
-	u64 newmsr;
-
 	check_if_tm_restore_required(tsk);
 
-	newmsr = oldmsr | (MSR_FP|MSR_VEC|MSR_VSX);
-	if (oldmsr != newmsr)
-		mtmsr_isync(newmsr);
-
+	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 	if (tsk->thread.regs->msr & MSR_FP)
 		__giveup_fpu(tsk);
 	if (tsk->thread.regs->msr & MSR_VEC)
 		__giveup_altivec(tsk);
 	__giveup_vsx(tsk);
+	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
 EXPORT_SYMBOL(giveup_vsx);
 
@@ -228,13 +233,14 @@ void enable_kernel_vsx(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
-		giveup_vsx(current);
-	} else {
-		u64 oldmsr = mfmsr();
+	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 
-		if (!(oldmsr & MSR_VSX))
-			mtmsr_isync(oldmsr | MSR_VSX);
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
+		if (current->thread.regs->msr & MSR_FP)
+			__giveup_fpu(current);
+		if (current->thread.regs->msr & MSR_VEC)
+			__giveup_altivec(current);
+		__giveup_vsx(current);
 	}
 }
 EXPORT_SYMBOL(enable_kernel_vsx);
@@ -256,16 +262,11 @@ EXPORT_SYMBOL_GPL(flush_vsx_to_thread);
 #ifdef CONFIG_SPE
 void giveup_spe(struct task_struct *)
 {
-	u64 oldmsr = mfmsr();
-	u64 newmsr;
-
 	check_if_tm_restore_required(tsk);
 
-	newmsr = oldmsr | MSR_SPE;
-	if (oldmsr != newmsr)
-		mtmsr_isync(newmsr);
-
+	msr_check_and_set(MSR_SPE);
 	__giveup_spe(tsk);
+	msr_check_and_clear(MSR_SPE);
 }
 EXPORT_SYMBOL(giveup_spe);
 
@@ -273,14 +274,10 @@ void enable_kernel_spe(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE)) {
-		giveup_spe(current);
-	} else {
-		u64 oldmsr = mfmsr();
+	msr_check_and_set(MSR_SPE);
 
-		if (!(oldmsr & MSR_SPE))
-			mtmsr_isync(oldmsr | MSR_SPE);
-	}
+	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE))
+		__giveup_spe(current);
 }
 EXPORT_SYMBOL(enable_kernel_spe);
 
-- 
2.5.0

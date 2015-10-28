Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75BA41A034F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:43 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/19] powerpc: create giveup_all()
Date: Wed, 28 Oct 2015 11:51:04 +1100
Message-Id: <1445993467-667-16-git-send-email-anton@samba.org>
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

Create a single function that gives everything up (FP, VMX, VSX, SPE).
Doing this all at once means we only do one MSR write.

A context switch microbenchmark using yield():

http://ozlabs.org/~anton/junkcode/context_switch2.c

./context_switch2 --test=yield --fp --altivec --vector 0 0

shows an improvement of 3% on POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h |  1 +
 arch/powerpc/kernel/process.c        | 75 ++++++++++++++++++++++++++++--------
 arch/powerpc/kvm/book3s_pr.c         | 17 +-------
 3 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index b6a4951..0b4a339 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -27,6 +27,7 @@ extern void giveup_vsx(struct task_struct *);
 extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
+extern void giveup_all(struct task_struct *);
 extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 
 #ifdef CONFIG_PPC_FPU
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index cf2d811..5ca416c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -308,6 +308,64 @@ void flush_spe_to_thread(struct task_struct *tsk)
 }
 #endif /* CONFIG_SPE */
 
+static unsigned long msr_all_available;
+
+static int __init init_msr_all_available(void)
+{
+#ifdef CONFIG_PPC_FPU
+	msr_all_available |= MSR_FP;
+#endif
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		msr_all_available |= MSR_VEC;
+#endif
+#ifdef CONFIG_VSX
+	if (cpu_has_feature(CPU_FTR_VSX))
+		msr_all_available |= MSR_VSX;
+#endif
+#ifdef CONFIG_SPE
+	if (cpu_has_feature(CPU_FTR_SPE))
+		msr_all_available |= MSR_SPE;
+#endif
+
+	return 0;
+}
+early_initcall(init_msr_all_available);
+
+void giveup_all(struct task_struct *tsk)
+{
+	unsigned long usermsr;
+
+	if (!tsk->thread.regs)
+		return;
+
+	usermsr = tsk->thread.regs->msr;
+
+	if ((usermsr & msr_all_available) == 0)
+		return;
+
+	msr_check_and_set(msr_all_available);
+
+#ifdef CONFIG_PPC_FPU
+	if (usermsr & MSR_FP)
+		__giveup_fpu(tsk);
+#endif
+#ifdef CONFIG_ALTIVEC
+	if (usermsr & MSR_VEC)
+		__giveup_altivec(tsk);
+#endif
+#ifdef CONFIG_VSX
+	if (usermsr & MSR_VSX)
+		__giveup_vsx(tsk);
+#endif
+#ifdef CONFIG_SPE
+	if (usermsr & MSR_SPE)
+		__giveup_spe(tsk);
+#endif
+
+	msr_check_and_clear(msr_all_available);
+}
+
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 void do_send_trap(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code, int signal_code, int breakpt)
@@ -839,21 +897,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	__switch_to_tm(prev);
 
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_FP))
-		giveup_fpu(prev);
-#ifdef CONFIG_ALTIVEC
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VEC))
-		giveup_altivec(prev);
-#endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_VSX
-	if (prev->thread.regs && (prev->thread.regs->msr & MSR_VSX))
-		/* VMX and FPU registers are already save here */
-		__giveup_vsx(prev);
-#endif /* CONFIG_VSX */
-#ifdef CONFIG_SPE
-	if ((prev->thread.regs && (prev->thread.regs->msr & MSR_SPE)))
-		giveup_spe(prev);
-#endif /* CONFIG_SPE */
+	/* Save FPU, Altivec, VSX and SPE state */
+	giveup_all(prev);
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	switch_booke_debug_regs(&new->thread.debug);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 49f5dad..a78e0e6 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1490,21 +1490,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		goto out;
 	/* interrupts now hard-disabled */
 
-	/* Save FPU state in thread_struct */
-	if (current->thread.regs->msr & MSR_FP)
-		giveup_fpu(current);
-
-#ifdef CONFIG_ALTIVEC
-	/* Save Altivec state in thread_struct */
-	if (current->thread.regs->msr & MSR_VEC)
-		giveup_altivec(current);
-#endif
-
-#ifdef CONFIG_VSX
-	/* Save VSX state in thread_struct */
-	if (current->thread.regs->msr & MSR_VSX)
-		__giveup_vsx(current);
-#endif
+	/* Save FPU, Altivec and VSX state */
+	giveup_all(current);
 
 	/* Preload FPU if it's enabled */
 	if (kvmppc_get_msr(vcpu) & MSR_FP)
-- 
2.5.0

Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 910391A0CB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:06:00 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/19] powerpc: create flush_all_to_thread()
Date: Thu, 29 Oct 2015 11:44:09 +1100
Message-Id: <1446079451-8774-18-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a single function that flushes everything (FP, VMX, VSX, SPE).
Doing this all at once means we only do one MSR write.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h |  1 +
 arch/powerpc/kernel/process.c        | 22 ++++++++++++++++++----
 arch/powerpc/kernel/swsusp.c         |  4 +---
 arch/powerpc/kvm/book3s_hv.c         |  5 ++---
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 8f85678..81d46a4 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -27,6 +27,7 @@ extern void giveup_vsx(struct task_struct *);
 extern void enable_kernel_spe(void);
 extern void load_up_spe(struct task_struct *);
 extern void giveup_all(struct task_struct *);
+extern void flush_all_to_thread(struct task_struct *);
 extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 
 #ifdef CONFIG_PPC_FPU
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a1540ee..e66d625 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -366,6 +366,23 @@ void giveup_all(struct task_struct *tsk)
 	msr_check_and_clear(msr_all_available);
 }
 
+void flush_all_to_thread(struct task_struct *tsk)
+{
+	if (tsk->thread.regs) {
+		preempt_disable();
+		BUG_ON(tsk != current);
+		giveup_all(tsk);
+
+#ifdef CONFIG_SPE
+		if (tsk->thread.regs->msr & MSR_SPE)
+			tsk->thread.spefscr = mfspr(SPRN_SPEFSCR);
+#endif
+
+		preempt_enable();
+	}
+}
+EXPORT_SYMBOL(flush_all_to_thread);
+
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 void do_send_trap(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code, int signal_code, int breakpt)
@@ -1136,10 +1153,7 @@ release_thread(struct task_struct *t)
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	flush_fp_to_thread(src);
-	flush_altivec_to_thread(src);
-	flush_vsx_to_thread(src);
-	flush_spe_to_thread(src);
+	flush_all_to_thread(src);
 	/*
 	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
 	 * flush but it removes the checkpointed state from the current CPU and
diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index eae33e1..6669b17 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -20,9 +20,7 @@ void save_processor_state(void)
 	 * flush out all the special registers so we don't need
 	 * to save them in the snapshot
 	 */
-	flush_fp_to_thread(current);
-	flush_altivec_to_thread(current);
-	flush_spe_to_thread(current);
+	flush_all_to_thread(current);
 
 #ifdef CONFIG_PPC64
 	hard_irq_disable();
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 9c26c5a..c165f4a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2700,9 +2700,8 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			goto out;
 	}
 
-	flush_fp_to_thread(current);
-	flush_altivec_to_thread(current);
-	flush_vsx_to_thread(current);
+	flush_all_to_thread(current);
+
 	vcpu->arch.wqp = &vcpu->arch.vcore->wq;
 	vcpu->arch.pgdir = current->mm->pgd;
 	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
-- 
2.5.0

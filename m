Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A4E31A029A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:46 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/19] powerpc: create flush_all_to_thread()
Date: Wed, 28 Oct 2015 11:51:05 +1100
Message-Id: <1445993467-667-17-git-send-email-anton@samba.org>
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

Create a single function that flushes everything (FP, VMX, VSX, SPE).
Doing this all at once means we only do one MSR write.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h |  1 +
 arch/powerpc/kernel/process.c        | 22 ++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c         |  5 ++---
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 0b4a339..08e2d65 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -28,6 +28,7 @@ extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 extern void giveup_all(struct task_struct *);
+extern void flush_all_to_thread(struct task_struct *);
 extern void switch_booke_debug_regs(struct debug_reg *new_debug);
 
 #ifdef CONFIG_PPC_FPU
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5ca416c..875ab50 100644
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

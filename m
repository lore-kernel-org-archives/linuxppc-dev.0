Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 37434B7571
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:57 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 15/16] KVM: PPC: booke: standard PPC floating point support
Message-ID: <20111221013445.GO8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e500mc has a normal PPC FPU, rather than SPE which is found
on e500v1/v2.

Based on code from Liu Yu <yu.liu@freescale.com>.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/system.h |    1 +
 arch/powerpc/kvm/booke.c          |   44 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/booke.h          |   30 +++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index e30a13d..0561356 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -140,6 +140,7 @@ extern void via_cuda_init(void);
 extern void read_rtc_time(void);
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
+extern void load_up_fpu(void);
 extern void disable_kernel_fp(void);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cf63b93..4bf43f9 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -460,6 +460,11 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
+#ifdef CONFIG_PPC_FPU
+	unsigned int fpscr;
+	int fpexc_mode;
+	u64 fpr[32];
+#endif
 
 	if (!vcpu->arch.sane) {
 		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -482,7 +487,46 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	}
 
 	kvm_guest_enter();
+
+#ifdef CONFIG_PPC_FPU
+	/* Save userspace FPU state in stack */
+	enable_kernel_fp();
+	memcpy(fpr, current->thread.fpr, sizeof(current->thread.fpr));
+	fpscr = current->thread.fpscr.val;
+	fpexc_mode = current->thread.fpexc_mode;
+
+	/* Restore guest FPU state to thread */
+	memcpy(current->thread.fpr, vcpu->arch.fpr, sizeof(vcpu->arch.fpr));
+	current->thread.fpscr.val = vcpu->arch.fpscr;
+
+	/*
+	 * Since we can't trap on MSR_FP in GS-mode, we consider the guest
+	 * as always using the FPU.  Kernel usage of FP (via
+	 * enable_kernel_fp()) in this thread must not occur while
+	 * vcpu->fpu_active is set.
+	 */
+	vcpu->fpu_active = 1;
+
+	kvmppc_load_guest_fp(vcpu);
+#endif
+
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
+
+#ifdef CONFIG_PPC_FPU
+	kvmppc_save_guest_fp(vcpu);
+
+	vcpu->fpu_active = 0;
+
+	/* Save guest FPU state from thread */
+	memcpy(vcpu->arch.fpr, current->thread.fpr, sizeof(vcpu->arch.fpr));
+	vcpu->arch.fpscr = current->thread.fpscr.val;
+
+	/* Restore userspace FPU state from stack */
+	memcpy(current->thread.fpr, fpr, sizeof(current->thread.fpr));
+	current->thread.fpscr.val = fpscr;
+	current->thread.fpexc_mode = fpexc_mode;
+#endif
+
 	kvm_guest_exit();
 
 out:
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index d53bcf2..3bf5eda 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -96,4 +96,34 @@ enum int_class {
 
 void kvmppc_set_pending_interrupt(struct kvm_vcpu *vcpu, enum int_class type);
 
+/*
+ * Load up guest vcpu FP state if it's needed.
+ * It also set the MSR_FP in thread so that host know
+ * we're holding FPU, and then host can help to save
+ * guest vcpu FP state if other threads require to use FPU.
+ * This simulates an FP unavailable fault.
+ *
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_PPC_FPU
+	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
+		load_up_fpu();
+		current->thread.regs->msr |= MSR_FP;
+	}
+#endif
+}
+
+/*
+ * Save guest vcpu FP state into thread.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_save_guest_fp(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_PPC_FPU
+	if (vcpu->fpu_active && (current->thread.regs->msr & MSR_FP))
+		giveup_fpu(current);
+#endif
+}
 #endif /* __KVM_BOOKE_H__ */
-- 
1.7.7.rc3.4.g8d714

Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4F4A2C03F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:43:42 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Date: Wed, 3 Jul 2013 15:42:37 +0300
Message-ID: <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add KVM Book3E AltiVec support. KVM Book3E FPU support gracefully reuse host
infrastructure so follow the same approach for AltiVec.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |   72 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 3cae2e3..c3c3af6 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -98,6 +98,19 @@ static inline bool kvmppc_supports_spe(void)
 	return false;
 }
 
+/*
+ * Always returns true is AltiVec unit is present, see
+ * kvmppc_core_check_processor_compat().
+ */
+static inline bool kvmppc_supports_altivec(void)
+{
+#ifdef CONFIG_ALTIVEC
+		if (cpu_has_feature(CPU_FTR_ALTIVEC))
+			return true;
+#endif
+	return false;
+}
+
 #ifdef CONFIG_SPE
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 {
@@ -151,6 +164,21 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu *vcpu)
 }
 
 /*
+ * Simulate AltiVec unavailable fault to load guest state
+ * from thread to AltiVec unit.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
+{
+	if (kvmppc_supports_altivec()) {
+		if (!(current->thread.regs->msr & MSR_VEC)) {
+			load_up_altivec(NULL);
+			current->thread.regs->msr |= MSR_VEC;
+		}
+	}
+}
+
+/*
  * Helper function for "full" MSR writes.  No need to call this if only
  * EE/CE/ME/DE/RI are changing.
  */
@@ -678,6 +706,12 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	u64 fpr[32];
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	vector128 vr[32];
+	vector128 vscr;
+	int used_vr = 0;
+#endif
+
 	if (!vcpu->arch.sane) {
 		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		return -EINVAL;
@@ -716,6 +750,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_load_guest_fp(vcpu);
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		/* Save userspace VEC state in stack */
+		enable_kernel_altivec();
+		memcpy(vr, current->thread.vr, sizeof(current->thread.vr));
+		vscr = current->thread.vscr;
+		used_vr = current->thread.used_vr;
+
+		/* Restore guest VEC state to thread */
+		memcpy(current->thread.vr, vcpu->arch.vr, sizeof(vcpu->arch.vr));
+		current->thread.vscr = vcpu->arch.vscr;
+
+		kvmppc_load_guest_altivec(vcpu);
+	}
+#endif
+
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
 
 	/* No need for kvm_guest_exit. It's done in handle_exit.
@@ -736,6 +786,23 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	current->thread.fpexc_mode = fpexc_mode;
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		/* Save AltiVec state to thread */
+		if (current->thread.regs->msr & MSR_VEC)
+			giveup_altivec(current);
+
+		/* Save guest state */
+		memcpy(vcpu->arch.vr, current->thread.vr, sizeof(vcpu->arch.vr));
+		vcpu->arch.vscr = current->thread.vscr;
+
+		/* Restore userspace state */
+		memcpy(current->thread.vr, vr, sizeof(current->thread.vr));
+		current->thread.vscr = vscr;
+		current->thread.used_vr = used_vr;
+	}
+#endif
+
 out:
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	return ret;
@@ -961,7 +1028,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) {
 			bool enabled = false;
 
 #ifndef CONFIG_KVM_BOOKE_HV
@@ -987,7 +1054,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	}
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) {
 			kvmppc_booke_queue_irqprio(vcpu,
 				BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
 			r = RESUME_GUEST;
@@ -1205,6 +1272,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		} else {
 			kvmppc_lazy_ee_enable();
 			kvmppc_load_guest_fp(vcpu);
+			kvmppc_load_guest_altivec(vcpu);
 		}
 	}
 
-- 
1.7.3.4

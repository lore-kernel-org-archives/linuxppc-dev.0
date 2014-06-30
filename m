Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 903C91A005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:18 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 4/6 v2] KVM: PPC: Book3E: Add AltiVec support
Date: Mon, 30 Jun 2014 18:34:55 +0300
Message-ID: <1404142497-6430-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
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
v2:
 - integrate Paul's FP/VMX/VSX changes

 arch/powerpc/kvm/booke.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4cc9b26..4ba75f6 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -100,6 +100,19 @@ static inline bool kvmppc_supports_spe(void)
 	return false;
 }
 
+/*
+ * Always returns true if AltiVec unit is present,
+ * see kvmppc_core_check_processor_compat().
+ */
+static inline bool kvmppc_supports_altivec(void)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		return true;
+#endif
+	return false;
+}
+
 #ifdef CONFIG_SPE
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 {
@@ -178,6 +191,40 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu *vcpu)
 #endif
 }
 
+/*
+ * Simulate AltiVec unavailable fault to load guest state
+ * from thread to AltiVec unit.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_ALTIVEC
+	if (kvmppc_supports_altivec()) {
+		if (!(current->thread.regs->msr & MSR_VEC)) {
+			enable_kernel_altivec();
+			load_vr_state(&vcpu->arch.vr);
+			current->thread.vr_save_area = &vcpu->arch.vr;
+			current->thread.regs->msr |= MSR_VEC;
+		}
+	}
+#endif
+}
+
+/*
+ * Save guest vcpu AltiVec state into thread.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_save_guest_altivec(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_ALTIVEC
+	if (kvmppc_supports_altivec()) {
+		if (current->thread.regs->msr & MSR_VEC)
+			giveup_altivec(current);
+		current->thread.vr_save_area = NULL;
+	}
+#endif
+}
+
 static void kvmppc_vcpu_sync_debug(struct kvm_vcpu *vcpu)
 {
 	/* Synchronize guest's desire to get debug interrupts into shadow MSR */
@@ -749,6 +796,17 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_load_guest_fp(vcpu);
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	/* Save userspace AltiVec state in stack */
+	if (kvmppc_supports_altivec())
+		enable_kernel_altivec();
+	/*
+	 * Since we can't trap on MSR_VEC in GS-mode, we consider the guest
+	 * as always using the AltiVec.
+	 */
+	kvmppc_load_guest_altivec(vcpu);
+#endif
+
 	/* Switch to guest debug context */
 	debug = vcpu->arch.shadow_dbg_reg;
 	switch_booke_debug_regs(&debug);
@@ -771,6 +829,10 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_save_guest_fp(vcpu);
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	kvmppc_save_guest_altivec(vcpu);
+#endif
+
 out:
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	return ret;
@@ -1014,7 +1076,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_spe() || kvmppc_supports_altivec()) {
 			bool enabled = false;
 
 #if !defined(CONFIG_KVM_BOOKE_HV) && defined(CONFIG_SPE)
@@ -1040,7 +1102,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	}
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_spe() || kvmppc_supports_altivec()) {
 			kvmppc_booke_queue_irqprio(vcpu,
 				BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
 			r = RESUME_GUEST;
@@ -1249,6 +1311,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			/* interrupts now hard-disabled */
 			kvmppc_fix_ee_before_entry();
 			kvmppc_load_guest_fp(vcpu);
+			kvmppc_load_guest_altivec(vcpu);
 		}
 	}
 
-- 
1.7.11.7

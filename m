Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B4F72C0178
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 06:54:52 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Date: Mon, 3 Jun 2013 23:54:26 +0300
Message-ID: <1370292868-2697-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
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

KVM Book3E FPU support gracefully reuse host infrastructure so we do the
same for AltiVec. To keep AltiVec lazy call kvmppc_load_guest_altivec()
just when returning to guest instead of each sched in.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c  |   74 +++++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/e500mc.c |    8 +++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index c08b04b..01eb635 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -134,6 +134,23 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu *vcpu)
 }
 
 /*
+ * Simulate AltiVec unavailable fault to load guest state
+ * from thread to AltiVec unit.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		if (!(current->thread.regs->msr & MSR_VEC)) {
+			load_up_altivec(NULL);
+			current->thread.regs->msr |= MSR_VEC;
+		}
+	}
+#endif
+}
+
+/*
  * Helper function for "full" MSR writes.  No need to call this if only
  * EE/CE/ME/DE/RI are changing.
  */
@@ -661,6 +678,12 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
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
@@ -699,6 +722,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
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
@@ -719,6 +758,23 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
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
@@ -822,6 +878,19 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
 	}
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
 static inline bool kvmppc_supports_spe(void)
 {
 #ifdef CONFIG_SPE
@@ -947,7 +1016,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		 */
 		bool handled = false;
 
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) {
 #ifdef CONFIG_SPE
 			if (cpu_has_feature(CPU_FTR_SPE))
 				if (vcpu->arch.shared->msr & MSR_SPE) {
@@ -976,7 +1045,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		 * The interrupt is shared, KVM support for the featured unit
 		 * is detected at run-time.
 		 */
-		if (kvmppc_supports_spe()) {
+		if (kvmppc_supports_altivec() || kvmppc_supports_spe()) {
 			kvmppc_booke_queue_irqprio(vcpu,
 				BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
 			r = RESUME_GUEST;
@@ -1188,6 +1257,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
 		} else {
 			kvmppc_lazy_ee_enable();
+			kvmppc_load_guest_altivec(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index c3bdc0a..9d7f38e 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -172,8 +172,16 @@ int kvmppc_core_check_processor_compat(void)
 		r = 0;
 	else if (strcmp(cur_cpu_spec->cpu_name, "e5500") == 0)
 		r = 0;
+#ifdef CONFIG_ALTIVEC
+	/*
+	 * Since guests have the priviledge to enable AltiVec, we need AltiVec
+	 * support in the host to save/restore their context.
+	 * Don't use CPU_FTR_ALTIVEC to identify cores with AltiVec unit
+	 * because it's cleared in the absence of CONFIG_ALTIVEC!
+	 */
 	else if (strcmp(cur_cpu_spec->cpu_name, "e6500") == 0)
 		r = 0;
+#endif
 	else
 		r = -ENOTSUPP;
 
-- 
1.7.4.1

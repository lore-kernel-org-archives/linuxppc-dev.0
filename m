Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:22:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/6] KVM: PPC: Book3S: Load/save FP/VMX/VSX state directly
 to/from vcpu struct
Message-ID: <20130910102221.GF28145@iris.ozlabs.ibm.com>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130910102000.GA28145@iris.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the vcpu floating-point and vector state stored in
the same type of struct as the main kernel uses, we can load that
state directly from the vcpu struct instead of having extra copies
to/from the thread_struct.  Similarly, when the guest state needs to
be saved, we can have it saved it directly to the vcpu struct by
setting the current->thread.fp_save_area and current->thread.vr_save_area
pointers.  That also means that we don't need to back up and restore
userspace's FP/vector state.  This all makes the code simpler and
faster.

Note that it's not necessary to save or modify current->thread.fpexc_mode,
since nothing in KVM uses or is affected by its value.  Nor is it
necessary to touch used_vr or used_vsr.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_pr.c | 72 ++++++++++----------------------------------
 arch/powerpc/kvm/booke.c     | 16 ----------
 arch/powerpc/kvm/booke.h     |  4 ++-
 3 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 90be91c..5eae919 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -462,16 +462,16 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 		 * both the traditional FP registers and the added VSX
 		 * registers into thread.fp_state.fpr[].
 		 */
-		if (current->thread.regs->msr & MSR_FP)
+		if (t->regs->msr & MSR_FP)
 			giveup_fpu(current);
-		vcpu->arch.fp = t->fp_state;
+		t->fp_save_area = NULL;
 	}
 
 #ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		if (current->thread.regs->msr & MSR_VEC)
 			giveup_altivec(current);
-		vcpu->arch.vr = t->vr_state;
+		t->vr_save_area = NULL;
 	}
 #endif
 
@@ -556,22 +556,20 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 #endif
 
 	if (msr & MSR_FP) {
-		t->fp_state = vcpu->arch.fp;
-		t->fpexc_mode = 0;
 		enable_kernel_fp();
-		load_fp_state(&t->fp_state);
+		load_fp_state(&vcpu->arch.fp);
+		t->fp_save_area = &vcpu->arch.fp;
 	}
 
 	if (msr & MSR_VEC) {
 #ifdef CONFIG_ALTIVEC
-		t->vr_state = vcpu->arch.vr;
-		t->vrsave = -1;
 		enable_kernel_altivec();
-		load_vr_state(&t->vr_state);
+		load_vr_state(&vcpu->arch.vr);
+		t->vr_save_area = &vcpu->arch.vr;
 #endif
 	}
 
-	current->thread.regs->msr |= msr;
+	t->regs->msr |= msr;
 	vcpu->arch.guest_owned_ext |= msr;
 	kvmppc_recalc_shadow_msr(vcpu);
 
@@ -592,11 +590,11 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 
 	if (lost_ext & MSR_FP) {
 		enable_kernel_fp();
-		load_fp_state(&current->thread.fp_state);
+		load_fp_state(&vcpu->arch.fp);
 	}
 	if (lost_ext & MSR_VEC) {
 		enable_kernel_altivec();
-		load_vr_state(&current->thread.vr_state);
+		load_vr_state(&vcpu->arch.vr);
 	}
 	current->thread.regs->msr |= lost_ext;
 }
@@ -1067,17 +1065,9 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
-	struct thread_fp_state fp;
-	int fpexc_mode;
 #ifdef CONFIG_ALTIVEC
-	struct thread_vr_state vr;
 	unsigned long uninitialized_var(vrsave);
-	int used_vr;
 #endif
-#ifdef CONFIG_VSX
-	int used_vsr;
-#endif
-	ulong ext_msr;
 
 	/* Check if we can run the vcpu at all */
 	if (!vcpu->arch.sane) {
@@ -1099,33 +1089,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	/* Save FPU state in stack */
+	/* Save FPU state in thread_struct */
 	if (current->thread.regs->msr & MSR_FP)
 		giveup_fpu(current);
-	fp = current->thread.fp_state;
-	fpexc_mode = current->thread.fpexc_mode;
 
 #ifdef CONFIG_ALTIVEC
-	/* Save Altivec state in stack */
-	used_vr = current->thread.used_vr;
-	if (used_vr) {
-		if (current->thread.regs->msr & MSR_VEC)
-			giveup_altivec(current);
-		vr = current->thread.vr_state;
-		vrsave = current->thread.vrsave;
-	}
+	/* Save Altivec state in thread_struct */
+	if (current->thread.regs->msr & MSR_VEC)
+		giveup_altivec(current);
 #endif
 
 #ifdef CONFIG_VSX
-	/* Save VSX state in stack */
-	used_vsr = current->thread.used_vsr;
-	if (used_vsr && (current->thread.regs->msr & MSR_VSX))
+	/* Save VSX state in thread_struct */
+	if (current->thread.regs->msr & MSR_VSX)
 		__giveup_vsx(current);
 #endif
 
-	/* Remember the MSR with disabled extensions */
-	ext_msr = current->thread.regs->msr;
-
 	/* Preload FPU if it's enabled */
 	if (vcpu->arch.shared->msr & MSR_FP)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
@@ -1140,25 +1119,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	/* Make sure we save the guest FPU/Altivec/VSX state */
 	kvmppc_giveup_ext(vcpu, MSR_FP | MSR_VEC | MSR_VSX);
 
-	current->thread.regs->msr = ext_msr;
-
-	/* Restore FPU/VSX state from stack */
-	current->thread.fp_state = fp;
-	current->thread.fpexc_mode = fpexc_mode;
-
-#ifdef CONFIG_ALTIVEC
-	/* Restore Altivec state from stack */
-	if (used_vr && current->thread.used_vr) {
-		current->thread.vr_state = vr;
-		current->thread.vrsave = vrsave;
-	}
-	current->thread.used_vr = used_vr;
-#endif
-
-#ifdef CONFIG_VSX
-	current->thread.used_vsr = used_vsr;
-#endif
-
 out:
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	return ret;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4998a65..34ae14e 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -655,10 +655,6 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
 int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret, s;
-#ifdef CONFIG_PPC_FPU
-	struct thread_fp_state fp;
-	int fpexc_mode;
-#endif
 
 	if (!vcpu->arch.sane) {
 		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -676,11 +672,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 #ifdef CONFIG_PPC_FPU
 	/* Save userspace FPU state in stack */
 	enable_kernel_fp();
-	fp = current->thread.fp_state;
-	fpexc_mode = current->thread.fpexc_mode;
-
-	/* Restore guest FPU state to thread */
-	current->thread.fp_state = vcpu->arch.fp;
 
 	/*
 	 * Since we can't trap on MSR_FP in GS-mode, we consider the guest
@@ -704,13 +695,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_save_guest_fp(vcpu);
 
 	vcpu->fpu_active = 0;
-
-	/* Save guest FPU state from thread */
-	vcpu->arch.fp = current->thread.fp_state;
-
-	/* Restore userspace FPU state from stack */
-	current->thread.fp_state = fp;
-	current->thread.fpexc_mode = fpexc_mode;
 #endif
 
 out:
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 7ffb699..4aab5cf 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -113,7 +113,8 @@ static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_PPC_FPU
 	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
 		enable_kernel_fp();
-		load_fp_state(&current->thread.fp_state);
+		load_fp_state(&vcpu->arch.fp);
+		current->thread.fp_save_area = &vcpu->arch.fp;
 		current->thread.regs->msr |= MSR_FP;
 	}
 #endif
@@ -128,6 +129,7 @@ static inline void kvmppc_save_guest_fp(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_PPC_FPU
 	if (vcpu->fpu_active && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
+	current->thread.fp_save_area = NULL;
 #endif
 }
 #endif /* __KVM_BOOKE_H__ */
-- 
1.8.4.rc3

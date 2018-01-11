Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBs44tHzF0Xq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:53 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id f14so1845451pga.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:53 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 17/26] KVM: PPC: Book3S PR: add math support for PR KVM HTM
Date: Thu, 11 Jan 2018 18:11:30 +0800
Message-Id: <1515665499-31710-18-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

The math registers will be saved into vcpu->arch.fp/vr and corresponding
vcpu->arch.fp_tm/vr_tm area.

We flush or giveup the math regs into vcpu->arch.fp/vr before saving
transaction. After transaction is restored, the math regs will be loaded
back into regs.

If there is a FP/VEC/VSX unavailable exception during transaction active
state, the math checkpoint content might be incorrect and we need to do
treclaim./load the correct checkpoint val/trechkpt. sequence to retry the
transaction.

If transaction is active, and the qemu process is switching out of CPU,
we need to keep the "guest_owned_ext" bits unchanged after qemu process
is switched back. The reason is that if we allow guest_owned_ext change
freely during a transaction, there will lack information to handle
FP/VEC/VSX unavailable exception during transaction active state.

Detail is as follows:
Assume we allow math bits to be given up freely during transaction:
- If it is the first FP unavailable exception after tbegin., vcpu->arch.fp/
vr need to be loaded for trechkpt.
- If it is the 2nd or subsequent FP unavailable exception after tbegin.,
vcpu->arch.fp_tm/vr_tm need to be loaded for trechkpt.
It will bring much additional complexity to cover both cases.

That is why we always save guest_owned_ext into vcpu->arch.save_msr_tm at
kvmppc_save_tm_pr(), then check those bits in vcpu->arch.save_msr_tm at
kvmppc_restore_tm_pr() to determine what math contents will be loaded.
With this, we will always load vcpu->arch.fp/vr in math unavailable
exception during active transaction.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h |   4 +-
 arch/powerpc/kvm/book3s_pr.c        | 114 +++++++++++++++++++++++++++++-------
 2 files changed, 95 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index eb3b821..1124c62 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -627,7 +627,9 @@ struct kvm_vcpu_arch {
 	struct thread_vr_state vr_tm;
 	u32 vrsave_tm; /* also USPRG0 */
 
-	u64 save_msr_tm; /* TS bits: whether TM restore is required */
+	u64 save_msr_tm; /* TS bits: whether TM restore is required
+			  * FP/VEC/VSX bits: saved guest_owned_ext
+			  */
 #endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index eef0928..c35bd02 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -55,6 +55,7 @@
 
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr);
+static int kvmppc_load_ext(struct kvm_vcpu *vcpu, ulong msr);
 static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
 /* Some compatibility defines */
@@ -280,6 +281,33 @@ void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	/* when we are in transaction active state and switch out of CPU,
+	 * we need to be careful to not "change" guest_owned_ext bits after
+	 * kvmppc_save_tm_pr()/kvmppc_restore_tm_pr() pair. The reason is
+	 * that we need to distinguish following 2 FP/VEC/VSX unavailable
+	 * exception cases in TM active state:
+	 * 1) tbegin. is executed with guest_owned_ext FP/VEC/VSX off. Then
+	 * there comes a FP/VEC/VSX unavailable exception during transaction.
+	 * In this case, the vcpu->arch.fp/vr contents need to be loaded as
+	 * checkpoint contents.
+	 * 2) tbegin. is executed with guest_owned_ext FP/VEC/VSX on. Then
+	 * there is task switch during suspended state. If we giveup ext and
+	 * update guest_owned_ext as no FP/VEC/VSX bits during context switch,
+	 * we need to load vcpu->arch.fp_tm/vr_tm contents as checkpoint
+	 * content.
+	 *
+	 * As a result, we don't change guest_owned_ext bits during
+	 * kvmppc_save/restore_tm_pr() pair. So that we can only use
+	 * vcpu->arch.fp/vr contents as checkpoint contents.
+	 * And we need to "save" the guest_owned_ext bits here who indicates
+	 * which math bits need to be "restored" in kvmppc_restore_tm_pr().
+	 */
+	vcpu->arch.save_msr_tm &= ~(MSR_FP | MSR_VEC | MSR_VSX);
+	vcpu->arch.save_msr_tm |= (vcpu->arch.guest_owned_ext &
+			(MSR_FP | MSR_VEC | MSR_VSX));
+
+	kvmppc_giveup_ext(vcpu, MSR_VSX);
+
 	preempt_disable();
 	_kvmppc_save_tm_pr(vcpu, mfmsr());
 	preempt_enable();
@@ -295,6 +323,16 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	_kvmppc_restore_tm_pr(vcpu, vcpu->arch.save_msr_tm);
 	preempt_enable();
+
+	if (vcpu->arch.save_msr_tm & MSR_VSX)
+		kvmppc_load_ext(vcpu, MSR_FP | MSR_VEC | MSR_VSX);
+	else {
+		if (vcpu->arch.save_msr_tm & MSR_VEC)
+			kvmppc_load_ext(vcpu, MSR_VEC);
+
+		if (vcpu->arch.save_msr_tm & MSR_FP)
+			kvmppc_load_ext(vcpu, MSR_FP);
+	}
 }
 #endif
 
@@ -788,12 +826,41 @@ static void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac)
 #endif
 }
 
+static int kvmppc_load_ext(struct kvm_vcpu *vcpu, ulong msr)
+{
+	struct thread_struct *t = &current->thread;
+
+	if (msr & MSR_FP) {
+		preempt_disable();
+		enable_kernel_fp();
+		load_fp_state(&vcpu->arch.fp);
+		disable_kernel_fp();
+		t->fp_save_area = &vcpu->arch.fp;
+		preempt_enable();
+	}
+
+	if (msr & MSR_VEC) {
+#ifdef CONFIG_ALTIVEC
+		preempt_disable();
+		enable_kernel_altivec();
+		load_vr_state(&vcpu->arch.vr);
+		disable_kernel_altivec();
+		t->vr_save_area = &vcpu->arch.vr;
+		preempt_enable();
+#endif
+	}
+
+	t->regs->msr |= msr;
+	vcpu->arch.guest_owned_ext |= msr;
+	kvmppc_recalc_shadow_msr(vcpu);
+
+	return RESUME_GUEST;
+}
+
 /* Handle external providers (FPU, Altivec, VSX) */
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 			     ulong msr)
 {
-	struct thread_struct *t = &current->thread;
-
 	/* When we have paired singles, we emulate in software */
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)
 		return RESUME_GUEST;
@@ -829,31 +896,34 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 	printk(KERN_INFO "Loading up ext 0x%lx\n", msr);
 #endif
 
-	if (msr & MSR_FP) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* if TM is active, the checkpointed math content
+	 * might be invalid. We need to reclaim current
+	 * transaction, load the correct math, and perform
+	 * rechkpoint.
+	 */
+	if (MSR_TM_ACTIVE(mfmsr())) {
 		preempt_disable();
-		enable_kernel_fp();
-		load_fp_state(&vcpu->arch.fp);
-		disable_kernel_fp();
-		t->fp_save_area = &vcpu->arch.fp;
-		preempt_enable();
-	}
+		kvmppc_save_tm_pr(vcpu);
+		/* need update the chkpt math reg saving content,
+		 * so that we can checkpoint with desired fp value.
+		 */
+		if (msr & MSR_FP)
+			memcpy(&vcpu->arch.fp_tm, &vcpu->arch.fp,
+					sizeof(struct thread_fp_state));
+
+		if (msr & MSR_VEC) {
+			memcpy(&vcpu->arch.vr_tm, &vcpu->arch.vr,
+					sizeof(struct thread_vr_state));
+			vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
+		}
 
-	if (msr & MSR_VEC) {
-#ifdef CONFIG_ALTIVEC
-		preempt_disable();
-		enable_kernel_altivec();
-		load_vr_state(&vcpu->arch.vr);
-		disable_kernel_altivec();
-		t->vr_save_area = &vcpu->arch.vr;
+		kvmppc_restore_tm_pr(vcpu);
 		preempt_enable();
-#endif
 	}
+#endif
 
-	t->regs->msr |= msr;
-	vcpu->arch.guest_owned_ext |= msr;
-	kvmppc_recalc_shadow_msr(vcpu);
-
-	return RESUME_GUEST;
+	return kvmppc_load_ext(vcpu, msr);
 }
 
 /*
-- 
1.8.3.1

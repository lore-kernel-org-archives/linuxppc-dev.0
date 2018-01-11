Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMBn4CjVzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:49 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i66so1305815pfd.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:49 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 16/26] KVM: PPC: Book3S PR: add transaction memory
 save/restore skeleton for PR KVM
Date: Thu, 11 Jan 2018 18:11:29 +0800
Message-Id: <1515665499-31710-17-git-send-email-wei.guo.simon@gmail.com>
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

The transaction memory checkpoint area save/restore behavior is
triggered when VCPU qemu process is switching out/into CPU. ie.
at kvmppc_core_vcpu_put_pr() and kvmppc_core_vcpu_load_pr().

MSR TM active state is determined by TS bits:
    active: 10(transactional) or 01 (suspended)
    inactive: 00 (non-transactional)
We don't "fake" TM functionality for guest. We "sync" guest virtual
MSR TM active state(10 or 01) with shadow MSR. That is to say,
we don't emulate a transactional guest with a TM inactive MSR.

TM SPR support(TFIAR/TFAR/TEXASR) has already been supported by
commit 9916d57e64a4 ("KVM: PPC: Book3S PR: Expose TM registers").
Math register support (FPR/VMX/VSX) will be done at subsequent
patch.

- TM save:
When kvmppc_save_tm_pr() is invoked, whether TM context need to
be saved can be determined by current host MSR state:
	* TM active - save TM context
	* TM inactive - no need to do so and only save TM SPRs.

- TM restore:
However when kvmppc_restore_tm_pr() is invoked, there is an
issue to determine whether TM restore should be performed.
The TM active host MSR val saved in kernel stack is not loaded yet.
We don't know whether there is a transaction to be restored from
current host MSR TM status at kvmppc_restore_tm_pr(). To solve this
issue, we save current MSR into vcpu->arch.save_msr_tm at
kvmppc_save_tm_pr(), and kvmppc_restore_tm_pr() check TS bits of
vcpu->arch.save_msr_tm to decide whether to do TM restore.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Suggested-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |  6 +++++
 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s_pr.c          | 41 +++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 9a66700..d8dbfa5 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -253,6 +253,12 @@ extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 				 struct kvm_vcpu *vcpu);
 extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
+void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
+#endif
+
 extern int kvm_irq_bypass;
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3aa5b57..eb3b821 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -627,6 +627,7 @@ struct kvm_vcpu_arch {
 	struct thread_vr_state vr_tm;
 	u32 vrsave_tm; /* also USPRG0 */
 
+	u64 save_msr_tm; /* TS bits: whether TM restore is required */
 #endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 5224b3c..eef0928 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <asm/asm-prototypes.h>
+#include <asm/tm.h>
 
 #include "book3s.h"
 
@@ -114,6 +115,9 @@ static void kvmppc_core_vcpu_load_pr(struct kvm_vcpu *vcpu, int cpu)
 
 	if (kvmppc_is_split_real(vcpu))
 		kvmppc_fixup_split_real(vcpu);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	kvmppc_restore_tm_pr(vcpu);
+#endif
 }
 
 static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
@@ -131,6 +135,10 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 	if (kvmppc_is_split_real(vcpu))
 		kvmppc_unfixup_split_real(vcpu);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	kvmppc_save_tm_pr(vcpu);
+#endif
+
 	kvmppc_giveup_ext(vcpu, MSR_FP | MSR_VEC | MSR_VSX);
 	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
 
@@ -255,6 +263,39 @@ static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
 	tm_disable();
 }
 
+void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * When kvmppc_save_tm_pr() is invoked, whether TM context need to
+	 * be saved can be determined by current MSR TS active state.
+	 *
+	 * We save current MSR's TM TS bits into vcpu->arch.save_msr_tm.
+	 * So that kvmppc_restore_tm_pr() can decide to do TM restore or
+	 * not based on that.
+	 */
+	vcpu->arch.save_msr_tm = mfmsr();
+
+	if (!(MSR_TM_ACTIVE(vcpu->arch.save_msr_tm))) {
+		kvmppc_save_tm_sprs(vcpu);
+		return;
+	}
+
+	preempt_disable();
+	_kvmppc_save_tm_pr(vcpu, mfmsr());
+	preempt_enable();
+}
+
+void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
+{
+	if (!MSR_TM_ACTIVE(vcpu->arch.save_msr_tm)) {
+		kvmppc_restore_tm_sprs(vcpu);
+		return;
+	}
+
+	preempt_disable();
+	_kvmppc_restore_tm_pr(vcpu, vcpu->arch.save_msr_tm);
+	preempt_enable();
+}
 #endif
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
1.8.3.1

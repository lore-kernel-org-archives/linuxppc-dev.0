Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRMf6QHHzF1XH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:18 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id z14so8264616pfe.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:18 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 15/30] KVM: PPC: Book3S PR: add transaction memory
 save/restore skeleton for PR KVM
Date: Wed, 28 Feb 2018 01:52:23 +0800
Message-Id: <1519753958-11756-5-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
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

Whether TM context need to be saved/restored can be determined
by kvmppc_get_msr() TM active state:
	* TM active - save/restore TM context
	* TM inactive - no need to do so and only save/restore
TM SPRs.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Suggested-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |  9 +++++++++
 arch/powerpc/include/asm/kvm_host.h   |  1 -
 arch/powerpc/kvm/book3s_pr.c          | 27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 9a66700..5911c3b 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -253,6 +253,15 @@ extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 				 struct kvm_vcpu *vcpu);
 extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu);
+void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu);
+#else
+static inline void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu) {}
+static inline void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu) {}
+#endif
+
 extern int kvm_irq_bypass;
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fef8133..89b3fed 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -626,7 +626,6 @@ struct kvm_vcpu_arch {
 
 	struct thread_vr_state vr_tm;
 	u32 vrsave_tm; /* also USPRG0 */
-
 #endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 91d0e59..ac9d58f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <asm/asm-prototypes.h>
+#include <asm/tm.h>
 
 #include "book3s.h"
 
@@ -115,6 +116,8 @@ static void kvmppc_core_vcpu_load_pr(struct kvm_vcpu *vcpu, int cpu)
 
 	if (kvmppc_is_split_real(vcpu))
 		kvmppc_fixup_split_real(vcpu);
+
+	kvmppc_restore_tm_pr(vcpu);
 }
 
 static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
@@ -134,6 +137,7 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 
 	kvmppc_giveup_ext(vcpu, MSR_FP | MSR_VEC | MSR_VSX);
 	kvmppc_giveup_fac(vcpu, FSCR_TAR_LG);
+	kvmppc_save_tm_pr(vcpu);
 
 	/* Enable AIL if supported */
 	if (cpu_has_feature(CPU_FTR_HVMODE) &&
@@ -306,6 +310,29 @@ static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
 	tm_disable();
 }
 
+void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
+{
+	if (!(MSR_TM_ACTIVE(kvmppc_get_msr(vcpu)))) {
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
+	if (!MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
+		kvmppc_restore_tm_sprs(vcpu);
+		return;
+	}
+
+	preempt_disable();
+	_kvmppc_restore_tm_pr(vcpu, kvmppc_get_msr(vcpu));
+	preempt_enable();
+}
 #endif
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
1.8.3.1

Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPkl2WM6zDrbm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:59 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id n10-v6so12519655plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:59 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 16/29] KVM: PPC: Book3S PR: add math support for PR KVM HTM
Date: Wed, 23 May 2018 15:01:59 +0800
Message-Id: <1527058932-7434-17-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
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
transaction. That will make our solution complicated. To solve this issue,
we always make the hardware guest MSR math bits (shadow_msr) consistent
with the MSR val which guest sees (kvmppc_get_msr()) when guest msr is
with tm enabled. Then all FP/VEC/VSX unavailable exception can be delivered
to guest and guest handles the exception by itself.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_pr.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 226bae7..4b81b3c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -308,6 +308,28 @@ static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
 	tm_disable();
 }
 
+/* loadup math bits which is enabled at kvmppc_get_msr() but not enabled at
+ * hardware.
+ */
+static void kvmppc_handle_lost_math_exts(struct kvm_vcpu *vcpu)
+{
+	ulong exit_nr;
+	ulong ext_diff = (kvmppc_get_msr(vcpu) & ~vcpu->arch.guest_owned_ext) &
+		(MSR_FP | MSR_VEC | MSR_VSX);
+
+	if (!ext_diff)
+		return;
+
+	if (ext_diff == MSR_FP)
+		exit_nr = BOOK3S_INTERRUPT_FP_UNAVAIL;
+	else if (ext_diff == MSR_VEC)
+		exit_nr = BOOK3S_INTERRUPT_ALTIVEC;
+	else
+		exit_nr = BOOK3S_INTERRUPT_VSX;
+
+	kvmppc_handle_ext(vcpu, exit_nr, ext_diff);
+}
+
 void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
 {
 	if (!(MSR_TM_ACTIVE(kvmppc_get_msr(vcpu)))) {
@@ -315,6 +337,8 @@ void kvmppc_save_tm_pr(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	kvmppc_giveup_ext(vcpu, MSR_VSX);
+
 	preempt_disable();
 	_kvmppc_save_tm_pr(vcpu, mfmsr());
 	preempt_enable();
@@ -324,12 +348,18 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)
 {
 	if (!MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
 		kvmppc_restore_tm_sprs(vcpu);
+		if (kvmppc_get_msr(vcpu) & MSR_TM)
+			kvmppc_handle_lost_math_exts(vcpu);
 		return;
 	}
 
 	preempt_disable();
 	_kvmppc_restore_tm_pr(vcpu, kvmppc_get_msr(vcpu));
 	preempt_enable();
+
+	if (kvmppc_get_msr(vcpu) & MSR_TM)
+		kvmppc_handle_lost_math_exts(vcpu);
+
 }
 #endif
 
@@ -468,6 +498,11 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 	/* Preload FPU if it's enabled */
 	if (kvmppc_get_msr(vcpu) & MSR_FP)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (kvmppc_get_msr(vcpu) & MSR_TM)
+		kvmppc_handle_lost_math_exts(vcpu);
+#endif
 }
 
 void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
-- 
1.8.3.1

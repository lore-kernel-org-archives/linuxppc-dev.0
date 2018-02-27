Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrQsc5ZJ7zDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 04:38:44 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g2so7781534pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:38:44 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 10/30] KVM: PPC: Book3S PR: Sync TM bits to shadow msr for
 problem state guest
Date: Wed, 28 Feb 2018 01:37:17 +0800
Message-Id: <1519753057-11059-11-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

MSR TS bits can be modified with non-privileged instruction like
tbegin./tend.  That means guest can change MSR value "silently" without
notifying host.

It is necessary to sync the TM bits to host so that host can calculate
shadow msr correctly.

note privilege guest will always fail transactions so we only take
care of problem state guest.

The logic is put into kvmppc_copy_from_svcpu() so that
kvmppc_handle_exit_pr() can use correct MSR TM bits even when preemption.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s_pr.c | 73 ++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 5c9e43f..4bf76c9 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -179,10 +179,36 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	svcpu->in_use = true;
 }
 
+static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
+{
+	ulong guest_msr = kvmppc_get_msr(vcpu);
+	ulong smsr = guest_msr;
+
+	/* Guest MSR values */
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE |
+		MSR_TM | MSR_TS_MASK;
+#else
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
+#endif
+	/* Process MSR values */
+	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
+	/* External providers the guest reserved */
+	smsr |= (guest_msr & vcpu->arch.guest_owned_ext);
+	/* 64-bit Process MSR values */
+#ifdef CONFIG_PPC_BOOK3S_64
+	smsr |= MSR_ISF | MSR_HV;
+#endif
+	vcpu->arch.shadow_msr = smsr;
+}
+
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
 void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 			    struct kvmppc_book3s_shadow_vcpu *svcpu)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	ulong old_msr;
+#endif
 	/*
 	 * vcpu_put would just call us again because in_use hasn't
 	 * been updated yet.
@@ -230,6 +256,30 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	to_book3s(vcpu)->vtb += get_vtb() - vcpu->arch.entry_vtb;
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		vcpu->arch.ic += mfspr(SPRN_IC) - vcpu->arch.entry_ic;
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/*
+	 * Unlike other MSR bits, MSR[TS]bits can be changed at guest without
+	 * notifying host:
+	 *  modified by unprivileged instructions like "tbegin"/"tend"/
+	 * "tresume"/"tsuspend" in PR KVM guest.
+	 *
+	 * It is necessary to sync here to calculate a correct shadow_msr.
+	 *
+	 * privileged guest's tbegin will be failed at present. So we
+	 * only take care of problem state guest.
+	 */
+	old_msr = kvmppc_get_msr(vcpu);
+	if (unlikely((old_msr & MSR_PR) &&
+		(vcpu->arch.shadow_srr1 & (MSR_TS_MASK)) !=
+				(old_msr & (MSR_TS_MASK)))) {
+		old_msr &= ~(MSR_TS_MASK);
+		old_msr |= (vcpu->arch.shadow_srr1 & (MSR_TS_MASK));
+		kvmppc_set_msr_fast(vcpu, old_msr);
+		kvmppc_recalc_shadow_msr(vcpu);
+	}
+#endif
+
 	svcpu->in_use = false;
 
 out:
@@ -317,29 +367,6 @@ static void kvm_set_spte_hva_pr(struct kvm *kvm, unsigned long hva, pte_t pte)
 
 /*****************************************/
 
-static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
-{
-	ulong guest_msr = kvmppc_get_msr(vcpu);
-	ulong smsr = guest_msr;
-
-	/* Guest MSR values */
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE |
-		MSR_TM | MSR_TS_MASK;
-#else
-	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
-#endif
-	/* Process MSR values */
-	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
-	/* External providers the guest reserved */
-	smsr |= (guest_msr & vcpu->arch.guest_owned_ext);
-	/* 64-bit Process MSR values */
-#ifdef CONFIG_PPC_BOOK3S_64
-	smsr |= MSR_ISF | MSR_HV;
-#endif
-	vcpu->arch.shadow_msr = smsr;
-}
-
 static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 {
 	ulong old_msr = kvmppc_get_msr(vcpu);
-- 
1.8.3.1

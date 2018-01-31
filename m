Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWx9D5H9yzDqrL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 08:25:03 +1100 (AEDT)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] KVM: PPC: Fix svcpu copying with preemption enabled
Date: Wed, 31 Jan 2018 22:24:58 +0100
Message-Id: <20180131212458.46749-1-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When copying between the vcpu and svcpu, we may get scheduled away onto
a different host CPU which in turn means our svcpu pointer may change.

That means we need to atomically copy to and from the svcpu with preemption
disabled, so that all code around it always sees a coherent state.

Reported-by: Simon Guo <wei.guo.simon@gmail.com>
Fixes: 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable interrupts earlier")
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |  6 ++----
 arch/powerpc/kvm/book3s_interrupts.S  |  4 +---
 arch/powerpc/kvm/book3s_pr.c          | 20 +++++++++-----------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 9a667007bff8..376ae803b69c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -249,10 +249,8 @@ extern int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd);
 extern void kvmppc_pr_init_default_hcalls(struct kvm *kvm);
 extern int kvmppc_hcall_impl_pr(unsigned long cmd);
 extern int kvmppc_hcall_impl_hv_realmode(unsigned long cmd);
-extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
-				 struct kvm_vcpu *vcpu);
-extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
-				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+extern void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu);
+extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu);
 extern int kvm_irq_bypass;
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index 901e6fe00c39..c18e845019ec 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -96,7 +96,7 @@ kvm_start_entry:
 
 kvm_start_lightweight:
 	/* Copy registers into shadow vcpu so we can access them in real mode */
-	GET_SHADOW_VCPU(r3)
+	mr	r3, r4
 	bl	FUNC(kvmppc_copy_to_svcpu)
 	nop
 	REST_GPR(4, r1)
@@ -165,9 +165,7 @@ after_sprg3_load:
 	stw	r12, VCPU_TRAP(r3)
 
 	/* Transfer reg values from shadow vcpu back to vcpu struct */
-	/* On 64-bit, interrupts are still off at this point */
 
-	GET_SHADOW_VCPU(r4)
 	bl	FUNC(kvmppc_copy_from_svcpu)
 	nop
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 7deaeeb14b93..3ae752314b34 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -121,7 +121,7 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 	if (svcpu->in_use) {
-		kvmppc_copy_from_svcpu(vcpu, svcpu);
+		kvmppc_copy_from_svcpu(vcpu);
 	}
 	memcpy(to_book3s(vcpu)->slb_shadow, svcpu->slb, sizeof(svcpu->slb));
 	to_book3s(vcpu)->slb_shadow_max = svcpu->slb_max;
@@ -143,9 +143,10 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 }
 
 /* Copy data needed by real-mode code from vcpu to shadow vcpu */
-void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
-			  struct kvm_vcpu *vcpu)
+void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
+
 	svcpu->gpr[0] = vcpu->arch.gpr[0];
 	svcpu->gpr[1] = vcpu->arch.gpr[1];
 	svcpu->gpr[2] = vcpu->arch.gpr[2];
@@ -177,17 +178,14 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		vcpu->arch.entry_ic = mfspr(SPRN_IC);
 	svcpu->in_use = true;
+
+	svcpu_put(svcpu);
 }
 
 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
-void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
-			    struct kvmppc_book3s_shadow_vcpu *svcpu)
+void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * vcpu_put would just call us again because in_use hasn't
-	 * been updated yet.
-	 */
-	preempt_disable();
+	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 
 	/*
 	 * Maybe we were already preempted and synced the svcpu from
@@ -233,7 +231,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	svcpu->in_use = false;
 
 out:
-	preempt_enable();
+	svcpu_put(svcpu);
 }
 
 static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
-- 
2.12.3

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWcpN4lN7zDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 20:07:40 +1100 (AEDT)
Subject: Re: [PATCH] KVM: PPC: Book3S PR: close a race window when SVCPU
 pointer is hold before kvmppc_copy_from_svcpu()
To: wei.guo.simon@gmail.com, kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>
References: <1517372604-21405-1-git-send-email-wei.guo.simon@gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <1b9a0861-6368-9a84-4d6e-cc9f05ef1be5@suse.de>
Date: Wed, 31 Jan 2018 10:07:35 +0100
MIME-Version: 1.0
In-Reply-To: <1517372604-21405-1-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31.01.18 05:23, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> commit 40fdd8c88c4a ("KVM: PPC: Book3S: PR: Make svcpu -> vcpu store
> preempt savvy") and commit 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable
> interrupts earlier") is trying to turns on preemption early when
> return into highmem guest exit handler.
> 
> However there is a race window in following example at
> arch/powerpc/kvm/book3s_interrupts.S:
> 
> highmem guest exit handler:
> ...
> 195         GET_SHADOW_VCPU(r4)
> 196         bl      FUNC(kvmppc_copy_from_svcpu)
> ...
> 239         bl      FUNC(kvmppc_handle_exit_pr)
> 
> If there comes a preemption between line 195 and 196, line 196
> may hold an invalid SVCPU reference with following sequence:
> 1) Qemu task T1 runs at GET_SHADOW_VCPU(r4) at line 195, on CPU A.
> 2) T1 is preempted and switch out CPU A. As a result, it checks
> CPU A's svcpu->in_use (=1 at present) and flush cpu A's svcpu to
> T1's vcpu.
> 3) Another task T2 switches into CPU A and it may update CPU A's
> svcpu->in_use into 1.
> 4) T1 is scheduled into CPU B. But it still holds CPU A's svcpu
> reference as R4. Then it executes kvmppc_copy_from_svcpu() with
> R4 and it will corrupt T1's VCPU with T2's content. T2's VCPU
> will also be impacted.
> 
> This patch moves the svcpu->in_use into VCPU so that the vcpus
> sharing the same svcpu can work properly and fix the above case.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

To me the description above sounds like what we really need to do is
move the preempt_disable() before GET_SHADOW_VCPU(). Or alternative put
GET_SHADOW_VCPU into kvmppc_copy_from_svcpu().

I guess along those lines we should also update the comment above
GET_SHADOW_VCPU() that says interrupts are disabled ;).

I would really like to keep the fact that the svcpu is currently used as
close to the svcpu as possible.

Does the untested patch below work for you? Because TB breaks
whitespace, I've also uploaded it to github:


https://github.com/agraf/linux-2.6/commit/2469804ed37b41167e9d97f4d72da24cdcb9f959


Alex


From: Alexander Graf <agraf@suse.de>
Date: Wed, 31 Jan 2018 09:48:09 +0100
Subject: [PATCH] KVM: PPC: Fix svcpu copying with preemption enabled

When copying between the vcpu and svcpu, we may get scheduled away onto
a different host CPU which in turn means our svcpu pointer may change.

That means we need to atomically copy to and from the svcpu with preemption
disabled, so that all code around it always sees a coherent state.

Reported-by: Simon Guo <wei.guo.simon@gmail.com>
Fixes: 3d3319b45eea ("KVM: PPC: Book3S: PR: Enable interrupts earlier")
Signed-off-by: Alexander Graf <agraf@suse.de>

diff --git a/arch/powerpc/include/asm/kvm_book3s.h
b/arch/powerpc/include/asm/kvm_book3s.h
index 9a667007bff8..376ae803b69c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -249,10 +249,8 @@ extern int kvmppc_h_pr(struct kvm_vcpu *vcpu,
unsigned long cmd);
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
diff --git a/arch/powerpc/kvm/book3s_interrupts.S
b/arch/powerpc/kvm/book3s_interrupts.S
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
index 7deaeeb14b93..f5c7797a38d7 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -121,7 +121,7 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu
*vcpu)
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
 	if (svcpu->in_use) {
-		kvmppc_copy_from_svcpu(vcpu, svcpu);
+		kvmppc_copy_from_svcpu(vcpu);
 	}
 	memcpy(to_book3s(vcpu)->slb_shadow, svcpu->slb, sizeof(svcpu->slb));
 	to_book3s(vcpu)->slb_shadow_max = svcpu->slb_max;
@@ -143,9 +143,16 @@ static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu
*vcpu)
 }

 /* Copy data needed by real-mode code from vcpu to shadow vcpu */
-void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
-			  struct kvm_vcpu *vcpu)
+void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_book3s_shadow_vcpu *svcpu;
+
+	/* On preemption the svcpu pointer may change, so disable it */
+	preempt_disable();
+
+	/* We need to make sure we fetch the svcpu with preemption disabled */
+	svcpu = current->thread.kvm_shadow_vcpu;
+
 	svcpu->gpr[0] = vcpu->arch.gpr[0];
 	svcpu->gpr[1] = vcpu->arch.gpr[1];
 	svcpu->gpr[2] = vcpu->arch.gpr[2];
@@ -177,18 +184,24 @@ void kvmppc_copy_to_svcpu(struct
kvmppc_book3s_shadow_vcpu *svcpu,
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		vcpu->arch.entry_ic = mfspr(SPRN_IC);
 	svcpu->in_use = true;
+
+	preempt_enable();
 }

 /* Copy data touched by real-mode code from shadow vcpu back to vcpu */
-void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
-			    struct kvmppc_book3s_shadow_vcpu *svcpu)
+void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_book3s_shadow_vcpu *svcpu;
+
 	/*
 	 * vcpu_put would just call us again because in_use hasn't
 	 * been updated yet.
 	 */
 	preempt_disable();

+	/* We need to make sure we fetch the svcpu with preemption disabled */
+	svcpu = current->thread.kvm_shadow_vcpu;
+
 	/*
 	 * Maybe we were already preempted and synced the svcpu from
 	 * our preempt notifiers. Don't bother touching this svcpu then.

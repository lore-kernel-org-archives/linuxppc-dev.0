Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 4053FB707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:16 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/26] KVM: PPC: Convert DAR to shared page.
Date: Sat, 26 Jun 2010 01:24:52 +0200
Message-Id: <1277508314-915-5-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The DAR register contains the address a data page fault occured at. This
register behaves pretty much like a simple data storage register that gets
written to on data faults. There is no hypervisor interaction required on
read or write.

This patch converts all users of the current field to the shared page.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h      |    1 -
 arch/powerpc/include/asm/kvm_para.h      |    1 +
 arch/powerpc/kvm/book3s.c                |   14 +++++++-------
 arch/powerpc/kvm/book3s_emulate.c        |    6 +++---
 arch/powerpc/kvm/book3s_paired_singles.c |    2 +-
 arch/powerpc/kvm/booke.c                 |    2 +-
 arch/powerpc/kvm/booke_emulate.c         |    4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 249c242..108dabc 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -230,7 +230,6 @@ struct kvm_vcpu_arch {
 	ulong csrr1;
 	ulong dsrr0;
 	ulong dsrr1;
-	ulong dear;
 	ulong esr;
 	u32 dec;
 	u32 decar;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 9f7565b..ec72a1c 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct kvm_vcpu_arch_shared {
+	__u64 dar;
 	__u64 msr;
 	__u32 dsisr;
 };
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 57fd73e..245bd2d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -594,14 +594,14 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	if (page_found == -ENOENT) {
 		/* Page not found in guest PTE entries */
-		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
+		vcpu->arch.shared->dar = kvmppc_get_fault_dar(vcpu);
 		vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 		vcpu->arch.shared->msr |=
 			(to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
 	} else if (page_found == -EPERM) {
 		/* Storage protection */
-		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
+		vcpu->arch.shared->dar = kvmppc_get_fault_dar(vcpu);
 		vcpu->arch.shared->dsisr =
 			to_svcpu(vcpu)->fault_dsisr & ~DSISR_NOHPTE;
 		vcpu->arch.shared->dsisr |= DSISR_PROTFAULT;
@@ -610,7 +610,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
 	} else if (page_found == -EINVAL) {
 		/* Page not found in guest SLB */
-		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
+		vcpu->arch.shared->dar = kvmppc_get_fault_dar(vcpu);
 		kvmppc_book3s_queue_irqprio(vcpu, vec + 0x80);
 	} else if (!is_mmio &&
 		   kvmppc_visible_gfn(vcpu, pte.raddr >> PAGE_SHIFT)) {
@@ -867,17 +867,17 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		if (to_svcpu(vcpu)->fault_dsisr & DSISR_NOHPTE) {
 			r = kvmppc_handle_pagefault(run, vcpu, dar, exit_nr);
 		} else {
-			vcpu->arch.dear = dar;
+			vcpu->arch.shared->dar = dar;
 			vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-			kvmppc_mmu_pte_flush(vcpu, vcpu->arch.dear, ~0xFFFUL);
+			kvmppc_mmu_pte_flush(vcpu, dar, ~0xFFFUL);
 			r = RESUME_GUEST;
 		}
 		break;
 	}
 	case BOOK3S_INTERRUPT_DATA_SEGMENT:
 		if (kvmppc_mmu_map_segment(vcpu, kvmppc_get_fault_dar(vcpu)) < 0) {
-			vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
+			vcpu->arch.shared->dar = kvmppc_get_fault_dar(vcpu);
 			kvmppc_book3s_queue_irqprio(vcpu,
 				BOOK3S_INTERRUPT_DATA_SEGMENT);
 		}
@@ -997,7 +997,7 @@ program_interrupt:
 		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
 			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu,
 				kvmppc_get_last_inst(vcpu));
-			vcpu->arch.dear = kvmppc_alignment_dar(vcpu,
+			vcpu->arch.shared->dar = kvmppc_alignment_dar(vcpu,
 				kvmppc_get_last_inst(vcpu));
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 		}
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 9982ff1..c147864 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -212,7 +212,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = kvmppc_st(vcpu, &addr, 32, zeros, true);
 			if ((r == -ENOENT) || (r == -EPERM)) {
 				*advance = 0;
-				vcpu->arch.dear = vaddr;
+				vcpu->arch.shared->dar = vaddr;
 				to_svcpu(vcpu)->fault_dar = vaddr;
 
 				dsisr = DSISR_ISSTORE;
@@ -330,7 +330,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 		vcpu->arch.shared->dsisr = spr_val;
 		break;
 	case SPRN_DAR:
-		vcpu->arch.dear = spr_val;
+		vcpu->arch.shared->dar = spr_val;
 		break;
 	case SPRN_HIOR:
 		to_book3s(vcpu)->hior = spr_val;
@@ -443,7 +443,7 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->dsisr);
 		break;
 	case SPRN_DAR:
-		kvmppc_set_gpr(vcpu, rt, vcpu->arch.dear);
+		kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->dar);
 		break;
 	case SPRN_HIOR:
 		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->hior);
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index 749dfbd..807576f 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -169,7 +169,7 @@ static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_store)
 
 	shared->msr = kvmppc_set_field(shared->msr, 33, 36, 0);
 	shared->msr = kvmppc_set_field(shared->msr, 42, 47, 0);
-	vcpu->arch.dear = eaddr;
+	shared->dar = eaddr;
 	/* Page Fault */
 	dsisr = kvmppc_set_field(0, 33, 33, 1);
 	if (is_store)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ddb4cac..5844bcf 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -195,7 +195,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 		if (update_esr == true)
 			vcpu->arch.esr = vcpu->arch.queued_esr;
 		if (update_dear == true)
-			vcpu->arch.dear = vcpu->arch.queued_dear;
+			vcpu->arch.shared->dar = vcpu->arch.queued_dear;
 		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
 
 		clear_bit(priority, &vcpu->arch.pending_exceptions);
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index b115203..51ef453 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -105,7 +105,7 @@ int kvmppc_booke_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 
 	switch (sprn) {
 	case SPRN_DEAR:
-		vcpu->arch.dear = spr_val; break;
+		vcpu->arch.shared->dar = spr_val; break;
 	case SPRN_ESR:
 		vcpu->arch.esr = spr_val; break;
 	case SPRN_DBCR0:
@@ -200,7 +200,7 @@ int kvmppc_booke_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 	case SPRN_IVPR:
 		kvmppc_set_gpr(vcpu, rt, vcpu->arch.ivpr); break;
 	case SPRN_DEAR:
-		kvmppc_set_gpr(vcpu, rt, vcpu->arch.dear); break;
+		kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->dar); break;
 	case SPRN_ESR:
 		kvmppc_set_gpr(vcpu, rt, vcpu->arch.esr); break;
 	case SPRN_DBCR0:
-- 
1.6.0.2

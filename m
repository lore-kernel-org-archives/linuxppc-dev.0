Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 0959EB7094
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:05 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/27] KVM: PPC: Convert DSISR to shared page
Date: Thu,  1 Jul 2010 12:42:38 +0200
Message-Id: <1277980982-12433-4-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
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

The DSISR register contains information about a data page fault. It is fully
read/write from inside the guest context and we don't need to worry about
interacting based on writes of this register.

This patch converts all users of the current field to the shared page.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    1 -
 arch/powerpc/include/asm/kvm_para.h      |    1 +
 arch/powerpc/kvm/book3s.c                |   11 ++++++-----
 arch/powerpc/kvm/book3s_emulate.c        |    6 +++---
 arch/powerpc/kvm/book3s_paired_singles.c |    2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 8274a2d..b5b1961 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -85,7 +85,6 @@ struct kvmppc_vcpu_book3s {
 	u64 hid[6];
 	u64 gqr[8];
 	int slb_nr;
-	u32 dsisr;
 	u64 sdr1;
 	u64 hior;
 	u64 msr_mask;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index a17dc52..9f7565b 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -24,6 +24,7 @@
 
 struct kvm_vcpu_arch_shared {
 	__u64 msr;
+	__u32 dsisr;
 };
 
 #ifdef __KERNEL__
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 38cca77..72917f8 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -595,15 +595,16 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if (page_found == -ENOENT) {
 		/* Page not found in guest PTE entries */
 		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
-		to_book3s(vcpu)->dsisr = to_svcpu(vcpu)->fault_dsisr;
+		vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 		vcpu->arch.shared->msr |=
 			(to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
 	} else if (page_found == -EPERM) {
 		/* Storage protection */
 		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
-		to_book3s(vcpu)->dsisr = to_svcpu(vcpu)->fault_dsisr & ~DSISR_NOHPTE;
-		to_book3s(vcpu)->dsisr |= DSISR_PROTFAULT;
+		vcpu->arch.shared->dsisr =
+			to_svcpu(vcpu)->fault_dsisr & ~DSISR_NOHPTE;
+		vcpu->arch.shared->dsisr |= DSISR_PROTFAULT;
 		vcpu->arch.shared->msr |=
 			(to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
@@ -867,7 +868,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = kvmppc_handle_pagefault(run, vcpu, dar, exit_nr);
 		} else {
 			vcpu->arch.dear = dar;
-			to_book3s(vcpu)->dsisr = to_svcpu(vcpu)->fault_dsisr;
+			vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 			kvmppc_mmu_pte_flush(vcpu, vcpu->arch.dear, ~0xFFFUL);
 			r = RESUME_GUEST;
@@ -994,7 +995,7 @@ program_interrupt:
 	}
 	case BOOK3S_INTERRUPT_ALIGNMENT:
 		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
-			to_book3s(vcpu)->dsisr = kvmppc_alignment_dsisr(vcpu,
+			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu,
 				kvmppc_get_last_inst(vcpu));
 			vcpu->arch.dear = kvmppc_alignment_dar(vcpu,
 				kvmppc_get_last_inst(vcpu));
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 35d3c16..9982ff1 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -221,7 +221,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				else if (r == -EPERM)
 					dsisr |= DSISR_PROTFAULT;
 
-				to_book3s(vcpu)->dsisr = dsisr;
+				vcpu->arch.shared->dsisr = dsisr;
 				to_svcpu(vcpu)->fault_dsisr = dsisr;
 
 				kvmppc_book3s_queue_irqprio(vcpu,
@@ -327,7 +327,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 		to_book3s(vcpu)->sdr1 = spr_val;
 		break;
 	case SPRN_DSISR:
-		to_book3s(vcpu)->dsisr = spr_val;
+		vcpu->arch.shared->dsisr = spr_val;
 		break;
 	case SPRN_DAR:
 		vcpu->arch.dear = spr_val;
@@ -440,7 +440,7 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->sdr1);
 		break;
 	case SPRN_DSISR:
-		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->dsisr);
+		kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->dsisr);
 		break;
 	case SPRN_DAR:
 		kvmppc_set_gpr(vcpu, rt, vcpu->arch.dear);
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index 626e6ef..749dfbd 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -173,7 +173,7 @@ static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_store)
 	/* Page Fault */
 	dsisr = kvmppc_set_field(0, 33, 33, 1);
 	if (is_store)
-		to_book3s(vcpu)->dsisr = kvmppc_set_field(dsisr, 38, 38, 1);
+		shared->dsisr = kvmppc_set_field(dsisr, 38, 38, 1);
 	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE);
 }
 
-- 
1.6.0.2

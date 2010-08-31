Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AE3C0B7106
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/35] KVM: PPC: Don't flush PTEs on NX/RO hit
Date: Tue, 31 Aug 2010 04:31:49 +0200
Message-Id: <1283221937-21006-9-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When hitting a no-execute or read-only data/inst storage interrupt we were
flushing the respective PTE so we're sure it gets properly overwritten next.

According to the spec, this is unnecessary though. The guest issues a tlbie
anyways, so we're safe to just keep the PTE around and have it manually removed
from the guest, saving us a flush.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 54ca578..2fb528f 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -887,7 +887,6 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			vcpu->arch.shared->msr |=
 				to_svcpu(vcpu)->shadow_srr1 & 0x58000000;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-			kvmppc_mmu_pte_flush(vcpu, kvmppc_get_pc(vcpu), ~0xFFFUL);
 			r = RESUME_GUEST;
 		}
 		break;
@@ -913,7 +912,6 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			vcpu->arch.shared->dar = dar;
 			vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-			kvmppc_mmu_pte_flush(vcpu, dar, ~0xFFFUL);
 			r = RESUME_GUEST;
 		}
 		break;
-- 
1.6.0.2

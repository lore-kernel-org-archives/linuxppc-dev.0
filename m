Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68E69B715D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:08 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/26] KVM: PPC: Don't flush PTEs on NX/RO hit
Date: Tue, 17 Aug 2010 15:57:43 +0200
Message-Id: <1282053481-18787-9-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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
index b3c1dde..3e017da 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -885,7 +885,6 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			vcpu->arch.shared->msr |=
 				to_svcpu(vcpu)->shadow_srr1 & 0x58000000;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-			kvmppc_mmu_pte_flush(vcpu, kvmppc_get_pc(vcpu), ~0xFFFUL);
 			r = RESUME_GUEST;
 		}
 		break;
@@ -911,7 +910,6 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			vcpu->arch.shared->dar = dar;
 			vcpu->arch.shared->dsisr = to_svcpu(vcpu)->fault_dsisr;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-			kvmppc_mmu_pte_flush(vcpu, dar, ~0xFFFUL);
 			r = RESUME_GUEST;
 		}
 		break;
-- 
1.6.0.2

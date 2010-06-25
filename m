Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id DD7BFB6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:11:53 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S_32 MMU debug compile fixes
Date: Sat, 26 Jun 2010 01:11:51 +0200
Message-Id: <1277507511-413-1-git-send-email-agraf@suse.de>
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

Due to previous changes, the Book3S_32 guest MMU code didn't compile properly
when enabling debugging.

This patch repairs the broken code paths, making it possible to define DEBUG_MMU
and friends again.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_32_mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 3292d76..079760b 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -104,7 +104,7 @@ static hva_t kvmppc_mmu_book3s_32_get_pteg(struct kvmppc_vcpu_book3s *vcpu_book3
 	pteg = (vcpu_book3s->sdr1 & 0xffff0000) | hash;
 
 	dprintk("MMU: pc=0x%lx eaddr=0x%lx sdr1=0x%llx pteg=0x%x vsid=0x%x\n",
-		vcpu_book3s->vcpu.arch.pc, eaddr, vcpu_book3s->sdr1, pteg,
+		kvmppc_get_pc(&vcpu_book3s->vcpu), eaddr, vcpu_book3s->sdr1, pteg,
 		sre->vsid);
 
 	r = gfn_to_hva(vcpu_book3s->vcpu.kvm, pteg >> PAGE_SHIFT);
@@ -269,7 +269,7 @@ no_page_found:
 		dprintk_pte("KVM MMU: No PTE found (sdr1=0x%llx ptegp=0x%lx)\n",
 			    to_book3s(vcpu)->sdr1, ptegp);
 		for (i=0; i<16; i+=2) {
-			dprintk_pte("   %02d: 0x%x - 0x%x (0x%llx)\n",
+			dprintk_pte("   %02d: 0x%x - 0x%x (0x%x)\n",
 				    i, pteg[i], pteg[i+1], ptem);
 		}
 	}
-- 
1.6.0.2

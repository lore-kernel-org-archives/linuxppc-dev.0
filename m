Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7602DB7D5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Jun 2010 23:25:44 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Remove obsolete kvmppc_mmu_find_pte
Date: Mon, 21 Jun 2010 15:25:40 +0200
Message-Id: <1277126740-32217-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initially we had to search for pte entries to invalidate them. Since
the logic has improved since then, we can just get rid of the search
function.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    1 -
 arch/powerpc/kvm/book3s_32_mmu_host.c |   20 --------------------
 arch/powerpc/kvm/book3s_64_mmu_host.c |   20 --------------------
 3 files changed, 0 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 6f74d93..4e99559 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -115,7 +115,6 @@ extern void kvmppc_mmu_book3s_32_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
-extern struct kvmppc_pte *kvmppc_mmu_find_pte(struct kvm_vcpu *vcpu, u64 ea, bool data);
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern int kvmppc_st(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec);
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 37779a5..904f5ac 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -151,26 +151,6 @@ void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 	}
 }
 
-struct kvmppc_pte *kvmppc_mmu_find_pte(struct kvm_vcpu *vcpu, u64 ea, bool data)
-{
-	int i;
-	u64 guest_vp;
-
-	guest_vp = vcpu->arch.mmu.ea_to_vp(vcpu, ea, false);
-	for (i=0; i<vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if (pte->pte.vpage == guest_vp)
-			return &pte->pte;
-	}
-
-	return NULL;
-}
-
 static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.hpte_cache_offset == HPTEG_CACHE_NUM)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 5d0e281..4ccdde1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -133,26 +133,6 @@ void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 	}
 }
 
-struct kvmppc_pte *kvmppc_mmu_find_pte(struct kvm_vcpu *vcpu, u64 ea, bool data)
-{
-	int i;
-	u64 guest_vp;
-
-	guest_vp = vcpu->arch.mmu.ea_to_vp(vcpu, ea, false);
-	for (i=0; i<vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if (pte->pte.vpage == guest_vp)
-			return &pte->pte;
-	}
-
-	return NULL;
-}
-
 static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.hpte_cache_offset == HPTEG_CACHE_NUM)
-- 
1.6.0.2

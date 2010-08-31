Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 562D9B710B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:21 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 09/35] KVM: PPC: Make invalidation code more reliable
Date: Tue, 31 Aug 2010 04:31:50 +0200
Message-Id: <1283221937-21006-10-git-send-email-agraf@suse.de>
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

There is a race condition in the pte invalidation code path where we can't
be sure if a pte was invalidated already. So let's move the spin lock around
to get rid of the race.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_mmu_hpte.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index bd6a767..79751d8 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -92,10 +92,6 @@ static void free_pte_rcu(struct rcu_head *head)
 
 static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
-	/* pte already invalidated? */
-	if (hlist_unhashed(&pte->list_pte))
-		return;
-
 	trace_kvm_book3s_mmu_invalidate(pte);
 
 	/* Different for 32 and 64 bit */
@@ -103,18 +99,24 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 
 	spin_lock(&vcpu->arch.mmu_lock);
 
+	/* pte already invalidated in between? */
+	if (hlist_unhashed(&pte->list_pte)) {
+		spin_unlock(&vcpu->arch.mmu_lock);
+		return;
+	}
+
 	hlist_del_init_rcu(&pte->list_pte);
 	hlist_del_init_rcu(&pte->list_pte_long);
 	hlist_del_init_rcu(&pte->list_vpte);
 	hlist_del_init_rcu(&pte->list_vpte_long);
 
-	spin_unlock(&vcpu->arch.mmu_lock);
-
 	if (pte->pte.may_write)
 		kvm_release_pfn_dirty(pte->pfn);
 	else
 		kvm_release_pfn_clean(pte->pfn);
 
+	spin_unlock(&vcpu->arch.mmu_lock);
+
 	vcpu->arch.hpte_cache_count--;
 	call_rcu(&pte->rcu_head, free_pte_rcu);
 }
-- 
1.6.0.2

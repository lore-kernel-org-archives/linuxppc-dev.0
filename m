Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D63791A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 00:13:52 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 18:43:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 03818E0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:46:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QDDj5b32571510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:43:45 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QD5PQp025866
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:35:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V4 2/4] KVM: PPC: Remove page table walk helpers
Date: Thu, 26 Mar 2015 18:43:40 +0530
Message-Id: <1427375622-3708-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch remove helpers which we had used only once in the code.
Limiting page table walk variants help in ensuring that we won't
end up with code walking page table with wrong assumptions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h  | 21 -------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 62 ++++++++++++++++---------------------
 arch/powerpc/kvm/e500_mmu_host.c    |  2 +-
 3 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9835ac4173b7..92fe01c355a9 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -249,27 +249,6 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 #endif
 pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 				 unsigned *shift);
-
-static inline pte_t *lookup_linux_ptep(pgd_t *pgdir, unsigned long hva,
-				     unsigned long *pte_sizep)
-{
-	pte_t *ptep;
-	unsigned long ps = *pte_sizep;
-	unsigned int shift;
-
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
-	if (!ptep)
-		return NULL;
-	if (shift)
-		*pte_sizep = 1ul << shift;
-	else
-		*pte_sizep = PAGE_SIZE;
-
-	if (ps > *pte_sizep)
-		return NULL;
-
-	return ptep;
-}
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 625407e4d3b0..73e083cb9f7e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -131,25 +131,6 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
-static pte_t lookup_linux_pte_and_update(pgd_t *pgdir, unsigned long hva,
-			      int writing, unsigned long *pte_sizep)
-{
-	pte_t *ptep;
-	unsigned long ps = *pte_sizep;
-	unsigned int hugepage_shift;
-
-	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hugepage_shift);
-	if (!ptep)
-		return __pte(0);
-	if (hugepage_shift)
-		*pte_sizep = 1ul << hugepage_shift;
-	else
-		*pte_sizep = PAGE_SIZE;
-	if (ps > *pte_sizep)
-		return __pte(0);
-	return kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
-}
-
 static inline void unlock_hpte(__be64 *hpte, unsigned long hpte_v)
 {
 	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
@@ -166,10 +147,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	struct revmap_entry *rev;
 	unsigned long g_ptel;
 	struct kvm_memory_slot *memslot;
-	unsigned long pte_size;
+	unsigned hpage_shift;
 	unsigned long is_io;
 	unsigned long *rmap;
-	pte_t pte;
+	pte_t *ptep;
 	unsigned int writing;
 	unsigned long mmu_seq;
 	unsigned long rcbits;
@@ -208,22 +189,33 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Translate to host virtual address */
 	hva = __gfn_to_hva_memslot(memslot, gfn);
+	ptep = find_linux_pte_or_hugepte(pgdir, hva, &hpage_shift);
+	if (ptep) {
+		pte_t pte;
+		unsigned int host_pte_size;
 
-	/* Look up the Linux PTE for the backing page */
-	pte_size = psize;
-	pte = lookup_linux_pte_and_update(pgdir, hva, writing, &pte_size);
-	if (pte_present(pte) && !pte_protnone(pte)) {
-		if (writing && !pte_write(pte))
-			/* make the actual HPTE be read-only */
-			ptel = hpte_make_readonly(ptel);
-		is_io = hpte_cache_bits(pte_val(pte));
-		pa = pte_pfn(pte) << PAGE_SHIFT;
-		pa |= hva & (pte_size - 1);
-		pa |= gpa & ~PAGE_MASK;
-	}
+		if (hpage_shift)
+			host_pte_size = 1ul << hpage_shift;
+		else
+			host_pte_size = PAGE_SIZE;
+		/*
+		 * We should always find the guest page size
+		 * to <= host page size, if host is using hugepage
+		 */
+		if (host_pte_size < psize)
+			return H_PARAMETER;
 
-	if (pte_size < psize)
-		return H_PARAMETER;
+		pte = kvmppc_read_update_linux_pte(ptep, writing, hpage_shift);
+		if (pte_present(pte) && !pte_protnone(pte)) {
+			if (writing && !pte_write(pte))
+				/* make the actual HPTE be read-only */
+				ptel = hpte_make_readonly(ptel);
+			is_io = hpte_cache_bits(pte_val(pte));
+			pa = pte_pfn(pte) << PAGE_SHIFT;
+			pa |= hva & (host_pte_size - 1);
+			pa |= gpa & ~PAGE_MASK;
+		}
+	}
 
 	ptel &= ~(HPTE_R_PP0 - psize);
 	ptel |= pa;
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 5840d546aa03..a1f5b0d4b1d6 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -468,7 +468,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 
 	pgdir = vcpu_e500->vcpu.arch.pgdir;
-	ptep = lookup_linux_ptep(pgdir, hva, &tsize_pages);
+	ptep = find_linux_pte_or_hugepte(pgdir, hva, NULL);
 	if (ptep) {
 		pte_t pte = READ_ONCE(*ptep);
 
-- 
2.1.0

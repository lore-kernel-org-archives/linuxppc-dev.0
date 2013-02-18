Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA0DC2C0291
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:44 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:55:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 93DF7125805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:59:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASaNi29818928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASbmP001204
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:38 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 14/17] powerpc: support for zerout withdraw.
Date: Mon, 18 Feb 2013 15:58:12 +0530
Message-Id: <1361183295-6958-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Need changes to other archs. This need to be fixed further

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h |    3 ++-
 arch/powerpc/mm/pgtable.c          |   11 ++++++++---
 mm/huge_memory.c                   |   18 ++++++++++++------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 4e49c34..3dfbec9 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -262,7 +262,8 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
+					     pmd_t *pmdp, int tozero);
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 841271f..fa5e108 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -355,7 +355,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 /* FIXME!! May be all this should be in pgtable_64.c ? */
 #define PTE_FRAG_SIZE (2 * PTRS_PER_PTE * sizeof(pte_t))
 
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp, int tozero)
 {
 	pgtable_t pgtable;
 	unsigned long *pgtable_slot;
@@ -368,8 +368,13 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	 * Make sure we are invalidating all the entries. So that
 	 * we fault and create new entries later
 	 */
-	/* zero out the table before returning */
-	memset(pgtable, 0, PTE_FRAG_SIZE);
+	/* FIXME!! this is not correct. zero out the table before returning
+	 * because we are using this for other things.
+	 * zap_huge_pmd
+	 */
+	if (tozero)
+		/* Not needed, because we depoist a zeroed table ? */
+		memset(pgtable, 0, PTE_FRAG_SIZE);
 	return pgtable;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5beb2e2..3777a5b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -781,7 +781,7 @@ static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 	entry = pmd_wrprotect(entry);
 	entry = pmd_mkhuge(entry);
 	set_pmd_at(mm, haddr, pmd, entry);
-	pgtable_trans_huge_deposit(mm, pgtable);
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	mm->nr_ptes++;
 	return true;
 }
@@ -996,7 +996,7 @@ static int do_huge_pmd_wp_zero_page_fallback(struct mm_struct *mm,
 	pmdp_clear_flush(vma, haddr, pmd);
 	/* leave pmd empty until pte is filled */
 
-	pgtable = pgtable_trans_huge_withdraw(mm);
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd, 1);
 	pmd_populate(mm, &_pmd, pgtable);
 
 	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
@@ -1091,7 +1091,7 @@ static int do_huge_pmd_wp_page_fallback(struct mm_struct *mm,
 		goto out_free_pages;
 	VM_BUG_ON(!PageHead(page));
 
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd, 1);
 	pmdp_clear_flush(vma, haddr, pmd);
 	/* leave pmd empty until pte is filled */
 
@@ -1373,7 +1373,13 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		struct page *page;
 		pgtable_t pgtable;
 		pmd_t orig_pmd;
-		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
+		/*
+		 * Withdraw the pgtable without zero out, because
+		 * the following pmd_get_and_clear will look at
+		 * pgtable contents, in case of some architectures
+		 * like ppc64
+		 */
+		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd, 0);
 		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		if (is_huge_zero_pmd(orig_pmd)) {
@@ -1705,7 +1711,7 @@ static int __split_huge_page_map(struct page *page,
 	pmd = page_check_address_pmd(page, mm, address,
 				     PAGE_CHECK_ADDRESS_PMD_SPLITTING_FLAG);
 	if (pmd) {
-		pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+		pgtable = pgtable_trans_huge_withdraw(mm, pmd, 1);
 		pmd_populate(mm, &_pmd, pgtable);
 
 		haddr = address;
@@ -2699,7 +2705,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pmdp_clear_flush(vma, haddr, pmd);
 	/* leave pmd empty until pte is filled */
 
-	pgtable = pgtable_trans_huge_withdraw(mm);
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd, 1);
 	pmd_populate(mm, &_pmd, pgtable);
 
 	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
-- 
1.7.10

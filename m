Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sHFW6dHSzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:59:11 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id f1-v6so1068104plt.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 10:59:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 1/7] powerpc/64s/radix: do not flush TLB when relaxing
 access
Date: Fri, 25 May 2018 03:58:47 +1000
Message-Id: <20180524175853.19695-2-npiggin@gmail.com>
In-Reply-To: <20180524175853.19695-1-npiggin@gmail.com>
References: <20180524175853.19695-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix flushes the TLB when updating ptes to increase permissiveness
of protection (increase access authority). Book3S does not require
TLB flushing in this case, and it is not done on hash. This patch
avoids the flush for radix.

>From Power ISA v3.0B, p.1090:

    Setting a Reference or Change Bit or Upgrading Access Authority
    (PTE Subject to Atomic Hardware Updates)

    If the only change being made to a valid PTE that is subject to
    atomic hardware updates is to set the Reference or Change bit to 1
    or to add access authorities, a simpler sequence suffices because
    the translation hardware will refetch the PTE if an access is
    attempted for which the only problems were reference and/or change
    bits needing to be set or insufficient access authority.

The nest MMU on POWER9 does not re-fetch the PTE after such an access
attempt before faulting, so address spaces with a coprocessor
attached will continue to flush in these cases.

This reduces tlbies for a kernel compile workload from 1.28M to 0.95M,
tlbiels from 20.17M 19.68M.

fork --fork --exec benchmark improved 2.77% (12000->12300).

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 10 +++++++---
 arch/powerpc/mm/pgtable.c          | 25 +++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 518518fb7c45..994492453f0e 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -31,16 +31,20 @@ int (*register_process_table)(unsigned long base, unsigned long page_size,
 int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp, pmd_t entry, int dirty)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	int changed;
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
-	assert_spin_locked(&vma->vm_mm->page_table_lock);
+	assert_spin_locked(&mm->page_table_lock);
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
+		__ptep_set_access_flags(mm, pmdp_ptep(pmdp),
 					pmd_pte(entry), address);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		/* See ptep_set_access_flags comments */
+		if (atomic_read(&mm->context.copros) > 0)
+			flush_pmd_tlb_range(vma, address,
+					address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f361ae571e9..02a24bce7e51 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -217,14 +217,35 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 			  pte_t *ptep, pte_t entry, int dirty)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	int changed;
+
 	entry = set_access_flags_filter(entry, vma, dirty);
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
 		if (!is_vm_hugetlb_page(vma))
-			assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
+			assert_pte_locked(mm, address);
+		__ptep_set_access_flags(mm, ptep, entry, address);
+#ifdef CONFIG_PPC_BOOK3S_64
+		/*
+		 * Book3S does not require a TLB flush when relaxing access
+		 * restrictions because the core MMU will reload the pte after
+		 * taking an access fault. However the NMMU on POWER9 does not
+		 * re-load the pte, so flush if we have a coprocessor attached
+		 * to this address space.
+		 *
+		 * This could be further refined and pushed out to NMMU drivers
+		 * so TLBIEs are only done for NMMU faults, but this is a more
+		 * minimal fix. The NMMU fault handler does
+		 * get_user_pages_remote or similar to bring the page tables
+		 * in, and this flush_tlb_page will do a global TLBIE because
+		 * the coprocessor is attached to the address space.
+		 */
+		if (atomic_read(&mm->context.copros) > 0)
+			flush_tlb_page(vma, address);
+#else
 		flush_tlb_page(vma, address);
+#endif
 	}
 	return changed;
 }
-- 
2.17.0

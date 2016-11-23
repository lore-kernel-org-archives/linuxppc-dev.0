Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP3yh3K8jzDw7C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:05:48 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so748614pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:05:48 -0800 (PST)
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
 <87y40ah0pa.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <248c0fa0-4094-429c-fa3b-1a53c75bcfbe@gmail.com>
Date: Thu, 24 Nov 2016 01:05:52 +1100
MIME-Version: 1.0
In-Reply-To: <87y40ah0pa.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/11/16 22:53, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On 23/11/16 22:09, Aneesh Kumar K.V wrote:
>>> When we are updating pte, we just need to flush the tlb mapping for
>>> that pte. Right now we do a full mm flush because we don't track page
>>> size. Update the interface to track the page size and use that to
>>> do the right tlb flush.
>>>
>>
>> Could you also clarify the scope -- this seems to be _radix_ only.
>> The problem statement is not very clear and why doesn't the flush_tlb_page()
>> following ptep_set_access_flags() work? What else do we need to do?
> 
> Yes it modifies only radix part.  Don't understand the flush_tlb_page()
> part of the comment above. We are modifying the tlbflush that we need to do in the pte update
> sequence for DD1. ie, we need to do the flush before we can set the pte
> with new value.
> 
> Also in this specific case, we can idealy drop that flush_tlb_page,
> because relaxing an access really don't need a tlb flush from generic
> architecture point of view. I left it there to make sure, we measure and
> get the invalidate path correct before going ahead with that
> optimization.
> 

OK.. here is my untested solution. I've only compiled it.
It breaks the 64/hash/radix abstractions, but it makes the
changes much simpler

Signed-off-by: Balbir Singh <bsingharora@gmail.com>

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 2a46dea..2454217 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -162,6 +162,30 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 	return old_pte;
 }
 
+static inline void radix__ptep_dd1_set_access_flags(struct mm_struct *mm,
+						unsigned long addr,
+						pte_t *ptep, pte_t entry,
+						unsigned long page_size)
+{
+
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
+					      _PAGE_RW | _PAGE_EXEC);
+
+	unsigned long old_pte, new_pte;
+
+	old_pte = __radix_pte_update(ptep, ~0, 0);
+	asm volatile("ptesync" : : : "memory");
+	/*
+	 * new value of pte
+	 */
+	new_pte = old_pte | set;
+
+	radix__flush_tlb_page_psize(mm, addr, page_size);
+	__radix_pte_update(ptep, 0, new_pte);
+
+	asm volatile("ptesync" : : : "memory");
+}
+
 /*
  * Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to invalidate tlb.
@@ -173,26 +197,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
 
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-
-		unsigned long old_pte, new_pte;
-
-		old_pte = __radix_pte_update(ptep, ~0, 0);
-		asm volatile("ptesync" : : : "memory");
-		/*
-		 * new value of pte
-		 */
-		new_pte = old_pte | set;
-
-		/*
-		 * For now let's do heavy pid flush
-		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
-		 */
-		radix__flush_tlb_mm(mm);
-
-		__radix_pte_update(ptep, 0, new_pte);
-	} else
-		__radix_pte_update(ptep, 0, set);
+	__radix_pte_update(ptep, 0, set);
 	asm volatile("ptesync" : : : "memory");
 }
 
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index f4f437c..0c7ee0e 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -7,12 +7,14 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #include "mmu_decl.h"
 #include <trace/events/thp.h>
+#include <linux/hugetlb.h>
 
 int (*register_process_table)(unsigned long base, unsigned long page_size,
 			      unsigned long tbl_size);
@@ -35,7 +37,15 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
+		if (radix_enabled() && cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+			unsigned long page_size;
+			page_size = is_vm_hugetlb_page(vma) ? PAGE_SIZE :
+					huge_page_size(hstate_vma(vma));
+
+			radix__ptep_dd1_set_access_flags(vma->vm_mm, address,
+					pmdp_ptep(pmdp), pmd_pte(entry), page_size);
+		} else
+			__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
 		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 911fdfb..ebb464e 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,7 +224,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	if (changed) {
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
+		/* Workaround to call radix update directly for DD1 */
+		if (radix_enabled() && cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+			unsigned long page_size;
+			page_size = is_vm_hugetlb_page(vma) ? PAGE_SIZE :
+					huge_page_size(hstate_vma(vma));
+
+			radix__ptep_dd1_set_access_flags(vma->vm_mm, address,
+					ptep, entry, page_size);
+		} else
+			__ptep_set_access_flags(vma->vm_mm, ptep, entry);
 		flush_tlb_page(vma, address);
 	}
 	return changed;

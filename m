Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRcQx5lHkzDqpV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 00:36:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78EXdV3015154
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 10:36:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7f3v8fvt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 10:36:22 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 15:36:20 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH 12/16] mm: Protect SPF handler against anon_vma changes
Date: Tue,  8 Aug 2017 16:35:45 +0200
In-Reply-To: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1502202949-8138-13-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The speculative page fault handler must be protected against anon_vma
changes. This is because page_add_new_anon_rmap() is called during the
speculative path.

In addition, don't try speculative page fault if the VMA don't have an
anon_vma structure allocated because its allocation should be
protected by the mmap_sem.

In __vma_adjust() when importer->anon_vma is set, there is no need to
protect against speculative page faults since speculative page fault
is aborted if the vma->anon_vma is not set.

When calling page_add_new_anon_rmap() vma->anon_vma is necessarily
valid since we checked for it when locking the pte and the anon_vma is
removed once the pte is unlocked. So even if the speculative page
fault handler is running concurrently with do_unmap(), as the pte is
locked in unmap_region() - through unmap_vmas() - and the anon_vma
unlinked later, because we check for the vma sequence counter which is
updated in unmap_page_range() before locking the pte, and then in
free_pgtables() so when locking the pte the change will be detected.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/memory.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 519c28507a93..cb6906435ff5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -587,7 +587,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
 		 */
+		write_seqcount_begin(&vma->vm_sequence);
 		unlink_anon_vmas(vma);
+		write_seqcount_end(&vma->vm_sequence);
 		unlink_file_vma(vma);
 
 		if (is_vm_hugetlb_page(vma)) {
@@ -601,7 +603,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = vma->vm_next;
+				write_seqcount_begin(&vma->vm_sequence);
 				unlink_anon_vmas(vma);
+				write_seqcount_end(&vma->vm_sequence);
 				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
@@ -2403,7 +2407,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 		 * thread doing COW.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		__page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(new_page, vma);
 		/*
@@ -2873,7 +2877,7 @@ int do_swap_page(struct vm_fault *vmf)
 		mem_cgroup_commit_charge(page, memcg, true, false);
 		activate_page(page);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		__page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
 	}
@@ -3015,7 +3019,7 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	__page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	lru_cache_add_active_or_unevictable(page, vma);
 setpte:
@@ -3940,6 +3944,9 @@ int handle_speculative_fault(struct mm_struct *mm, unsigned long address,
 	if (address < vma->vm_start || vma->vm_end <= address)
 		goto unlock;
 
+	if (unlikely(!vma->anon_vma))
+		goto unlock;
+
 	/*
 	 * Huge pages are not yet supported.
 	 */
-- 
2.7.4

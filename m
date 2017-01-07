Return-Path: <hughd@google.com>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3twyWw6XQBzDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2017 10:37:48 +1100 (AEDT)
Received: by mail-pg0-x232.google.com with SMTP id 14so18455958pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Jan 2017 15:37:47 -0800 (PST)
Date: Sat, 7 Jan 2017 15:37:31 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mm: stop leaking PageTables
Message-ID: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4.10-rc loadtest (even on x86, even without THPCache) fails with
"fork: Cannot allocate memory" or some such; and /proc/meminfo
shows PageTables growing.

rc1 removed the freeing of an unused preallocated pagetable after
do_fault_around() has called map_pages(): which is usually a good
optimization, so that the followup doesn't have to reallocate one;
but it's not sufficient to shift the freeing into alloc_set_pte(),
since there are failure cases (most commonly VM_FAULT_RETRY) which
never reach finish_fault().

Check and free it at the outer level in do_fault(), then we don't
need to worry in alloc_set_pte(), and can restore that to how it was
(I cannot find any reason to pte_free() under lock as it was doing).

And fix a separate pagetable leak, or crash, introduced by the same
change, that could only show up on some ppc64: why does do_set_pmd()'s
failure case attempt to withdraw a pagetable when it never deposited
one, at the same time overwriting (so leaking) the vmf->prealloc_pte?
Residue of an earlier implementation, perhaps?  Delete it.

Fixes: 953c66c2b22a ("mm: THP page cache support for ppc64")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/memory.c |   47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

--- 4.10-rc2/mm/memory.c	2016-12-25 18:40:50.830453384 -0800
+++ linux/mm/memory.c	2017-01-07 13:34:29.373381551 -0800
@@ -3008,13 +3008,6 @@ static int do_set_pmd(struct vm_fault *v
 	ret = 0;
 	count_vm_event(THP_FILE_MAPPED);
 out:
-	/*
-	 * If we are going to fallback to pte mapping, do a
-	 * withdraw with pmd lock held.
-	 */
-	if (arch_needs_pgtable_deposit() && ret == VM_FAULT_FALLBACK)
-		vmf->prealloc_pte = pgtable_trans_huge_withdraw(vma->vm_mm,
-								vmf->pmd);
 	spin_unlock(vmf->ptl);
 	return ret;
 }
@@ -3055,20 +3048,18 @@ int alloc_set_pte(struct vm_fault *vmf,
 
 		ret = do_set_pmd(vmf, page);
 		if (ret != VM_FAULT_FALLBACK)
-			goto fault_handled;
+			return ret;
 	}
 
 	if (!vmf->pte) {
 		ret = pte_alloc_one_map(vmf);
 		if (ret)
-			goto fault_handled;
+			return ret;
 	}
 
 	/* Re-check under ptl */
-	if (unlikely(!pte_none(*vmf->pte))) {
-		ret = VM_FAULT_NOPAGE;
-		goto fault_handled;
-	}
+	if (unlikely(!pte_none(*vmf->pte)))
+		return VM_FAULT_NOPAGE;
 
 	flush_icache_page(vma, page);
 	entry = mk_pte(page, vma->vm_page_prot);
@@ -3088,15 +3079,8 @@ int alloc_set_pte(struct vm_fault *vmf,
 
 	/* no need to invalidate: a not-present page won't be cached */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
-	ret = 0;
 
-fault_handled:
-	/* preallocated pagetable is unused: free it */
-	if (vmf->prealloc_pte) {
-		pte_free(vmf->vma->vm_mm, vmf->prealloc_pte);
-		vmf->prealloc_pte = 0;
-	}
-	return ret;
+	return 0;
 }
 
 
@@ -3360,15 +3344,24 @@ static int do_shared_fault(struct vm_fau
 static int do_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	int ret;
 
 	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
 	if (!vma->vm_ops->fault)
-		return VM_FAULT_SIGBUS;
-	if (!(vmf->flags & FAULT_FLAG_WRITE))
-		return do_read_fault(vmf);
-	if (!(vma->vm_flags & VM_SHARED))
-		return do_cow_fault(vmf);
-	return do_shared_fault(vmf);
+		ret = VM_FAULT_SIGBUS;
+	else if (!(vmf->flags & FAULT_FLAG_WRITE))
+		ret = do_read_fault(vmf);
+	else if (!(vma->vm_flags & VM_SHARED))
+		ret = do_cow_fault(vmf);
+	else
+		ret = do_shared_fault(vmf);
+
+	/* preallocated pagetable is unused: free it */
+	if (vmf->prealloc_pte) {
+		pte_free(vma->vm_mm, vmf->prealloc_pte);
+		vmf->prealloc_pte = 0;
+	}
+	return ret;
 }
 
 static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,

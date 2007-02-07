Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Feb 2007 15:50:50 +1100
Subject: [PATCH 1/3] add vm_insert_pfn()
In-Reply-To: <1170823850.450936.293648942401.qpush@grosgo>
Message-Id: <20070207045052.E0766DDE40@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nick Piggin <npiggin@suse.de>

Add a vm_insert_pfn helper, so that ->fault handlers can have nopfn
functionality by installing their own pte and returning NULL.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 include/linux/mm.h |    1 +
 mm/memory.c        |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

Index: linux-cell/include/linux/mm.h
===================================================================
--- linux-cell.orig/include/linux/mm.h	2007-01-22 10:34:06.000000000 +1100
+++ linux-cell/include/linux/mm.h	2007-02-06 13:46:51.000000000 +1100
@@ -1120,6 +1120,7 @@ unsigned long vmalloc_to_pfn(void *addr)
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
+int vm_insert_pfn(struct vm_area_struct *, unsigned long addr, unsigned long pfn);
 
 struct page *follow_page(struct vm_area_struct *, unsigned long address,
 			unsigned int foll_flags);
Index: linux-cell/mm/memory.c
===================================================================
--- linux-cell.orig/mm/memory.c	2007-01-12 14:49:15.000000000 +1100
+++ linux-cell/mm/memory.c	2007-02-06 13:46:51.000000000 +1100
@@ -1277,6 +1277,50 @@ int vm_insert_page(struct vm_area_struct
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+/**
+ * vm_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_inert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return NULL.
+ */
+int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int retval;
+	pte_t *pte, entry;
+	spinlock_t *ptl;
+
+	BUG_ON(!(vma->vm_flags & VM_PFNMAP));
+	BUG_ON(is_cow_mapping(vma->vm_flags));
+
+	retval = -ENOMEM;
+	pte = get_locked_pte(mm, addr, &ptl);
+	if (!pte)
+		goto out;
+	retval = -EBUSY;
+	if (!pte_none(*pte))
+		goto out_unlock;
+
+	/* Ok, finally just insert the thing.. */
+	entry = pfn_pte(pfn, vma->vm_page_prot);
+	set_pte_at(mm, addr, pte, entry);
+	update_mmu_cache(vma, addr, entry);
+
+	retval = 0;
+out_unlock:
+	pte_unmap_unlock(pte, ptl);
+
+out:
+	return retval;
+}
+EXPORT_SYMBOL(vm_insert_pfn);
+
 /*
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results

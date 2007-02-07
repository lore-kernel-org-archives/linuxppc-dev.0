Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Feb 2007 15:50:51 +1100
Subject: [PATCH 2/3] Add NOPFN_REFAULT result from vm_ops->nopfn()
In-Reply-To: <1170823850.450936.293648942401.qpush@grosgo>
Message-Id: <20070207045054.058B3DDECC@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a NOPFN_REFAULT return code for vm_ops->nopfn() equivalent
to NOPAGE_REFAULT for vmops->nopage() indicating that the handler
requests a re-execution of the faulting instruction

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 include/linux/mm.h |    1 +
 mm/memory.c        |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-cell/include/linux/mm.h
===================================================================
--- linux-cell.orig/include/linux/mm.h	2007-02-06 14:40:45.000000000 +1100
+++ linux-cell/include/linux/mm.h	2007-02-06 14:40:52.000000000 +1100
@@ -637,6 +637,7 @@ static inline int page_mapped(struct pag
  */
 #define NOPFN_SIGBUS	((unsigned long) -1)
 #define NOPFN_OOM	((unsigned long) -2)
+#define NOPFN_REFAULT	((unsigned long) -3)
 
 /*
  * Different kinds of faults, as returned by handle_mm_fault().
Index: linux-cell/mm/memory.c
===================================================================
--- linux-cell.orig/mm/memory.c	2007-02-06 14:41:10.000000000 +1100
+++ linux-cell/mm/memory.c	2007-02-06 14:41:45.000000000 +1100
@@ -2357,10 +2357,12 @@ static noinline int do_no_pfn(struct mm_
 	BUG_ON(is_cow_mapping(vma->vm_flags));
 
 	pfn = vma->vm_ops->nopfn(vma, address & PAGE_MASK);
-	if (pfn == NOPFN_OOM)
+	if (unlikely(pfn == NOPFN_OOM))
 		return VM_FAULT_OOM;
-	if (pfn == NOPFN_SIGBUS)
+	else if (unlikely(pfn == NOPFN_SIGBUS))
 		return VM_FAULT_SIGBUS;
+	else if (unlikely(pfn == NOPFN_REFAULT))
+		return VM_FAULT_MINOR;
 
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 

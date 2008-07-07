Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707143011.205708473@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:52 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 2/5] powerpc: Define flags for Strong Access Ordering
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch defines:

- PROT_SAO, which is passed into mmap() and mprotect() in the prot field
- VM_SAO in vma->vm_flags, and
- _PAGE_SAO, the combination of WIMG bits in the pte that enables strong
access ordering for the page.

NOTE: There doesn't seem to be a precedent for architecture-dependent vm_flags.
It may be better to define VM_SAO somewhere in include/asm-powerpc/.  Since
vm_flags is a long, defining it in the high-order word would help prevent a
collision with any newly added values in architecture-independent code.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 include/asm-powerpc/mman.h          |    2 ++
 include/asm-powerpc/pgtable-ppc64.h |    3 +++
 include/linux/mm.h                  |    1 +
 3 files changed, 6 insertions(+)

Index: b/include/asm-powerpc/mman.h
===================================================================
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define PROT_SAO	0x10		/* Strong Access Ordering */
+
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_LOCKED	0x80
Index: b/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- a/include/asm-powerpc/pgtable-ppc64.h
+++ b/include/asm-powerpc/pgtable-ppc64.h
@@ -93,6 +93,9 @@
 #define _PAGE_RW	0x0200 /* software: user write access allowed */
 #define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */
 
+/* Strong Access Ordering */
+#define _PAGE_SAO	(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
+
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
 
 #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
Index: b/include/linux/mm.h
===================================================================
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -108,6 +108,7 @@
 
 #define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear pages */
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
+#define VM_SAO		0x20000000	/* Strong Access Ordering (powerpc) */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS

-- 
Dave Kleikamp
IBM Linux Technology Center

Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 18:01:12 -0400
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20080610220112.10257.48747.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
References: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 03/06] powerpc: Define flags for Strong Access Ordering
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Define flags for Strong Access Ordering

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

diff -Nurp linux002/include/asm-powerpc/mman.h linux003/include/asm-powerpc/mman.h
--- linux002/include/asm-powerpc/mman.h	2008-04-16 21:49:44.000000000 -0500
+++ linux003/include/asm-powerpc/mman.h	2008-06-10 16:48:59.000000000 -0500
@@ -10,6 +10,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define PROT_SAO	0x10		/* Strong Access Ordering */
+
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_LOCKED	0x80
diff -Nurp linux002/include/asm-powerpc/pgtable-ppc64.h linux003/include/asm-powerpc/pgtable-ppc64.h
--- linux002/include/asm-powerpc/pgtable-ppc64.h	2008-06-05 10:07:56.000000000 -0500
+++ linux003/include/asm-powerpc/pgtable-ppc64.h	2008-06-10 16:48:59.000000000 -0500
@@ -94,6 +94,9 @@
 #define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */
 
+/* Strong Access Ordering */
+#define _PAGE_SAO	(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
+
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
 
 #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
diff -Nurp linux002/include/linux/mm.h linux003/include/linux/mm.h
--- linux002/include/linux/mm.h	2008-06-05 10:08:01.000000000 -0500
+++ linux003/include/linux/mm.h	2008-06-10 16:48:59.000000000 -0500
@@ -108,6 +108,7 @@ extern unsigned int kobjsize(const void 
 
 #define VM_CAN_NONLINEAR 0x08000000	/* Has ->fault & does nonlinear pages */
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
+#define VM_SAO		0x20000000	/* Strong Access Ordering (powerpc) */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS

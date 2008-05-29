Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 29 May 2008 15:51:45 +1000
Subject: [PATCH] [POWERPC] Free a PTE bit on ppc64 with 64K pages
Message-Id: <20080529055401.9B758DDDE7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch frees a PTE bit when using 64K pages on ppc64. This is done
by getting rid of the separate _PAGE_HASHPTE bit. Instead, we just test
if any of the 16 sub-page bits is set. For non-combo pages (ie. real
64K pages), we set SUB0 and the location encoding in that field.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Please review and make sure I didn't miss something ... 

The freed bit is intended to be used as _PAGE_SPECIAL in order
to support fast get_user_pages().

Test booted with 64K pages on G5, power5 and power6

 arch/powerpc/mm/hash_low_64.S       |   12 ++++++------
 arch/powerpc/mm/hugetlbpage.c       |    5 ++---
 include/asm-powerpc/pgtable-4k.h    |    2 ++
 include/asm-powerpc/pgtable-64k.h   |   18 ++++++++++++++++--
 include/asm-powerpc/pgtable-ppc64.h |    1 -
 5 files changed, 26 insertions(+), 12 deletions(-)

--- linux-work.orig/arch/powerpc/mm/hash_low_64.S	2008-05-29 12:10:47.000000000 +1000
+++ linux-work/arch/powerpc/mm/hash_low_64.S	2008-05-29 12:56:16.000000000 +1000
@@ -388,7 +388,7 @@ _GLOBAL(__hash_page_4K)
 	 */
 	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
 	or	r30,r30,r31
-	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE
+	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED
 	oris	r30,r30,_PAGE_COMBO@h
 	/* Write the linux PTE atomically (setting busy) */
 	stdcx.	r30,0,r6
@@ -468,7 +468,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	 * go to out-of-line code to try to modify the HPTE. We look for
 	 * the bit at (1 >> (index + 32))
 	 */
-	andi.	r0,r31,_PAGE_HASHPTE
+	rldicl.	r0,r31,64-12,48
 	li	r26,0			/* Default hidx */
 	beq	htab_insert_pte
 
@@ -726,7 +726,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_P
 	 */
 	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
 	or	r30,r30,r31
-	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE
+	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED
 	/* Write the linux PTE atomically (setting busy) */
 	stdcx.	r30,0,r6
 	bne-	1b
@@ -794,17 +794,17 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* Check if we may already be in the hashtable, in this case, we
 	 * go to out-of-line code to try to modify the HPTE
 	 */
-	andi.	r0,r31,_PAGE_HASHPTE
+	rldicl.	r0,r31,64-12,48
 	bne	ht64_modify_pte
 
 ht64_insert_pte:
 	/* Clear hpte bits in new pte (we also clear BUSY btw) and
-	 * add _PAGE_HASHPTE
+	 * add _PAGE_HPTE_SUB0
 	 */
 	lis	r0,_PAGE_HPTEFLAGS@h
 	ori	r0,r0,_PAGE_HPTEFLAGS@l
 	andc	r30,r30,r0
-	ori	r30,r30,_PAGE_HASHPTE
+	oris	r30,r30,_PAGE_HPTE_SUB0@h
 
 	/* Phyical address in r5 */
 	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
Index: linux-work/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hugetlbpage.c	2008-05-29 12:16:25.000000000 +1000
+++ linux-work/arch/powerpc/mm/hugetlbpage.c	2008-05-29 12:18:51.000000000 +1000
@@ -458,8 +458,7 @@ int hash_huge_page(struct mm_struct *mm,
 		old_pte = pte_val(*ptep);
 		if (old_pte & _PAGE_BUSY)
 			goto out;
-		new_pte = old_pte | _PAGE_BUSY |
-			_PAGE_ACCESSED | _PAGE_HASHPTE;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
 					 old_pte, new_pte));
 
@@ -499,7 +498,7 @@ repeat:
 			      HPTES_PER_GROUP) & ~0x7UL;
 
 		/* clear HPTE slot informations in new PTE */
-		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
+		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HUGE_HPTE;
 
 		/* Add in WIMG bits */
 		/* XXX We should store these in the pte */
Index: linux-work/include/asm-powerpc/pgtable-4k.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pgtable-4k.h	2008-05-29 12:07:09.000000000 +1000
+++ linux-work/include/asm-powerpc/pgtable-4k.h	2008-05-29 12:17:36.000000000 +1000
@@ -41,6 +41,8 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 /* PTE bits */
+#define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
+#define _PAGE_HUGE_HPTE	_PAGE_HASHPTE
 #define _PAGE_SECONDARY 0x8000 /* software: HPTE is in secondary group */
 #define _PAGE_GROUP_IX  0x7000 /* software: HPTE index within group */
 #define _PAGE_F_SECOND  _PAGE_SECONDARY
Index: linux-work/include/asm-powerpc/pgtable-64k.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pgtable-64k.h	2008-05-29 12:06:37.000000000 +1000
+++ linux-work/include/asm-powerpc/pgtable-64k.h	2008-05-29 12:17:45.000000000 +1000
@@ -75,6 +75,21 @@ static inline struct subpage_prot_table 
 #define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
 
+/* For 64K page, we don't have a separate _PAGE_HASHPTE bit. Instead,
+ * we set that to be the whole sub-bits mask. The C code will only
+ * test this, so a multi-bit mask will work. For combo pages, this
+ * is equivalent as effectively, the old _PAGE_HASHPTE was an OR of
+ * all the sub bits. For real 64k pages, we now have the assembly set
+ * _PAGE_HPTE_SUB0 in addition to setting the HIDX bits which overlap
+ * that mask. This is fine as long as the HIDX bits are never set on
+ * a PTE that isn't hashed, which is the case today.
+ *
+ * A little nit is for the huge page C code, which does the hashing
+ * in C, we need to provide which bit to use.
+ */
+#define _PAGE_HASHPTE	_PAGE_HPTE_SUB
+#define _PAGE_HUGE_HPTE	_PAGE_HPTE_SUB0
+
 /* Note the full page bits must be in the same location as for normal
  * 4k pages as the same asssembly will be used to insert 64K pages
  * wether the kernel has CONFIG_PPC_64K_PAGES or not
@@ -83,8 +98,7 @@ static inline struct subpage_prot_table 
 #define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
 
 /* PTE flags to conserve for HPTE identification */
-#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_HPTE_SUB |\
-                         _PAGE_COMBO)
+#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)
 
 /* Shift to put page number into pte.
  *
Index: linux-work/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pgtable-ppc64.h	2008-05-29 12:06:55.000000000 +1000
+++ linux-work/include/asm-powerpc/pgtable-ppc64.h	2008-05-29 12:06:58.000000000 +1000
@@ -91,7 +91,6 @@
 #define _PAGE_DIRTY	0x0080 /* C: page changed */
 #define _PAGE_ACCESSED	0x0100 /* R: page referenced */
 #define _PAGE_RW	0x0200 /* software: user write access allowed */
-#define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */
 
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)

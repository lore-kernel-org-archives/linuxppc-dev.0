Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A71C1007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 15:56:09 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAR4r8KR020424
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 15:53:08 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAR4qYCm1552420
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 15:52:34 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAR4u6gj012841
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 15:56:07 +1100
Date: Fri, 27 Nov 2009 15:56:04 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Fix bug in pagetable cache cleanup with
	CONFIG_PPC_SUBPAGE_PROT (v2)
Message-ID: <20091127045604.GE3184@yookeroo>
References: <20091124053114.GD2737@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091124053114.GD2737@yookeroo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, stupid compile bug in the !CONFIG_PPC_SUBPAGE_PROT case with the
last version.  Fixed below.

Fix bug in pagetable cache cleanup with CONFIG_PPC_SUBPAGE_PROT

Commit a0668cdc154e54bf0c85182e0535eea237d53146 cleans up the handling
of kmem_caches for allocating various levels of pagetables.
Unfortunately, it conflicts badly with CONFIG_PPC_SUBPAGE_PROT, due to
the latter's cleverly hidden technique of adding some extra allocation
space to the top level page directory to store the extra information
it needs.

Since that extra allocation really doesn't fit into the cleaned up
page directory allocating scheme, this patch alters
CONFIG_PPC_SUBPAGE_PROT to instead allocate its struct
subpage_prot_table as part of the mm_context_t.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/mmu-hash64.h	2009-11-27 10:40:40.000000000 +1100
+++ working-2.6/arch/powerpc/include/asm/mmu-hash64.h	2009-11-27 15:54:27.423721648 +1100
@@ -373,6 +373,38 @@ extern void slb_set_size(u16 size);
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+/*
+ * For the sub-page protection option, we extend the PGD with one of
+ * these.  Basically we have a 3-level tree, with the top level being
+ * the protptrs array.  To optimize speed and memory consumption when
+ * only addresses < 4GB are being protected, pointers to the first
+ * four pages of sub-page protection words are stored in the low_prot
+ * array.
+ * Each page of sub-page protection words protects 1GB (4 bytes
+ * protects 64k).  For the 3-level tree, each page of pointers then
+ * protects 8TB.
+ */
+struct subpage_prot_table {
+	unsigned long maxaddr;	/* only addresses < this are protected */
+	unsigned int **protptrs[2];
+	unsigned int *low_prot[4];
+};
+
+#define SBP_L1_BITS		(PAGE_SHIFT - 2)
+#define SBP_L2_BITS		(PAGE_SHIFT - 3)
+#define SBP_L1_COUNT		(1 << SBP_L1_BITS)
+#define SBP_L2_COUNT		(1 << SBP_L2_BITS)
+#define SBP_L2_SHIFT		(PAGE_SHIFT + SBP_L1_BITS)
+#define SBP_L3_SHIFT		(SBP_L2_SHIFT + SBP_L2_BITS)
+
+extern void subpage_prot_free(struct mm_struct *mm);
+extern void subpage_prot_init_new_context(struct mm_struct *mm);
+#else
+static inline void subpage_prot_free(struct mm_struct *mm) {}
+static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+
 typedef unsigned long mm_context_id_t;
 
 typedef struct {
@@ -386,6 +418,9 @@ typedef struct {
 	u16 sllp;		/* SLB page size encoding */
 #endif
 	unsigned long vdso_base;
+#ifdef CONFIG_PPC_SUBPAGE_PROT
+	struct subpage_prot_table spt;
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
 } mm_context_t;
 
 
Index: working-2.6/arch/powerpc/include/asm/pgalloc-64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgalloc-64.h	2009-11-27 10:40:40.000000000 +1100
+++ working-2.6/arch/powerpc/include/asm/pgalloc-64.h	2009-11-27 10:55:00.654766147 +1100
@@ -28,10 +28,6 @@
  */
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
-#ifndef CONFIG_PPC_SUBPAGE_PROT
-static inline void subpage_prot_free(pgd_t *pgd) {}
-#endif
-
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) (pgtable_cache[(shift)-1])
 
@@ -42,7 +38,6 @@ static inline pgd_t *pgd_alloc(struct mm
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	subpage_prot_free(pgd);
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
Index: working-2.6/arch/powerpc/include/asm/pte-hash64-64k.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pte-hash64-64k.h	2009-11-17 11:55:00.000000000 +1100
+++ working-2.6/arch/powerpc/include/asm/pte-hash64-64k.h	2009-11-27 10:55:00.654766147 +1100
@@ -76,41 +76,4 @@
 	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
 
-
-#ifdef CONFIG_PPC_SUBPAGE_PROT
-/*
- * For the sub-page protection option, we extend the PGD with one of
- * these.  Basically we have a 3-level tree, with the top level being
- * the protptrs array.  To optimize speed and memory consumption when
- * only addresses < 4GB are being protected, pointers to the first
- * four pages of sub-page protection words are stored in the low_prot
- * array.
- * Each page of sub-page protection words protects 1GB (4 bytes
- * protects 64k).  For the 3-level tree, each page of pointers then
- * protects 8TB.
- */
-struct subpage_prot_table {
-	unsigned long maxaddr;	/* only addresses < this are protected */
-	unsigned int **protptrs[2];
-	unsigned int *low_prot[4];
-};
-
-#undef PGD_TABLE_SIZE
-#define PGD_TABLE_SIZE		((sizeof(pgd_t) << PGD_INDEX_SIZE) + \
-				 sizeof(struct subpage_prot_table))
-
-#define SBP_L1_BITS		(PAGE_SHIFT - 2)
-#define SBP_L2_BITS		(PAGE_SHIFT - 3)
-#define SBP_L1_COUNT		(1 << SBP_L1_BITS)
-#define SBP_L2_COUNT		(1 << SBP_L2_BITS)
-#define SBP_L2_SHIFT		(PAGE_SHIFT + SBP_L1_BITS)
-#define SBP_L3_SHIFT		(SBP_L2_SHIFT + SBP_L2_BITS)
-
-extern void subpage_prot_free(pgd_t *pgd);
-
-static inline struct subpage_prot_table *pgd_subpage_prot(pgd_t *pgd)
-{
-	return (struct subpage_prot_table *)(pgd + PTRS_PER_PGD);
-}
-#endif /* CONFIG_PPC_SUBPAGE_PROT */
 #endif	/* __ASSEMBLY__ */
Index: working-2.6/arch/powerpc/mm/subpage-prot.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/subpage-prot.c	2009-11-17 11:55:00.000000000 +1100
+++ working-2.6/arch/powerpc/mm/subpage-prot.c	2009-11-27 10:55:00.658768751 +1100
@@ -24,9 +24,9 @@
  * Also makes sure that the subpage_prot_table structure is
  * reinitialized for the next user.
  */
-void subpage_prot_free(pgd_t *pgd)
+void subpage_prot_free(struct mm_struct *mm)
 {
-	struct subpage_prot_table *spt = pgd_subpage_prot(pgd);
+	struct subpage_prot_table *spt = &mm->context.spt;
 	unsigned long i, j, addr;
 	u32 **p;
 
@@ -51,6 +51,13 @@ void subpage_prot_free(pgd_t *pgd)
 	spt->maxaddr = 0;
 }
 
+void subpage_prot_init_new_context(struct mm_struct *mm)
+{
+	struct subpage_prot_table *spt = &mm->context.spt;
+
+	memset(spt, 0, sizeof(*spt));
+}
+
 static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 			     int npages)
 {
@@ -87,7 +94,7 @@ static void hpte_flush_range(struct mm_s
 static void subpage_prot_clear(unsigned long addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = pgd_subpage_prot(mm->pgd);
+	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 **spm, *spp;
 	int i, nw;
 	unsigned long next, limit;
@@ -136,7 +143,7 @@ static void subpage_prot_clear(unsigned 
 long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
 {
 	struct mm_struct *mm = current->mm;
-	struct subpage_prot_table *spt = pgd_subpage_prot(mm->pgd);
+	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 **spm, *spp;
 	int i, nw;
 	unsigned long next, limit;
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2009-11-27 10:40:40.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2009-11-27 15:53:15.231721501 +1100
@@ -835,9 +835,9 @@ void demote_segment_4k(struct mm_struct 
  * Result is 0: full permissions, _PAGE_RW: read-only,
  * _PAGE_USER or _PAGE_USER|_PAGE_RW: no access.
  */
-static int subpage_protection(pgd_t *pgdir, unsigned long ea)
+static int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
-	struct subpage_prot_table *spt = pgd_subpage_prot(pgdir);
+	struct subpage_prot_table *spt = &mm->context.spt;
 	u32 spp = 0;
 	u32 **sbpm, *sbpp;
 
@@ -865,7 +865,7 @@ static int subpage_protection(pgd_t *pgd
 }
 
 #else /* CONFIG_PPC_SUBPAGE_PROT */
-static inline int subpage_protection(pgd_t *pgdir, unsigned long ea)
+static inline int subpage_protection(struct mm_struct *mm, unsigned long ea)
 {
 	return 0;
 }
Index: working-2.6/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mmu_context_hash64.c	2009-11-27 10:40:40.000000000 +1100
+++ working-2.6/arch/powerpc/mm/mmu_context_hash64.c	2009-11-27 10:55:00.658768751 +1100
@@ -76,6 +76,7 @@ int init_new_context(struct task_struct 
 	 */
 	if (slice_mm_new_context(mm))
 		slice_set_user_psize(mm, mmu_virtual_psize);
+	subpage_prot_init_new_context(mm);
 	mm->context.id = index;
 
 	return 0;
@@ -92,5 +93,6 @@ EXPORT_SYMBOL_GPL(__destroy_context);
 void destroy_context(struct mm_struct *mm)
 {
 	__destroy_context(mm->context.id);
+	subpage_prot_free(mm);
 	mm->context.id = NO_CONTEXT;
 }


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

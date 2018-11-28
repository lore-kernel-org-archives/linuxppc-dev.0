Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F996C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 12:11:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEC52086B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 12:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEC52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434fdq5NzRzDqf1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 23:11:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434f5103QgzDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:46:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 434f4w1YZtz9v0B0;
 Wed, 28 Nov 2018 12:46:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9SnlK3ArDwrm; Wed, 28 Nov 2018 12:46:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 434f4w0zsfz9v09s;
 Wed, 28 Nov 2018 12:46:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F3998B867;
 Wed, 28 Nov 2018 12:46:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id v6917-zElBev; Wed, 28 Nov 2018 12:46:41 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0376D8B853;
 Wed, 28 Nov 2018 12:46:41 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D88D069B1B; Wed, 28 Nov 2018 11:46:37 +0000 (UTC)
Message-Id: <d188d49b3a5279fd49e69eb00f23936f33e05d29.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 08/16] powerpc/mm: Extend pte_fragment functionality to
 PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 28 Nov 2018 11:46:37 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to allow the 8xx to handle pte_fragments, this patch
extends the use of pte_fragments to PPC32 platforms.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  5 ++++-
 arch/powerpc/include/asm/book3s/32/pgalloc.h  | 18 ++++++++++--------
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  5 +++--
 arch/powerpc/include/asm/mmu_context.h        |  2 +-
 arch/powerpc/include/asm/nohash/32/mmu.h      |  4 +++-
 arch/powerpc/include/asm/nohash/32/pgalloc.h  | 23 ++++++++++++-----------
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  8 +++++---
 arch/powerpc/mm/Makefile                      |  1 +
 arch/powerpc/mm/mmu_context.c                 | 10 ++++++++++
 arch/powerpc/mm/mmu_context_nohash.c          |  2 +-
 arch/powerpc/mm/pgtable_32.c                  | 25 ++++---------------------
 11 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 5bd26c218b94..2bb500d25de6 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_POWERPC_BOOK3S_32_MMU_HASH_H_
 #define _ASM_POWERPC_BOOK3S_32_MMU_HASH_H_
+
 /*
  * 32-bit hash table MMU support
  */
@@ -9,6 +10,8 @@
  * BATs
  */
 
+#include <asm/page.h>
+
 /* Block size masks */
 #define BL_128K	0x000
 #define BL_256K 0x001
@@ -43,7 +46,7 @@ struct ppc_bat {
 	u32 batl;
 };
 
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index a70f3cf16dc8..56e805107352 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -27,6 +27,10 @@ extern void __bad_pte(pmd_t *pmd);
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
+void pte_frag_destroy(void *pte_frag);
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel);
+void pte_fragment_free(unsigned long *table, int kernel);
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -56,30 +60,28 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_PRESENT);
+	*pmdp = __pmd(__pa(pte_page) | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
-		pgtable_page_dtor(virt_to_page(table));
-		free_page((unsigned long)table);
+		pte_fragment_free((unsigned long *)table, 0);
 	} else {
 		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(index_size), table);
@@ -117,6 +119,6 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	pgtable_free_tlb(tlb, table, 0);
 }
 #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 32c33eccc0e2..47156b93f9af 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -329,7 +329,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long)__va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 
@@ -346,7 +346,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define pte_offset_kernel(dir, addr)	\
 	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
 #define pte_offset_map(dir, addr)		\
-	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
+	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
+		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
 #define pte_unmap(pte)		kunmap_atomic(pte)
 
 /*
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 0381394a425b..c05efd2e8736 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -223,7 +223,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
-#ifndef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BOOK3E_64
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
index f61f933a4cd8..7d94a36d57d2 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
 #define _ASM_POWERPC_NOHASH_32_MMU_H_
 
+#include <asm/page.h>
+
 #if defined(CONFIG_40x)
 /* 40x-style software loaded TLB */
 #include <asm/nohash/32/mmu-40x.h>
@@ -17,7 +19,7 @@
 #endif
 
 #ifndef __ASSEMBLY__
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 #endif
 
 #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6fbbb90043c0..7b8d0a3ab0fd 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -27,6 +27,10 @@ extern void __bad_pte(pmd_t *pmd);
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
+void pte_frag_destroy(void *pte_frag);
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel);
+void pte_fragment_free(unsigned long *table, int kernel);
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -58,11 +62,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
-		      _PMD_PRESENT);
+	*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #else
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
@@ -74,10 +77,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
+	*pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
@@ -85,20 +88,18 @@ extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
-		pgtable_page_dtor(virt_to_page(table));
-		free_page((unsigned long)table);
+		pte_fragment_free((unsigned long *)table, 0);
 	} else {
 		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(index_size), table);
@@ -137,6 +138,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	pgtable_free_tlb(tlb, table, 0);
 }
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 3ffb0ff5a038..31a03e9a42c4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -20,6 +20,7 @@ extern int icache_44x_need_flush;
 #endif /* __ASSEMBLY__ */
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
+
 #define PMD_INDEX_SIZE	0
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
@@ -333,12 +334,12 @@ static inline int pte_young(pte_t pte)
  */
 #ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+	((unsigned long)__va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_vaddr(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
+	((unsigned long)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_page(pmd)		\
 	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 #endif
@@ -357,7 +358,8 @@ static inline int pte_young(pte_t pte)
 	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
 				  pte_index(addr))
 #define pte_offset_map(dir, addr)		\
-	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
+	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
+		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
 #define pte_unmap(pte)		kunmap_atomic(pte)
 
 /*
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3cbb1acf0745..c8778a640d68 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
 				   $(hash64-y) mmu_context_book3s64.o \
 				   pgtable-book3s64.o pgtable-frag.o
+obj-$(CONFIG_PPC32)		+= pgtable-frag.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index f84e14f23e50..bb52320b7369 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -15,6 +15,7 @@
 #include <linux/sched/mm.h>
 
 #include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
 
 #if defined(CONFIG_PPC32)
 static inline void switch_mm_pgdir(struct task_struct *tsk,
@@ -97,3 +98,12 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	switch_mmu_context(prev, next, tsk);
 }
 
+#ifdef CONFIG_PPC32
+void arch_exit_mmap(struct mm_struct *mm)
+{
+	void *frag = pte_frag_get(&mm->context);
+
+	if (frag)
+		pte_frag_destroy(frag);
+}
+#endif
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 2faca46ad720..431ecf37f17c 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -385,6 +385,7 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 #endif
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
+	pte_frag_set(&mm->context, NULL);
 	return 0;
 }
 
@@ -487,4 +488,3 @@ void __init mmu_context_init(void)
 	next_context = FIRST_CONTEXT;
 	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
 }
-
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bda3c6f1bd32..deb49a6e9cad 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -45,32 +45,15 @@ extern char etext[], _stext[], _sinittext[], _einittext[];
 
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
+	if (!slab_is_available())
+		return memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
-	if (slab_is_available()) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	} else {
-		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-		if (pte)
-			clear_page(pte);
-	}
-	return pte;
+	return (pte_t *)pte_fragment_alloc(mm, address, 1);
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	struct page *ptepage;
-
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
+	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
 
 void __iomem *
-- 
2.13.3


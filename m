Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66E77DE6C7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:54:05 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Date: Thu, 11 Sep 2008 01:53:06 +0400
Message-Id: <1221083587-8091-2-git-send-email-yanok@emcraft.com>
In-Reply-To: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for page sizes bigger than 4KB (16KB/64KB/256KB) on
PPC 44x.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig                    |   23 +++++++++
 arch/powerpc/include/asm/highmem.h      |    8 +++-
 arch/powerpc/include/asm/page.h         |   26 +++++++++-
 arch/powerpc/include/asm/page_32.h      |    4 ++
 arch/powerpc/include/asm/ppc_page_asm.h |   75 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h  |    4 ++
 arch/powerpc/kernel/head_44x.S          |   21 +++++---
 arch/powerpc/kernel/head_booke.h        |    7 ++-
 arch/powerpc/kernel/misc_32.S           |   13 +++---
 arch/powerpc/mm/pgtable_32.c            |    2 +-
 10 files changed, 162 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ppc_page_asm.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 587da5e..ca93157 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -413,6 +413,29 @@ config PPC_64K_PAGES
 	  while on hardware with such support, it will be used to map
 	  normal application pages.
 
+choice
+	prompt "Page size"
+	depends on 44x && PPC32
+	default PPC32_4K_PAGES
+	help
+	  The PAGE_SIZE definition. Increasing the page size may
+	  improve the system performance in some dedicated cases.
+	  If unsure, set it to 4 KB.
+
+config PPC32_4K_PAGES
+	bool "4k page size"
+
+config PPC32_16K_PAGES
+	bool "16k page size"
+
+config PPC32_64K_PAGES
+	bool "64k page size"
+
+config PPC32_256K_PAGES
+	bool "256k page size"
+
+endchoice
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	default "9" if PPC_64K_PAGES
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 5d99b64..1aec96d 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -38,9 +38,15 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
+#if defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC32_256K_PAGES)
+#define PKMAP_ORDER	(27 - PAGE_SHIFT)
+#define LAST_PKMAP	(1 << PKMAP_ORDER)
+#define PKMAP_BASE	(FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
+#else
 #define LAST_PKMAP 	(1 << PTE_SHIFT)
-#define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_BASE	((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK)
+#endif
+#define LAST_PKMAP_MASK	(LAST_PKMAP-1)
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e088545..1de90b4 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -15,12 +15,17 @@
 #include <asm/types.h>
 
 /*
- * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
+ * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
+ * on PPC44x). For PPC64 we support either 4K or 64K software
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#ifdef CONFIG_PPC_64K_PAGES
+#if defined(CONFIG_PPC32_256K_PAGES)
+#define PAGE_SHIFT		18
+#elif defined(CONFIG_PPC32_64K_PAGES) || defined(CONFIG_PPC_64K_PAGES)
 #define PAGE_SHIFT		16
+#elif defined(CONFIG_PPC32_16K_PAGES)
+#define PAGE_SHIFT		14
 #else
 #define PAGE_SHIFT		12
 #endif
@@ -140,11 +145,19 @@ typedef struct { pte_basic_t pte; } pte_t;
 /* 64k pages additionally define a bigger "real PTE" type that gathers
  * the "second half" part of the PTE for pseudo 64k pages
  */
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_64K_PAGES
 typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
 #endif
+#else
+#ifdef CONFIG_PPC32_4K_PAGES
+typedef struct { pte_t pte; } real_pte_t;
+#else
+typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+#endif
+#endif /* !CONFIG_PPC64 */
 
 /* PMD level */
 #ifdef CONFIG_PPC64
@@ -180,12 +193,19 @@ typedef pte_basic_t pte_t;
 #define pte_val(x)	(x)
 #define __pte(x)	(x)
 
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_PPC_64K_PAGES
 typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
 #else
 typedef unsigned long real_pte_t;
 #endif
-
+#else
+#ifdef CONFIG_PPC32_4K_PAGES
+typedef unsigned long real_pte_t;
+#else
+typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
+#endif
+#endif /* !PPC64 */
 
 #ifdef CONFIG_PPC64
 typedef unsigned long pmd_t;
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index ebfae53..d176270 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -20,7 +20,11 @@
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
+#ifdef CONFIG_PPC32_256K_PAGES
+#define PTE_SHIFT	(PAGE_SHIFT - 7)
+#else
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
+#endif
 #else
 typedef unsigned long pte_basic_t;
 #define PTE_SHIFT	(PAGE_SHIFT - 2)	/* 1024 ptes per page */
diff --git a/arch/powerpc/include/asm/ppc_page_asm.h b/arch/powerpc/include/asm/ppc_page_asm.h
new file mode 100644
index 0000000..e1250fa
--- /dev/null
+++ b/arch/powerpc/include/asm/ppc_page_asm.h
@@ -0,0 +1,75 @@
+/*
+ * arch/powerpc/include/asm/ppc_page_asm.h
+ *
+ * 2007 (C) DENX Software Engineering.
+ *
+ *  This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ *
+ *  The page definitions used in the asm files ppc_44x.S and misc.S.
+ * PAGE_SIZE = 4K and 64K are only supported on the PPC44x.
+ *
+ */
+#ifndef PPC_PAGE_ASM_H
+#define PPC_PAGE_ASM_H
+
+#include <asm/page.h>
+
+#if (PAGE_SHIFT == 12)
+/*
+ * PAGE_SIZE  4K
+ * PAGE_SHIFT 12
+ * PTE_SHIFT   9
+ * PMD_SHIFT  21
+ */
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
+#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 14)
+/*
+ * PAGE_SIZE  16K
+ * PAGE_SHIFT 14
+ * PTE_SHIFT  11
+ * PMD_SHIFT  25
+ */
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
+#define PPC44x_PGD_OFF_SH	9  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	23 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	21 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	18 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		17 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 16)
+/*
+ * PAGE_SIZE  64K
+ * PAGE_SHIFT 16
+ * PTE_SHIFT  13
+ * PMD_SHIFT  29
+ */
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
+#define PPC44x_PGD_OFF_SH	5  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	27 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	19 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	16 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		15 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 18)
+/*
+ * PAGE_SIZE  256K
+ * PAGE_SHIFT 18
+ * PTE_SHIFT  11
+ * PMD_SHIFT  29
+ */
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
+#define PPC44x_PGD_OFF_SH	5  /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	27 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	17 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	18 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		13 /*31 - PAGE_SHIFT*/
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 9665a26..4e7cd1f 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -15,8 +15,12 @@
 #ifdef CONFIG_PPC64
 #define THREAD_SHIFT		14
 #else
+#if defined(CONFIG_PPC32_256K_PAGES)
+#define THREAD_SHIFT		15
+#else
 #define THREAD_SHIFT		13
 #endif
+#endif
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index f3a1ea9..c0a99a4 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -36,6 +36,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/ppc_page_asm.h>
 #include "head_booke.h"
 
 
@@ -391,12 +392,14 @@ interrupt_base:
 	rlwimi	r13,r12,10,30,30
 
 	/* Load the PTE */
-	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
+	/* Compute pgdir/pmd offset */
+	rlwinm  r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
+	/* Compute pte address */
+	rlwimi  r12, r10, PPC44x_PTE_ADD_SH, PPC44x_PTE_ADD_M1, 28
 	lwz	r11, 0(r12)		/* Get high word of pte entry */
 	lwz	r12, 4(r12)		/* Get low word of pte entry */
 
@@ -485,12 +488,14 @@ tlb_44x_patch_hwater_D:
 	/* Make up the required permissions */
 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
 
-	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
+	/* Compute pgdir/pmd offset */
+	rlwinm 	r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
+	/* Compute pte address */
+	rlwimi	r12, r10, PPC44x_PTE_ADD_SH, PPC44x_PTE_ADD_M1, 28
 	lwz	r11, 0(r12)		/* Get high word of pte entry */
 	lwz	r12, 4(r12)		/* Get low word of pte entry */
 
@@ -554,14 +559,14 @@ tlb_44x_patch_hwater_I:
  */
 finish_tlb_load:
 	/* Combine RPN & ERPN an write WS 0 */
-	rlwimi	r11,r12,0,0,19
+	rlwimi	r11,r12,0,0,PPC44x_RPN_M2
 	tlbwe	r11,r13,PPC44x_TLB_XLAT
 
 	/*
 	 * Create WS1. This is the faulting address (EPN),
 	 * page size, and valid flag.
 	 */
-	li	r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
+	li	r11,PPC44x_TLB_VALID | PPC44x_TLBE_SIZE
 	rlwimi	r10,r11,0,20,31			/* Insert valid and page size*/
 	tlbwe	r10,r13,PPC44x_TLB_PAGEID	/* Write PAGEID */
 
@@ -634,12 +639,12 @@ _GLOBAL(set_context)
  * goes at the beginning of the data segment, which is page-aligned.
  */
 	.data
-	.align	12
+	.align	PAGE_SHIFT
 	.globl	sdata
 sdata:
 	.globl	empty_zero_page
 empty_zero_page:
-	.space	4096
+	.space	PAGE_SIZE
 
 /*
  * To support >32-bit physical addresses, we use an 8KB pgdir.
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index fce2df9..4f802df 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -20,7 +20,9 @@
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
+	lis	r11,THREAD_SIZE@h;					     \
+	ori	r11,r11,THREAD_SIZE@l;					     \
+	add	r1,r1,r11;						     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
@@ -112,7 +114,8 @@
 	andi.	r10,r10,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
+	addis	r11,r11,EXC_LVL_FRAME_OVERHEAD@ha; /* allocate stack frame */\
+	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD@l;  /* allocate stack frame */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	stw	r9,_CCR(r11);		/* save CR			   */\
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7a6dfbc..97463ba 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -29,6 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/kexec.h>
+#include <asm/ppc_page_asm.h>
 
 	.text
 
@@ -589,8 +590,8 @@ _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
 	blr
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
+	rlwinm	r3,r3,0,0,PPC44x_RPN_M2		/* Get page base address */
+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
 0:	dcbst	0,r3				/* Write line to ram */
@@ -630,8 +631,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
 	isync
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
+	rlwinm	r3,r3,0,0,PPC44x_RPN_M2		/* Get page base address */
+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
 0:	dcbst	0,r3				/* Write line to ram */
@@ -655,7 +656,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
  * void clear_pages(void *page, int order) ;
  */
 _GLOBAL(clear_pages)
-	li	r0,4096/L1_CACHE_BYTES
+	li	r0,PAGE_SIZE/L1_CACHE_BYTES
 	slw	r0,r0,r4
 	mtctr	r0
 #ifdef CONFIG_8xx
@@ -713,7 +714,7 @@ _GLOBAL(copy_page)
 	dcbt	r5,r4
 	li	r11,L1_CACHE_BYTES+4
 #endif /* MAX_COPY_PREFETCH */
-	li	r0,4096/L1_CACHE_BYTES - MAX_COPY_PREFETCH
+	li	r0,PAGE_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
 	crclr	4*cr0+eq
 2:
 	mtctr	r0
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2001abd..efaf46a 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -400,7 +400,7 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 static int fixmaps;
-unsigned long FIXADDR_TOP = 0xfffff000;
+unsigned long FIXADDR_TOP = (-PAGE_SIZE);
 EXPORT_SYMBOL(FIXADDR_TOP);
 
 void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
-- 
1.5.6.1

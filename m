Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B3E6DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 06:56:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBHJtObV002145
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 14:55:24 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBHJuFUV184028
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 14:56:15 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBHJuE46032578
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 14:56:15 -0500
Date: Wed, 17 Dec 2008 14:56:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
Message-ID: <20081217195607.GE3049@localhost.localdomain>
References: <49406F61.2000004@emcraft.com>
	<1228960541-11407-1-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228960541-11407-1-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Vladimir Panfilov <pvr@emcraft.com>, wd@denx.de,
	dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 04:55:41AM +0300, Ilya Yanok wrote:
>This patch adds support for page sizes bigger than 4K (16K/64K) on
>PPC 44x.
>PGDIR table is much smaller than page in case of 16K/64K pages (512
>and 32 bytes resp.) so we allocate PGDIR with kzalloc() instead of
>__get_free_pages().
>PTE table covers rather big memory area in case of 16K/64K pages
>(32MB and 512MB resp.) so we can easily put FIXMAP and PKMAP in
>area covered by one PTE table.
>
>Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>Signed-off-by: Vladimir Panfilov <pvr@emcraft.com>
>Signed-off-by: Ilya Yanok <yanok@emcraft.com>

I tested this a bit today on a Bamboo board.  Overall, it functioned
well enough to not crash :).  Note that I also included Hollis'
memory size alignment patch which is required.

The code looks pretty clean now.  I think if we're going to include
this patch it should go in now.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
> arch/powerpc/Kconfig                   |   58 ++++++++++++++++++++++++--------
> arch/powerpc/include/asm/highmem.h     |   19 +++++++++-
> arch/powerpc/include/asm/mmu-44x.h     |   17 +++++++++
> arch/powerpc/include/asm/page.h        |   13 ++++---
> arch/powerpc/include/asm/page_32.h     |    7 +++-
> arch/powerpc/kernel/asm-offsets.c      |    4 ++
> arch/powerpc/kernel/head_44x.S         |   23 ++++++++-----
> arch/powerpc/kernel/misc_32.S          |   12 +++---
> arch/powerpc/mm/pgtable_32.c           |   23 ++++++++-----
> arch/powerpc/platforms/Kconfig.cputype |    2 +-
> 10 files changed, 130 insertions(+), 48 deletions(-)
>
>diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>index 525c13a..cd8ff7c 100644
>--- a/arch/powerpc/Kconfig
>+++ b/arch/powerpc/Kconfig
>@@ -401,23 +401,53 @@ config PPC_HAS_HASH_64K
> 	depends on PPC64
> 	default n
>
>-config PPC_64K_PAGES
>-	bool "64k page size"
>-	depends on PPC64
>-	select PPC_HAS_HASH_64K
>+choice
>+	prompt "Page size"
>+	default PPC_4K_PAGES
> 	help
>-	  This option changes the kernel logical page size to 64k. On machines
>-	  without processor support for 64k pages, the kernel will simulate
>-	  them by loading each individual 4k page on demand transparently,
>-	  while on hardware with such support, it will be used to map
>-	  normal application pages.
>+	  Select the kernel logical page size. Increasing the page size
>+	  will reduce software overhead at each page boundary, allow
>+	  hardware prefetch mechanisms to be more effective, and allow
>+	  larger dma transfers increasing IO efficiency and reducing
>+	  overhead. However the utilization of memory will increase.
>+	  For example, each cached file will using a multiple of the
>+	  page size to hold its contents and the difference between the
>+	  end of file and the end of page is wasted.
>+
>+	  Some dedicated systems, such as software raid serving with
>+	  accelerated calculations, have shown significant increases.
>+
>+	  If you configure a 64 bit kernel for 64k pages but the
>+	  processor does not support them, then the kernel will simulate
>+	  them with 4k pages, loading them on demand, but with the
>+	  reduced software overhead and larger internal fragmentation.
>+	  For the 32 bit kernel, a large page option will not be offered
>+	  unless it is supported by the configured processor.
>+
>+	  If unsure, choose 4K_PAGES.
>+
>+config PPC_4K_PAGES
>+	bool "4k page size"
>+
>+config PPC_16K_PAGES
>+	bool "16k page size" if 44x
>+
>+config PPC_64K_PAGES
>+	bool "64k page size" if 44x || PPC_STD_MMU_64
>+	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
>+
>+endchoice
>
> config FORCE_MAX_ZONEORDER
> 	int "Maximum zone order"
>-	range 9 64 if PPC_64K_PAGES
>-	default "9" if PPC_64K_PAGES
>-	range 13 64 if PPC64 && !PPC_64K_PAGES
>-	default "13" if PPC64 && !PPC_64K_PAGES
>+	range 9 64 if PPC_STD_MMU_64 && PPC_64K_PAGES
>+	default "9" if PPC_STD_MMU_64 && PPC_64K_PAGES
>+	range 13 64 if PPC_STD_MMU_64 && !PPC_64K_PAGES
>+	default "13" if PPC_STD_MMU_64 && !PPC_64K_PAGES
>+	range 9 64 if PPC_STD_MMU_32 && PPC_16K_PAGES
>+	default "9" if PPC_STD_MMU_32 && PPC_16K_PAGES
>+	range 7 64 if PPC_STD_MMU_32 && PPC_64K_PAGES
>+	default "7" if PPC_STD_MMU_32 && PPC_64K_PAGES
> 	range 11 64
> 	default "11"
> 	help
>@@ -437,7 +467,7 @@ config FORCE_MAX_ZONEORDER
>
> config PPC_SUBPAGE_PROT
> 	bool "Support setting protections for 4k subpages"
>-	depends on PPC_64K_PAGES
>+	depends on PPC_STD_MMU_64 && PPC_64K_PAGES
> 	help
> 	  This option adds support for a system call to allow user programs
> 	  to set access permissions (read/write, readonly, or no access)
>diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
>index 91c5895..7d6bb37 100644
>--- a/arch/powerpc/include/asm/highmem.h
>+++ b/arch/powerpc/include/asm/highmem.h
>@@ -38,9 +38,24 @@ extern pte_t *pkmap_page_table;
>  * easily, subsequent pte tables have to be allocated in one physical
>  * chunk of RAM.
>  */
>-#define LAST_PKMAP 	(1 << PTE_SHIFT)
>-#define LAST_PKMAP_MASK (LAST_PKMAP-1)
>+/*
>+ * We use one full pte table with 4K pages. And with 16K/64K pages pte
>+ * table covers enough memory (32MB and 512MB resp.) that both FIXMAP
>+ * and PKMAP can be placed in single pte table. We use 1024 pages for
>+ * PKMAP in case of 16K/64K pages.
>+ */
>+#ifdef CONFIG_PPC_4K_PAGES
>+#define PKMAP_ORDER	PTE_SHIFT
>+#else
>+#define PKMAP_ORDER	10
>+#endif
>+#define LAST_PKMAP	(1 << PKMAP_ORDER)
>+#ifndef CONFIG_PPC_4K_PAGES
>+#define PKMAP_BASE	(FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
>+#else
> #define PKMAP_BASE	((FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK)
>+#endif
>+#define LAST_PKMAP_MASK	(LAST_PKMAP-1)
> #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
> #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
>
>diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
>index a825524..73e1909 100644
>--- a/arch/powerpc/include/asm/mmu-44x.h
>+++ b/arch/powerpc/include/asm/mmu-44x.h
>@@ -4,6 +4,8 @@
>  * PPC440 support
>  */
>
>+#include <asm/page.h>
>+
> #define PPC44x_MMUCR_TID	0x000000ff
> #define PPC44x_MMUCR_STS	0x00010000
>
>@@ -73,4 +75,19 @@ typedef struct {
> /* Size of the TLBs used for pinning in lowmem */
> #define PPC_PIN_SIZE	(1 << 28)	/* 256M */
>
>+#if (PAGE_SHIFT == 12)
>+#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
>+#elif (PAGE_SHIFT == 14)
>+#define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
>+#elif (PAGE_SHIFT == 16)
>+#define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
>+#else
>+#error "Unsupported PAGE_SIZE"
>+#endif
>+
>+#define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
>+#define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
>+#define PPC44x_PTE_ADD_SHIFT	(32 - PGDIR_SHIFT + PTE_SHIFT + PTE_T_LOG2)
>+#define PPC44x_PTE_ADD_MASK_BIT	(32 - PTE_T_LOG2 - PTE_SHIFT)
>+
> #endif /* _ASM_POWERPC_MMU_44X_H_ */
>diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>index c0b8d4a..197d569 100644
>--- a/arch/powerpc/include/asm/page.h
>+++ b/arch/powerpc/include/asm/page.h
>@@ -19,12 +19,15 @@
> #include <asm/kdump.h>
>
> /*
>- * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
>+ * On regular PPC32 page size is 4K (but we support 4K/16K/64K pages
>+ * on PPC44x). For PPC64 we support either 4K or 64K software
>  * page size. When using 64K pages however, whether we are really supporting
>  * 64K pages in HW or not is irrelevant to those definitions.
>  */
>-#ifdef CONFIG_PPC_64K_PAGES
>+#if defined(CONFIG_PPC_64K_PAGES)
> #define PAGE_SHIFT		16
>+#elif defined(CONFIG_PPC_16K_PAGES)
>+#define PAGE_SHIFT		14
> #else
> #define PAGE_SHIFT		12
> #endif
>@@ -151,7 +154,7 @@ typedef struct { pte_basic_t pte; } pte_t;
> /* 64k pages additionally define a bigger "real PTE" type that gathers
>  * the "second half" part of the PTE for pseudo 64k pages
>  */
>-#ifdef CONFIG_PPC_64K_PAGES
>+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
> typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
> #else
> typedef struct { pte_t pte; } real_pte_t;
>@@ -191,10 +194,10 @@ typedef pte_basic_t pte_t;
> #define pte_val(x)	(x)
> #define __pte(x)	(x)
>
>-#ifdef CONFIG_PPC_64K_PAGES
>+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
> typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
> #else
>-typedef unsigned long real_pte_t;
>+typedef pte_t real_pte_t;
> #endif
>
>
>diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>index d77072a..1458d95 100644
>--- a/arch/powerpc/include/asm/page_32.h
>+++ b/arch/powerpc/include/asm/page_32.h
>@@ -19,6 +19,8 @@
> #define PTE_FLAGS_OFFSET	0
> #endif
>
>+#define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2)	/* full page */
>+
> #ifndef __ASSEMBLY__
> /*
>  * The basic type of a PTE - 64 bits for those CPUs with > 32 bit
>@@ -26,10 +28,8 @@
>  */
> #ifdef CONFIG_PTE_64BIT
> typedef unsigned long long pte_basic_t;
>-#define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
> #else
> typedef unsigned long pte_basic_t;
>-#define PTE_SHIFT	(PAGE_SHIFT - 2)	/* 1024 ptes per page */
> #endif
>
> struct page;
>@@ -39,6 +39,9 @@ extern void copy_page(void *to, void *from);
>
> #include <asm-generic/page.h>
>
>+#define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
>+#define PTE_T_LOG2	(__builtin_ffs(sizeof(pte_t)) - 1)
>+
> #endif /* __ASSEMBLY__ */
>
> #endif /* _ASM_POWERPC_PAGE_32_H */
>diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
>index 75c5dd0..0142318 100644
>--- a/arch/powerpc/kernel/asm-offsets.c
>+++ b/arch/powerpc/kernel/asm-offsets.c
>@@ -378,6 +378,10 @@ int main(void)
> 	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
> 	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
> #endif
>+#ifdef CONFIG_44x
>+	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
>+	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
>+#endif
>
> 	return 0;
> }
>diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
>index f3a1ea9..3bf6bd1 100644
>--- a/arch/powerpc/kernel/head_44x.S
>+++ b/arch/powerpc/kernel/head_44x.S
>@@ -391,12 +391,14 @@ interrupt_base:
> 	rlwimi	r13,r12,10,30,30
>
> 	/* Load the PTE */
>-	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
>+	/* Compute pgdir/pmd offset */
>+	rlwinm  r12, r10, PPC44x_PGD_OFF_SHIFT, PPC44x_PGD_OFF_MASK_BIT, 29
> 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
> 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
> 	beq	2f			/* Bail if no table */
>
>-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
>+	/* Compute pte address */
>+	rlwimi  r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK_BIT, 28
> 	lwz	r11, 0(r12)		/* Get high word of pte entry */
> 	lwz	r12, 4(r12)		/* Get low word of pte entry */
>
>@@ -485,12 +487,14 @@ tlb_44x_patch_hwater_D:
> 	/* Make up the required permissions */
> 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_HWEXEC
>
>-	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
>+	/* Compute pgdir/pmd offset */
>+	rlwinm 	r12, r10, PPC44x_PGD_OFF_SHIFT, PPC44x_PGD_OFF_MASK_BIT, 29
> 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
> 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
> 	beq	2f			/* Bail if no table */
>
>-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
>+	/* Compute pte address */
>+	rlwimi	r12, r10, PPC44x_PTE_ADD_SHIFT, PPC44x_PTE_ADD_MASK_BIT, 28
> 	lwz	r11, 0(r12)		/* Get high word of pte entry */
> 	lwz	r12, 4(r12)		/* Get low word of pte entry */
>
>@@ -554,15 +558,16 @@ tlb_44x_patch_hwater_I:
>  */
> finish_tlb_load:
> 	/* Combine RPN & ERPN an write WS 0 */
>-	rlwimi	r11,r12,0,0,19
>+	rlwimi	r11,r12,0,0,31-PAGE_SHIFT
> 	tlbwe	r11,r13,PPC44x_TLB_XLAT
>
> 	/*
> 	 * Create WS1. This is the faulting address (EPN),
> 	 * page size, and valid flag.
> 	 */
>-	li	r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
>-	rlwimi	r10,r11,0,20,31			/* Insert valid and page size*/
>+	li	r11,PPC44x_TLB_VALID | PPC44x_TLBE_SIZE
>+	/* Insert valid and page size */
>+	rlwimi	r10,r11,0,PPC44x_PTE_ADD_MASK_BIT,31
> 	tlbwe	r10,r13,PPC44x_TLB_PAGEID	/* Write PAGEID */
>
> 	/* And WS 2 */
>@@ -634,12 +639,12 @@ _GLOBAL(set_context)
>  * goes at the beginning of the data segment, which is page-aligned.
>  */
> 	.data
>-	.align	12
>+	.align	PAGE_SHIFT
> 	.globl	sdata
> sdata:
> 	.globl	empty_zero_page
> empty_zero_page:
>-	.space	4096
>+	.space	PAGE_SIZE
>
> /*
>  * To support >32-bit physical addresses, we use an 8KB pgdir.
>diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
>index bdc8b0e..950b708 100644
>--- a/arch/powerpc/kernel/misc_32.S
>+++ b/arch/powerpc/kernel/misc_32.S
>@@ -647,8 +647,8 @@ _GLOBAL(__flush_dcache_icache)
> BEGIN_FTR_SECTION
> 	blr
> END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>-	rlwinm	r3,r3,0,0,19			/* Get page base address */
>-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
>+	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address */
>+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
> 	mtctr	r4
> 	mr	r6,r3
> 0:	dcbst	0,r3				/* Write line to ram */
>@@ -688,8 +688,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> 	rlwinm	r0,r10,0,28,26			/* clear DR */
> 	mtmsr	r0
> 	isync
>-	rlwinm	r3,r3,0,0,19			/* Get page base address */
>-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
>+	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address */
>+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
> 	mtctr	r4
> 	mr	r6,r3
> 0:	dcbst	0,r3				/* Write line to ram */
>@@ -713,7 +713,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  * void clear_pages(void *page, int order) ;
>  */
> _GLOBAL(clear_pages)
>-	li	r0,4096/L1_CACHE_BYTES
>+	li	r0,PAGE_SIZE/L1_CACHE_BYTES
> 	slw	r0,r0,r4
> 	mtctr	r0
> #ifdef CONFIG_8xx
>@@ -771,7 +771,7 @@ _GLOBAL(copy_page)
> 	dcbt	r5,r4
> 	li	r11,L1_CACHE_BYTES+4
> #endif /* MAX_COPY_PREFETCH */
>-	li	r0,4096/L1_CACHE_BYTES - MAX_COPY_PREFETCH
>+	li	r0,PAGE_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
> 	crclr	4*cr0+eq
> 2:
> 	mtctr	r0
>diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>index c31d6d2..f966a5e 100644
>--- a/arch/powerpc/mm/pgtable_32.c
>+++ b/arch/powerpc/mm/pgtable_32.c
>@@ -72,24 +72,29 @@ extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
> #define p_mapped_by_tlbcam(x)	(0UL)
> #endif /* HAVE_TLBCAM */
>
>-#ifdef CONFIG_PTE_64BIT
>-/* Some processors use an 8kB pgdir because they have 8-byte Linux PTEs. */
>-#define PGDIR_ORDER	1
>-#else
>-#define PGDIR_ORDER	0
>-#endif
>+#define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
>
> pgd_t *pgd_alloc(struct mm_struct *mm)
> {
> 	pgd_t *ret;
>
>-	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, PGDIR_ORDER);
>+	/* pgdir take page or two with 4K pages and a page fraction otherwise */
>+#ifndef CONFIG_PPC_4K_PAGES
>+	ret = (pgd_t *)kzalloc(1 << PGDIR_ORDER, GFP_KERNEL);
>+#else
>+	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO,
>+			PGDIR_ORDER - PAGE_SHIFT);
>+#endif
> 	return ret;
> }
>
> void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> {
>-	free_pages((unsigned long)pgd, PGDIR_ORDER);
>+#ifndef CONFIG_PPC_4K_PAGES
>+	kfree((void *)pgd);
>+#else
>+	free_pages((unsigned long)pgd, PGDIR_ORDER - PAGE_SHIFT);
>+#endif
> }
>
> __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
>@@ -400,7 +405,7 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
> #endif /* CONFIG_DEBUG_PAGEALLOC */
>
> static int fixmaps;
>-unsigned long FIXADDR_TOP = 0xfffff000;
>+unsigned long FIXADDR_TOP = (-PAGE_SIZE);
> EXPORT_SYMBOL(FIXADDR_TOP);
>
> void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
>diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>index 548efa5..51098bc 100644
>--- a/arch/powerpc/platforms/Kconfig.cputype
>+++ b/arch/powerpc/platforms/Kconfig.cputype
>@@ -204,7 +204,7 @@ config PPC_STD_MMU_32
>
> config PPC_MM_SLICES
> 	bool
>-	default y if HUGETLB_PAGE || PPC_64K_PAGES
>+	default y if HUGETLB_PAGE || (PPC_STD_MMU_64 && PPC_64K_PAGES)
> 	default n
>
> config VIRT_CPU_ACCOUNTING
>-- 
>1.5.6.1
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev

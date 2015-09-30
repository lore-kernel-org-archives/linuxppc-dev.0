Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9617B1A05FD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:28:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 136543578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2SQBh51511418
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2S1U0007269
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/31] powerpc/mm: make a separate copy for book3s
Date: Wed, 30 Sep 2015 07:56:56 +0530
Message-Id: <1443580044-30659-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this patch we do:
cp pgtable-ppc32.h book3s/32/pgtable.h
cp pgtable-ppc64.h book3s/64/pgtable.h

This enable us to do further changes to hash specific config.
We will change the page table format for 64bit hash in later patches.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 340 +++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 618 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/pgtable.h    |  10 +
 arch/powerpc/include/asm/mmu-hash64.h        |   2 +-
 arch/powerpc/include/asm/pgtable-ppc32.h     |   2 -
 arch/powerpc/include/asm/pgtable-ppc64.h     |   4 -
 arch/powerpc/include/asm/pgtable.h           |   4 +
 7 files changed, 973 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
new file mode 100644
index 000000000000..1a58a05be99c
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -0,0 +1,340 @@
+#ifndef _ASM_POWERPC_PGTABLE_PPC32_H
+#define _ASM_POWERPC_PGTABLE_PPC32_H
+
+#include <asm-generic/pgtable-nopmd.h>
+
+#ifndef __ASSEMBLY__
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+
+extern unsigned long ioremap_bot;
+
+#ifdef CONFIG_44x
+extern int icache_44x_need_flush;
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * The normal case is that PTEs are 32-bits and we have a 1-page
+ * 1024-entry pgdir pointing to 1-page 1024-entry PTE pages.  -- paulus
+ *
+ * For any >32-bit physical address platform, we can use the following
+ * two level page table layout where the pgdir is 8KB and the MS 13 bits
+ * are an index to the second level table.  The combined pgdir/pmd first
+ * level has 2048 entries and the second level has 512 64-bit PTE entries.
+ * -Matt
+ */
+/* PGDIR_SHIFT determines what a top-level page table entry can map */
+#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/*
+ * entries per page directory level: our page-table tree is two-level, so
+ * we don't really have any PMD directory.
+ */
+#ifndef __ASSEMBLY__
+#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
+#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
+#endif	/* __ASSEMBLY__ */
+
+#define PTRS_PER_PTE	(1 << PTE_SHIFT)
+#define PTRS_PER_PMD	1
+#define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
+
+#define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
+#define FIRST_USER_ADDRESS	0UL
+
+#define pte_ERROR(e) \
+	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
+		(unsigned long long)pte_val(e))
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+/*
+ * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
+ * value (for now) on others, from where we can start layout kernel
+ * virtual space that goes below PKMAP and FIXMAP
+ */
+#ifdef CONFIG_HIGHMEM
+#define KVIRT_TOP	PKMAP_BASE
+#else
+#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#endif
+
+/*
+ * ioremap_bot starts at that address. Early ioremaps move down from there,
+ * until mem_init() at which point this becomes the top of the vmalloc
+ * and ioremap space
+ */
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define IOREMAP_TOP	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
+#else
+#define IOREMAP_TOP	KVIRT_TOP
+#endif
+
+/*
+ * Just any arbitrary offset to the start of the vmalloc VM area: the
+ * current 16MB value just means that there will be a 64MB "hole" after the
+ * physical memory until the kernel virtual memory starts.  That means that
+ * any out-of-bounds memory accesses will hopefully be caught.
+ * The vmalloc() routines leaves a hole of 4kB between each vmalloced
+ * area for the same reason. ;)
+ *
+ * We no longer map larger than phys RAM with the BATs so we don't have
+ * to worry about the VMALLOC_OFFSET causing problems.  We do have to worry
+ * about clashes between our early calls to ioremap() that start growing down
+ * from ioremap_base being run into the VM area allocations (growing upwards
+ * from VMALLOC_START).  For this reason we have ioremap_bot to check when
+ * we actually run into our mappings setup in the early boot with the VM
+ * system.  This really does become a problem for machines with good amounts
+ * of RAM.  -- Cort
+ */
+#define VMALLOC_OFFSET (0x1000000) /* 16M */
+#ifdef PPC_PIN_SIZE
+#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#else
+#define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#endif
+#define VMALLOC_END	ioremap_bot
+
+/*
+ * Bits in a linux-style PTE.  These match the bits in the
+ * (hardware-defined) PowerPC PTE as closely as possible.
+ */
+
+#if defined(CONFIG_40x)
+#include <asm/pte-40x.h>
+#elif defined(CONFIG_44x)
+#include <asm/pte-44x.h>
+#elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
+#include <asm/pte-book3e.h>
+#elif defined(CONFIG_FSL_BOOKE)
+#include <asm/pte-fsl-booke.h>
+#elif defined(CONFIG_8xx)
+#include <asm/pte-8xx.h>
+#else /* CONFIG_6xx */
+#include <asm/book3s/32/hash.h>
+#endif
+
+/* And here we include common definitions */
+#include <asm/pte-common.h>
+
+#ifndef __ASSEMBLY__
+
+#define pte_clear(mm, addr, ptep) \
+	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
+
+#define pmd_none(pmd)		(!pmd_val(pmd))
+#define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
+#define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
+#define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
+
+/*
+ * When flushing the tlb entry for a page, we also need to flush the hash
+ * table entry.  flush_hash_pages is assembler (for speed) in hashtable.S.
+ */
+extern int flush_hash_pages(unsigned context, unsigned long va,
+			    unsigned long pmdval, int count);
+
+/* Add an HPTE to the hash table */
+extern void add_hash_page(unsigned context, unsigned long va,
+			  unsigned long pmdval);
+
+/* Flush an entry from the TLB/hash table */
+extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
+			     unsigned long address);
+
+/*
+ * PTE updates. This function is called whenever an existing
+ * valid PTE is updated. This does -not- include set_pte_at()
+ * which nowadays only sets a new PTE.
+ *
+ * Depending on the type of MMU, we may need to use atomic updates
+ * and the PTE may be either 32 or 64 bit wide. In the later case,
+ * when using atomic updates, only the low part of the PTE is
+ * accessed atomically.
+ *
+ * In addition, on 44x, we also maintain a global flag indicating
+ * that an executable user mapping was modified, which is needed
+ * to properly flush the virtually tagged instruction cache of
+ * those implementations.
+ */
+#ifndef CONFIG_PTE_64BIT
+static inline unsigned long pte_update(pte_t *p,
+				       unsigned long clr,
+				       unsigned long set)
+{
+#ifdef PTE_ATOMIC_UPDATES
+	unsigned long old, tmp;
+
+	__asm__ __volatile__("\
+1:	lwarx	%0,0,%3\n\
+	andc	%1,%0,%4\n\
+	or	%1,%1,%5\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%3\n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*p)
+	: "r" (p), "r" (clr), "r" (set), "m" (*p)
+	: "cc" );
+#else /* PTE_ATOMIC_UPDATES */
+	unsigned long old = pte_val(*p);
+	*p = __pte((old & ~clr) | set);
+#endif /* !PTE_ATOMIC_UPDATES */
+
+#ifdef CONFIG_44x
+	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
+		icache_44x_need_flush = 1;
+#endif
+	return old;
+}
+#else /* CONFIG_PTE_64BIT */
+static inline unsigned long long pte_update(pte_t *p,
+					    unsigned long clr,
+					    unsigned long set)
+{
+#ifdef PTE_ATOMIC_UPDATES
+	unsigned long long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__("\
+1:	lwarx	%L0,0,%4\n\
+	lwzx	%0,0,%3\n\
+	andc	%1,%L0,%5\n\
+	or	%1,%1,%6\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%4\n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*p)
+	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
+	: "cc" );
+#else /* PTE_ATOMIC_UPDATES */
+	unsigned long long old = pte_val(*p);
+	*p = __pte((old & ~(unsigned long long)clr) | set);
+#endif /* !PTE_ATOMIC_UPDATES */
+
+#ifdef CONFIG_44x
+	if ((old & _PAGE_USER) && (old & _PAGE_EXEC))
+		icache_44x_need_flush = 1;
+#endif
+	return old;
+}
+#endif /* CONFIG_PTE_64BIT */
+
+/*
+ * 2.6 calls this without flushing the TLB entry; this is wrong
+ * for our hash-based implementation, we fix that up here.
+ */
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int __ptep_test_and_clear_young(unsigned int context, unsigned long addr, pte_t *ptep)
+{
+	unsigned long old;
+	old = pte_update(ptep, _PAGE_ACCESSED, 0);
+#if _PAGE_HASHPTE != 0
+	if (old & _PAGE_HASHPTE) {
+		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
+		flush_hash_pages(context, addr, ptephys, 1);
+	}
+#endif
+	return (old & _PAGE_ACCESSED) != 0;
+}
+#define ptep_test_and_clear_young(__vma, __addr, __ptep) \
+	__ptep_test_and_clear_young((__vma)->vm_mm->context.id, __addr, __ptep)
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep)
+{
+	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
+}
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
+{
+	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+}
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	ptep_set_wrprotect(mm, addr, ptep);
+}
+
+
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+{
+	unsigned long set = pte_val(entry) &
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
+
+	pte_update(ptep, clr, set);
+}
+
+#define __HAVE_ARCH_PTE_SAME
+#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
+
+/*
+ * Note that on Book E processors, the pmd contains the kernel virtual
+ * (lowmem) address of the pte page.  The physical address is less useful
+ * because everything runs with translation enabled (even the TLB miss
+ * handler).  On everything else the pmd contains the physical address
+ * of the pte page.  -- paulus
+ */
+#ifndef CONFIG_BOOKE
+#define pmd_page_vaddr(pmd)	\
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+#define pmd_page(pmd)		\
+	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
+#else
+#define pmd_page_vaddr(pmd)	\
+	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
+#define pmd_page(pmd)		\
+	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
+#endif
+
+/* to find an entry in a kernel page-table-directory */
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+
+/* to find an entry in a page-table-directory */
+#define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
+#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
+
+/* Find an entry in the third-level page table.. */
+#define pte_index(address)		\
+	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_offset_kernel(dir, addr)	\
+	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
+#define pte_offset_map(dir, addr)		\
+	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
+#define pte_unmap(pte)		kunmap_atomic(pte)
+
+/*
+ * Encode and decode a swap entry.
+ * Note that the bits we use in a PTE for representing a swap entry
+ * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
+ *   -- paulus
+ */
+#define __swp_type(entry)		((entry).val & 0x1f)
+#define __swp_offset(entry)		((entry).val >> 5)
+#define __swp_entry(type, offset)	((swp_entry_t) { (type) | ((offset) << 5) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
+
+#ifndef CONFIG_PPC_4K_PAGES
+void pgtable_cache_init(void);
+#else
+/*
+ * No page table caches to initialise
+ */
+#define pgtable_cache_init()	do { } while (0)
+#endif
+
+extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
+		      pmd_t **pmdp);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_PGTABLE_PPC32_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
new file mode 100644
index 000000000000..fd00cab62008
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -0,0 +1,618 @@
+#ifndef _ASM_POWERPC_PGTABLE_PPC64_H_
+#define _ASM_POWERPC_PGTABLE_PPC64_H_
+/*
+ * This file contains the functions and defines necessary to modify and use
+ * the ppc64 hashed page table.
+ */
+
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/pgtable-ppc64-64k.h>
+#else
+#include <asm/pgtable-ppc64-4k.h>
+#endif
+#include <asm/barrier.h>
+
+#define FIRST_USER_ADDRESS	0UL
+
+/*
+ * Size of EA range mapped by our pagetables.
+ */
+#define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
+			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
+#define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PMD_CACHE_INDEX	(PMD_INDEX_SIZE + 1)
+#else
+#define PMD_CACHE_INDEX	PMD_INDEX_SIZE
+#endif
+/*
+ * Define the address range of the kernel non-linear virtual area
+ */
+
+#ifdef CONFIG_PPC_BOOK3E
+#define KERN_VIRT_START ASM_CONST(0x8000000000000000)
+#else
+#define KERN_VIRT_START ASM_CONST(0xD000000000000000)
+#endif
+#define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
+
+/*
+ * The vmalloc space starts at the beginning of that region, and
+ * occupies half of it on hash CPUs and a quarter of it on Book3E
+ * (we keep a quarter for the virtual memmap)
+ */
+#define VMALLOC_START	KERN_VIRT_START
+#ifdef CONFIG_PPC_BOOK3E
+#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 2)
+#else
+#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
+#endif
+#define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
+
+/*
+ * The second half of the kernel virtual space is used for IO mappings,
+ * it's itself carved into the PIO region (ISA and PHB IO space) and
+ * the ioremap space
+ *
+ *  ISA_IO_BASE = KERN_IO_START, 64K reserved area
+ *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
+ * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
+ */
+#define KERN_IO_START	(KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
+#define FULL_IO_SIZE	0x80000000ul
+#define  ISA_IO_BASE	(KERN_IO_START)
+#define  ISA_IO_END	(KERN_IO_START + 0x10000ul)
+#define  PHB_IO_BASE	(ISA_IO_END)
+#define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
+#define IOREMAP_BASE	(PHB_IO_END)
+#define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
+
+
+/*
+ * Region IDs
+ */
+#define REGION_SHIFT		60UL
+#define REGION_MASK		(0xfUL << REGION_SHIFT)
+#define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
+
+#define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
+#define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
+#define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
+#define USER_REGION_ID		(0UL)
+
+/*
+ * Defines the address of the vmemap area, in its own region on
+ * hash table CPUs and after the vmalloc space on Book3E
+ */
+#ifdef CONFIG_PPC_BOOK3E
+#define VMEMMAP_BASE		VMALLOC_END
+#define VMEMMAP_END		KERN_IO_START
+#else
+#define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
+#endif
+#define vmemmap			((struct page *)VMEMMAP_BASE)
+
+
+/*
+ * Include the PTE bits definitions
+ */
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/book3s/64/hash.h>
+#else
+#include <asm/pte-book3e.h>
+#endif
+#include <asm/pte-common.h>
+
+#ifdef CONFIG_PPC_MM_SLICES
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#ifndef __ASSEMBLY__
+
+/*
+ * This is the default implementation of various PTE accessors, it's
+ * used in all cases except Book3S with 64K pages where we have a
+ * concept of sub-pages
+ */
+#ifndef __real_pte
+
+#ifdef CONFIG_STRICT_MM_TYPECHECKS
+#define __real_pte(e,p)		((real_pte_t){(e)})
+#define __rpte_to_pte(r)	((r).pte)
+#else
+#define __real_pte(e,p)		(e)
+#define __rpte_to_pte(r)	(__pte(r))
+#endif
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
+
+#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
+	do {							         \
+		index = 0;					         \
+		shift = mmu_psize_defs[psize].shift;		         \
+
+#define pte_iterate_hashed_end() } while(0)
+
+/*
+ * We expect this to be called only for user addresses or kernel virtual
+ * addresses other than the linear mapping.
+ */
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+
+#endif /* __real_pte */
+
+
+/* pte_clear moved to later in this file */
+
+#define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
+#define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
+
+#define pmd_set(pmdp, pmdval) 	(pmd_val(*(pmdp)) = (pmdval))
+#define pmd_none(pmd)		(!pmd_val(pmd))
+#define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
+				 || (pmd_val(pmd) & PMD_BAD_BITS))
+#define	pmd_present(pmd)	(!pmd_none(pmd))
+#define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
+#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
+extern struct page *pmd_page(pmd_t pmd);
+
+#define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
+#define pud_none(pud)		(!pud_val(pud))
+#define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
+				 || (pud_val(pud) & PUD_BAD_BITS))
+#define pud_present(pud)	(pud_val(pud) != 0)
+#define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
+#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+
+extern struct page *pud_page(pud_t pud);
+
+static inline pte_t pud_pte(pud_t pud)
+{
+	return __pte(pud_val(pud));
+}
+
+static inline pud_t pte_pud(pte_t pte)
+{
+	return __pud(pte_val(pte));
+}
+#define pud_write(pud)		pte_write(pud_pte(pud))
+#define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
+#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
+
+/*
+ * Find an entry in a page-table-directory.  We combine the address region
+ * (the high order N bits) and the pgd portion of the address.
+ */
+#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
+
+#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
+
+#define pmd_offset(pudp,addr) \
+  (((pmd_t *) pud_page_vaddr(*(pudp))) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+
+#define pte_offset_kernel(dir,addr) \
+  (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
+
+#define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
+#define pte_unmap(pte)			do { } while(0)
+
+/* to find an entry in a kernel page-table-directory */
+/* This now only contains the vmalloc pages */
+#define pgd_offset_k(address) pgd_offset(&init_mm, address)
+extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned long pte, int huge);
+
+/* Atomic PTE updates */
+static inline unsigned long pte_update(struct mm_struct *mm,
+				       unsigned long addr,
+				       pte_t *ptep, unsigned long clr,
+				       unsigned long set,
+				       int huge)
+{
+#ifdef PTE_ATOMIC_UPDATES
+	unsigned long old, tmp;
+
+	__asm__ __volatile__(
+	"1:	ldarx	%0,0,%3		# pte_update\n\
+	andi.	%1,%0,%6\n\
+	bne-	1b \n\
+	andc	%1,%0,%4 \n\
+	or	%1,%1,%7\n\
+	stdcx.	%1,0,%3 \n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
+	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
+	: "cc" );
+#else
+	unsigned long old = pte_val(*ptep);
+	*ptep = __pte((old & ~clr) | set);
+#endif
+	/* huge pages use the old page table lock */
+	if (!huge)
+		assert_pte_locked(mm, addr);
+
+#ifdef CONFIG_PPC_STD_MMU_64
+	if (old & _PAGE_HASHPTE)
+		hpte_need_flush(mm, addr, ptep, old, huge);
+#endif
+
+	return old;
+}
+
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
+{
+	unsigned long old;
+
+	if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
+	return (old & _PAGE_ACCESSED) != 0;
+}
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young(__vma, __addr, __ptep)		   \
+({									   \
+	int __r;							   \
+	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
+	__r;								   \
+})
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
+{
+
+	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+		return;
+
+	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+		return;
+
+	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
+}
+
+/*
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty. The generic routines only flush if the
+ * entry was young or dirty which is not good enough.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ */
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+#define ptep_clear_flush_young(__vma, __address, __ptep)		\
+({									\
+	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, \
+						  __ptep);		\
+	__young;							\
+})
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep)
+{
+	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
+	return __pte(old);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
+			     pte_t * ptep)
+{
+	pte_update(mm, addr, ptep, ~0UL, 0, 0);
+}
+
+
+/* Set the dirty and/or accessed bits atomically in a linux PTE, this
+ * function doesn't need to flush the hash entry
+ */
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+{
+	unsigned long bits = pte_val(entry) &
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+
+#ifdef PTE_ATOMIC_UPDATES
+	unsigned long old, tmp;
+
+	__asm__ __volatile__(
+	"1:	ldarx	%0,0,%4\n\
+		andi.	%1,%0,%6\n\
+		bne-	1b \n\
+		or	%0,%3,%0\n\
+		stdcx.	%0,0,%4\n\
+		bne-	1b"
+	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
+	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
+	:"cc");
+#else
+	unsigned long old = pte_val(*ptep);
+	*ptep = __pte(old | bits);
+#endif
+}
+
+#define __HAVE_ARCH_PTE_SAME
+#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
+
+#define pte_ERROR(e) \
+	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+#define pmd_ERROR(e) \
+	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+
+/* Encode and de-code a swap entry */
+#define MAX_SWAPFILES_CHECK() do { \
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
+	/*							\
+	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
+	 * We filter HPTEFLAGS on set_pte.			\
+	 */							\
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	} while (0)
+/*
+ * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ */
+#define SWP_TYPE_BITS 5
+#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
+				& ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+					((type) << _PAGE_BIT_SWAP_TYPE) \
+					| ((offset) << PTE_RPN_SHIFT) })
+
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
+#define __swp_entry_to_pte(x)		__pte((x).val)
+
+void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+void pgtable_cache_init(void);
+#endif /* __ASSEMBLY__ */
+
+/*
+ * THP pages can't be special. So use the _PAGE_SPECIAL
+ */
+#define _PAGE_SPLITTING _PAGE_SPECIAL
+
+/*
+ * We need to differentiate between explicit huge page and THP huge
+ * page, since THP huge page also need to track real subpage details
+ */
+#define _PAGE_THP_HUGE  _PAGE_4K_PFN
+
+/*
+ * set of bits not changed in pmd_modify.
+ */
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
+			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
+			 _PAGE_THP_HUGE)
+
+#ifndef __ASSEMBLY__
+/*
+ * The linux hugepage PMD now include the pmd entries followed by the address
+ * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
+ * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
+ * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
+ * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
+ *
+ * The last three bits are intentionally left to zero. This memory location
+ * are also used as normal page PTE pointers. So if we have any pointers
+ * left around while we collapse a hugepage, we need to make sure
+ * _PAGE_PRESENT bit of that is zero when we look at them
+ */
+static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
+{
+	return (hpte_slot_array[index] >> 3) & 0x1;
+}
+
+static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
+					   int index)
+{
+	return hpte_slot_array[index] >> 4;
+}
+
+static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
+					unsigned int index, unsigned int hidx)
+{
+	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
+}
+
+struct page *realmode_pfn_to_page(unsigned long pfn);
+
+static inline char *get_hpte_slot_array(pmd_t *pmdp)
+{
+	/*
+	 * The hpte hindex is stored in the pgtable whose address is in the
+	 * second half of the PMD
+	 *
+	 * Order this load with the test for pmd_trans_huge in the caller
+	 */
+	smp_rmb();
+	return *(char **)(pmdp + PTRS_PER_PMD);
+
+
+}
+
+extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
+				   pmd_t *pmdp, unsigned long old_pmd);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
+extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
+extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
+extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		       pmd_t *pmdp, pmd_t pmd);
+extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+				 pmd_t *pmd);
+/*
+ *
+ * For core kernel code by design pmd_trans_huge is never run on any hugetlbfs
+ * page. The hugetlbfs page table walking and mangling paths are totally
+ * separated form the core VM paths and they're differentiated by
+ *  VM_HUGETLB being set on vm_flags well before any pmd_trans_huge could run.
+ *
+ * pmd_trans_huge() is defined as false at build time if
+ * CONFIG_TRANSPARENT_HUGEPAGE=n to optimize away code blocks at build
+ * time in such case.
+ *
+ * For ppc64 we need to differntiate from explicit hugepages from THP, because
+ * for THP we also track the subpage details at the pmd level. We don't do
+ * that for explicit huge pages.
+ *
+ */
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
+}
+
+static inline int pmd_trans_splitting(pmd_t pmd)
+{
+	if (pmd_trans_huge(pmd))
+		return pmd_val(pmd) & _PAGE_SPLITTING;
+	return 0;
+}
+
+extern int has_transparent_hugepage(void);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline int pmd_large(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return ((pmd_val(pmd) & 0x3) != 0x0);
+}
+
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
+static inline pmd_t pte_pmd(pte_t pte)
+{
+	return __pmd(pte_val(pte));
+}
+
+static inline pte_t *pmdp_ptep(pmd_t *pmd)
+{
+	return (pte_t *)pmd;
+}
+
+#define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
+#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
+#define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
+#define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
+#define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
+#define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
+#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+
+#define __HAVE_ARCH_PMD_WRITE
+#define pmd_write(pmd)		pte_write(pmd_pte(pmd))
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	/* Do nothing, mk_pmd() does this part.  */
+	return pmd;
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	pmd_val(pmd) &= ~_PAGE_PRESENT;
+	return pmd;
+}
+
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_SPLITTING;
+	return pmd;
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
+}
+
+#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
+extern int pmdp_set_access_flags(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp,
+				 pmd_t entry, int dirty);
+
+extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
+					 unsigned long addr,
+					 pmd_t *pmdp,
+					 unsigned long clr,
+					 unsigned long set);
+
+static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pmd_t *pmdp)
+{
+	unsigned long old;
+
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
+	return ((old & _PAGE_ACCESSED) != 0);
+}
+
+#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
+extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+				     unsigned long address, pmd_t *pmdp);
+#define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
+extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
+extern pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
+				     unsigned long addr, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pmd_t *pmdp)
+{
+
+	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
+		return;
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
+}
+
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+extern void pmdp_splitting_flush(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
+
+extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
+#define pmdp_collapse_flush pmdp_collapse_flush
+
+#define __HAVE_ARCH_PGTABLE_DEPOSIT
+extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				       pgtable_t pgtable);
+#define __HAVE_ARCH_PGTABLE_WITHDRAW
+extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+
+#define __HAVE_ARCH_PMDP_INVALIDATE
+extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			    pmd_t *pmdp);
+
+#define pmd_move_must_withdraw pmd_move_must_withdraw
+struct spinlock;
+static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+					 struct spinlock *old_pmd_ptl)
+{
+	/*
+	 * Archs like ppc64 use pgtable to store per pmd
+	 * specific information. So when we switch the pmd,
+	 * we should also withdraw and deposit the pgtable
+	 */
+	return true;
+}
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
new file mode 100644
index 000000000000..a8d8e5152bd4
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_POWERPC_BOOK3S_PGTABLE_H
+#define _ASM_POWERPC_BOOK3S_PGTABLE_H
+
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/pgtable.h>
+#else
+#include <asm/book3s/32/pgtable.h>
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index a82f5347540a..b8cf654c7a90 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -20,7 +20,7 @@
  * need for various slices related matters. Note that this isn't the
  * complete pgtable.h but only a portion of it.
  */
-#include <asm/pgtable-ppc64.h>
+#include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
 #include <asm/processor.h>
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 1a58a05be99c..aac6547b0823 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -115,8 +115,6 @@ extern int icache_44x_need_flush;
 #include <asm/pte-fsl-booke.h>
 #elif defined(CONFIG_8xx)
 #include <asm/pte-8xx.h>
-#else /* CONFIG_6xx */
-#include <asm/book3s/32/hash.h>
 #endif
 
 /* And here we include common definitions */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 4f7d8e2f2a2f..80629eebd985 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -97,11 +97,7 @@
 /*
  * Include the PTE bits definitions
  */
-#ifdef CONFIG_PPC_BOOK3S
-#include <asm/book3s/64/hash.h>
-#else
 #include <asm/pte-book3e.h>
-#endif
 #include <asm/pte-common.h>
 
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 0717693c8428..07d7ca96c13f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -13,11 +13,15 @@ struct mm_struct;
 
 #endif /* !__ASSEMBLY__ */
 
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/book3s/pgtable.h>
+#else
 #if defined(CONFIG_PPC64)
 #  include <asm/pgtable-ppc64.h>
 #else
 #  include <asm/pgtable-ppc32.h>
 #endif
+#endif /* !CONFIG_PPC_BOOK3S */
 
 /*
  * We save the slot number & secondary bit in the second half of the
-- 
2.5.0

Return-Path: <edi@linux.vnet.ibm.com>
Message-ID: <45705FA3.4040904@linux.vnet.ibm.com>
Date: Fri, 01 Dec 2006 12:00:19 -0500
From: Edi Shmueli <edi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/1] PPC32 : Huge-page support for ppc440 - 2.6.19-rc4 -
	revised
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Edi Shmueli <edi@linux.vnet.ibm.com>

Following requests to test the patch under the latest kernel, here it is again, tested for 2.6.19-rc4.
This patch enables applications to exploit the PPC440 TLB support for huge-page mapping, to minimize TLB thrashing.
Applications with large memory footprint that exploit this support, experience minimal TLB misses, and boost in performance.
NAS benchmarks tested with this patch indicate hundreds of percent of improvement in performance.

Signed-off-by: Edi Shmueli <edi@linux.vnet.ibm.com>
-----

Benchmarks and Implementation comments
======================================
Below is the NAS IS benchmark results, executing under Linux, with and
without this huge-page mapping support.
IS Benchmark           4KB pages             16MB pages
=======================================================
  Class             =   A                     A
  Size              =   8388608               8388608
  Iterations        =   10                    10
  Time in seconds   =   24.44                 6.38
  Mop/s total       =   3.43                  13.15
  Operation type    =   keys ranked           keys ranked
  Verification      =   SUCCESSFUL            SUCCESSFUL
Implementation details:
=======================
This patch is ppc440 architecture-specific. It enables the use of huge-pages by processes executing under the 2.6.16 kernel on the ppc440 processors.
Huge-pages are accessible to user processes using either the hugetlbfs or using shared memory. See Documentation/vs/hugetlbpage.txt.
==
The ppc 32bit kernel uses 64bit PTEs (set by CONFIG_PTE_64BIT).
I exploit a "hole" of 4 unused bits in the PTE MS word (bits 24-27) and code the page size information in those bits.
I then modified the TLB miss handler (head_44x.S) to stop using the constant PPC44x_TLB_4K to set the page size in the TLB.
Instead, when a TLB miss happens, the miss handler reads the size information from the PTE and sets that size in the TLB entry.
This way, different TLB entries get to map different page sizes (e.g., 4KB or 16MB).
The TLB replacement policy remains RR. This means that a huge-page entry in the TLB may be overwritten if not used for a long time, but when accessed it will be set again by the TLB miss handler, with the correct size, as set in the PTE.
==
In arch/ppc/mm/hugetlbpage.c is where page table entries are set to map huge pages:
By default , each process has two-level page-tables. It has 2048, 32bit PMD (or PGD) entries at the higher-level, each maps 2MB of the process address spase, and 512, 64bit PTE entries in each lower-level page table.
When a TLB miss happens and no PTE is found by the miss handler to offer the translation, a check is made (memory.c) on whether the faulting address belongs to a huge-page VM region.
If so, the code in set_huge_pte_at() will set the required number of PMDs (e.g.,8 PMDs for huge-pages of size 16MB, or 1 PMD for huge-pages of size 2MB or less) to point to the *same* lower-level PTE page table.
Within the lower-level page table, it will set the required number PTEs (e.g., all 512 PTEs for huge-pages larger than 2MB, or 256 PTEs for huge-pages of size 1MB etc.) to point to the *same* physical huge-page frame.
All these PTEs will be *identical* and have the page-size coded in their MS word as described above.
==
Once the TLB miss handler copies the mapping (and the size) from the PTE into on of a TLB entry, the process will not suffer any TLB misses for that huge-page.
If the mapping was overwritten by the TLB RR replacement policy, it will be re-loaded again (probably in a different TLB entry) when the process re-access that huge-page.


diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/arch/ppc/kernel/head_44x.S my_linux/arch/ppc/kernel/head_44x.S
--- linux-2.6.19-rc4-vanilla/arch/ppc/kernel/head_44x.S    2006-11-14 11:16:29.000000000 -0500
+++ my_linux/arch/ppc/kernel/head_44x.S    2006-11-14 17:26:13.000000000 -0500
@@ -21,12 +21,14 @@
   *            debbie_chu@mvista.com
   *    Copyright 2002-2005 MontaVista Software, Inc.
   *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
+ *    Copyright (C) 2006 Edi Shmueli, IBM Corporation.
+ *    PowerPC 44x handling of huge-page misses.
   *
   * This program is free software; you can redistribute  it and/or modify it
   * under  the terms of  the GNU General  Public License as published by the
   * Free Software Foundation;  either version 2 of the  License, or (at your
   * option) any later version.
- */
+*/

  #include <asm/processor.h>
  #include <asm/page.h>
@@ -654,19 +656,22 @@ finish_tlb_load:
      lis    r11, tlb_44x_index@ha
      stw    r13, tlb_44x_index@l(r11)

-    lwz    r11, 0(r12)            /* Get MS word of PTE */
-    lwz    r12, 4(r12)            /* Get LS word of PTE */
-    rlwimi    r11, r12, 0, 0 , 19        /* Insert RPN */
-    tlbwe    r11, r13, PPC44x_TLB_XLAT    /* Write XLAT */
-
+    /*huge-page support*/
      /*
       * Create PAGEID. This is the faulting address,
       * page size, and valid flag.
-     */
-    li    r11, PPC44x_TLB_VALID | PPC44x_TLB_4K
-    rlwimi    r10, r11, 0, 20, 31        /* Insert valid and page size */
+    */
+    lwz    r11, 0(r12)            /* Get MS word of PTE */
+    andi.   r11, r11, 0x000000F0        /* Leave only the size */
+    ori     r11, r11, PPC44x_TLB_VALID | PPC44x_TLB_4K /* Insert valid and page size */
+    rlwimi    r10, r11, 0, 20, 31        /* Combine EA from r10 with flags from r11 */
      tlbwe    r10, r13, PPC44x_TLB_PAGEID    /* Write PAGEID */

+    lwz    r11, 0(r12)            /* Get MS word of PTE */
+    lwz    r12, 4(r12)            /* Get LS word of PTE */
+    rlwimi    r11, r12, 0, 0 , 19        /* Insert RPN */
+    tlbwe    r11, r13, PPC44x_TLB_XLAT    /* Write XLAT */
+
      li    r10, PPC44x_TLB_SR@l        /* Set SR */
      rlwimi    r10, r12, 0, 30, 30        /* Set SW = _PAGE_RW */
      rlwimi    r10, r12, 29, 29, 29        /* SX = _PAGE_HWEXEC */
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/arch/ppc/mm/hugetlbpage.c my_linux/arch/ppc/mm/hugetlbpage.c
--- linux-2.6.19-rc4-vanilla/arch/ppc/mm/hugetlbpage.c    1969-12-31 19:00:00.000000000 -0500
+++ my_linux/arch/ppc/mm/hugetlbpage.c    2006-11-15 11:44:43.297682864 -0500
@@ -0,0 +1,185 @@
+/*
+ * PPC32 (440) Huge TLB Page Support for Kernel.
+ *
+ * Copyright (C) 2006 Edi Shmueli, IBM Corporation.
+ *
+ * Based on the IA-32 version:
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/smp_lock.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/sysctl.h>
+#include <asm/mman.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+  pgd_t *pgd;
+  pud_t *pud;
+  pmd_t *pmd=NULL;
+  pte_t *ptep=NULL;
+
+  pgd = pgd_offset(mm, addr);
+
+  pud = pud_offset(pgd, addr);
+  if(!pud)
+    return NULL;
+
+  pmd = pmd_offset(pud, addr);
+  if(!pmd)
+    return NULL;
+
+  ptep = pte_offset_map(pmd, addr); /*also check pte_offset_map_lock()*/
+
+  return ptep;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+{
+    pgd_t *pgd;
+    pud_t *pud;
+    pmd_t *pmd;
+    pte_t *pte = NULL;
+
+    pgd = pgd_offset(mm, addr);
+
+    pud = pud_alloc(mm, pgd, addr);
+    if (!pud)
+      return NULL;
+
+    pmd = pmd_alloc(mm, pud, addr);
+    if (!pmd)
+      return NULL;
+
+    pte = pte_alloc_map(mm, pmd, addr); /* also sets pmd !!!*/
+    if (!pte)
+      return NULL;
+
+
+    BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
+
+    return pte;
+}
+
+#ifdef ARCH_HAS_SETCLEAR_HUGE_PTE
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte){
+  pgd_t *pgd;
+  pud_t *pud;
+  pmd_t *pmd;
+  pmd_t pmd_val;
+  int i;
+
+  /* For the cow case, we overwrite '*ptep' (which points to the orig huge-page) with 'pte' (which points to the new page). */
+  /* Cow is detected after the TLB exception handler has already wrote a TLB entry that points to the "orig" page but       */
+  /* this entry does not have the user write permission set (UW), so when the process tries the write, we get exception.    */
+  /* As we reach this call to overwrite the PTEs to point to the new huge-page, the TLB contains                            */
+  /* translation for the old huge-page. By invalidating the TLB, we ensure the TLB exception handler will re-fill           */
+  /* the entry from the updated page tables */
+  if (pte_present(*ptep)) {
+    flush_tlb_pending();
+  }
+
+  ptep = (pte_t *)((unsigned long)ptep & _PTE_MASK); /* point to first pte for this huge page */
+
+  /* update _PTE_CNT pte entries, starting with ptep set above */
+  for(i=0; i < _PTE_CNT ;i++){
+    set_pte_at(mm, addr, ptep, pte);
+    ptep++;
+  }
+
+  /* next, we set all pmd's that cover the huge-page to point to the above PTEs table. */
+  /* 'pmd' that mapps 'addr', was already set when hugetlb_fault() called huge_pte_alloc() */
+  /* we start by locating it... */
+  pgd = pgd_offset(mm, addr);
+  pud = pud_offset(pgd, addr);
+  pmd = pmd_offset(pud, addr); /*this pmd already points to the PTEs table. It was set be the call to huge_pte_alloc()  */
+  pmd_val=*pmd;
+
+  /* find the first pmd that mapps the huge page  */
+  addr=addr & HPAGE_MASK;
+  pgd = pgd_offset(mm, addr);
+  pud = pud_offset(pgd, addr);
+  pmd = pmd_offset(pud, addr);
+
+  for(i=0;i< (HPAGE_SIZE >> PMD_SHIFT);i++){
+    *pmd=pmd_val;
+    pmd++;
+  }
+}
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep){
+  pgd_t *pgd;
+  pud_t *pud;
+  pmd_t *pmd;
+  pte_t pte;
+  int i;
+  pmd_t pmd_val;
+
+  ptep = (pte_t *)((unsigned long)ptep & _PTE_MASK); /* point to first pte for this huge page */
+
+  /*Clean _PTE_CNT entries, starting with ptep set above*/
+  for(i=0; i < _PTE_CNT ;i++){
+    pte=ptep_get_and_clear(mm, addr, ptep);
+    ptep++;
+  }
+
+  addr=addr & HPAGE_MASK; /* point to the base of the huge-page that contains addr */
+  pgd = pgd_offset(mm, addr);
+  pud = pud_offset(pgd, addr);
+  pmd = pmd_offset(pud, addr);
+
+  pmd_val=*pmd; //this is the first pmd that mappes the huge page;
+
+  pmd++; /* leave it... page cache will delete it */
+
+  for(i=1;i< (HPAGE_SIZE >> PMD_SHIFT);i++){
+    pmd_clear(pmd);
+    pmd++;
+  }
+
+  return pte; /*all pte's are the same, except maybe dirty bit*/
+}
+#endif
+
+int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
+{
+  if (len & ~HPAGE_MASK)
+    return -EINVAL;
+  if (addr & ~HPAGE_MASK)
+    return -EINVAL;
+  return 0;
+}
+
+struct page *
+follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
+{
+  pte_t *pte;
+  struct page *page;
+
+  pte = huge_pte_offset(mm, address);
+  page = pte_page(*pte);
+  return page;
+}
+
+int pmd_huge(pmd_t pmd)
+{
+  return 0;
+}
+
+struct page *
+follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+        pmd_t *pmd, int write)
+{
+   return NULL;
+}
+
+
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/arch/ppc/mm/Makefile my_linux/arch/ppc/mm/Makefile
--- linux-2.6.19-rc4-vanilla/arch/ppc/mm/Makefile    2006-11-14 11:16:29.000000000 -0500
+++ my_linux/arch/ppc/mm/Makefile    2006-11-06 09:52:41.000000000 -0500
@@ -9,3 +9,4 @@ obj-$(CONFIG_PPC_STD_MMU)    += hashtable.o
  obj-$(CONFIG_40x)        += 4xx_mmu.o
  obj-$(CONFIG_44x)        += 44x_mmu.o
  obj-$(CONFIG_FSL_BOOKE)        += fsl_booke_mmu.o
+obj-$(CONFIG_HUGETLB_PAGE)      += hugetlbpage.o
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/fs/Kconfig my_linux/fs/Kconfig
--- linux-2.6.19-rc4-vanilla/fs/Kconfig    2006-11-14 11:17:37.000000000 -0500
+++ my_linux/fs/Kconfig    2006-11-14 17:26:13.000000000 -0500
@@ -1008,7 +1008,7 @@ config TMPFS_POSIX_ACL

  config HUGETLBFS
      bool "HugeTLB file system support"
-    depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
+    depends X86 || IA64 || PPC || PPC64 || SPARC64 || SUPERH || BROKEN
      help
        hugetlbfs is a filesystem backing for HugeTLB pages, based on
        ramfs. For architectures that support it, say Y here and read
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/asm-ppc/page.h my_linux/include/asm-ppc/page.h
--- linux-2.6.19-rc4-vanilla/include/asm-ppc/page.h    2006-11-14 11:18:00.000000000 -0500
+++ my_linux/include/asm-ppc/page.h    2006-11-14 17:26:14.000000000 -0500
@@ -7,6 +7,12 @@
  #define PAGE_SHIFT    12
  #define PAGE_SIZE    (ASM_CONST(1) << PAGE_SHIFT)

+#ifdef CONFIG_HUGETLB_PAGE
+#define HPAGE_SHIFT     24
+#define HPAGE_SIZE      ((1UL) << HPAGE_SHIFT)
+#define HPAGE_MASK      (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+#endif
  /*
   * Subtle: this is an int (not an unsigned long) and so it
   * gets extended to 64 bits the way want (i.e. with 1s).  -- paulus
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/asm-ppc/pgtable.h my_linux/include/asm-ppc/pgtable.h
--- linux-2.6.19-rc4-vanilla/include/asm-ppc/pgtable.h    2006-11-14 11:18:00.000000000 -0500
+++ my_linux/include/asm-ppc/pgtable.h    2006-11-15 11:40:45.332514013 -0500
@@ -263,6 +263,40 @@ extern unsigned long ioremap_bot, iorema
  #define    _PAGE_NO_CACHE    0x00000400        /* H: I bit */
  #define    _PAGE_WRITETHRU    0x00000800        /* H: W bit */

+#if   HPAGE_SHIFT == 10 /*Unsupported*/
+#define _PAGE_HUGE      0x0000000000000000ULL   /* H: SIZE=1K bytes */
+#define _PTE_MASK       0xfffffff8UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 9))
+#elif HPAGE_SHIFT == 12
+#define _PAGE_HUGE      0x0000001000000000ULL   /* H: SIZE=4K bytes */
+#define _PTE_MASK       0xfffffff8UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 9))
+#elif HPAGE_SHIFT == 14
+#define _PAGE_HUGE      0x0000002000000000ULL   /* H: SIZE=16K bytes */
+#define _PTE_MASK       0xffffffe0UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 7))
+#elif HPAGE_SHIFT == 16
+#define _PAGE_HUGE      0x0000003000000000ULL   /* H: SIZE=64K bytes */
+#define _PTE_MASK       0xffffff80UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 5))
+#elif HPAGE_SHIFT == 18
+#define _PAGE_HUGE      0x0000004000000000ULL   /* H: SIZE=256K bytes */
+#define _PTE_MASK       0xfffffe00UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 3))
+#elif HPAGE_SHIFT == 20
+#define _PAGE_HUGE      0x0000005000000000ULL   /* H: SIZE=1M bytes */
+#define _PTE_MASK       0xfffff800UL
+#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 1))
+#elif HPAGE_SHIFT == 24
+#define _PAGE_HUGE      0x0000007000000000ULL   /* H: SIZE=16M bytes */
+#define _PTE_MASK       0xfffff000UL
+#define _PTE_CNT        ((1UL) << PTE_SHIFT)
+#elif HPAGE_SHIFT == 28
+#define _PAGE_HUGE      0x0000009000000000ULL   /* H: SIZE=256M bytes */
+#define _PTE_MASK       0xfffff000UL
+#define _PTE_CNT        ((1UL) << PTE_SHIFT)
+#endif
+
  /* TODO: Add large page lowmem mapping support */
  #define _PMD_PRESENT    0
  #define _PMD_PRESENT_MASK (PAGE_MASK)
@@ -490,7 +524,12 @@ extern unsigned long bad_call_to_PMD_PAG
  #define PFN_SHIFT_OFFSET    (PAGE_SHIFT)
  #endif

-#define pte_pfn(x)        (pte_val(x) >> PFN_SHIFT_OFFSET)
+/*                                                                                    v             */
+/* huge-page fix:  since now the PTE (MS) contains the size of the page e.g., 0x0000007000000000ULL */
+/* which was once assumed to be 0, we must zero it, otherwise we get extreamly huge (and wrong) pfn */
+//#define pte_pfn(x)        ( pte_val(x) >> PFN_SHIFT_OFFSET )
+#define pte_pfn(x)        ( ( pte_val(x) & 0x0000000fffffffffULL ) >> PFN_SHIFT_OFFSET )
+
  #define pte_page(x)        pfn_to_page(pte_pfn(x))

  #define pfn_pte(pfn, prot)    __pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
@@ -539,6 +578,7 @@ static inline int pte_exec(pte_t pte)        {
  static inline int pte_dirty(pte_t pte)        { return pte_val(pte) & _PAGE_DIRTY; }
  static inline int pte_young(pte_t pte)        { return pte_val(pte) & _PAGE_ACCESSED; }
  static inline int pte_file(pte_t pte)        { return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_huge(pte_t pte)           { return (pte_val(pte) & _PAGE_HUGE)?1:0; }

  static inline void pte_uncache(pte_t pte)       { pte_val(pte) |= _PAGE_NO_CACHE; }
  static inline void pte_cache(pte_t pte)         { pte_val(pte) &= ~_PAGE_NO_CACHE; }
@@ -564,6 +604,8 @@ static inline pte_t pte_mkdirty(pte_t pt
      pte_val(pte) |= _PAGE_DIRTY; return pte; }
  static inline pte_t pte_mkyoung(pte_t pte) {
      pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkhuge(pte_t pte) {
+        pte_val(pte) |= _PAGE_HUGE; return pte; }

  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  {
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/linux/hugetlb.h my_linux/include/linux/hugetlb.h
--- linux-2.6.19-rc4-vanilla/include/linux/hugetlb.h    2006-11-14 11:18:05.000000000 -0500
+++ my_linux/include/linux/hugetlb.h    2006-11-14 17:26:18.000000000 -0500
@@ -2,6 +2,7 @@
  #define _LINUX_HUGETLB_H

  #ifdef CONFIG_HUGETLB_PAGE
+#define ARCH_HAS_SETCLEAR_HUGE_PTE

  #include <linux/mempolicy.h>
  #include <asm/tlbflush.h>
diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/linux/mmzone.h my_linux/include/linux/mmzone.h
--- linux-2.6.19-rc4-vanilla/include/linux/mmzone.h    2006-11-14 11:18:06.000000000 -0500
+++ my_linux/include/linux/mmzone.h    2006-11-14 17:26:17.000000000 -0500
@@ -18,7 +18,7 @@

  /* Free memory management - zoned buddy allocator.  */
  #ifndef CONFIG_FORCE_MAX_ZONEORDER
-#define MAX_ORDER 11
+#define MAX_ORDER 13
  #else
  #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
  #endif

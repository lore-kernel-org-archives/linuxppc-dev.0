Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Feb 2009 13:56:45 +1100
Subject: [PATCH] powerpc: Split the various pgtable-* headers based on MMU type
Message-Id: <20090224025735.818ADDDE1F@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the definition of the PTE format for each MMU type
to separate files instead of all in one file. This improves overall
maintainability and will make it easier to add new types.

There are still some type-related ifdef's in the generic headers,
we might remove them in the long run, but this page shouldn't result
in any code change, just definitions being moved around.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-40x.h        |   64 +++++
 arch/powerpc/include/asm/pgtable-44x.h        |  102 ++++++++
 arch/powerpc/include/asm/pgtable-8xx.h        |   64 +++++
 arch/powerpc/include/asm/pgtable-fsl-booke.h  |   46 +++
 arch/powerpc/include/asm/pgtable-hash32.h     |   49 +++
 arch/powerpc/include/asm/pgtable-hash64-4k.h  |  117 +++++++++
 arch/powerpc/include/asm/pgtable-hash64-64k.h |  155 ++++++++++++
 arch/powerpc/include/asm/pgtable-hash64.h     |   47 +++
 arch/powerpc/include/asm/pgtable-ppc32.h      |  321 +-------------------------
 arch/powerpc/include/asm/pgtable-ppc64.h      |   53 ----
 10 files changed, 676 insertions(+), 342 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-40x.h	2009-02-24 11:37:41.000000000 +1100
@@ -0,0 +1,64 @@
+#ifndef _ASM_POWERPC_PGTABLE_40x_H
+#define _ASM_POWERPC_PGTABLE_40x_H
+#ifdef __KERNEL__
+
+/*
+ * At present, all PowerPC 400-class processors share a similar TLB
+ * architecture. The instruction and data sides share a unified,
+ * 64-entry, fully-associative TLB which is maintained totally under
+ * software control. In addition, the instruction side has a
+ * hardware-managed, 4-entry, fully-associative TLB which serves as a
+ * first level to the shared TLB. These two TLBs are known as the UTLB
+ * and ITLB, respectively (see "mmu.h" for definitions).
+ *
+ * There are several potential gotchas here.  The 40x hardware TLBLO
+ * field looks like this:
+ *
+ * 0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
+ * RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G
+ *
+ * Where possible we make the Linux PTE bits match up with this
+ *
+ * - bits 20 and 21 must be cleared, because we use 4k pages (40x can
+ *   support down to 1k pages), this is done in the TLBMiss exception
+ *   handler.
+ * - We use only zones 0 (for kernel pages) and 1 (for user pages)
+ *   of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
+ *   miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
+ *   zone.
+ * - PRESENT *must* be in the bottom two bits because swap cache
+ *   entries use the top 30 bits.  Because 40x doesn't support SMP
+ *   anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
+ *   is cleared in the TLB miss handler before the TLB entry is loaded.
+ * - All other bits of the PTE are loaded into TLBLO without
+ *   modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
+ *   software PTE bits.  We actually use use bits 21, 24, 25, and
+ *   30 respectively for the software bits: ACCESSED, DIRTY, RW, and
+ *   PRESENT.
+ */
+
+#define	_PAGE_GUARDED	0x001	/* G: page is guarded from prefetch */
+#define _PAGE_FILE	0x001	/* when !present: nonlinear file mapping */
+#define _PAGE_PRESENT	0x002	/* software: PTE contains a translation */
+#define	_PAGE_NO_CACHE	0x004	/* I: caching is inhibited */
+#define	_PAGE_WRITETHRU	0x008	/* W: caching is write-through */
+#define	_PAGE_USER	0x010	/* matches one of the zone permission bits */
+#define	_PAGE_RW	0x040	/* software: Writes permitted */
+#define	_PAGE_DIRTY	0x080	/* software: dirty page */
+#define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
+#define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
+#define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
+
+#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_BAD	0x802
+#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
+#define _PMD_SIZE_4M	0x0c0
+#define _PMD_SIZE_16M	0x0e0
+
+#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
+
+/* Until my rework is finished, 40x still needs atomic PTE updates */
+#define PTE_ATOMIC_UPDATES	1
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_40x_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-44x.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-44x.h	2009-02-24 11:40:02.000000000 +1100
@@ -0,0 +1,102 @@
+#ifndef _ASM_POWERPC_PGTABLE_44x_H
+#define _ASM_POWERPC_PGTABLE_44x_H
+#ifdef __KERNEL__
+
+/*
+ * Definitions for PPC440
+ *
+ * Because of the 3 word TLB entries to support 36-bit addressing,
+ * the attribute are difficult to map in such a fashion that they
+ * are easily loaded during exception processing.  I decided to
+ * organize the entry so the ERPN is the only portion in the
+ * upper word of the PTE and the attribute bits below are packed
+ * in as sensibly as they can be in the area below a 4KB page size
+ * oriented RPN.  This at least makes it easy to load the RPN and
+ * ERPN fields in the TLB. -Matt
+ *
+ * This isn't entirely true anymore, at least some bits are now
+ * easier to move into the TLB from the PTE. -BenH.
+ *
+ * Note that these bits preclude future use of a page size
+ * less than 4KB.
+ *
+ *
+ * PPC 440 core has following TLB attribute fields;
+ *
+ *   TLB1:
+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
+ *   RPN.................................  -  -  -  -  -  - ERPN.......
+ *
+ *   TLB2:
+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
+ *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW SR
+ *
+ * Newer 440 cores (440x6 as used on AMCC 460EX/460GT) have additional
+ * TLB2 storage attibute fields. Those are:
+ *
+ *   TLB2:
+ *   0...10    11   12   13   14   15   16...31
+ *   no change WL1  IL1I IL1D IL2I IL2D no change
+ *
+ * There are some constrains and options, to decide mapping software bits
+ * into TLB entry.
+ *
+ *   - PRESENT *must* be in the bottom three bits because swap cache
+ *     entries use the top 29 bits for TLB2.
+ *
+ *   - FILE *must* be in the bottom three bits because swap cache
+ *     entries use the top 29 bits for TLB2.
+ *
+ *   - CACHE COHERENT bit (M) has no effect on original PPC440 cores,
+ *     because it doesn't support SMP. However, some later 460 variants
+ *     have -some- form of SMP support and so I keep the bit there for
+ *     future use
+ *
+ * With the PPC 44x Linux implementation, the 0-11th LSBs of the PTE are used
+ * for memory protection related functions (see PTE structure in
+ * include/asm-ppc/mmu.h).  The _PAGE_XXX definitions in this file map to the
+ * above bits.  Note that the bit values are CPU specific, not architecture
+ * specific.
+ *
+ * The kernel PTE entry holds an arch-dependent swp_entry structure under
+ * certain situations. In other words, in such situations some portion of
+ * the PTE bits are used as a swp_entry. In the PPC implementation, the
+ * 3-24th LSB are shared with swp_entry, however the 0-2nd three LSB still
+ * hold protection values. That means the three protection bits are
+ * reserved for both PTE and SWAP entry at the most significant three
+ * LSBs.
+ *
+ * There are three protection bits available for SWAP entry:
+ *	_PAGE_PRESENT
+ *	_PAGE_FILE
+ *	_PAGE_HASHPTE (if HW has)
+ *
+ * So those three bits have to be inside of 0-2nd LSB of PTE.
+ *
+ */
+
+#define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
+#define _PAGE_RW	0x00000002		/* S: Write permission */
+#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
+#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
+#define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
+#define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
+#define _PAGE_SPECIAL	0x00000020		/* S: Special page */
+#define _PAGE_USER	0x00000040		/* S: User page */
+#define _PAGE_ENDIAN	0x00000080		/* H: E bit */
+#define _PAGE_GUARDED	0x00000100		/* H: G bit */
+#define _PAGE_COHERENT	0x00000200		/* H: M bit */
+#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
+#define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
+
+/* TODO: Add large page lowmem mapping support */
+#define _PMD_PRESENT	0
+#define _PMD_PRESENT_MASK (PAGE_MASK)
+#define _PMD_BAD	(~PAGE_MASK)
+
+/* ERPN in a PTE never gets cleared, ignore it */
+#define _PTE_NONE_MASK	0xffffffff00000000ULL
+
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_44x_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-8xx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-8xx.h	2009-02-24 11:35:17.000000000 +1100
@@ -0,0 +1,64 @@
+#ifndef _ASM_POWERPC_PGTABLE_8xx_H
+#define _ASM_POWERPC_PGTABLE_8xx_H
+#ifdef __KERNEL__
+
+/*
+ * The PowerPC MPC8xx uses a TLB with hardware assisted, software tablewalk.
+ * We also use the two level tables, but we can put the real bits in them
+ * needed for the TLB and tablewalk.  These definitions require Mx_CTR.PPM = 0,
+ * Mx_CTR.PPCS = 0, and MD_CTR.TWAM = 1.  The level 2 descriptor has
+ * additional page protection (when Mx_CTR.PPCS = 1) that allows TLB hit
+ * based upon user/super access.  The TLB does not have accessed nor write
+ * protect.  We assume that if the TLB get loaded with an entry it is
+ * accessed, and overload the changed bit for write protect.  We use
+ * two bits in the software pte that are supposed to be set to zero in
+ * the TLB entry (24 and 25) for these indicators.  Although the level 1
+ * descriptor contains the guarded and writethrough/copyback bits, we can
+ * set these at the page level since they get copied from the Mx_TWC
+ * register when the TLB entry is loaded.  We will use bit 27 for guard, since
+ * that is where it exists in the MD_TWC, and bit 26 for writethrough.
+ * These will get masked from the level 2 descriptor at TLB load time, and
+ * copied to the MD_TWC before it gets loaded.
+ * Large page sizes added.  We currently support two sizes, 4K and 8M.
+ * This also allows a TLB hander optimization because we can directly
+ * load the PMD into MD_TWC.  The 8M pages are only used for kernel
+ * mapping of well known areas.  The PMD (PGD) entries contain control
+ * flags in addition to the address, so care must be taken that the
+ * software no longer assumes these are only pointers.
+ */
+
+/* Definitions for 8xx embedded chips. */
+#define _PAGE_PRESENT	0x0001	/* Page is valid */
+#define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
+#define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
+#define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
+
+/* These five software bits must be masked out when the entry is loaded
+ * into the TLB.
+ */
+#define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
+#define _PAGE_GUARDED	0x0010	/* software: guarded access */
+#define _PAGE_DIRTY	0x0020	/* software: page changed */
+#define _PAGE_RW	0x0040	/* software: user write access allowed */
+#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
+
+/* Setting any bits in the nibble with the follow two controls will
+ * require a TLB exception handler change.  It is assumed unused bits
+ * are always zero.
+ */
+#define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
+#define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */
+
+#define _PMD_PRESENT	0x0001
+#define _PMD_BAD	0x0ff0
+#define _PMD_PAGE_MASK	0x000c
+#define _PMD_PAGE_8M	0x000c
+
+#define _PTE_NONE_MASK _PAGE_ACCESSED
+
+/* Until my rework is finished, 8xx still needs atomic PTE updates */
+#define PTE_ATOMIC_UPDATES	1
+
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_8xx_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-fsl-booke.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-fsl-booke.h	2009-02-24 11:41:32.000000000 +1100
@@ -0,0 +1,46 @@
+#ifndef _ASM_POWERPC_PGTABLE_FSL_BOOKE_H
+#define _ASM_POWERPC_PGTABLE_FSL_BOOKE_H
+#ifdef __KERNEL__
+
+/* PTE bit definitions for Freescale BookE SW loaded TLB MMU based
+ * processors
+ *
+   MMU Assist Register 3:
+
+   32 33 34 35 36  ... 50 51 52 53 54 55 56 57 58 59 60 61 62 63
+   RPN......................  0  0 U0 U1 U2 U3 UX SX UW SW UR SR
+
+   - PRESENT *must* be in the bottom three bits because swap cache
+     entries use the top 29 bits.
+
+   - FILE *must* be in the bottom three bits because swap cache
+     entries use the top 29 bits.
+*/
+
+/* Definitions for FSL Book-E Cores */
+#define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
+#define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
+#define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
+#define _PAGE_RW	0x00004	/* S: Write permission (SW) */
+#define _PAGE_DIRTY	0x00008	/* S: Page dirty */
+#define _PAGE_HWEXEC	0x00010	/* H: SX permission */
+#define _PAGE_ACCESSED	0x00020	/* S: Page referenced */
+
+#define _PAGE_ENDIAN	0x00040	/* H: E bit */
+#define _PAGE_GUARDED	0x00080	/* H: G bit */
+#define _PAGE_COHERENT	0x00100	/* H: M bit */
+#define _PAGE_NO_CACHE	0x00200	/* H: I bit */
+#define _PAGE_WRITETHRU	0x00400	/* H: W bit */
+#define _PAGE_SPECIAL	0x00800 /* S: Special page */
+
+#ifdef CONFIG_PTE_64BIT
+/* ERPN in a PTE never gets cleared, ignore it */
+#define _PTE_NONE_MASK	0xffffffffffff0000ULL
+#endif
+
+#define _PMD_PRESENT	0
+#define _PMD_PRESENT_MASK (PAGE_MASK)
+#define _PMD_BAD	(~PAGE_MASK)
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_FSL_BOOKE_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-hash32.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-hash32.h	2009-02-24 11:26:58.000000000 +1100
@@ -0,0 +1,49 @@
+#ifndef _ASM_POWERPC_PGTABLE_HASH32_H
+#define _ASM_POWERPC_PGTABLE_HASH32_H
+#ifdef __KERNEL__
+
+/*
+ * The "classic" 32-bit implementation of the PowerPC MMU uses a hash
+ * table containing PTEs, together with a set of 16 segment registers,
+ * to define the virtual to physical address mapping.
+ *
+ * We use the hash table as an extended TLB, i.e. a cache of currently
+ * active mappings.  We maintain a two-level page table tree, much
+ * like that used by the i386, for the sake of the Linux memory
+ * management code.  Low-level assembler code in hash_low_32.S
+ * (procedure hash_page) is responsible for extracting ptes from the
+ * tree and putting them into the hash table when necessary, and
+ * updating the accessed and modified bits in the page table tree.
+ */
+
+#define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
+#define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
+#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
+#define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
+#define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
+#define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
+#define _PAGE_WRITETHRU	0x040	/* W: cache write-through */
+#define _PAGE_DIRTY	0x080	/* C: page changed */
+#define _PAGE_ACCESSED	0x100	/* R: page referenced */
+#define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
+#define _PAGE_RW	0x400	/* software: user write access allowed */
+#define _PAGE_SPECIAL	0x800	/* software: Special page */
+
+#ifdef CONFIG_PTE_64BIT
+/* We never clear the high word of the pte */
+#define _PTE_NONE_MASK	(0xffffffff00000000ULL | _PAGE_HASHPTE)
+#else
+#define _PTE_NONE_MASK	_PAGE_HASHPTE
+#endif
+
+#define _PMD_PRESENT	0
+#define _PMD_PRESENT_MASK (PAGE_MASK)
+#define _PMD_BAD	(~PAGE_MASK)
+
+/* Hash table based platforms need atomic updates of the linux PTE */
+#define PTE_ATOMIC_UPDATES	1
+
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_HASH32_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc32.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2009-02-24 11:21:44.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2009-02-24 11:47:04.000000000 +1100
@@ -19,55 +19,6 @@ extern int icache_44x_need_flush;
 #endif /* __ASSEMBLY__ */
 
 /*
- * The PowerPC MMU uses a hash table containing PTEs, together with
- * a set of 16 segment registers (on 32-bit implementations), to define
- * the virtual to physical address mapping.
- *
- * We use the hash table as an extended TLB, i.e. a cache of currently
- * active mappings.  We maintain a two-level page table tree, much
- * like that used by the i386, for the sake of the Linux memory
- * management code.  Low-level assembler code in hashtable.S
- * (procedure hash_page) is responsible for extracting ptes from the
- * tree and putting them into the hash table when necessary, and
- * updating the accessed and modified bits in the page table tree.
- */
-
-/*
- * The PowerPC MPC8xx uses a TLB with hardware assisted, software tablewalk.
- * We also use the two level tables, but we can put the real bits in them
- * needed for the TLB and tablewalk.  These definitions require Mx_CTR.PPM = 0,
- * Mx_CTR.PPCS = 0, and MD_CTR.TWAM = 1.  The level 2 descriptor has
- * additional page protection (when Mx_CTR.PPCS = 1) that allows TLB hit
- * based upon user/super access.  The TLB does not have accessed nor write
- * protect.  We assume that if the TLB get loaded with an entry it is
- * accessed, and overload the changed bit for write protect.  We use
- * two bits in the software pte that are supposed to be set to zero in
- * the TLB entry (24 and 25) for these indicators.  Although the level 1
- * descriptor contains the guarded and writethrough/copyback bits, we can
- * set these at the page level since they get copied from the Mx_TWC
- * register when the TLB entry is loaded.  We will use bit 27 for guard, since
- * that is where it exists in the MD_TWC, and bit 26 for writethrough.
- * These will get masked from the level 2 descriptor at TLB load time, and
- * copied to the MD_TWC before it gets loaded.
- * Large page sizes added.  We currently support two sizes, 4K and 8M.
- * This also allows a TLB hander optimization because we can directly
- * load the PMD into MD_TWC.  The 8M pages are only used for kernel
- * mapping of well known areas.  The PMD (PGD) entries contain control
- * flags in addition to the address, so care must be taken that the
- * software no longer assumes these are only pointers.
- */
-
-/*
- * At present, all PowerPC 400-class processors share a similar TLB
- * architecture. The instruction and data sides share a unified,
- * 64-entry, fully-associative TLB which is maintained totally under
- * software control. In addition, the instruction side has a
- * hardware-managed, 4-entry, fully-associative TLB which serves as a
- * first level to the shared TLB. These two TLBs are known as the UTLB
- * and ITLB, respectively (see "mmu.h" for definitions).
- */
-
-/*
  * The normal case is that PTEs are 32-bits and we have a 1-page
  * 1024-entry pgdir pointing to 1-page 1024-entry PTE pages.  -- paulus
  *
@@ -135,261 +86,25 @@ extern int icache_44x_need_flush;
  */
 
 #if defined(CONFIG_40x)
-
-/* There are several potential gotchas here.  The 40x hardware TLBLO
-   field looks like this:
-
-   0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
-   RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G
-
-   Where possible we make the Linux PTE bits match up with this
-
-   - bits 20 and 21 must be cleared, because we use 4k pages (40x can
-     support down to 1k pages), this is done in the TLBMiss exception
-     handler.
-   - We use only zones 0 (for kernel pages) and 1 (for user pages)
-     of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
-     miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
-     zone.
-   - PRESENT *must* be in the bottom two bits because swap cache
-     entries use the top 30 bits.  Because 40x doesn't support SMP
-     anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
-     is cleared in the TLB miss handler before the TLB entry is loaded.
-   - All other bits of the PTE are loaded into TLBLO without
-     modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
-     software PTE bits.  We actually use use bits 21, 24, 25, and
-     30 respectively for the software bits: ACCESSED, DIRTY, RW, and
-     PRESENT.
-*/
-
-/* Definitions for 40x embedded chips. */
-#define	_PAGE_GUARDED	0x001	/* G: page is guarded from prefetch */
-#define _PAGE_FILE	0x001	/* when !present: nonlinear file mapping */
-#define _PAGE_PRESENT	0x002	/* software: PTE contains a translation */
-#define	_PAGE_NO_CACHE	0x004	/* I: caching is inhibited */
-#define	_PAGE_WRITETHRU	0x008	/* W: caching is write-through */
-#define	_PAGE_USER	0x010	/* matches one of the zone permission bits */
-#define	_PAGE_RW	0x040	/* software: Writes permitted */
-#define	_PAGE_DIRTY	0x080	/* software: dirty page */
-#define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
-#define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
-#define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
-
-#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
-#define _PMD_BAD	0x802
-#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
-#define _PMD_SIZE_4M	0x0c0
-#define _PMD_SIZE_16M	0x0e0
-#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
-
-/* Until my rework is finished, 40x still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
+#include <asm/pgtable-40x.h>
 #elif defined(CONFIG_44x)
-/*
- * Definitions for PPC440
- *
- * Because of the 3 word TLB entries to support 36-bit addressing,
- * the attribute are difficult to map in such a fashion that they
- * are easily loaded during exception processing.  I decided to
- * organize the entry so the ERPN is the only portion in the
- * upper word of the PTE and the attribute bits below are packed
- * in as sensibly as they can be in the area below a 4KB page size
- * oriented RPN.  This at least makes it easy to load the RPN and
- * ERPN fields in the TLB. -Matt
- *
- * Note that these bits preclude future use of a page size
- * less than 4KB.
- *
- *
- * PPC 440 core has following TLB attribute fields;
- *
- *   TLB1:
- *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
- *   RPN.................................  -  -  -  -  -  - ERPN.......
- *
- *   TLB2:
- *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
- *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW SR
- *
- * Newer 440 cores (440x6 as used on AMCC 460EX/460GT) have additional
- * TLB2 storage attibute fields. Those are:
- *
- *   TLB2:
- *   0...10    11   12   13   14   15   16...31
- *   no change WL1  IL1I IL1D IL2I IL2D no change
- *
- * There are some constrains and options, to decide mapping software bits
- * into TLB entry.
- *
- *   - PRESENT *must* be in the bottom three bits because swap cache
- *     entries use the top 29 bits for TLB2.
- *
- *   - FILE *must* be in the bottom three bits because swap cache
- *     entries use the top 29 bits for TLB2.
- *
- *   - CACHE COHERENT bit (M) has no effect on original PPC440 cores,
- *     because it doesn't support SMP. However, some later 460 variants
- *     have -some- form of SMP support and so I keep the bit there for
- *     future use
- *
- * With the PPC 44x Linux implementation, the 0-11th LSBs of the PTE are used
- * for memory protection related functions (see PTE structure in
- * include/asm-ppc/mmu.h).  The _PAGE_XXX definitions in this file map to the
- * above bits.  Note that the bit values are CPU specific, not architecture
- * specific.
- *
- * The kernel PTE entry holds an arch-dependent swp_entry structure under
- * certain situations. In other words, in such situations some portion of
- * the PTE bits are used as a swp_entry. In the PPC implementation, the
- * 3-24th LSB are shared with swp_entry, however the 0-2nd three LSB still
- * hold protection values. That means the three protection bits are
- * reserved for both PTE and SWAP entry at the most significant three
- * LSBs.
- *
- * There are three protection bits available for SWAP entry:
- *	_PAGE_PRESENT
- *	_PAGE_FILE
- *	_PAGE_HASHPTE (if HW has)
- *
- * So those three bits have to be inside of 0-2nd LSB of PTE.
- *
- */
-
-#define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
-#define _PAGE_RW	0x00000002		/* S: Write permission */
-#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
-#define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
-#define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
-#define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
-#define _PAGE_SPECIAL	0x00000020		/* S: Special page */
-#define _PAGE_USER	0x00000040		/* S: User page */
-#define _PAGE_ENDIAN	0x00000080		/* H: E bit */
-#define _PAGE_GUARDED	0x00000100		/* H: G bit */
-#define _PAGE_COHERENT	0x00000200		/* H: M bit */
-#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
-#define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
-
-/* TODO: Add large page lowmem mapping support */
-#define _PMD_PRESENT	0
-#define _PMD_PRESENT_MASK (PAGE_MASK)
-#define _PMD_BAD	(~PAGE_MASK)
-
-/* ERPN in a PTE never gets cleared, ignore it */
-#define _PTE_NONE_MASK	0xffffffff00000000ULL
-
-#define __HAVE_ARCH_PTE_SPECIAL
-
+#include <asm/pgtable-44x.h>
 #elif defined(CONFIG_FSL_BOOKE)
-/*
-   MMU Assist Register 3:
-
-   32 33 34 35 36  ... 50 51 52 53 54 55 56 57 58 59 60 61 62 63
-   RPN......................  0  0 U0 U1 U2 U3 UX SX UW SW UR SR
-
-   - PRESENT *must* be in the bottom three bits because swap cache
-     entries use the top 29 bits.
-
-   - FILE *must* be in the bottom three bits because swap cache
-     entries use the top 29 bits.
-*/
-
-/* Definitions for FSL Book-E Cores */
-#define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
-#define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
-#define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
-#define _PAGE_RW	0x00004	/* S: Write permission (SW) */
-#define _PAGE_DIRTY	0x00008	/* S: Page dirty */
-#define _PAGE_HWEXEC	0x00010	/* H: SX permission */
-#define _PAGE_ACCESSED	0x00020	/* S: Page referenced */
-
-#define _PAGE_ENDIAN	0x00040	/* H: E bit */
-#define _PAGE_GUARDED	0x00080	/* H: G bit */
-#define _PAGE_COHERENT	0x00100	/* H: M bit */
-#define _PAGE_NO_CACHE	0x00200	/* H: I bit */
-#define _PAGE_WRITETHRU	0x00400	/* H: W bit */
-#define _PAGE_SPECIAL	0x00800 /* S: Special page */
-
-#ifdef CONFIG_PTE_64BIT
-/* ERPN in a PTE never gets cleared, ignore it */
-#define _PTE_NONE_MASK	0xffffffffffff0000ULL
-#endif
-
-#define _PMD_PRESENT	0
-#define _PMD_PRESENT_MASK (PAGE_MASK)
-#define _PMD_BAD	(~PAGE_MASK)
-
-#define __HAVE_ARCH_PTE_SPECIAL
-
+#include <asm/pgtable-fsl-booke.h>
 #elif defined(CONFIG_8xx)
-/* Definitions for 8xx embedded chips. */
-#define _PAGE_PRESENT	0x0001	/* Page is valid */
-#define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
-#define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
-#define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
-
-/* These five software bits must be masked out when the entry is loaded
- * into the TLB.
- */
-#define _PAGE_EXEC	0x0008	/* software: i-cache coherency required */
-#define _PAGE_GUARDED	0x0010	/* software: guarded access */
-#define _PAGE_DIRTY	0x0020	/* software: page changed */
-#define _PAGE_RW	0x0040	/* software: user write access allowed */
-#define _PAGE_ACCESSED	0x0080	/* software: page referenced */
-
-/* Setting any bits in the nibble with the follow two controls will
- * require a TLB exception handler change.  It is assumed unused bits
- * are always zero.
- */
-#define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
-#define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */
-
-#define _PMD_PRESENT	0x0001
-#define _PMD_BAD	0x0ff0
-#define _PMD_PAGE_MASK	0x000c
-#define _PMD_PAGE_8M	0x000c
-
-#define _PTE_NONE_MASK _PAGE_ACCESSED
-
-/* Until my rework is finished, 8xx still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
+#include <asm/pgtable-8xx.h>
 #else /* CONFIG_6xx */
-/* Definitions for 60x, 740/750, etc. */
-#define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
-#define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
-#define _PAGE_USER	0x004	/* usermode access allowed */
-#define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
-#define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
-#define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
-#define _PAGE_WRITETHRU	0x040	/* W: cache write-through */
-#define _PAGE_DIRTY	0x080	/* C: page changed */
-#define _PAGE_ACCESSED	0x100	/* R: page referenced */
-#define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
-#define _PAGE_RW	0x400	/* software: user write access allowed */
-#define _PAGE_SPECIAL	0x800	/* software: Special page */
-
-#ifdef CONFIG_PTE_64BIT
-/* We never clear the high word of the pte */
-#define _PTE_NONE_MASK	(0xffffffff00000000ULL | _PAGE_HASHPTE)
-#else
-#define _PTE_NONE_MASK	_PAGE_HASHPTE
+#include <asm/pgtable-hash32.h>
 #endif
 
-#define _PMD_PRESENT	0
-#define _PMD_PRESENT_MASK (PAGE_MASK)
-#define _PMD_BAD	(~PAGE_MASK)
-
-/* Hash table based platforms need atomic updates of the linux PTE */
-#define PTE_ATOMIC_UPDATES	1
-
+/* If _PAGE_SPECIAL is defined, then we advertise our support for it */
+#ifdef _PAGE_SPECIAL
 #define __HAVE_ARCH_PTE_SPECIAL
-
 #endif
 
 /*
- * Some bits are only used on some cpu families...
+ * Some bits are only used on some cpu families... Make sure that all
+ * the undefined gets defined as 0
  */
 #ifndef _PAGE_HASHPTE
 #define _PAGE_HASHPTE	0
@@ -600,11 +315,19 @@ extern void flush_hash_entry(struct mm_s
 			     unsigned long address);
 
 /*
- * Atomic PTE updates.
- *
- * pte_update clears and sets bit atomically, and returns
- * the old pte value.  In the 64-bit PTE case we lock around the
- * low PTE word since we expect ALL flag bits to be there
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
  */
 #ifndef CONFIG_PTE_64BIT
 static inline unsigned long pte_update(pte_t *p,
Index: linux-work/arch/powerpc/include/asm/pgtable-hash64-4k.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-hash64-4k.h	2009-02-18 13:20:35.000000000 +1100
@@ -0,0 +1,117 @@
+#ifndef _ASM_POWERPC_PGTABLE_4K_H
+#define _ASM_POWERPC_PGTABLE_4K_H
+/*
+ * Entries per page directory level.  The PTE level must use a 64b record
+ * for each page table entry.  The PMD and PGD level use a 32b record for
+ * each entry by assuming that each entry is page aligned.
+ */
+#define PTE_INDEX_SIZE  9
+#define PMD_INDEX_SIZE  7
+#define PUD_INDEX_SIZE  7
+#define PGD_INDEX_SIZE  9
+
+#ifndef __ASSEMBLY__
+#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
+#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
+#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+#endif	/* __ASSEMBLY__ */
+
+#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
+#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PUD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
+
+/* PMD_SHIFT determines what a second-level page table entry can map */
+#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/* With 4k base page size, hugepage PTEs go at the PMD level */
+#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
+
+/* PUD_SHIFT determines what a third-level page table entry can map */
+#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+
+/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
+#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/* PTE bits */
+#define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
+#define _PAGE_SECONDARY 0x8000 /* software: HPTE is in secondary group */
+#define _PAGE_GROUP_IX  0x7000 /* software: HPTE index within group */
+#define _PAGE_F_SECOND  _PAGE_SECONDARY
+#define _PAGE_F_GIX     _PAGE_GROUP_IX
+#define _PAGE_SPECIAL	0x10000 /* software: special page */
+#define __HAVE_ARCH_PTE_SPECIAL
+
+/* PTE flags to conserve for HPTE identification */
+#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
+			 _PAGE_SECONDARY | _PAGE_GROUP_IX)
+
+/* There is no 4K PFN hack on 4K pages */
+#define _PAGE_4K_PFN	0
+
+/* PAGE_MASK gives the right answer below, but only by accident */
+/* It should be preserving the high 48 bits and then specifically */
+/* preserving _PAGE_SECONDARY | _PAGE_GROUP_IX */
+#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
+                         _PAGE_HPTEFLAGS | _PAGE_SPECIAL)
+
+/* Bits to mask out from a PMD to get to the PTE page */
+#define PMD_MASKED_BITS		0
+/* Bits to mask out from a PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0
+/* Bits to mask out from a PGD to get to the PUD page */
+#define PGD_MASKED_BITS		0
+
+/* shift to put page number into pte */
+#define PTE_RPN_SHIFT	(17)
+
+#ifdef STRICT_MM_TYPECHECKS
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
+#ifdef CONFIG_PPC_HAS_HASH_64K
+#define pte_pagesize_index(mm, addr, pte)	get_slice_psize(mm, addr)
+#else
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+#endif
+
+/*
+ * 4-level page tables related bits
+ */
+
+#define pgd_none(pgd)		(!pgd_val(pgd))
+#define pgd_bad(pgd)		(pgd_val(pgd) == 0)
+#define pgd_present(pgd)	(pgd_val(pgd) != 0)
+#define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
+#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page(pgd)		virt_to_page(pgd_page_vaddr(pgd))
+
+#define pud_offset(pgdp, addr)	\
+  (((pud_t *) pgd_page_vaddr(*(pgdp))) + \
+    (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
+
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
+
+#define remap_4k_pfn(vma, addr, pfn, prot)	\
+	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
+#endif /* _ASM_POWERPC_PGTABLE_4K_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-hash64-64k.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-hash64-64k.h	2009-02-18 13:20:35.000000000 +1100
@@ -0,0 +1,155 @@
+#ifndef _ASM_POWERPC_PGTABLE_64K_H
+#define _ASM_POWERPC_PGTABLE_64K_H
+
+#include <asm-generic/pgtable-nopud.h>
+
+
+#define PTE_INDEX_SIZE  12
+#define PMD_INDEX_SIZE  12
+#define PUD_INDEX_SIZE	0
+#define PGD_INDEX_SIZE  4
+
+#ifndef __ASSEMBLY__
+#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+
+#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
+#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
+
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
+#undef PGD_TABLE_SIZE
+#define PGD_TABLE_SIZE		((sizeof(pgd_t) << PGD_INDEX_SIZE) + \
+				 sizeof(struct subpage_prot_table))
+
+#define SBP_L1_BITS		(PAGE_SHIFT - 2)
+#define SBP_L2_BITS		(PAGE_SHIFT - 3)
+#define SBP_L1_COUNT		(1 << SBP_L1_BITS)
+#define SBP_L2_COUNT		(1 << SBP_L2_BITS)
+#define SBP_L2_SHIFT		(PAGE_SHIFT + SBP_L1_BITS)
+#define SBP_L3_SHIFT		(SBP_L2_SHIFT + SBP_L2_BITS)
+
+extern void subpage_prot_free(pgd_t *pgd);
+
+static inline struct subpage_prot_table *pgd_subpage_prot(pgd_t *pgd)
+{
+	return (struct subpage_prot_table *)(pgd + PTRS_PER_PGD);
+}
+#endif /* CONFIG_PPC_SUBPAGE_PROT */
+#endif	/* __ASSEMBLY__ */
+
+/* With 4k base page size, hugepage PTEs go at the PMD level */
+#define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
+
+/* PMD_SHIFT determines what a second-level page table entry can map */
+#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+#define PGDIR_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/* Additional PTE bits (don't change without checking asm in hash_low.S) */
+#define __HAVE_ARCH_PTE_SPECIAL
+#define _PAGE_SPECIAL	0x00000400 /* software: special page */
+#define _PAGE_HPTE_SUB	0x0ffff000 /* combo only: sub pages HPTE bits */
+#define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
+#define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
+#define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
+
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
+
+/* Note the full page bits must be in the same location as for normal
+ * 4k pages as the same asssembly will be used to insert 64K pages
+ * wether the kernel has CONFIG_PPC_64K_PAGES or not
+ */
+#define _PAGE_F_SECOND  0x00008000 /* full page: hidx bits */
+#define _PAGE_F_GIX     0x00007000 /* full page: hidx bits */
+
+/* PTE flags to conserve for HPTE identification */
+#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)
+
+/* Shift to put page number into pte.
+ *
+ * That gives us a max RPN of 34 bits, which means a max of 50 bits
+ * of addressable physical space, or 46 bits for the special 4k PFNs.
+ */
+#define PTE_RPN_SHIFT	(30)
+#define PTE_RPN_MAX	(1UL << (64 - PTE_RPN_SHIFT))
+#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved accross
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+                         _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+/* Bits to mask out from a PMD to get to the PTE page */
+#define PMD_MASKED_BITS		0x1ff
+/* Bits to mask out from a PGD/PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0x1ff
+
+/* Manipulate "rpte" values */
+#define __real_pte(e,p) 	((real_pte_t) { \
+	(e), pte_val(*((p) + PTRS_PER_PTE)) })
+#define __rpte_to_hidx(r,index)	((pte_val((r).pte) & _PAGE_COMBO) ? \
+        (((r).hidx >> ((index)<<2)) & 0xf) : ((pte_val((r).pte) >> 12) & 0xf))
+#define __rpte_to_pte(r)	((r).pte)
+#define __rpte_sub_valid(rpte, index) \
+	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
+
+
+/* Trick: we set __end to va + 64k, which happens works for
+ * a 16M page as well as we want only one iteration
+ */
+#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)	    \
+        do {                                                                \
+                unsigned long __end = va + PAGE_SIZE;                       \
+                unsigned __split = (psize == MMU_PAGE_4K ||                 \
+				    psize == MMU_PAGE_64K_AP);              \
+                shift = mmu_psize_defs[psize].shift;                        \
+		for (index = 0; va < __end; index++, va += (1L << shift)) { \
+		        if (!__split || __rpte_sub_valid(rpte, index)) do { \
+
+#define pte_iterate_hashed_end() } while(0); } } while(0)
+
+#define pte_pagesize_index(mm, addr, pte)	\
+	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
+
+#define remap_4k_pfn(vma, addr, pfn, prot)				\
+	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
+			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
+
+#endif /* _ASM_POWERPC_PGTABLE_64K_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-hash64.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pgtable-hash64.h	2009-02-24 11:54:48.000000000 +1100
@@ -0,0 +1,47 @@
+#ifndef _ASM_POWERPC_PGTABLE_HASH64_H
+#define _ASM_POWERPC_PGTABLE_HASH64_H
+#ifdef __KERNEL__
+
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/pgtable-hash64-64k.h>
+#else
+#include <asm/pgtable-hash64-4k.h>
+#endif
+
+/*
+ * Common bits between 4K and 64K pages in a linux-style PTE.
+ * These match the bits in the (hardware-defined) PowerPC PTE as closely
+ * as possible. Additional bits may be defined in pgtable-hash64-*.h
+ */
+#define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
+#define _PAGE_USER	0x0002 /* matches one of the PP bits */
+#define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
+#define _PAGE_EXEC	0x0004 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_GUARDED	0x0008
+#define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
+#define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
+#define _PAGE_WRITETHRU	0x0040 /* W: cache write-through */
+#define _PAGE_DIRTY	0x0080 /* C: page changed */
+#define _PAGE_ACCESSED	0x0100 /* R: page referenced */
+#define _PAGE_RW	0x0200 /* software: user write access allowed */
+#define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */
+
+/* Strong Access Ordering */
+#define _PAGE_SAO	(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
+
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
+
+#define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
+
+/* PTEIDX nibble */
+#define _PTEIDX_SECONDARY	0x8
+#define _PTEIDX_GROUP_IX	0x7
+
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
+			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
+			 _PAGE_4K_PFN | _PAGE_RW | _PAGE_USER |		\
+			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
+
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PGTABLE_HASH64_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-02-24 11:52:20.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-02-24 12:42:24.000000000 +1100
@@ -10,11 +10,6 @@
 #include <asm/tlbflush.h>
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_PPC_64K_PAGES
-#include <asm/pgtable-64k.h>
-#else
-#include <asm/pgtable-4k.h>
-#endif
 
 #define FIRST_USER_ADDRESS	0
 
@@ -25,15 +20,6 @@
                 	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
-#if TASK_SIZE_USER64 > PGTABLE_RANGE
-#error TASK_SIZE_USER64 exceeds pagetable range
-#endif
-
-#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
-#error TASK_SIZE_USER64 exceeds user VSID range
-#endif
-
-
 /*
  * Define the address range of the vmalloc VM area.
  */
@@ -75,30 +61,17 @@
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
 
-/*
- * Common bits in a linux-style PTE.  These match the bits in the
- * (hardware-defined) PowerPC PTE as closely as possible. Additional
- * bits may be defined in pgtable-*.h
- */
-#define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
-#define _PAGE_USER	0x0002 /* matches one of the PP bits */
-#define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
-#define _PAGE_EXEC	0x0004 /* No execute on POWER4 and newer (we invert) */
-#define _PAGE_GUARDED	0x0008
-#define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
-#define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
-#define _PAGE_WRITETHRU	0x0040 /* W: cache write-through */
-#define _PAGE_DIRTY	0x0080 /* C: page changed */
-#define _PAGE_ACCESSED	0x0100 /* R: page referenced */
-#define _PAGE_RW	0x0200 /* software: user write access allowed */
-#define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */
+#include <asm/pgtable-hash64.h>
 
-/* Strong Access Ordering */
-#define _PAGE_SAO	(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
+/* Some sanity checking */
+#if TASK_SIZE_USER64 > PGTABLE_RANGE
+#error TASK_SIZE_USER64 exceeds pagetable range
+#endif
 
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
+#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
+#error TASK_SIZE_USER64 exceeds user VSID range
+#endif
 
-#define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
 
 /* __pgprot defined in arch/powerpc/include/asm/page.h */
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
@@ -117,16 +90,10 @@
 #define PAGE_AGP	__pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_NO_CACHE)
 #define HAVE_PAGE_AGP
 
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
-			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
-			 _PAGE_4K_PFN | _PAGE_RW | _PAGE_USER |		\
-			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
-/* PTEIDX nibble */
-#define _PTEIDX_SECONDARY	0x8
-#define _PTEIDX_GROUP_IX	0x7
-
 /* To make some generic powerpc code happy */
+#ifndef _PAGE_HWEXEC
 #define _PAGE_HWEXEC		0
+#endif
 
 /*
  * POWER4 and newer have per page execute protection, older chips can only

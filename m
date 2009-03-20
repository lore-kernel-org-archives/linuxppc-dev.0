Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 20 Mar 2009 16:34:08 +1100
Subject: [PATCH 1/6] powerpc/mm: Tweak PTE bit combination definitions (v3)
Message-Id: <1237527248.890279.946079812092.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch tweaks the way some PTE bit combinations are defined, in such a
way that the 32 and 64-bit variant become almost identical and that will
make it easier to bring in a new common pte-* file for the new variant
of the Book3-E support.

The combination of bits defining access to kernel pages are now clearly
separated from the combination used by userspace and the core VM. The
resulting generated code should remain identical unless I made a mistake.

Note: While at it, I removed a non-sensical statement related to CONFIG_KGDB
in ppc_mmu_32.c which could cause kernel mappings to be user accessible when
that option is enabled. Probably something that bitrot.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Fix mixup with next patch
v3: Fix loss of PAGE_KERNEL_EXEC which broke modules on ppc64

 arch/powerpc/include/asm/fixmap.h        |    2 -
 arch/powerpc/include/asm/pgtable-ppc32.h |   39 ++++++++++++-------------
 arch/powerpc/include/asm/pgtable-ppc64.h |   46 +++++++++++++++++++-----------
 arch/powerpc/include/asm/pgtable.h       |    4 ++
 arch/powerpc/include/asm/pte-8xx.h       |    3 +
 arch/powerpc/include/asm/pte-hash32.h    |    1 
 arch/powerpc/include/asm/pte-hash64-4k.h |    3 -
 arch/powerpc/include/asm/pte-hash64.h    |   47 +++++++++++++++++--------------
 arch/powerpc/mm/fsl_booke_mmu.c          |    2 -
 arch/powerpc/mm/pgtable_32.c             |    4 +-
 arch/powerpc/mm/ppc_mmu_32.c             |   10 +-----
 arch/powerpc/sysdev/cpm_common.c         |    2 -
 12 files changed, 88 insertions(+), 75 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:46:06.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:49:51.000000000 +1100
@@ -81,11 +81,6 @@
  */
 #include <asm/pte-hash64.h>
 
-/* To make some generic powerpc code happy */
-#ifndef _PAGE_HWEXEC
-#define _PAGE_HWEXEC		0
-#endif
-
 /* Some other useful definitions */
 #define PTE_RPN_MAX	(1UL << (64 - PTE_RPN_SHIFT))
 #define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
@@ -96,28 +91,44 @@
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
                          _PAGE_ACCESSED | _PAGE_SPECIAL)
 
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 
 
-/* __pgprot defined in arch/powerpc/include/asm/page.h */
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
-
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_USER)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_USER | _PAGE_EXEC)
+/* Permission masks used to generate the __P and __S table,
+ *
+ * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
+ */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
 #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
-#define PAGE_KERNEL_CI	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | \
-			       _PAGE_WRENABLE | _PAGE_NO_CACHE | _PAGE_GUARDED)
-#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_EXEC)
 
-#define PAGE_AGP	__pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_NO_CACHE)
-#define HAVE_PAGE_AGP
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
+#define PAGE_KERNEL_RO __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
+
+/* Protection bits for use by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
+			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
+			 _PAGE_4K_PFN | _PAGE_USER | _PAGE_RW |		\
+			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
+
 
 /* We always have _PAGE_SPECIAL on 64 bit */
 #define __HAVE_ARCH_PTE_SPECIAL
 
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
 /*
  * POWER4 and newer have per page execute protection, older chips can only
@@ -395,7 +406,8 @@ static inline void pte_clear(struct mm_s
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW |
+		 _PAGE_EXEC | _PAGE_HWEXEC);
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
Index: linux-work/arch/powerpc/include/asm/pte-hash64-4k.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-hash64-4k.h	2009-03-20 15:46:06.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-hash64-4k.h	2009-03-20 15:47:40.000000000 +1100
@@ -8,9 +8,6 @@
 #define _PAGE_F_GIX     _PAGE_GROUP_IX
 #define _PAGE_SPECIAL	0x10000 /* software: special page */
 
-/* There is no 4K PFN hack on 4K pages */
-#define _PAGE_4K_PFN	0
-
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
 			 _PAGE_SECONDARY | _PAGE_GROUP_IX)
Index: linux-work/arch/powerpc/include/asm/pte-hash64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-hash64.h	2009-03-20 15:46:06.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-hash64.h	2009-03-20 15:47:40.000000000 +1100
@@ -6,36 +6,41 @@
  * Common bits between 4K and 64K pages in a linux-style PTE.
  * These match the bits in the (hardware-defined) PowerPC PTE as closely
  * as possible. Additional bits may be defined in pgtable-hash64-*.h
+ *
+ * Note: We only support user read/write permissions. Supervisor always
+ * have full read/write to pages above PAGE_OFFSET (pages below that
+ * always use the user access permissions).
+ *
+ * We could create separate kernel read-only if we used the 3 PP bits
+ * combinations that newer processors provide but we currently don't.
  */
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
+#define _PAGE_PRESENT		0x0001 /* software: pte contains a translation */
+#define _PAGE_USER		0x0002 /* matches one of the PP bits */
+#define _PAGE_FILE		0x0002 /* (!present only) software: pte holds file offset */
+#define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_GUARDED		0x0008
+#define _PAGE_COHERENT		0x0010 /* M: enforce memory coherence (SMP systems) */
+#define _PAGE_NO_CACHE		0x0020 /* I: cache inhibit */
+#define _PAGE_WRITETHRU		0x0040 /* W: cache write-through */
+#define _PAGE_DIRTY		0x0080 /* C: page changed */
+#define _PAGE_ACCESSED		0x0100 /* R: page referenced */
+#define _PAGE_RW		0x0200 /* software: user write access allowed */
+#define _PAGE_BUSY		0x0800 /* software: PTE & hash are busy */
+
+/* No separate kernel read-only */
+#define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
+#define _PAGE_KERNEL_RO		 _PAGE_KERNEL_RW
 
 /* Strong Access Ordering */
-#define _PAGE_SAO	(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
+#define _PAGE_SAO		(_PAGE_WRITETHRU | _PAGE_NO_CACHE | _PAGE_COHERENT)
 
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
-
-#define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
+/* No page size encoding in the linux PTE */
+#define _PAGE_PSIZE		0
 
 /* PTEIDX nibble */
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
 
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
-			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
-			 _PAGE_4K_PFN | _PAGE_RW | _PAGE_USER |		\
-			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
-
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/pte-hash64-64k.h>
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc32.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-20 15:47:39.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-20 15:47:40.000000000 +1100
@@ -144,6 +144,13 @@ extern int icache_44x_need_flush;
 #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif
 
+#ifndef _PAGE_KERNEL_RO
+#define _PAGE_KERNEL_RO	0
+#endif
+#ifndef _PAGE_KERNEL_RW
+#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
+#endif
+
 #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
 
 /* Location of the PFN in the PTE. Most platforms use the same as _PAGE_SHIFT
@@ -186,30 +193,25 @@ extern int icache_44x_need_flush;
 #else
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #endif
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_NO_CACHE)
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 
-#define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY | _PAGE_HWWRITE)
-#define _PAGE_KERNEL	(_PAGE_BASE | _PAGE_SHARED | _PAGE_WRENABLE)
-#define _PAGE_KERNEL_NC	(_PAGE_BASE_NC | _PAGE_SHARED | _PAGE_WRENABLE)
-
-#ifdef CONFIG_PPC_STD_MMU
-/* On standard PPC MMU, no user access implies kernel read/write access,
- * so to write-protect kernel memory we must turn on user access */
-#define _PAGE_KERNEL_RO	(_PAGE_BASE | _PAGE_SHARED | _PAGE_USER)
-#else
-#define _PAGE_KERNEL_RO	(_PAGE_BASE | _PAGE_SHARED)
-#endif
-
-#define _PAGE_IO	(_PAGE_KERNEL_NC | _PAGE_GUARDED)
-#define _PAGE_RAM	(_PAGE_KERNEL | _PAGE_HWEXEC)
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
+#define PAGE_KERNEL_RO __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
 
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
 	defined(CONFIG_KPROBES)
 /* We want the debuggers to be able to set breakpoints anywhere, so
  * don't write protect the kernel text */
-#define _PAGE_RAM_TEXT	_PAGE_RAM
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
-#define _PAGE_RAM_TEXT	(_PAGE_KERNEL_RO | _PAGE_HWEXEC)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
 #endif
 
 #define PAGE_NONE	__pgprot(_PAGE_BASE)
@@ -220,9 +222,6 @@ extern int icache_44x_need_flush;
 #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 
-#define PAGE_KERNEL		__pgprot(_PAGE_RAM)
-#define PAGE_KERNEL_NOCACHE	__pgprot(_PAGE_IO)
-
 /*
  * The PowerPC can only do execute protection on a segment (256MB) basis,
  * not on a page basis.  So we consider execute permission the same as read.
Index: linux-work/arch/powerpc/include/asm/pte-8xx.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-8xx.h	2009-03-20 15:46:06.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-8xx.h	2009-03-20 15:47:40.000000000 +1100
@@ -59,6 +59,9 @@
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
+/* We need to add _PAGE_SHARED to kernel pages */
+#define _PAGE_KERNEL_RO	(_PAGE_SHARED)
+#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
 
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_PTE_8xx_H */
Index: linux-work/arch/powerpc/include/asm/pte-hash32.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-hash32.h	2009-03-20 15:46:06.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-hash32.h	2009-03-20 15:47:40.000000000 +1100
@@ -44,6 +44,5 @@
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
 
-
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_PTE_HASH32_H */
Index: linux-work/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_32.c	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/mm/pgtable_32.c	2009-03-20 15:47:40.000000000 +1100
@@ -164,7 +164,7 @@ __ioremap_caller(phys_addr_t addr, unsig
 
 	/* Make sure we have the base flags */
 	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= _PAGE_KERNEL;
+		flags |= PAGE_KERNEL;
 
 	/* Non-cacheable page cannot be coherent */
 	if (flags & _PAGE_NO_CACHE)
@@ -296,7 +296,7 @@ void __init mapin_ram(void)
 	p = memstart_addr + s;
 	for (; s < total_lowmem; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
-		f = ktext ?_PAGE_RAM_TEXT : _PAGE_RAM;
+		f = ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL;
 		map_page(v, p, f);
 #ifdef CONFIG_PPC_STD_MMU_32
 		if (ktext)
Index: linux-work/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/ppc_mmu_32.c	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/mm/ppc_mmu_32.c	2009-03-20 15:47:40.000000000 +1100
@@ -74,9 +74,6 @@ unsigned long p_mapped_by_bats(phys_addr
 
 unsigned long __init mmu_mapin_ram(void)
 {
-#ifdef CONFIG_POWER4
-	return 0;
-#else
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
 
@@ -95,7 +92,7 @@ unsigned long __init mmu_mapin_ram(void)
 			break;
 	}
 
-	setbat(2, PAGE_OFFSET, 0, bl, _PAGE_RAM);
+	setbat(2, PAGE_OFFSET, 0, bl, PAGE_KERNEL_X);
 	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
 	if ((done < tot) && !bat_addrs[3].limit) {
 		/* use BAT3 to cover a bit more */
@@ -103,12 +100,11 @@ unsigned long __init mmu_mapin_ram(void)
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, PAGE_OFFSET+done, done, bl, _PAGE_RAM);
+		setbat(3, PAGE_OFFSET+done, done, bl, PAGE_KERNEL_X);
 		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
 	}
 
 	return done;
-#endif
 }
 
 /*
@@ -136,9 +132,7 @@ void __init setbat(int index, unsigned l
 		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
 		bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
 		bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
-#ifndef CONFIG_KGDB /* want user access for breakpoints */
 		if (flags & _PAGE_USER)
-#endif
 			bat[1].batu |= 1; 	/* Vp = 1 */
 		if (flags & _PAGE_GUARDED) {
 			/* G bit must be zero in IBATs */
Index: linux-work/arch/powerpc/sysdev/cpm_common.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/cpm_common.c	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/cpm_common.c	2009-03-20 15:47:40.000000000 +1100
@@ -56,7 +56,7 @@ void __init udbg_init_cpm(void)
 {
 	if (cpm_udbg_txdesc) {
 #ifdef CONFIG_CPM2
-		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
+		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
 #endif
 		udbg_putc = udbg_putc_cpm;
 	}
Index: linux-work/arch/powerpc/include/asm/fixmap.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/fixmap.h	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/fixmap.h	2009-03-20 15:47:40.000000000 +1100
@@ -61,7 +61,7 @@ extern void __set_fixmap (enum fixed_add
  * Some hardware wants to get fixmapped without caching.
  */
 #define set_fixmap_nocache(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+		__set_fixmap(idx, phys, PAGE_KERNEL_NCG)
 
 #define clear_fixmap(idx) \
 		__set_fixmap(idx, 0, __pgprot(0))
Index: linux-work/arch/powerpc/include/asm/pgtable.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable.h	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable.h	2009-03-20 15:47:40.000000000 +1100
@@ -25,6 +25,10 @@ static inline void assert_pte_locked(str
 #  include <asm/pgtable-ppc32.h>
 #endif
 
+/* Special mapping for AGP */
+#define PAGE_AGP	(PAGE_KERNEL_NC)
+#define HAVE_PAGE_AGP
+
 #ifndef __ASSEMBLY__
 
 /* Insert a PTE, top-level function is out of line. It uses an inline
Index: linux-work/arch/powerpc/mm/fsl_booke_mmu.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/fsl_booke_mmu.c	2009-03-20 15:46:00.000000000 +1100
+++ linux-work/arch/powerpc/mm/fsl_booke_mmu.c	2009-03-20 15:47:40.000000000 +1100
@@ -162,7 +162,7 @@ unsigned long __init mmu_mapin_ram(void)
 	phys_addr_t phys = memstart_addr;
 
 	while (cam[tlbcam_index] && tlbcam_index < ARRAY_SIZE(cam)) {
-		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], _PAGE_KERNEL, 0);
+		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], PAGE_KERNEL_X, 0);
 		virt += cam[tlbcam_index];
 		phys += cam[tlbcam_index];
 		tlbcam_index++;

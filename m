Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id CE1981A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:40:59 +1000 (AEST)
Message-Id: <f4a53e003d35f37d7825b88d7f07ae88a918ed3c.1439382634.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 02/20] powerpc/8xx: Map linear kernel RAM with 8M pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:40:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a live running system (VoIP gateway for Air Trafic Control), over
a 10 minutes period (with 277s idle), we get 87 millions DTLB misses
and approximatly 35 secondes are spent in DTLB handler.
This represents 5.8% of the overall time and even 10.8% of the
non-idle time.
Among those 87 millions DTLB misses, 15% are on user addresses and
85% are on kernel addresses. And within the kernel addresses, 93%
are on addresses from the linear address space and only 7% are on
addresses from the virtual address space.

MPC8xx has no BATs but it has 8Mb page size. This patch implements
mapping of kernel RAM using 8Mb pages, on the same model as what is
done on the 40x.

In 4k pages mode, each PGD entry maps a 4Mb area: we map every two
entries to the same 8Mb physical page. In each second entry, we add
4Mb to the page physical address to ease life of the FixupDAR
routine. This is just ignored by HW.

In 16k pages mode, each PGD entry maps a 64Mb area: each PGD entry
will point to the first page of the area. The DTLB handler adds
gets the 3 bits from EPN to map the correct page.

With this patch applied, we now get only 13 millions TLB misses
during the 10 minutes period. The idle time has increased to 313s
and the overall time spent in DTLB miss handler is 6.3s, which
represents 1% of the overall time and 2.2% of non-idle time.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 30 ++++++++++++++-
 arch/powerpc/mm/8xx_mmu.c      | 83 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/Makefile       |  1 +
 arch/powerpc/mm/mmu_decl.h     | 15 ++------
 4 files changed, 115 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/mm/8xx_mmu.c

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1557926..a10a48f 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -398,11 +398,13 @@ DataStoreTLBMiss:
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r3
 
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtcr	r11
+	bgt-	cr7,5f		/* CR7.GT = bit 29 = Large page (8M or 512K) */
+	mtcr	r3
 
 	/* We have a pte table, so load fetch the pte from the table.
 	 */
@@ -455,6 +457,24 @@ DataStoreTLBMiss:
 	EXCEPTION_EPILOG_0
 	rfi
 
+5:	mtcr	r3
+	ori	r11, r11, MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
+#ifdef CONFIG_PPC_16K_PAGES
+	rlwimi	r11, r10, 0, 0x03800000
+#endif
+	rlwinm	r10, r11, 0, 0xff800000
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mfspr	r3, SPRN_SPRG_SCRATCH2
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	EXCEPTION_EPILOG_0
+	rfi
+
+
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -532,13 +552,15 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	/* Insert level 1 index */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtcr	r11
+	bgt	cr7,200f
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
 	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31
-	lwz	r11,0(r11)
+201:	lwz	r11,0(r11)
 /* Check if it really is a dcbx instruction. */
 /* dcbt and dcbtst does not generate DTLB Misses/Errors,
  * no need to include them here */
@@ -557,6 +579,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
+	/* concat physical page address(r11) and page offset(r10) */
+200:	rlwimi	r11, r10, 0, 32 - (PAGE_SHIFT << 1), 31
+	b	201b
+
 144:	mfspr	r10, SPRN_DSISR
 	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
 	mtspr	SPRN_DSISR, r10
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
new file mode 100644
index 0000000..be6f041
--- /dev/null
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -0,0 +1,83 @@
+/*
+ * This file contains the routines for initializing the MMU
+ * on the 8xx series of chips.
+ *  -- christophe
+ *
+ *  Derived from arch/powerpc/mm/40x_mmu.c:
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/memblock.h>
+
+#include "mmu_decl.h"
+
+extern int __map_without_ltlbs;
+/*
+ * MMU_init_hw does the chip-specific initialization of the MMU hardware.
+ */
+void __init MMU_init_hw(void)
+{
+	/* Nothing to do for the time being but keep it similar to other PPC */
+}
+
+#define LARGE_PAGE_SIZE_4M	(1<<22)
+#define LARGE_PAGE_SIZE_8M	(1<<23)
+#define LARGE_PAGE_SIZE_64M	(1<<26)
+
+unsigned long __init mmu_mapin_ram(unsigned long top)
+{
+	unsigned long v, s, mapped;
+	phys_addr_t p;
+
+	v = KERNELBASE;
+	p = 0;
+	s = top;
+
+	if (__map_without_ltlbs)
+		return 0;
+
+#ifdef CONFIG_PPC_4K_PAGES
+	while (s >= LARGE_PAGE_SIZE_8M) {
+		pmd_t *pmdp;
+		unsigned long val = p | MD_PS8MEG;
+
+		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val + LARGE_PAGE_SIZE_4M;
+
+		v += LARGE_PAGE_SIZE_8M;
+		p += LARGE_PAGE_SIZE_8M;
+		s -= LARGE_PAGE_SIZE_8M;
+	}
+#else /* CONFIG_PPC_16K_PAGES */
+	while (s >= LARGE_PAGE_SIZE_64M) {
+		pmd_t *pmdp;
+		unsigned long val = p | MD_PS8MEG;
+
+		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
+		pmd_val(*pmdp++) = val;
+
+		v += LARGE_PAGE_SIZE_64M;
+		p += LARGE_PAGE_SIZE_64M;
+		s -= LARGE_PAGE_SIZE_64M;
+	}
+#endif
+
+	mapped = top - s;
+
+	/* If the size of RAM is not an exact power of two, we may not
+	 * have covered RAM in its entirety with 8 MiB
+	 * pages. Consequently, restrict the top end of RAM currently
+	 * allocable so that calls to the MEMBLOCK to allocate PTEs for "tail"
+	 * coverage with normal-sized pages (or other reasons) do not
+	 * attempt to allocate outside the allowed range.
+	 */
+	memblock_set_current_limit(mapped);
+
+	return mapped;
+}
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3eb73a3..ca03ac0 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PPC_ICSWX)		+= icswx.o
 obj-$(CONFIG_PPC_ICSWX_PID)	+= icswx_pid.o
 obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 085b66b..99e88bc 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -132,21 +132,16 @@ extern void wii_memory_fixups(void);
 /* ...and now those things that may be slightly different between processor
  * architectures.  -- Dan
  */
-#if defined(CONFIG_8xx)
-#define MMU_init_hw()		do { } while(0)
-#define mmu_mapin_ram(top)	(0UL)
-
-#elif defined(CONFIG_4xx)
+#ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
+#endif
 
-#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#ifdef CONFIG_PPC_FSL_BOOK3E
 extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx);
 extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 				 phys_addr_t phys);
 #ifdef CONFIG_PPC32
-extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
@@ -160,8 +155,4 @@ struct tlbcam {
 	u32	MAS3;
 	u32	MAS7;
 };
-#elif defined(CONFIG_PPC32)
-/* anything 32-bit except 4xx or 8xx */
-extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(unsigned long top);
 #endif
-- 
2.1.0

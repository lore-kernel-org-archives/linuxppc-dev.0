Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XW5GrTzF0jx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:31 +1100 (AEDT)
Message-Id: <56c6cf4d094d6bb2c94c536e9b0ade88b411d5c6.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/8] powerpc/mm: extend _PAGE_PRIVILEGED to all CPUs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:27 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit ac29c64089b74 ("powerpc/mm: Replace _PAGE_USER with
_PAGE_PRIVILEGED") introduced _PAGE_PRIVILEGED for BOOK3S/64

This patch generalises _PAGE_PRIVILEGED for all CPUs, allowing
to have either _PAGE_PRIVILEGED or _PAGE_USER or both.

PPC_8xx has a _PAGE_SHARED flag which is set for and only for
all non user pages. Lets rename it _PAGE_PRIVILEGED to remove
confusion as it has nothing to do with Linux shared pages.

On BookE, there's a _PAGE_BAP_SR which has to be set for kernel
pages: defining _PAGE_PRIVILEGED as _PAGE_BAP_SR will make
this generic

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 10 +---------
 arch/powerpc/include/asm/nohash/pte-book3e.h |  1 +
 arch/powerpc/include/asm/pte-common.h        | 24 ++++++++++++++++--------
 arch/powerpc/kernel/head_8xx.S               |  6 +++---
 arch/powerpc/mm/8xx_mmu.c                    |  2 +-
 arch/powerpc/mm/dump_linuxpagetables.c       | 11 +----------
 arch/powerpc/mm/pgtable.c                    |  3 ++-
 arch/powerpc/mm/pgtable_32.c                 |  9 +--------
 arch/powerpc/mm/pgtable_64.c                 | 14 +-------------
 10 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 44697817ccc6..db38050e1a98 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -15,7 +15,7 @@
 #define _PAGE_BIT_SWAP_TYPE	0
 
 #define _PAGE_RO		0
-#define _PAGE_SHARED		0
+#define _PAGE_USER		0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 19a5ecaef265..7c7040f015e2 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -31,7 +31,7 @@
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
-#define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
+#define _PAGE_PRIVILEGED	0x0004	/* No ASID (context) compare */
 #define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
 #define _PAGE_DIRTY	0x0100	/* C: page changed */
 
@@ -54,13 +54,5 @@
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
-/* We need to add _PAGE_SHARED to kernel pages */
-#define _PAGE_KERNEL_RO		(_PAGE_SHARED | _PAGE_RO)
-#define _PAGE_KERNEL_ROX	(_PAGE_SHARED | _PAGE_RO | _PAGE_EXEC)
-#define _PAGE_KERNEL_RW		(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
-				 _PAGE_HWWRITE)
-#define _PAGE_KERNEL_RWX	(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
-				 _PAGE_HWWRITE | _PAGE_EXEC)
-
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_8xx_H */
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 2da4532ca377..ccee8eb509bb 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -55,6 +55,7 @@
 #define _PAGE_KERNEL_RWX	(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY | _PAGE_BAP_SX)
 #define _PAGE_KERNEL_ROX	(_PAGE_BAP_SR | _PAGE_BAP_SX)
 #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
+#define _PAGE_PRIVILEGED	(_PAGE_BAP_SR)
 
 #define _PAGE_HASHPTE	0
 #define _PAGE_BUSY	0
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index ce142ef99ba7..0e6595a1b9d8 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -8,9 +8,6 @@
 #ifndef _PAGE_HASHPTE
 #define _PAGE_HASHPTE	0
 #endif
-#ifndef _PAGE_SHARED
-#define _PAGE_SHARED	0
-#endif
 #ifndef _PAGE_HWWRITE
 #define _PAGE_HWWRITE	0
 #endif
@@ -45,6 +42,14 @@
 #ifndef _PAGE_PTE
 #define _PAGE_PTE 0
 #endif
+/* At least one of _PAGE_PRIVILEGED or _PAGE_USER must be defined */
+#ifndef _PAGE_PRIVILEGED
+#define _PAGE_PRIVILEGED 0
+#else
+#ifndef _PAGE_USER
+#define _PAGE_USER 0
+#endif
+#endif
 
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
@@ -54,16 +59,18 @@
 #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif
 #ifndef _PAGE_KERNEL_RO
-#define _PAGE_KERNEL_RO		(_PAGE_RO)
+#define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
 #endif
 #ifndef _PAGE_KERNEL_ROX
-#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_RO)
+#define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
 #endif
 #ifndef _PAGE_KERNEL_RW
-#define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
+#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
+				 _PAGE_HWWRITE)
 #endif
 #ifndef _PAGE_KERNEL_RWX
-#define _PAGE_KERNEL_RWX	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE | _PAGE_EXEC)
+#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_RW | \
+				 _PAGE_HWWRITE | _PAGE_EXEC)
 #endif
 #ifndef _PAGE_HPTEFLAGS
 #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
@@ -85,7 +92,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  */
 static inline bool pte_user(pte_t pte)
 {
-	return (pte_val(pte) & _PAGE_USER) == _PAGE_USER;
+	return (pte_val(pte) & (_PAGE_USER | _PAGE_PRIVILEGED)) == _PAGE_USER;
 }
 #endif /* __ASSEMBLY__ */
 
@@ -116,6 +123,7 @@ static inline bool pte_user(pte_t pte)
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
 			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | \
+			 _PAGE_PRIVILEGED | \
 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
 
 /*
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6399dcadf51d..642680389b7e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -678,7 +678,7 @@ DTLBMissIMMR:
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
 			  _PAGE_PRESENT | _PAGE_NO_CACHE
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -696,7 +696,7 @@ DTLBMissLinear:
 	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -715,7 +715,7 @@ ITLBMissLinear:
 	li	r11, MI_PS8MEG | MI_SVALID | _PAGE_EXEC
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 0be77709446c..5d53684c2ebd 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -67,7 +67,7 @@ void __init MMU_init_hw(void)
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
 #ifdef CONFIG_PIN_TLB_DATA
 	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY;
+	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY;
 #ifdef CONFIG_PIN_TLB_IMMR
 	int i = 29;
 #else
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index c2e7dea59490..d9547e1ec5ef 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -112,13 +112,8 @@ struct flag_info {
 
 static const struct flag_info flag_array[] = {
 	{
-#ifdef CONFIG_PPC_BOOK3S_64
-		.mask	= _PAGE_PRIVILEGED,
-		.val	= 0,
-#else
-		.mask	= _PAGE_USER,
+		.mask	= _PAGE_USER | _PAGE_PRIVILEGED,
 		.val	= _PAGE_USER,
-#endif
 		.set	= "user",
 		.clear	= "    ",
 	}, {
@@ -228,10 +223,6 @@ static const struct flag_info flag_array[] = {
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
 		.set	= "special",
-	}, {
-		.mask	= _PAGE_SHARED,
-		.val	= _PAGE_SHARED,
-		.set	= "shared",
 	}
 };
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index a03ff3d99e0c..9f361ae571e9 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -54,7 +54,8 @@ static inline int pte_looks_normal(pte_t pte)
 	return 0;
 #else
 	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER)) ==
+		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER |
+		 _PAGE_PRIVILEGED)) ==
 		(_PAGE_PRESENT | _PAGE_USER);
 #endif
 }
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f6c7f54c0515..d35d9ad3c1cd 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -98,14 +98,7 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-
-#ifdef _PAGE_BAP_SR
-	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
-	 * which means that we just cleared supervisor access... oops ;-) This
-	 * restores it
-	 */
-	flags |= _PAGE_BAP_SR;
-#endif
+	flags |= _PAGE_PRIVILEGED;
 
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 813ea22c3e00..c9a623c2d8a2 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -244,20 +244,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	/*
 	 * Force kernel mapping.
 	 */
-#if defined(CONFIG_PPC_BOOK3S_64)
-	flags |= _PAGE_PRIVILEGED;
-#else
 	flags &= ~_PAGE_USER;
-#endif
-
-
-#ifdef _PAGE_BAP_SR
-	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
-	 * which means that we just cleared supervisor access... oops ;-) This
-	 * restores it
-	 */
-	flags |= _PAGE_BAP_SR;
-#endif
+	flags |= _PAGE_PRIVILEGED;
 
 	if (ppc_md.ioremap)
 		return ppc_md.ioremap(addr, size, flags, caller);
-- 
2.13.3

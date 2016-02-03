Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A61911A0256
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 09:54:18 +1100 (AEDT)
Message-Id: <91ce07cab7f989d663a44de57a63169f5177fff7.1454538976.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454538974.git.christophe.leroy@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 10/23] powerpc/8xx: map more RAM at startup when needed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  3 Feb 2016 23:54:13 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On recent kernels, with some debug options like for instance
CONFIG_LOCKDEP, the BSS requires more than 8M memory, allthough
the kernel code fits in the first 8M.
Today, it is necessary to activate CONFIG_PIN_TLB to get more than 8M
at startup, allthough pinning TLB is not necessary for that.

This patch adds more pages (up to 24Mb) to the initial mapping if
possible/needed in order to have the necessary mappings regardless of
CONFIG_PIN_TLB.

We could have mapped 16M or 24M inconditionnally but since some
platforms only have 8M memory, we need something a bit more elaborated

Therefore, if the bootloader is compliant with ePAPR standard, we use
r7 to know how much memory was mapped by the bootloader.
Otherwise, we try to determine the required memory size by looking at
the _end symbol and the address of the device tree.

This patch does not modify the behaviour when CONFIG_PIN_TLB is
selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: Automatic detection of available/needed memory instead of allocating 16M for all.
v4: no change
v5: no change

 arch/powerpc/kernel/head_8xx.S | 56 +++++++++++++++++++++++++++++++++++++++---
 arch/powerpc/mm/8xx_mmu.c      | 10 +++-----
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index ae721a1..a268cf4 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -72,6 +72,9 @@
 #define RPN_PATTERN	0x00f0
 #endif
 
+/* ePAPR magic value for non BOOK III-E CPUs */
+#define EPAPR_SMAGIC	0x65504150
+
 	__HEAD
 _ENTRY(_stext);
 _ENTRY(_start);
@@ -101,6 +104,38 @@ _ENTRY(_start);
  */
 	.globl	__start
 __start:
+/*
+ * Determine initial RAM size
+ *
+ * If the Bootloader is ePAPR compliant, the size is given in r7
+ * otherwise, we have to determine how much is needed. For that, we have to
+ * check whether _end of kernel and device tree are within the first 8Mb.
+ */
+	lis	r30, 0x00800000@h	/* 8Mb by default */
+
+	lis	r8, EPAPR_SMAGIC@h
+	ori	r8, r8, EPAPR_SMAGIC@l
+	cmplw	cr0, r8, r6
+	bne	1f
+	lis	r30, 0x01800000@h	/* 24Mb max */
+	cmplw	cr0, r7, r30
+	bgt	2f
+	mr	r30, r7			/* save initial ram size */
+	b	2f
+1:
+	/* is kernel _end or DTB in the first 8M ? if not map 16M */
+	lis	r8, (_end - PAGE_OFFSET)@h
+	ori	r8, r8, (_end - PAGE_OFFSET)@l
+	addi	r8, r8, -1
+	or	r8, r8, r3
+	cmplw	cr0, r8, r30
+	blt	2f
+	lis	r30, 0x01000000@h	/* 16Mb */
+	/* is kernel _end or DTB in the first 16M ? if not map 24M */
+	cmplw	cr0, r8, r30
+	blt	2f
+	lis	r30, 0x01800000@h	/* 24Mb */
+2:
 	mr	r31,r3			/* save device tree ptr */
 
 	/* We have to turn on the MMU right away so we get cache modes
@@ -737,6 +772,8 @@ start_here:
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
+	lis	r3, initial_memory_size@ha
+	stw	r30, initial_memory_size@l(r3)
 	li	r3,0
 	mr	r4,r31
 	bl	machine_init
@@ -868,10 +905,15 @@ initial_mmu:
 	mtspr	SPRN_MD_RPN, r8
 
 #ifdef CONFIG_PIN_TLB
-	/* Map two more 8M kernel data pages.
-	*/
+	/* Map one more 8M kernel data page. */
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
+#else
+	/* Map one more 8M kernel data page if needed */
+	lis	r10, 0x00800000@h
+	cmplw	cr0, r30, r10
+	ble	1f
+#endif
 
 	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
 	addis	r8, r8, 0x0080		/* Add 8M */
@@ -884,20 +926,28 @@ initial_mmu:
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
 
+#ifdef CONFIG_PIN_TLB
+	/* Map one more 8M kernel data page. */
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
+#else
+	/* Map one more 8M kernel data page if needed */
+	lis	r10, 0x01000000@h
+	cmplw	cr0, r30, r10
+	ble	1f
+#endif
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
-#endif
 
 	/* Since the cache is enabled according to the information we
 	 * just loaded into the TLB, invalidate and enable the caches here.
 	 * We should probably check/set other modes....later.
 	 */
+1:
 	lis	r8, IDC_INVALL@h
 	mtspr	SPRN_IC_CST, r8
 	mtspr	SPRN_DC_CST, r8
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 4de93b2..6965575 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -20,6 +20,7 @@
 #define IMMR_SIZE (__fix_to_virt(FIX_IMMR_TOP) + PAGE_SIZE - VIRT_IMMR_BASE)
 
 extern int __map_without_ltlbs;
+int initial_memory_size; /* size of initial memory mapped by head_8xx.S */
 
 /*
  * Return PA for this VA if it is in IMMR area, or 0
@@ -143,11 +144,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-#ifdef CONFIG_PIN_TLB
-	/* 8xx can only access 24MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
-#else
-	/* 8xx can only access 8MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
-#endif
+	memblock_set_current_limit(min_t(u64, first_memblock_size,
+					 initial_memory_size));
 }
-- 
2.1.0

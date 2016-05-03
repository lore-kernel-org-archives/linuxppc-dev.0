Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzksB27DLzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 01:01:34 +1000 (AEST)
Message-Id: <7a03fdb8854cf6c26fa83a324862c6f17449728b.1462052178.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1462052178.git.christophe.leroy@c-s.fr>
References: <cover.1462052178.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc/8xx: Rework CONFIG_PIN_TLB handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  3 May 2016 17:01:28 +0200 (CEST)
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

We could have inconditionaly mapped 16 or 24M bytes at startup
but some old hardware only have 8M and mapping non-existing RAM
would be an issue due to speculative accesses.

With the preceeding patch however, the TLB entries are populated on
demand. By setting up the TLB miss handler to handle up to 24M until
the handler is patched for the entire memory space, it is possible
to allow access up to more memory without mapping non-existing RAM.

It is therefore not needed anymore to map memory data at all
at startup. It will be handled by the TLB miss handler.

One might still want to PIN the IMMR and the first 24M of RAM.
It is now possible to do it in the C memory initialisation
functions. In addition, we now know how much memory we have
when we do it, so we are able to adapt the pining to the
real amount of memory available. So boards with less than 24M
can now also benefit from PIN_TLB.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 44 ++++--------------------------------------
 arch/powerpc/mm/8xx_mmu.c      | 27 ++++++++++++++++++--------
 2 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3de7d02..b8602e5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -491,7 +491,7 @@ _ENTRY(DTLBMiss_jmp)
 
 4:
 _ENTRY(DTLBMiss_cmp)
-	cmpli	cr0, r11, PAGE_OFFSET@h
+	cmpli	cr0, r11, (PAGE_OFFSET + 0x1800000)@h
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 	bge-	3b
 
@@ -586,7 +586,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	BRANCH_UNLESS_KERNEL(3f)
 	rlwinm	r11, r10, 16, 0xfff8
 _ENTRY(FixupDAR_cmp)
-	cmpli	cr7, r11, PAGE_OFFSET@h
+	cmpli	cr0, r11, (PAGE_OFFSET + 0x1800000)@h
 	blt-	cr7, 200f
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 	/* Insert level 1 index */
@@ -823,23 +823,16 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 #endif
 
-	/* Now map the lower 8 Meg into the TLBs.  For this quick hack,
-	 * we can load the instruction and data TLB registers with the
-	 * same values.
-	 */
+	/* Now map the lower 8 Meg into the ITLB. */
 	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
-	mtspr	SPRN_MD_EPN, r8
 	li	r8, MI_PS8MEG | (2 << 5)	/* Set 8M byte page, APG 2 */
 	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MI_TWC, r8
-	li	r8, MI_PS8MEG		/* Set 8M byte page, APG 0 */
-	ori	r8, r8, MI_SVALID	/* Make it valid */
-	mtspr	SPRN_MD_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
-	mtspr	SPRN_MD_RPN, r8
+
 	lis	r8, MI_APG_INIT@h	/* Set protection modes */
 	ori	r8, r8, MI_APG_INIT@l
 	mtspr	SPRN_MI_AP, r8
@@ -851,9 +844,6 @@ initial_mmu:
 	 * internal registers (among other things).
 	 */
 #ifdef CONFIG_PIN_TLB
-	addi	r10, r10, 0x0100
-	mtspr	SPRN_MD_CTR, r10
-#endif
 	mfspr	r9, 638			/* Get current IMMR */
 	andis.	r9, r9, 0xfff8		/* Get 512 kbytes boundary */
 
@@ -866,32 +856,6 @@ initial_mmu:
 	mr	r8, r9			/* Create paddr for TLB */
 	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
 	mtspr	SPRN_MD_RPN, r8
-
-#ifdef CONFIG_PIN_TLB
-	/* Map two more 8M kernel data pages.
-	*/
-	addi	r10, r10, 0x0100
-	mtspr	SPRN_MD_CTR, r10
-
-	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
-	addis	r8, r8, 0x0080		/* Add 8M */
-	ori	r8, r8, MI_EVALID	/* Mark it valid */
-	mtspr	SPRN_MD_EPN, r8
-	li	r9, MI_PS8MEG		/* Set 8M byte page */
-	ori	r9, r9, MI_SVALID	/* Make it valid */
-	mtspr	SPRN_MD_TWC, r9
-	li	r11, MI_BOOTINIT	/* Create RPN for address 0 */
-	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r11
-
-	addi	r10, r10, 0x0100
-	mtspr	SPRN_MD_CTR, r10
-
-	addis	r8, r8, 0x0080		/* Add 8M */
-	mtspr	SPRN_MD_EPN, r8
-	mtspr	SPRN_MD_TWC, r9
-	addis	r11, r11, 0x0080	/* Add 8M */
-	mtspr	SPRN_MD_RPN, r11
 #endif
 
 	/* Since the cache is enabled according to the information we
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 996dfaa..0f0a83e 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -50,16 +50,32 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
+#define LARGE_PAGE_SIZE_8M	(1<<23)
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
 void __init MMU_init_hw(void)
 {
-	/* Nothing to do for the time being but keep it similar to other PPC */
+	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
+#ifdef CONFIG_PIN_TLB
+	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
+	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY;
+	int i;
+	unsigned long addr = 0;
+	unsigned long mem = total_lowmem;
+
+	for (i = 29; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
+		mtspr(SPRN_MD_CTR, ctr | (i << 8));
+		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
+		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
+		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
+		addr += LARGE_PAGE_SIZE_8M;
+		mem -= LARGE_PAGE_SIZE_8M;
+	}
+#endif
 }
 
-#define LARGE_PAGE_SIZE_8M	(1<<23)
-
 static void mmu_mapin_immr(void)
 {
 	unsigned long p = PHYS_IMMR_BASE;
@@ -124,13 +140,8 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-#ifdef CONFIG_PIN_TLB
 	/* 8xx can only access 24MB at the moment */
 	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
-#else
-	/* 8xx can only access 8MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
-#endif
 }
 
 /*
-- 
2.1.0

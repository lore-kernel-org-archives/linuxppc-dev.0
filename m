Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8206A2C0380
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:55:07 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 3/8] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Date: Thu, 4 Jul 2013 20:54:09 +0800
Message-ID: <1372942454-25191-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is based on the codes in the head_44x.S. Since we always align to
256M before mapping the PAGE_OFFSET for a relocatable kernel, we also
change the init tlb map to 256M size.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Move the code to set kernstart_addr and virt_phys_offset to a c function.
    So we can expand it easily later.

Hi Scott,

I still use the 256M align for the init tlb as in v1 for the following reasons:
  * This should be the most possible case in reality.
  * This is just for very early booting code and should not be a big issue
    if the first tlb entry shrink to a less size later.

 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  8 +++---
 arch/powerpc/kernel/head_fsl_booke.S          | 37 +++++++++++++++++++++++++++
 arch/powerpc/mm/fsl_booke_mmu.c               | 28 ++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5374776..5b2e115 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -859,7 +859,7 @@ config DYNAMIC_MEMSTART
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on ADVANCED_OPTIONS && FLATMEM && 44x
+	depends on ADVANCED_OPTIONS && FLATMEM && (44x || FSL_BOOKE)
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index 2201f84..211e507 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -167,10 +167,10 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
 	mtspr	SPRN_MAS0,r6
 	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
-	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
+	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_256M))@l
 	mtspr	SPRN_MAS1,r6
-	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@h
-	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@l
+	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_256M, M_IF_SMP)@h
+	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_256M, M_IF_SMP)@l
 	mtspr	SPRN_MAS2,r6
 	mtspr	SPRN_MAS3,r8
 	tlbwe
@@ -178,6 +178,8 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
 /* 7. Jump to KERNELBASE mapping */
 	lis	r6,(KERNELBASE & ~0xfff)@h
 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
+	rlwinm	r7,r25,0,0x0fffffff
+	add	r6,r7,r6
 
 #elif defined(ENTRY_MAPPING_KEXEC_SETUP)
 /*
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index dab091e..134064d 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -73,6 +73,33 @@ _ENTRY(_start);
 	li	r24,0			/* CPU number */
 	li	r23,0			/* phys kernel start (high) */
 
+#ifdef CONFIG_RELOCATABLE
+	bl	0f			/* Get our runtime address */
+0:	mflr	r3			/* Make it accessible */
+	addis	r3,r3,(_stext - 0b)@ha
+	addi	r3,r3,(_stext - 0b)@l	/* Get our current runtime base */
+
+	/* Translate _stext address to physical, save in r23/r25 */
+	bl	get_phys_addr
+	mr	r23,r3
+	mr	r25,r4
+
+	/*
+	 * We have the runtime (virutal) address of our base.
+	 * We calculate our shift of offset from a 256M page.
+	 * We could map the 256M page we belong to at PAGE_OFFSET and
+	 * get going from there.
+	 */
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	rlwinm	r6,r25,0,0xfffffff		/* r6 = PHYS_START % 256M */
+	rlwinm	r5,r4,0,0xfffffff		/* r5 = KERNELBASE % 256M */
+	subf	r3,r5,r6			/* r3 = r6 - r5 */
+	add	r3,r4,r3			/* Required Virutal Address */
+
+	bl	relocate
+#endif
+
 /* We try to not make any assumptions about how the boot loader
  * setup or used the TLBs.  We invalidate all mappings from the
  * boot loader and load a single entry in TLB1[0] to map the
@@ -182,6 +209,16 @@ _ENTRY(__early_start)
 
 	bl	early_init
 
+#ifdef CONFIG_RELOCATABLE
+#ifdef CONFIG_PHYS_64BIT
+	mr	r3,r23
+	mr	r4,r25
+#else
+	mr	r3,r25
+#endif
+	bl	relocate_init
+#endif
+
 #ifdef CONFIG_DYNAMIC_MEMSTART
 	lis	r3,kernstart_addr@ha
 	la	r3,kernstart_addr@l(r3)
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 07ba45b..5fe271c 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -241,4 +241,32 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* 64M mapped initially according to head_fsl_booke.S */
 	memblock_set_current_limit(min_t(u64, limit, 0x04000000));
 }
+
+#ifdef CONFIG_RELOCATABLE
+notrace void __init relocate_init(phys_addr_t start)
+{
+	unsigned long base = KERNELBASE;
+
+	/*
+	 * Relocatable kernel support based on processing of dynamic
+	 * relocation entries.
+	 * Compute the virt_phys_offset :
+	 * virt_phys_offset = stext.run - kernstart_addr
+	 *
+	 * stext.run = (KERNELBASE & ~0xfffffff) + (kernstart_addr & 0xfffffff)
+	 * When we relocate, we have :
+	 *
+	 *	(kernstart_addr & 0xfffffff) = (stext.run & 0xfffffff)
+	 *
+	 * hence:
+	 *  virt_phys_offset = (KERNELBASE & ~0xfffffff) -
+	 *                              (kernstart_addr & ~0xfffffff)
+	 *
+	 */
+	kernstart_addr = start;
+	start &= ~0xfffffff;
+	base &= ~0xfffffff;
+	virt_phys_offset = base - start;
+}
+#endif
 #endif
-- 
1.8.1.4

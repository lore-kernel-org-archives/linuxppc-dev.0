Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40AEB2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:22:14 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Date: Wed, 7 Aug 2013 09:18:31 +0800
Message-ID: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is based on the codes in the head_44x.S. The difference is that
the init tlb size we used is 64M. With this patch we can only load the
kernel at address between memstart_addr ~ memstart_addr + 64M. We will
fix this restriction in the following patches.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v3:
  * Use the 64M align.
  * typo fix.

v2: Move the code to set kernstart_addr and virt_phys_offset to a c function.
    So we can expand it easily later.

 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  2 ++
 arch/powerpc/kernel/head_fsl_booke.S          | 37 +++++++++++++++++++++++++++
 arch/powerpc/mm/fsl_booke_mmu.c               | 28 ++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3bf72cd..57dc8f9 100644
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
index a92c79b..f22e7e4 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -176,6 +176,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 7. Jump to KERNELBASE mapping */
 	lis	r6,(KERNELBASE & ~0xfff)@h
 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
+	rlwinm	r7,r25,0,0x03ffffff
+	add	r6,r7,r6
 
 #elif defined(ENTRY_MAPPING_KEXEC_SETUP)
 /*
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 377bd81..f6ec9a3 100644
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
+	 * We calculate our shift of offset from a 64M page.
+	 * We could map the 64M page we belong to at PAGE_OFFSET and
+	 * get going from there.
+	 */
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	rlwinm	r6,r25,0,0x3ffffff		/* r6 = PHYS_START % 64M */
+	rlwinm	r5,r4,0,0x3ffffff		/* r5 = KERNELBASE % 64M */
+	subf	r3,r5,r6			/* r3 = r6 - r5 */
+	add	r3,r4,r3			/* Required Virtual Address */
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
index 07ba45b..ce4a116 100644
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
+	 * stext.run = (KERNELBASE & ~0x3ffffff) + (kernstart_addr & 0x3ffffff)
+	 * When we relocate, we have :
+	 *
+	 *	(kernstart_addr & 0x3ffffff) = (stext.run & 0x3ffffff)
+	 *
+	 * hence:
+	 *  virt_phys_offset = (KERNELBASE & ~0x3ffffff) -
+	 *                              (kernstart_addr & ~0x3ffffff)
+	 *
+	 */
+	kernstart_addr = start;
+	start &= ~0x3ffffff;
+	base &= ~0x3ffffff;
+	virt_phys_offset = base - start;
+}
+#endif
 #endif
-- 
1.8.3.1

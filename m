Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31ECA2C035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 19:21:12 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: enable relocatable support for 6xx
Date: Wed, 19 Jun 2013 17:20:01 +0800
Message-ID: <1371633604-4491-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
References: <1371633604-4491-1-git-send-email-haokexin@gmail.com>
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

This is based on the codes in head_44x.S. With this patch the kernel
can only boot from 0 with CONFIG_RELOCATABLE enabled. We will add the
support to boot from a non 0 address in the following patches.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                   |   2 +-
 arch/powerpc/include/asm/page.h        |   2 +-
 arch/powerpc/kernel/head_32.S          | 103 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom_init_check.sh |   2 +-
 4 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c33e3ad..8fe2792 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -866,7 +866,7 @@ config DYNAMIC_MEMSTART
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on ADVANCED_OPTIONS && FLATMEM && 44x
+	depends on ADVANCED_OPTIONS && FLATMEM && (44x || 6xx)
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 988c812..7145c14 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -207,7 +207,7 @@ extern long long virt_phys_offset;
  * On non-Book-E PPC64 PAGE_OFFSET and MEMORY_START are constants so use
  * the other definitions for __va & __pa.
  */
-#ifdef CONFIG_BOOKE
+#if defined(CONFIG_BOOKE) || defined(CONFIG_6xx)
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
 #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dc0488b..eb47b13 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -73,6 +73,8 @@ _ENTRY(_start);
 	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
 	nop
 
+	bl	perform_relocation
+
 /* PMAC
  * Enter here with the kernel text, data and bss loaded starting at
  * 0, running with virtual == physical mapping.
@@ -149,6 +151,8 @@ __start:
  */
 	bl	early_init
 
+	bl	after_relocation_init
+
 /* Switch MMU off, clear BATs and flush TLB. At this point, r3 contains
  * the physical address we are running at, returned by early_init()
  */
@@ -180,6 +184,7 @@ __after_mmu_off:
 #endif /* CONFIG_6xx */
 
 
+#ifndef CONFIG_RELOCATABLE
 /*
  * We need to run with _start at physical address 0.
  * On CHRP, we are loaded at 0x10000 since OF on CHRP uses
@@ -193,6 +198,8 @@ __after_mmu_off:
 	lis	r5,PHYSICAL_START@h
 	cmplw	0,r4,r5			/* already running at PHYSICAL_START? */
 	bne	relocate_kernel
+#endif
+
 /*
  * we now have the 1st 16M of ram mapped with the bats.
  * prep needs the mmu to be turned on here, but pmac already has it on.
@@ -1263,6 +1270,102 @@ m8260_gorom:
 	blr
 #endif
 
+perform_relocation:
+#ifdef CONFIG_RELOCATABLE
+/*
+ * Relocate ourselves to the current runtime address.
+ * This is called only by the Boot CPU.
+ * r21 will be loaded with the physical runtime address of _stext
+ * Save the r3~r7 since these registers may contain the values needed
+ * by the following boot code.
+ */
+	mr	r22,r3
+	mr	r23,r4
+	mr	r24,r5
+	mr	r25,r6
+	mr	r26,r7
+
+	mflr	r20
+	bl	0f				/* Get our runtime address */
+0:	mflr	r21				/* Make it accessible */
+	addis	r21,r21,(_stext - 0b)@ha
+	addi	r21,r21,(_stext - 0b)@l 	/*Get our current runtime base*/
+
+	/*
+	 * We have the runtime address of our base.
+	 * We calculate our shift of offset from a 256M page.
+	 * We could map the 256M page we belong to at PAGE_OFFSET and
+	 * get going from there.
+	 */
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	rlwinm	r6,r21,0,4,31			/* r6 = PHYS_START % 256M */
+	rlwinm	r5,r4,0,4,31			/* r5 = KERNELBASE % 256M */
+	subf	r3,r5,r6			/* r3 = r6 - r5 */
+	add	r3,r4,r3			/* Required Virutal Address */
+
+	bl	relocate
+	mtlr	r20
+	mr	r3,r22
+	mr	r4,r23
+	mr	r5,r24
+	mr	r6,r25
+	mr	r7,r26
+#endif
+	blr
+
+after_relocation_init:
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Relocatable kernel support based on processing of dynamic
+	 * relocation entries.
+	 *
+	 * r21 will contain the current offset of _stext
+	 */
+	lis	r3,kernstart_addr@ha
+	la	r3,kernstart_addr@l(r3)
+
+	/* Store kernstart_addr */
+	tophys(r3,r3)
+	stw	r21,0(r3)
+
+	/*
+	 * Compute the virt_phys_offset :
+	 * virt_phys_offset = stext.run - kernstart_addr
+	 *
+	 * stext.run = (KERNELBASE & ~0xfffffff) + (kernstart_addr & 0xfffffff)
+	 * When we relocate, we have :
+	 *
+	 *	(kernstart_addr & 0xfffffff) = (stext.run & 0xfffffff)
+	 *
+	 * hence:
+	 *  virt_phys_offset = (KERNELBASE & ~0xfffffff)
+	 *                            - (kernstart_addr & ~0xfffffff)
+	 *
+	 */
+
+	/* KERNELBASE&~0xfffffff => (r4,r5) */
+	lis	r5,KERNELBASE@h
+	rlwinm	r5,r5,0,0,3	/* Align to 256M, lower 32bit */
+
+	/* kernelstart_addr & ~0xfffffff => (r6,r7) */
+	rlwinm	r7,r21,0,0,3	/* Align to 256M, lower 32bit */
+
+	/*
+	 * 64bit subtraction.
+	 */
+	subf	r5,r7,r5
+
+	/* Store virt_phys_offset */
+	lis	r3,virt_phys_offset@h
+	ori	r3,r3,virt_phys_offset@l
+
+	tophys(r3,r3)
+	li	r4,0
+	stw	r4,0(r3)	/* Higher 32bit */
+	stw	r5,4(r3)	/* Lower 32bit */
+#endif
+	blr
 
 /*
  * We put a few things here that have to be page-aligned.
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 3765da6..a24c208 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -22,7 +22,7 @@ __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry
-boot_command_line __prom_init_toc_start __prom_init_toc_end"
+boot_command_line __prom_init_toc_start __prom_init_toc_end virt_phys_offset"
 
 NM="$1"
 OBJ="$2"
-- 
1.8.1.4

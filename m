Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B2392C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 12:01:20 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: enable the relocatable support for the fsl booke
 32bit kernel
Date: Thu, 27 Jun 2013 10:00:33 +0800
Message-ID: <1372298434-20220-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372298434-20220-1-git-send-email-haokexin@gmail.com>
References: <1372298434-20220-1-git-send-email-haokexin@gmail.com>
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
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  8 ++-
 arch/powerpc/kernel/head_fsl_booke.S          | 92 +++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c33e3ad..9eb97ac 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -866,7 +866,7 @@ config DYNAMIC_MEMSTART
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on ADVANCED_OPTIONS && FLATMEM && 44x
+	depends on ADVANCED_OPTIONS && FLATMEM && (44x || FSL_BOOKE)
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index a92c79b..32a4b38 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -165,10 +165,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
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
@@ -176,6 +176,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 7. Jump to KERNELBASE mapping */
 	lis	r6,(KERNELBASE & ~0xfff)@h
 	ori	r6,r6,(KERNELBASE & ~0xfff)@l
+	rlwinm	r7,r25,0,4,31
+	add	r6,r7,r6
 
 #elif defined(ENTRY_MAPPING_KEXEC_SETUP)
 /*
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..c3b4c8e53 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -83,10 +83,43 @@ _ENTRY(_start);
 	andc	r31,r20,r18		/* r31 = page base */
 	or	r31,r31,r19		/* r31 = devtree phys addr */
 	mfspr	r30,SPRN_MAS7
-
-	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
-	li	r23,0			/* phys kernel start (high) */
+
+#ifdef CONFIG_RELOCATABLE
+	bl	0f				/* Get our runtime address */
+0:	mflr	r3				/* Make it accessible */
+	addis	r3,r3,(_stext - 0b)@ha
+	addi	r3,r3,(_stext - 0b)@l 	/* Get our current runtime base */
+
+	/* Translate _stext address to physical, save in r23/r25 */
+	tlbsx	0,r3			/* must succeed */
+
+	mfspr	r16,SPRN_MAS1
+	mfspr	r20,SPRN_MAS3
+	rlwinm	r17,r16,25,0x1f		/* r17 = log2(page size) */
+	li	r18,1024
+	slw	r18,r18,r17		/* r18 = page size */
+	addi	r18,r18,-1
+	and	r19,r3,r18		/* r19 = page offset */
+	andc	r25,r20,r18		/* r25 = page base */
+	or	r25,r25,r19		/* r25 = _stext phys addr */
+	mfspr	r23,SPRN_MAS7
+
+	/*
+	 * We have the runtime (virutal) address of our base.
+	 * We calculate our shift of offset from a 256M page.
+	 * We could map the 256M page we belong to at PAGE_OFFSET and
+	 * get going from there.
+	 */
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	rlwinm	r6,r25,0,4,31			/* r6 = PHYS_START % 256M */
+	rlwinm	r5,r4,0,4,31			/* r5 = KERNELBASE % 256M */
+	subf	r3,r5,r6			/* r3 = r6 - r5 */
+	add	r3,r4,r3			/* Required Virutal Address */
+
+	bl	relocate
+#endif
 
 /* We try to not make any assumptions about how the boot loader
  * setup or used the TLBs.  We invalidate all mappings from the
@@ -197,7 +230,58 @@ _ENTRY(__early_start)
 
 	bl	early_init
 
-#ifdef CONFIG_DYNAMIC_MEMSTART
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Relocatable kernel support based on processing of dynamic
+	 * relocation entries.
+	 *
+	 * r25/r23 will contain RPN/ERPN for the start address of memory
+	 */
+	lis	r3,kernstart_addr@ha
+	la	r3,kernstart_addr@l(r3)
+
+#ifdef CONFIG_PHYS_64BIT
+	stw	r23,0(r3)
+	stw	r25,4(r3)
+#else
+	stw	r25,0(r3)
+#endif
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
+	 *  virt_phys_offset = (KERNELBASE & ~0xfffffff) -
+	 *                              (kernstart_addr & ~0xfffffff)
+	 *
+	 */
+
+	/* KERNELBASE&~0xfffffff => (r4,r5) */
+	li	r4, 0		/* higer 32bit */
+	lis	r5,KERNELBASE@h
+	rlwinm	r5,r5,0,0,3	/* Align to 256M, lower 32bit */
+
+	rlwinm	r7,r25,0,0,3
+	/*
+	 * 64bit subtraction.
+	 */
+	subfc	r5,r7,r5
+	subfe	r4,r23,r4
+
+	/* Store virt_phys_offset */
+	lis	r3,virt_phys_offset@ha
+	la	r3,virt_phys_offset@l(r3)
+
+	stw	r4,0(r3)
+	stw	r5,4(r3)
+
+#elif defined(CONFIG_DYNAMIC_MEMSTART)
 	lis	r3,kernstart_addr@ha
 	la	r3,kernstart_addr@l(r3)
 #ifdef CONFIG_PHYS_64BIT
-- 
1.8.1.4

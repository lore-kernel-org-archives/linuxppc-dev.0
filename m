Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E255167B92
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 18:30:01 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9C8cTAu010478
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 03:38:30 -0500
Subject: [PATCH 1/4] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 18:29:53 +1000
Message-Id: <1160641793.4792.133.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are currently two versions of the functions for applying the
feature fixups, one for CPU features and one for firmware features. In
addition, they are both in assembly.

This patch replaces them with a single C function. The call site is
slightly moved on ppc64 as well to be called from C instead of from
assembly, though it's a very small move, and thus shouldn't cause any
problem (called at the start of setup_system() instead of just before
calling it).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-cell/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/head_64.S	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/head_64.S	2006-10-12 14:24:54.000000000 +1000
@@ -2000,13 +2000,6 @@ _STATIC(start_here_common)
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-	/* Apply the CPUs-specific fixups (nop out sections not relevant
-	 * to this CPU
-	 */
-	li	r3,0
-	bl	.do_cpu_ftr_fixups
-	bl	.do_fw_ftr_fixups
-
 	/* ptr to current */
 	LOAD_REG_IMMEDIATE(r4, init_task)
 	std	r4,PACACURRENT(r13)
Index: linux-cell/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/misc_64.S	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/misc_64.S	2006-10-12 14:24:54.000000000 +1000
@@ -277,99 +277,6 @@ _GLOBAL(identify_cpu)
 	mr	r3,r5
 	bctr
 
-/*
- * do_cpu_ftr_fixups - goes through the list of CPU feature fixups
- * and writes nop's over sections of code that don't apply for this cpu.
- * r3 = data offset (not changed)
- */
-_GLOBAL(do_cpu_ftr_fixups)
-	/* Get CPU 0 features */
-	LOAD_REG_IMMEDIATE(r6,cur_cpu_spec)
-	sub	r6,r6,r3
-	ld	r4,0(r6)
-	sub	r4,r4,r3
-	ld	r4,CPU_SPEC_FEATURES(r4)
-	/* Get the fixup table */
-	LOAD_REG_IMMEDIATE(r6,__start___ftr_fixup)
-	sub	r6,r6,r3
-	LOAD_REG_IMMEDIATE(r7,__stop___ftr_fixup)
-	sub	r7,r7,r3
-	/* Do the fixup */
-1:	cmpld	r6,r7
-	bgelr
-	addi	r6,r6,32
-	ld	r8,-32(r6)	/* mask */
-	and	r8,r8,r4
-	ld	r9,-24(r6)	/* value */
-	cmpld	r8,r9
-	beq	1b
-	ld	r8,-16(r6)	/* section begin */
-	ld	r9,-8(r6)	/* section end */
-	subf.	r9,r8,r9
-	beq	1b
-	/* write nops over the section of code */
-	/* todo: if large section, add a branch at the start of it */
-	srwi	r9,r9,2
-	mtctr	r9
-	sub	r8,r8,r3
-	lis	r0,0x60000000@h	/* nop */
-3:	stw	r0,0(r8)
-	andi.	r10,r4,CPU_FTR_SPLIT_ID_CACHE@l
-	beq	2f
-	dcbst	0,r8		/* suboptimal, but simpler */
-	sync
-	icbi	0,r8
-2:	addi	r8,r8,4
-	bdnz	3b
-	sync			/* additional sync needed on g4 */
-	isync
-	b	1b
-
-/*
- * do_fw_ftr_fixups - goes through the list of firmware feature fixups
- * and writes nop's over sections of code that don't apply for this firmware.
- * r3 = data offset (not changed)
- */
-_GLOBAL(do_fw_ftr_fixups)
-	/* Get firmware features */
-	LOAD_REG_IMMEDIATE(r6,powerpc_firmware_features)
-	sub	r6,r6,r3
-	ld	r4,0(r6)
-	/* Get the fixup table */
-	LOAD_REG_IMMEDIATE(r6,__start___fw_ftr_fixup)
-	sub	r6,r6,r3
-	LOAD_REG_IMMEDIATE(r7,__stop___fw_ftr_fixup)
-	sub	r7,r7,r3
-	/* Do the fixup */
-1:	cmpld	r6,r7
-	bgelr
-	addi	r6,r6,32
-	ld	r8,-32(r6)	/* mask */
-	and	r8,r8,r4
-	ld	r9,-24(r6)	/* value */
-	cmpld	r8,r9
-	beq	1b
-	ld	r8,-16(r6)	/* section begin */
-	ld	r9,-8(r6)	/* section end */
-	subf.	r9,r8,r9
-	beq	1b
-	/* write nops over the section of code */
-	/* todo: if large section, add a branch at the start of it */
-	srwi	r9,r9,2
-	mtctr	r9
-	sub	r8,r8,r3
-	lis	r0,0x60000000@h	/* nop */
-3:	stw	r0,0(r8)
-BEGIN_FTR_SECTION
-	dcbst	0,r8		/* suboptimal, but simpler */
-	sync
-	icbi	0,r8
-END_FTR_SECTION_IFSET(CPU_FTR_SPLIT_ID_CACHE)
-	addi	r8,r8,4
-	bdnz	3b
-	sync			/* additional sync needed on g4 */
-	isync
-	b	1b
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 /*
Index: linux-cell/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup-common.c	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup-common.c	2006-10-12 17:46:02.000000000 +1000
@@ -520,3 +520,32 @@ void __init setup_panic(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
 }
+
+void do_feature_fixups(unsigned long offset, unsigned long value,
+		       void *fixup_start, void *fixup_end)
+{
+	struct fixup_entry {
+		unsigned long	mask;
+		unsigned long	value;
+		unsigned int	*start;
+		unsigned int	*end;
+	} *fcur, *fend;
+
+	fcur = fixup_start;
+	fend = fixup_end;
+
+	for (; fcur < fend; fcur++) {
+		unsigned int *pcur, *pend;
+
+		if ((value & fcur->mask) == fcur->value)
+			continue;
+
+		pcur = fcur->start - offset;
+		pend = fcur->end - offset;
+		for (; pcur < pend; pcur++) {
+			*pcur = 0x60000000u;
+			asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync"
+			     : : "r" (pcur));
+		}
+	}
+}
Index: linux-cell/arch/powerpc/kernel/setup.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup.h	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup.h	2006-10-12 17:46:02.000000000 +1000
@@ -1,9 +1,12 @@
 #ifndef _POWERPC_KERNEL_SETUP_H
 #define _POWERPC_KERNEL_SETUP_H
 
-void check_for_initrd(void);
-void do_init_bootmem(void);
-void setup_panic(void);
+extern void check_for_initrd(void);
+extern void do_init_bootmem(void);
+extern void setup_panic(void);
+extern void do_feature_fixups(unsigned long offset, unsigned long value,
+			      void *fixup_start, void *fixup_end);
+
 extern int do_early_xmon;
 
 #endif /* _POWERPC_KERNEL_SETUP_H */
Index: linux-cell/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_32.c	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_32.c	2006-10-12 17:46:24.000000000 +1000
@@ -90,6 +90,7 @@ int ucache_bsize;
  */
 unsigned long __init early_init(unsigned long dt_ptr)
 {
+	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 	unsigned long offset = reloc_offset();
 
 	/* First zero the BSS -- use memset_io, some platforms don't have
@@ -101,7 +102,9 @@ unsigned long __init early_init(unsigned
 	 * that depend on which cpu we have.
 	 */
 	identify_cpu(offset, 0);
-	do_cpu_ftr_fixups(offset);
+
+	do_feature_fixups(offset, cur_cpu_spec->cpu_features,
+			  &__start___ftr_fixup, &__stop___ftr_fixup);
 
 	return KERNELBASE + offset;
 }
Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-12 14:24:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-12 17:46:18.000000000 +1000
@@ -346,8 +346,19 @@ static void __init initialize_cache_info
  */
 void __init setup_system(void)
 {
+	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
+	extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
+
 	DBG(" -> setup_system()\n");
 
+	/* Apply the CPUs-specific and firmware specific fixups to kernel
+	 * text (nop out sections not relevant to this CPU or this firmware)
+	 */
+	do_feature_fixups(0, cur_cpu_spec->cpu_features,
+			  &__start___ftr_fixup, &__stop___ftr_fixup);
+	do_feature_fixups(0, powerpc_firmware_features,
+			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
+
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
 	 */

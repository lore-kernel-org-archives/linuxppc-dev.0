Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE1ADDDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 23:58:25 +1000 (EST)
Date: Wed, 22 Aug 2007 08:58:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: RFC: [PATCH v2] Fixup modpost warnings in head*.S for ppc32
Message-ID: <Pine.LNX.4.64.0708220856530.31744@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Addess the following modpost warnings we get out of the ppc32 head
files:

WARNING: vmlinux.o(.text+0x358): Section mismatch: reference to .init.text:early_init (between 'skpinv' and 'interrupt_base')
WARNING: vmlinux.o(.text+0x380): Section mismatch: reference to .init.text:machine_init (between 'skpinv' and 'interrupt_base')
WARNING: vmlinux.o(.text+0x384): Section mismatch: reference to .init.text:MMU_init (between 'skpinv' and 'interrupt_base')
WARNING: vmlinux.o(.text+0x3aa): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
WARNING: vmlinux.o(.text+0x3ae): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')

Does anyone have any issues with this?  This version cleans up 40x based
on the latest for-2.6.24 tree and removes the stabs defn from _ENTRY.

- k

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7d73a13..6d332db 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -48,20 +48,17 @@
 	mtspr	SPRN_DBAT##n##L,RB;	\
 1:

-	.text
+	.section	.text.head, "ax"
 	.stabs	"arch/powerpc/kernel/",N_SO,0,0,0f
 	.stabs	"head_32.S",N_SO,0,0,0f
 0:
-	.globl	_stext
-_stext:
+_ENTRY(_stext);

 /*
  * _start is defined this way because the XCOFF loader in the OpenFirmware
  * on the powermac expects the entry point to be a procedure descriptor.
  */
-	.text
-	.globl	_start
-_start:
+_ENTRY(_start);
 	/*
 	 * These are here for legacy reasons, the kernel used to
 	 * need to look like a coff function entry for the pmac
@@ -841,7 +838,7 @@ relocate_kernel:
  * r3 = dest addr, r4 = source addr, r5 = copy limit, r6 = start offset
  * on exit, r3, r4, r5 are unchanged, r6 is updated to be >= r5.
  */
-_GLOBAL(copy_and_flush)
+_ENTRY(copy_and_flush)
 	addi	r5,r5,-4
 	addi	r6,r6,-4
 4:	li	r0,L1_CACHE_BYTES/4
@@ -954,9 +951,9 @@ __secondary_start:
  * included in CONFIG_6xx
  */
 #if !defined(CONFIG_6xx)
-_GLOBAL(__save_cpu_setup)
+_ENTRY(__save_cpu_setup)
 	blr
-_GLOBAL(__restore_cpu_setup)
+_ENTRY(__restore_cpu_setup)
 	blr
 #endif /* !defined(CONFIG_6xx) */

@@ -1080,7 +1077,7 @@ start_here:
 /*
  * Set up the segment registers for a new context.
  */
-_GLOBAL(set_context)
+_ENTRY(set_context)
 	mulli	r3,r3,897	/* multiply context by skew factor */
 	rlwinm	r3,r3,4,8,27	/* VSID = (context & 0xfffff) << 4 */
 	addis	r3,r3,0x6000	/* Set Ks, Ku bits */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index a8e0457..00bdb6d 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -52,9 +52,9 @@
  *
  * This is all going to change RSN when we add bi_recs.......  -- Dan
  */
-	.text
-_GLOBAL(_stext)
-_GLOBAL(_start)
+	.section	.text.head, "ax"
+_ENTRY(_stext);
+_ENTRY(_start);

 	/* Save parameters we are passed.
 	*/
@@ -89,9 +89,9 @@ turn_on_mmu:
  */
 	. = 0xc0
 crit_save:
-_GLOBAL(crit_r10)
+_ENTRY(crit_r10)
 	.space	4
-_GLOBAL(crit_r11)
+_ENTRY(crit_r11)
 	.space	4

 /*
@@ -814,7 +814,7 @@ finish_tlb_load:
  * The PowerPC 4xx family of processors do not have an FPU, so this just
  * returns.
  */
-_GLOBAL(giveup_fpu)
+_ENTRY(giveup_fpu)
 	blr

 /* This is where the main kernel code starts.
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 8869596..7b0fda9 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -50,9 +50,9 @@
  *   r7 - End of kernel command line string
  *
  */
-	.text
-_GLOBAL(_stext)
-_GLOBAL(_start)
+	.section	.text.head, "ax"
+_ENTRY(_stext);
+_ENTRY(_start);
 	/*
 	 * Reserve a word at a fixed location to store the address
 	 * of abatron_pteptrs
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 901be47..a6ecdd6 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -38,12 +38,9 @@
 #else
 #define DO_8xx_CPU6(val, reg)
 #endif
-	.text
-	.globl	_stext
-_stext:
-	.text
-	.globl	_start
-_start:
+	.section	.text.head, "ax"
+_ENTRY(_stext);
+_ENTRY(_start);

 /* MPC8xx
  * This port was done on an MBX board with an 860.  Right now I only
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 1f155d3..d83cbbb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -52,9 +52,9 @@
  *   r7 - End of kernel command line string
  *
  */
-	.text
-_GLOBAL(_stext)
-_GLOBAL(_start)
+	.section	.text.head, "ax"
+_ENTRY(_stext);
+_ENTRY(_start);
 	/*
 	 * Reserve a word at a fixed location to store the address
 	 * of abatron_pteptrs
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0c45855..823a8cb 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -34,6 +34,8 @@ SECTIONS

 	/* Text and gots */
 	.text : {
+		ALIGN_FUNCTION();
+		*(.text.head)
 		_text = .;
 		TEXT_TEXT
 		SCHED_TEXT
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 211fdae..2dbd4e7 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -209,6 +209,10 @@ GLUE(.,name):

 #else /* 32-bit */

+#define _ENTRY(n)	\
+	.globl n;	\
+n:
+
 #define _GLOBAL(n)	\
 	.text;		\
 	.stabs __stringify(n:F-1),N_FUN,0,0,n;\

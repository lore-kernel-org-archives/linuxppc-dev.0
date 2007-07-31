Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23264DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 16:44:15 +1000 (EST)
Date: Tue, 31 Jul 2007 16:44:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix more section mismatches in head_64.S
Message-Id: <20070731164413.0421b430.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x8174): Section mismatch: reference to .init.text:.prom_init (between '.__boot_from_prom' and '.__after_prom_start')
WARNING: vmlinux.o(.text+0x8498): Section mismatch: reference to .init.text:.early_setup (between '.start_here_multiplatform' and '.start_here_common')
WARNING: vmlinux.o(.text+0x8514): Section mismatch: reference to .init.text:.setup_system (between '.start_here_common' and 'system_call_common')
WARNING: vmlinux.o(.text+0x8530): Section mismatch: reference to .init.text:.start_kernel (between '.start_here_common' and 'system_call_common')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/head_64.S |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

Booted in POWER5+.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1448af9..1718000 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1672,8 +1672,9 @@ _GLOBAL(__start_initialization_multiplatform)
 	 * Are we booted from a PROM Of-type client-interface ?
 	 */
 	cmpldi	cr0,r5,0
-	bne	.__boot_from_prom		/* yes -> prom */
-
+	beq	1f
+	b	.__boot_from_prom		/* yes -> prom */
+1:
 	/* Save parameters */
 	mr	r31,r3
 	mr	r30,r4
@@ -1701,7 +1702,7 @@ _GLOBAL(__start_initialization_multiplatform)
 	bl	.__mmu_off
 	b	.__after_prom_start
 
-_STATIC(__boot_from_prom)
+_INIT_STATIC(__boot_from_prom)
 	/* Save parameters */
 	mr	r31,r3
 	mr	r30,r4
@@ -1768,9 +1769,10 @@ _STATIC(__after_prom_start)
 					/*	the source addr		 */
 
 	cmpdi	r4,0			/* In some cases the loader may  */
-	beq	.start_here_multiplatform /* have already put us at zero */
+	bne	1f
+	b	.start_here_multiplatform /* have already put us at zero */
 					/* so we can skip the copy.      */
-	LOAD_REG_IMMEDIATE(r5,copy_to_here) /* # bytes of memory to copy */
+1:	LOAD_REG_IMMEDIATE(r5,copy_to_here) /* # bytes of memory to copy */
 	sub	r5,r5,r27
 
 	li	r6,0x100		/* Start offset, the first 0x100 */
@@ -1957,7 +1959,7 @@ _GLOBAL(enable_64b_mode)
 /*
  * This is where the main kernel code starts.
  */
-_STATIC(start_here_multiplatform)
+_INIT_STATIC(start_here_multiplatform)
 	/* get a new offset, now that the kernel has moved. */
 	bl	.reloc_offset
 	mr	r26,r3
@@ -2019,7 +2021,7 @@ _STATIC(start_here_multiplatform)
 	b	.	/* prevent speculative execution */
 	
 	/* This is where all platforms converge execution */
-_STATIC(start_here_common)
+_INIT_STATIC(start_here_common)
 	/* relocation is on at this point */
 
 	/* The following code sets up the SP and TOC now that we are */
-- 
1.5.2.4

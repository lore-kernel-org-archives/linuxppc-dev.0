Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id 3AD712BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 06:55:33 +1100 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate7.mot.com (Motorola/Motgate7) with ESMTP id iAGJlYZL012261
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 12:47:34 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by az33exr03.mot.com (Motorola/az33exr03) with ESMTP id iAGJtBxx028115
	for <linuxppc-embedded@ozlabs.org>; Tue, 16 Nov 2004 13:55:13 -0600
Date: Tue, 16 Nov 2004 13:55:27 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0411161353000.32505@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Refactor common book-e exception code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Moves common handling of InstructionStorage, Alignment, Program, and 
Decrementer exceptions handlers for Book-E processors (44x & e500) into 
common code.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	2004-11-16 13:43:34 -06:00
+++ b/arch/ppc/kernel/head_44x.S	2004-11-16 13:43:34 -06:00
@@ -414,30 +414,16 @@
 	b	data_access
 
 	/* Instruction Storage Interrupt */
-	START_EXCEPTION(InstructionStorage)
-	NORMAL_EXCEPTION_PROLOG
-	mr      r4,r12                  /* Pass SRR0 as arg2 */
-	li      r5,0                    /* Pass zero as arg3 */
-	EXC_XFER_EE_LITE(0x0400, handle_page_fault)
+	INSTRUCTION_STORAGE_EXCEPTION
 
 	/* External Input Interrupt */
 	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
 
 	/* Alignment Interrupt */
-	START_EXCEPTION(Alignment)
-	NORMAL_EXCEPTION_PROLOG
-	mfspr   r4,SPRN_DEAR            /* Grab the DEAR and save it */
-	stw     r4,_DEAR(r11)
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x0600, AlignmentException)
+	ALIGNMENT_EXCEPTION
 
 	/* Program Interrupt */
-	START_EXCEPTION(Program)
-	NORMAL_EXCEPTION_PROLOG
-	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
-	stw	r4,_ESR(r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x700, ProgramCheckException)
+	PROGRAM_EXCEPTION
 
 	/* Floating Point Unavailable Interrupt */
 	EXCEPTION(0x2010, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
@@ -451,12 +437,7 @@
 	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
-	START_EXCEPTION(Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis     r0,TSR_DIS@h            /* Setup the DEC interrupt mask */
-	mtspr   SPRN_TSR,r0		/* Clear the DEC interrupt */
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x1000, timer_interrupt)
+	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */
diff -Nru a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h	2004-11-16 13:43:34 -06:00
+++ b/arch/ppc/kernel/head_booke.h	2004-11-16 13:43:34 -06:00
@@ -303,4 +303,37 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
 
+#define INSTRUCTION_STORAGE_EXCEPTION					      \
+	START_EXCEPTION(InstructionStorage)				      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr	r5,SPRN_ESR;		/* Grab the ESR and save it */	      \
+	stw	r5,_ESR(r11);						      \
+	mr      r4,r12;                 /* Pass SRR0 as arg2 */		      \
+	li      r5,0;                   /* Pass zero as arg3 */		      \
+	EXC_XFER_EE_LITE(0x0400, handle_page_fault)
+
+#define ALIGNMENT_EXCEPTION						      \
+	START_EXCEPTION(Alignment)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr   r4,SPRN_DEAR;           /* Grab the DEAR and save it */	      \
+	stw     r4,_DEAR(r11);						      \
+	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_EE(0x0600, AlignmentException)
+
+#define PROGRAM_EXCEPTION						      \
+	START_EXCEPTION(Program)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	mfspr	r4,SPRN_ESR;		/* Grab the ESR and save it */	      \
+	stw	r4,_ESR(r11);						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_STD(0x0700, ProgramCheckException)
+
+#define DECREMENTER_EXCEPTION						      \
+	START_EXCEPTION(Decrementer)					      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask */    \
+	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \
+	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_LITE(0x0900, timer_interrupt)
+
 #endif /* __HEAD_BOOKE_H__ */
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-11-16 13:43:34 -06:00
+++ b/arch/ppc/kernel/head_e500.S	2004-11-16 13:43:34 -06:00
@@ -464,32 +464,16 @@
 	b	data_access
 
 	/* Instruction Storage Interrupt */
-	START_EXCEPTION(InstructionStorage)
-	NORMAL_EXCEPTION_PROLOG
-	mfspr	r5,SPRN_ESR		/* Grab the ESR and save it */
-	stw	r5,_ESR(r11)
-	mr      r4,r12                  /* Pass SRR0 as arg2 */
-	li      r5,0                    /* Pass zero as arg3 */
-	EXC_XFER_EE_LITE(0x0400, handle_page_fault)
+	INSTRUCTION_STORAGE_EXCEPTION
 
 	/* External Input Interrupt */
 	EXCEPTION(0x0500, ExternalInput, do_IRQ, EXC_XFER_LITE)
 
 	/* Alignment Interrupt */
-	START_EXCEPTION(Alignment)
-	NORMAL_EXCEPTION_PROLOG
-	mfspr   r4,SPRN_DEAR            /* Grab the DEAR and save it */
-	stw     r4,_DEAR(r11)
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x0600, AlignmentException)
+	ALIGNMENT_EXCEPTION
 
 	/* Program Interrupt */
-	START_EXCEPTION(Program)
-	NORMAL_EXCEPTION_PROLOG
-	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
-	stw	r4,_ESR(r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x0700, ProgramCheckException)
+	PROGRAM_EXCEPTION
 
 	/* Floating Point Unavailable Interrupt */
 	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
@@ -503,12 +487,7 @@
 	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
-	START_EXCEPTION(Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis     r0,TSR_DIS@h            /* Setup the DEC interrupt mask */
-	mtspr   SPRN_TSR,r0		/* Clear the DEC interrupt */
-	addi    r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x0900, timer_interrupt)
+	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */

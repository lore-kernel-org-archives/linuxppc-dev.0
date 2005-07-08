Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92CFC67C05
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Jul 2005 01:03:24 +1000 (EST)
Date: Thu, 7 Jul 2005 21:36:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Yuli Barcohen <yuli@arabellasw.com>
Message-ID: <20050708003639.GA5174@dmt.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<1120244191.18872.3.camel@jmcmullan.timesys>
	<17096.61878.43282.752343@astp0002.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
In-Reply-To: <17096.61878.43282.752343@astp0002.localdomain>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Jason McMullan <jason.mcmullan@gmail.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Yuli, 

On Mon, Jul 04, 2005 at 11:22:14AM +0300, Yuli Barcohen wrote:
> >>>>> Jason McMullan writes:
> 
> [...deleted...]
> 
>     Jason> Ha. Funny. The glibc powerpc maintainer doesn't want any
>     Jason> embedded fixes in the mainline. Last I checked, that was for
>     Jason> 'the tools vendors' to fix.
> 
>     Jason> "We won't work around processor bugs" is their philosophy.
> 
> [...deleted...]
> 
> I investigated the problem a bit when I had trouble with a self-compiled
> glibc a year or so ago. IIRC, I found bug in the memset code, not in the
> chip. The code was just wrong for cache line sizes not equal to 32. So
> memset.S is good for 60x series (PQII included) but for 8xx it fails.

I suppose you didnt actually use dcbz for userspace memset on 8xx? 

> We use dcbX instructions in some kernel drivers and since we never had any
> problems with those drivers I'm a bit surprised to hear that all 8xx
> chips have got that bug.

The problem is that the DAR register is correctly unset (it comes as NULL IIRC) 
on pagefaults for the dcbz instruction. The dcbz instructions you issue are probably
always works on kernel addresses whose pagetables are present?

Joakim has developed a workaround for the problem... although I promised him
several times to test it I never managed to get dcbz to work on the kernel 
copying functions. :(

He has posted it here in the past... here it is attached anyway.
 



--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcbx.patch5"

===== head_8xx.S 1.21 vs edited =====
--- 1.21/arch/ppc/kernel/head_8xx.S	2005-03-29 00:21:20 +02:00
+++ edited/head_8xx.S	2005-04-06 17:01:51 +02:00
@@ -32,6 +32,8 @@
 #include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 
+#define CONFIG_8xx_DCBxFIXED
+
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
 #define DO_8xx_CPU6(val, reg)	\
@@ -41,6 +43,20 @@
 #else
 #define DO_8xx_CPU6(val, reg)
 #endif
+
+#ifdef CONFIG_8xx_DCBxFIXED
+/* These macros are used to tag DAR with a known value so that the
+ * DataTLBError can recognize a buggy dcbx instruction and workaround
+ * the problem.
+ */
+#define TAG_VAL 0x00f0	/*  -1 may also be used */
+#define TAG_DAR_R10 	\
+	li	r10, TAG_VAL;\
+	mtspr	SPRN_DAR, r10;
+#else
+#define TAG_DAR_R10
+#endif
+
 	.text
 	.globl	_stext
 _stext:
@@ -174,6 +190,7 @@
 	xfer(n, hdlr)
 
 #define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)	\
+	TAG_DAR_R10;						\
 	li	r10,trap;					\
 	stw	r10,TRAP(r11);					\
 	li	r10,MSR_KERNEL;					\
@@ -214,6 +231,7 @@
 	mfspr r5,SPRN_DSISR
 	stw r5,_DSISR(r11)
 	addi r3,r1,STACK_FRAME_OVERHEAD
+	TAG_DAR_R10
 	EXC_XFER_STD(0x200, MachineCheckException)
 
 /* Data access exception.
@@ -227,6 +245,7 @@
 	stw	r10,_DSISR(r11)
 	mr	r5,r10
 	mfspr	r4,SPRN_DAR
+	TAG_DAR_R10
 	EXC_XFER_EE_LITE(0x300, handle_page_fault)
 
 /* Instruction access exception.
@@ -252,6 +271,7 @@
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+	TAG_DAR_R10
 	EXC_XFER_EE(0x600, AlignmentException)
 
 /* Program check exception */
@@ -414,7 +434,13 @@
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
+#ifdef CONFIG_8xx_DCBxFIXED
+ #if TAG_VAL == 0x00f0 /* Save 1 instr. by reusing the val loaded in r11 above */
+ 	mtspr	SPRN_DAR, r11
+ #else
+ 	TAG_DAR_R10
+ #endif
+#endif
 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
 	mtcr	r11
@@ -450,11 +476,20 @@
 	mfcr	r10
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
+ 	mfspr	r10, SPRN_DAR
+#ifdef  CONFIG_8xx_DCBxFIXED
+	/* If DAR contains TAG_VAL implies a buggy dcbx instruction
+	 * that did not set DAR.
+	 */
+	cmpwi	cr0, r10, TAG_VAL
+	beq-	100f	/* Branch if TAG_VAL to dcbx workaround procedure */
+101:	/* return from dcbx instruction bug workaround, r10 holds value of DAR */	
+#endif
 
 	/* First, make sure this was a store operation.
 	*/
-	mfspr	r10, SPRN_DSISR
-	andis.	r11, r10, 0x0200	/* If set, indicates store op */
+	mfspr	r11, SPRN_DSISR
+	andis.	r11, r11, 0x0200	/* If set, indicates store op */
 	beq	2f
 
 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
@@ -473,7 +508,7 @@
 	 * are initialized in mapin_ram().  This will avoid the problem,
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
-	mfspr	r10, SPRN_DAR
+	/* DAR is in r10 already */
 	rlwinm	r11, r10, 0, 0, 19
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, SPRN_M_CASID
@@ -523,7 +558,13 @@
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
+#ifdef CONFIG_8xx_DCBxFIXED
+ #if TAG_VAL == 0x00f0 /* Save 1 instr. by reusing the val loaded in r11 above */
+	mtspr	SPRN_DAR, r11
+ #else
+	TAG_DAR_R10
+ #endif
+#endif
 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
 	mtcr	r11
@@ -561,6 +602,185 @@
 
 	. = 0x2000
 
+#ifdef CONFIG_8xx_DCBxFIXED
+/* This is the workaround procedure to calculate the data EA for buggy dcbx,dcbi instructions
+ * by decoding the registers used by the dcbx instruction and adding them.
+ * DAR is set to the calculated address and r10 also holds the EA on exit.
+ */
+//#define INSTR_CHECK /* define to verify if it is a dcbx instr. Should not be needed. */
+//#define NO_SELF_MODIFYING_CODE /* define if you don't want to use self modifying code */
+//#define DEBUG_DCBX_INSTRUCTIONS /* for debugging only. Needs INSTR_CHECK defined as well. */
+//#define KERNEL_SPACE_ONLY /* define if user space do NOT contain dcbx instructions. */
+
+#ifndef KERNEL_SPACE_ONLY
+	nop	/* A few nops to make the modified_instr: space below cache line aligned */
+	nop
+139:	/* fetch instruction from userspace memory */
+	DO_8xx_CPU6(0x3780, r3)
+	mtspr	SPRN_MD_EPN, r10
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table entry address */
+	lwz	r11, 0(r11)	/* Get the level 1 entry */
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
+	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
+	lwz	r11, 0(r11)	/* Get the pte */
+	/* concat physical page address(r11) and page offset(r10) */
+	rlwimi	r11, r10, 0, 20, 31
+	b	140f
+#endif
+100:	/* Entry point for dcbx workaround. */
+	/* fetch instruction from memory. */
+	mfspr	r10,SPRN_SRR0
+#ifndef KERNEL_SPACE_ONLY
+	andis.	r11, r10, 0x8000
+	tophys  (r11, r10)
+	beq-	139b		/* Branch if user space address */
+#else
+	tophys  (r11, r10)
+#endif
+140:	lwz	r11,0(r11)
+#ifdef INSTR_CHECK
+/* Check if it really is a dcbx instruction. This is not needed as far as I can tell */
+/* dcbt and dcbtst does not generate DTLB Misses/Errors, no need to include them here */
+	rlwinm	r10, r11, 0, 21, 30
+	cmpwi	cr0, r10, 2028	/* Is dcbz? */
+	beq+	142f
+	cmpwi	cr0, r10, 940	/* Is dcbi? */
+	beq+	142f
+	cmpwi	cr0, r10, 108	/* Is dcbst? */
+	beq+	142f
+	cmpwi	cr0, r10, 172	/* Is dcbf? */
+	beq+	142f
+	cmpwi	cr0, r10, 1964	/* Is icbi? */
+	beq+	142f
+#ifdef DEBUG_DCBX_INSTRUCTIONS
+141:	b 141b /* Stop here if no dcbx instruction */
+#endif
+	mfspr	r10, SPRN_DAR	/* r10 must hold DAR at exit */
+	b 101b			/* None of the above, go back to normal TLB processing */
+142:	/* continue, it was a dcbx instruction. */
+#endif
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)		/* restore r3 from memory */
+#endif
+#ifndef NO_SELF_MODIFYING_CODE
+	andis.	r10,r11,0x1f	/* test if reg RA is r0 */
+	li	r10,modified_instr@l
+	dcbtst	r0,r10		/* touch for store */
+	rlwinm	r11,r11,0,0,20	/* Zero lower 10 bits */
+	oris	r11,r11,640	/* Transform instr. to a "add r10,RA,RB" */
+	ori	r11,r11,532
+	stw	r11,0(r10)	/* store add/and instruction */
+	dcbf	0,r10		/* flush new instr. to memory. */
+	icbi	0,r10		/* invalidate instr. cache line */
+	lwz	r11, 4(r0)	/* restore r11 from memory */
+	mfspr	r10, SPRN_M_TW	/* restore r10 from M_TW */
+	isync			/* Wait until new instr is loaded from memory */
+modified_instr:
+	.space	4		/* this is where the add/and instr. is stored */
+#ifdef DEBUG_DCBX_INSTRUCTIONS
+	/* fill with some garbage */ 
+	li	r11,0xffff
+	stw	r11,0(r11)
+#endif
+	bne+	143f
+	subf	r10,r0,r10		/* r10=r10-r0, only if reg RA is r0 */
+143:	mtdar	r10			/* store faulting EA in DAR */
+	b	101b			/* Go back to normal TLB handling */
+#else
+	mfctr	r10
+	mtdar	r10			/* save ctr reg in DAR */
+	rlwinm	r10, r11, 24, 24, 28	/* offset into jump table for reg RB */
+	addi	r10, r10, 150f@l	/* add start of table */
+	mtctr	r10			/* load ctr with jump address */
+	xor	r10, r10, r10		/* sum starts at zero */
+	bctr				/* jump into table */
+150:
+	add	r10, r10, r0
+	b	151f
+	add	r10, r10, r1
+	b	151f
+	add	r10, r10, r2
+	b	151f
+	add	r10, r10, r3
+	b	151f
+	add	r10, r10, r4
+	b	151f
+	add	r10, r10, r5
+	b	151f
+	add	r10, r10, r6
+	b	151f
+	add	r10, r10, r7
+	b	151f
+	add	r10, r10, r8
+	b	151f
+	add	r10, r10, r9
+	b	151f
+	mtctr	r11	/* reg 10 needs special handling */
+	b	154f
+	mtctr	r11	/* reg 11 needs special handling */
+	b	153f
+	add	r10, r10, r12
+	b	151f
+	add	r10, r10, r13
+	b	151f
+	add	r10, r10, r14
+	b	151f
+	add	r10, r10, r15
+	b	151f
+	add	r10, r10, r16
+	b	151f
+	add	r10, r10, r17
+	b	151f
+	add	r10, r10, r18
+	b	151f
+	add	r10, r10, r19
+	b	151f
+	add	r10, r10, r20
+	b	151f
+	add	r10, r10, r21
+	b	151f
+	add	r10, r10, r22
+	b	151f
+	add	r10, r10, r23
+	b	151f
+	add	r10, r10, r24
+	b	151f
+	add	r10, r10, r25
+	b	151f
+	add	r10, r10, r25
+	b	151f
+	add	r10, r10, r27
+	b	151f
+	add	r10, r10, r28
+	b	151f
+	add	r10, r10, r29
+	b	151f
+	add	r10, r10, r30
+	b	151f
+	add	r10, r10, r31
+151:
+	rlwinm. r11,r11,19,24,28	/* offset into jump table for reg RA */
+	beq	152f			/* if reg RA is zero, don't add it */ 
+	addi	r11, r11, 150b@l	/* add start of table */
+	mtctr	r11			/* load ctr with jump address */
+	rlwinm	r11,r11,0,16,10		/* make sure we don't execute this more than once */
+	bctr				/* jump into table */
+152:
+	mfdar	r11
+	mtctr	r11			/* restore ctr reg from DAR */
+	mtdar	r10			/* save fault EA to DAR */
+	b	101b			/* Go back to normal TLB handling */
+
+	/* special handling for r10,r11 since these are modified already */
+153:	lwz	r11, 4(r0)	/* load r11 from memory */
+	b	155f
+154:	mfspr	r11, SPRN_M_TW	/* load r10 from M_TW */
+155:	add	r10, r10, r11	/* add it */
+	mfctr	r11		/* restore r11 */
+	b	151b
+#endif
+#endif
 	.globl	giveup_fpu
 giveup_fpu:
 	blr


--NMuMz9nt05w80d4+--

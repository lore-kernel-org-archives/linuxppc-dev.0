Date: Fri, 09 May 2003 14:37:15 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <IGEFJKJNHJDCBKALBJLLMENAFLAA.joakim.tjernlund@lumentis.se>
To: Till Straumann <strauman@SLAC.Stanford.EDU>,
	Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEIEFMAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Me again :-)
>
> I have completed and tested my workaround for the dcbx instructions. The workaround
> handles ALL dcbx instructions, ANY register combination and works both on
> kernel space and user space addresses.
>
> I also did some benchmarking using copy_page(dcbz enabled) and memcpy to
> memory allocated with kmalloc and/or vmalloc. copy_page is about 30% faster
> than memcpy even with the workaround applied.

Here I go again :)

I have been running this patch on some 20-30 custom MPC860/862 boards in our test lab
since I posted this message and it is stable.

I made some changes since then:
 - Made it configurable, #define CONFIG_8xx_DCBxFIXED to enable it.
 - Tagging in the fast path in the DLBMiss handler is just one(1) instruction.
 - Test and branch if TAG present is two instructions in the DTLB Error handler.
 - Enabled the use of the dcbz instruction in copy_tofrom_user(), cacheable_memzero(),
   cacheable_memcpy(), clear_page() and copy_page()

Feedback most welcome!
Patch against linuxppc_2_4_devel follows.

 Jocke

--- a/arch/ppc/kernel/head_8xx.S	Tue Apr 29 00:45:35 2003
+++ b/arch/ppc/kernel/head_8xx.S	Fri May  9 14:16:44 2003
@@ -31,6 +31,27 @@
 #include <asm/ppc_asm.h>
 #include "ppc_defs.h"

+#ifdef CONFIG_8xx_DCBxFIXED
+/* These macros are used to tag DAR with a known value so that the
+ * DataTLBError can recognize a buggy dcbx instruction and workaround
+ * the problem.
+ */
+	#define TAG_VAL 0x00f0
+	#define TAG_DAR_R20 	\
+		li	r20, TAG_VAL;\
+		mtspr	DAR, r20;
+#else
+	#define TAG_DAR_R20
+#endif
+/* Macro to make the code more readable. */
+#ifdef CONFIG_8xx_CPU6
+  #define DO_8xx_CPU6(val, reg) \
+	li	reg, val; \
+	stw	reg, 12(r0); \
+	lwz	reg, 12(r0);
+#else
+  #define DO_8xx_CPU6(val, reg)
+#endif
 	.text
 	.globl	_stext
 _stext:
@@ -166,6 +187,7 @@
 	. = n;					\
 label:						\
 	EXCEPTION_PROLOG;			\
+	TAG_DAR_R20;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
 	li	r20,MSR_KERNEL;			\
 	FINISH_EXCEPTION(hdlr)
@@ -188,6 +210,7 @@
 	mr	r5,r20
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
+	TAG_DAR_R20
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
@@ -226,6 +249,7 @@
 	EXCEPTION_PROLOG
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
+	TAG_DAR_R20
 	mfspr	r5,DSISR
 	stw	r5,_DSISR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -457,6 +481,13 @@
 #endif
 	mtspr	MD_RPN, r20	/* Update TLB entry */

+#ifdef CONFIG_8xx_DCBxFIXED
+#if TAG_VAL == 0x00f0 /* Save 1 instr. by reusing the val loaded in r21 above */
+	mtspr	DAR, r21
+#else
+	TAG_DAR_R20
+#endif
+#endif
 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
@@ -466,7 +497,17 @@
 #endif
 	rfi

-2:	mfspr	r20, M_TW	/* Restore registers */
+2:
+#ifdef CONFIG_8xx_DCBxFIXED
+	/* Copy 20 msb from MD_EPN to DAR since the dcxx instructions fails
+	 * to update DAR when they cause a DTLB Miss.
+	 */
+	mfspr	r21, MD_EPN
+	mfspr	r20, DAR
+	rlwimi	r20, r21, 0, 0, 19
+	mtspr	DAR, r20
+#endif
+	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
@@ -504,10 +545,19 @@
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)

+	mfspr	r20, DAR
+#ifdef  CONFIG_8xx_DCBxFIXED
+	/* If DAR contains TAG_VAL implies a buggy dcbx instruction
+	 * that did not set DAR.
+	 */
+	cmplwi	cr0, r20, TAG_VAL
+	beq-	100f	/* Branch if TAG_VAL to dcbx workaround procedure */
+101:	/* return from dcbx instruction bug workaround, r20 holds value of DAR */
 	/* First, make sure this was a store operation.
 	*/
-	mfspr	r20, DSISR
-	andis.	r21, r20, 0x0200	/* If set, indicates store op */
+#endif
+	mfspr	r21, DSISR
+	andis.	r21, r21, 0x0200	/* If set, indicates store op */
 	beq	2f

 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
@@ -526,7 +576,7 @@
 	 * are initialized in mapin_ram().  This will avoid the problem,
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
-	mfspr	r20, DAR
+	/* DAR is in r20 already */
 	rlwinm	r21, r20, 0, 0, 19
 	ori	r21, r21, MD_EVALID
 	mfspr	r20, M_CASID
@@ -591,6 +641,13 @@
 #endif
 	mtspr	MD_RPN, r20	/* Update TLB entry */

+#ifdef CONFIG_8xx_DCBxFIXED
+#if TAG_VAL == 0x00f0 /* Save 1 instr. by reusing the val loaded in r21 above */
+	mtspr	DAR, r21
+#else
+	TAG_DAR_R20
+#endif
+#endif
 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
@@ -628,6 +685,149 @@

 	. = 0x2000

+#ifdef CONFIG_8xx_DCBxFIXED
+/* This is the workaround procedure to calculate the data EA for a buggy dcbx instruction
+ * by decoding the registers used by the dcbx instruction and adding them.
+ * DAR is set to the calculated address and r20 also holds the EA on exit.
+ */
+139:	/* fetch instruction from userspace memory */
+	DO_8xx_CPU6(0x3780, r3)
+	mtspr	MD_EPN, r20
+	mfspr	r21, M_TWB	/* Get level 1 table entry address */
+	lwz	r21, 0(r21)	/* Get the level 1 entry */
+	tophys  (r21, r21)
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	MD_TWC, r21	/* Load pte table base address */
+	mfspr	r21, MD_TWC	/* ....and get the pte address */
+	lwz	r21, 0(r21)	/* Get the pte */
+	/* concat physical page address(r21) and page offset(r20) */
+	rlwimi	r21, r20, 0, 20, 31
+	b	140f
+100:	/* Entry point for dcbx workaround. */
+	/* fetch instruction from memory. */
+	mfspr	r20,SRR0
+	andis.	r21, r20, 0x8000
+	beq-	139b		/* Branch if user space address */
+	tophys  (r21, r20)
+140:	lwz	r21,0(r21)
+
+/* Check if it really is a dcbx instruction */
+	rlwinm	r20, r21, 0, 21, 30
+	cmpwi	cr0, r20, 2028	/* Is dcbz? */
+	beq+	142f
+	cmpwi	cr0, r20, 940	/* Is dcbi? */
+	beq+	142f
+	cmpwi	cr0, r20, 556	/* Is dcbt? */
+	beq+	142f
+	cmpwi	cr0, r20, 172	/* Is dcbf? */
+	beq+	142f
+#ifdef DEBUG_DCBX_INSTRUCTIONS
+	cmpwi	cr0, r20, 108	/* Is dcbst? Should never cause a DTLB Miss/Error */
+	beq+	142f
+	cmpwi	cr0, r20, 492	/* Is dcbtst? Should never cause a DTLB Miss/Error */
+	beq+	142f
+
+141:	b 141b /* Stop here if no dcbx instruction */
+#endif
+	mfspr	r20, DAR	/* r20 must hold DAR at exit */
+	b 101b			/* None of the above, go back to normal TLB processing */
+142:	/* continue, it was a dcbx instruction. */
+
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)		/* restore r3 from memory */
+#endif
+	mfctr	r20
+	mtdar	r20			/* save ctr reg in DAR */
+	rlwinm	r20, r21, 24, 24, 28	/* offset into jump table for reg RB */
+	addi	r20, r20, 150f@l	/* add start of table */
+	mtctr	r20			/* load ctr with jump address */
+	xor	r20, r20, r20		/* sum starts at zero */
+	bctr				/* jump into table */
+150:
+	add	r20, r20, r0
+	b	151f
+	add	r20, r20, r1
+	b	151f
+	add	r20, r20, r2
+	b	151f
+	add	r20, r20, r3
+	b	151f
+	add	r20, r20, r4
+	b	151f
+	add	r20, r20, r5
+	b	151f
+	add	r20, r20, r6
+	b	151f
+	add	r20, r20, r7
+	b	151f
+	add	r20, r20, r8
+	b	151f
+	add	r20, r20, r9
+	b	151f
+	add	r20, r20, r10
+	b	151f
+	add	r20, r20, r11
+	b	151f
+	add	r20, r20, r12
+	b	151f
+	add	r20, r20, r13
+	b	151f
+	add	r20, r20, r14
+	b	151f
+	add	r20, r20, r15
+	b	151f
+	add	r20, r20, r16
+	b	151f
+	add	r20, r20, r17
+	b	151f
+	add	r20, r20, r18
+	b	151f
+	add	r20, r20, r19
+	b	151f
+	mtctr	r21	/* reg 20 needs special handling */
+	b	154f
+	mtctr	r21	/* reg 21 needs special handling */
+	b	153f
+	add	r20, r20, r22
+	b	151f
+	add	r20, r20, r23
+	b	151f
+	add	r20, r20, r24
+	b	151f
+	add	r20, r20, r25
+	b	151f
+	add	r20, r20, r25
+	b	151f
+	add	r20, r20, r27
+	b	151f
+	add	r20, r20, r28
+	b	151f
+	add	r20, r20, r29
+	b	151f
+	add	r20, r20, r30
+	b	151f
+	add	r20, r20, r31
+151:
+	rlwinm. r21,r21,19,24,28	/* offset into jump table for reg RA */
+	beq	152f			/* if reg RA is zero, don't add it */
+	addi	r21, r21, 150b@l	/* add start of table */
+	mtctr	r21			/* load ctr with jump address */
+	rlwinm	r21,r21,0,16,10		/* make sure we don't execute this more than once */
+	bctr				/* jump into table */
+152:
+	mfdar	r21
+	mtctr	r21			/* restore ctr reg from DAR */
+	mtdar	r20			/* save fault EA to DAR */
+	b	101b			/* Go back to normal TLB handling */
+
+	/* special handling for r20,r21 since these are modified already */
+153:	lwz	r21, 4(r0)	/* load r21 from memory */
+	b	155f
+154:	mfspr	r21, M_TW	/* load r20 from M_TW */
+155:	add	r20, r20, r21	/* add it */
+	mfctr	r21		/* restore r21 */
+	b	151b
+#endif
 /*
  * This code finishes saving the registers to the exception frame
  * and jumps to the appropriate handler for the exception, turning
--- a/arch/ppc/lib/string.S	Tue Apr 29 00:45:35 2003
+++ b/arch/ppc/lib/string.S	Fri May  9 14:17:07 2003
@@ -151,7 +151,7 @@
 	bdnz	4b
 3:	mtctr	r9
 	li	r7,4
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx) || defined(CONFIG_8xx_DCBxFIXED)
 10:	dcbz	r7,r6
 #else
 10:	stw	r4, 4(r6)
@@ -253,7 +253,7 @@
 	mtctr	r0
 	beq	63f
 53:
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx) || defined(CONFIG_8xx_DCBxFIXED)
 	dcbz	r11,r6
 #endif
 	COPY_16_BYTES
@@ -452,6 +452,8 @@
 53:
 #if !defined(CONFIG_8xx)
 	dcbt	r3,r4
+#endif
+#if !defined(CONFIG_8xx) || defined(CONFIG_8xx_DCBxFIXED)
 54:	dcbz	r11,r6
 #endif
 /* had to move these to keep extable in order */
@@ -461,7 +463,7 @@
 	.long	71b,101f
 	.long	72b,102f
 	.long	73b,103f
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_8xx) || defined(CONFIG_8xx_DCBxFIXED)
 	.long	54b,105f
 #endif
 	.text
--- a/arch/ppc/kernel/misc.S	Tue Apr 29 00:45:35 2003
+++ b/arch/ppc/kernel/misc.S	Fri May  9 14:16:23 2003
@@ -657,7 +657,7 @@
 _GLOBAL(clear_page)
 	li	r0,4096/L1_CACHE_LINE_SIZE
 	mtctr	r0
-#ifdef CONFIG_8xx
+#if defined(CONFIG_8xx) && !defined(CONFIG_8xx_DCBxFIXED)
 	li	r4, 0
 1:	stw	r4, 0(r3)
 	stw	r4, 4(r3)
@@ -710,6 +710,8 @@
 1:
 #ifndef CONFIG_8xx
 	dcbt	r11,r4
+#endif
+#if !defined(CONFIG_8xx) || defined(CONFIG_8xx_DCBxFIXED)
 	dcbz	r5,r3
 #endif
 	COPY_16_BYTES


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3A7B535A.E2E9AE0B@routefree.com>
Date: Fri, 02 Feb 2001 16:39:54 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: "Curry, Diane" <dcurry@infiniswitch.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb on IBM Walnut board panics the kernel
References: <FF6CF34C346E724596A2FB5CAAB2C49707F8F2@voyager.ops.infiniswitch.com>
Content-Type: multipart/mixed;
 boundary="------------D3B42C3D92EB68A830A201AB"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D3B42C3D92EB68A830A201AB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Curry, Diane" wrote:
>
> I'm running Monta Vista's Hard Hat Linux (11/26/200 2.4.0-test2) on an
> IBM 405GP walnut rev D board. On an x86 PC running Red Hat Linux 7.0,
> using MV's CDK, I built a small program using ppc_4xx-gcc with the -g
> switch.

Attached is a patch to files in linux/arch/ppc/kernel and
include/asm-ppc that makes the kernel work fine with debugging user mode
programs with a stock gdb 5.0. (we had problems with gdb 4.18, but a
cross compiled gdb5 worked fine).

cd linux; patch -p0 < diffs

Don't know how it compares with monta vista's fixes, but we've been
running these in our development systems for over a month.  We also have
patches that makes PCI device configuration work better in the absence
of a real bios on the walnut board, if anyone would like them.
	david
--------------D3B42C3D92EB68A830A201AB
Content-Type: text/plain; charset=us-ascii;
 name="diffs"
Content-Disposition: inline;
 filename="diffs"
Content-Transfer-Encoding: 7bit

Index: arch/ppc/kernel/head_4xx.S
===================================================================
diff -u -r1.1.1.3 -r1.4
--- arch/ppc/kernel/head_4xx.S	2000/12/28 19:10:54	1.1.1.3
+++ arch/ppc/kernel/head_4xx.S	2000/12/28 23:14:16	1.4
@@ -194,6 +194,17 @@

 	## Common exception code for all exception types.

+#ifdef CONFIG_405GP
+###
+### Need to insert a harmless instruction at the start of each trap
+### handler in case DBCR0_IC is set.  Otherwise we will jump to the
+### DebugException handler and trash whatever we saved in SPRN_SPRG0
+###
+#define COMMON_PROLOG_PREAMBLE  nop
+#else
+#define COMMON_PROLOG_PREAMBLE
+#endif
+
 #define FTR_INT_STATS
 #ifdef FTR_INT_STATS
 #define COMMON_PROLOG(n)                                                     \
@@ -267,6 +278,7 @@
 	## Common exception code for standard (non-critical) exceptions.

 #define	STND_EXCEPTION_PROLOG(n)					     \
+	COMMON_PROLOG_PREAMBLE;         				     \
 	COMMON_PROLOG(n);						     \
 	mfspr	r22,SPRN_SRR0;		/* Faulting instruction address	   */\
 	lis	r20,MSR_WE@h;						     \
@@ -277,6 +289,7 @@
 	## Common exception code for critical exceptions.

 #define	CRIT_EXCEPTION_PROLOG(n)					     \
+	COMMON_PROLOG_PREAMBLE;         			             \
 	COMMON_PROLOG(n);						     \
 	mfspr	r22,SPRN_SRR2;		/* Faulting instruction address	   */\
 	lis	r20,MSR_WE@h;						     \
@@ -496,7 +509,18 @@
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	li	r7,CRIT_EXC;
 	li	r20,MSR_KERNEL_DEBUG_TRAP;  /* can't turn MSR_DE back on yet */
-	FINISH_EXCEPTION(DebugException)
+	andi.	r0,r23,MSR_PR		/* check if user mode */
+	bne+	1f
+	cmplwi	cr0,r22,0x2000		/* check exception address */
+	ble-	2f
+1:
+	bl	transfer_to_handler;	/* process as a regular exception */
+	.long	DebugException;
+	.long	ret_from_except;
+2:
+	bl	transfer_to_handler;	/* we interrupted another exception */
+	.long	debug_off_except_return;/* clear MSR_DE, DBSR_IC and do a */
+	.long	0			/* fast return to the handler */

 #else
 	CRIT_EXCEPTION(0x2000,	DebugTrap,		UnknownException)
@@ -586,22 +610,41 @@
         nop
         nop
         nop
-        nop
-
-        nop
-        nop
-        nop
-        nop
-
         nop
-        nop
-        nop
-        nop
+#endif

-        nop
-        nop
-        nop
-        nop
+#ifdef CONFIG_IBM405GP
+###
+### do a critical exception return and disable MSR_DE so that the
+### interrupted trap handler can complete without pesky debug interrupts
+###
+debug_off_except_return:
+	lis	r0,DBSR_IC@h	/* clear DBSR_IC */
+	mtspr	SPRN_DBSR,r0
+	mtspr	SPRN_SPRG2,r21	/* put exception stack ptr back */
+	lwz	r3,_CTR(r1)
+	lwz	r0,_LINK(r1)
+	mtctr	r3
+	mtlr	r0
+	lwz	r3,_XER(r1)
+	mtspr	XER,r3
+	REST_10GPRS(3, r1)
+	REST_10GPRS(13, r1)
+	REST_8GPRS(23, r1)
+	REST_GPR(31, r1)
+	lwz	r0,_MSR(r1)
+	rlwinm  r0,r0,0,23,21   /* clear MSR_DE in r0 */
+	sync
+	mtspr	SPRN_SRR3,r0
+	lwz	r2,_CCR(r1)
+	mtcrf	0xFF,r2
+	lwz	r2,_NIP(r1)
+	mtspr	SPRN_SRR2,r2
+	lwz	r0,GPR0(r1)
+	lwz	r2,GPR2(r1)
+	lwz	r1,GPR1(r1)
+	SYNC
+	rfci
 #endif

 ###
Index: arch/ppc/kernel/ppc-stub.c
===================================================================
diff -u -r1.1.1.3 -r1.3
--- arch/ppc/kernel/ppc-stub.c	2000/12/28 19:10:54	1.1.1.3
+++ arch/ppc/kernel/ppc-stub.c	2000/12/28 21:54:15	1.3
@@ -472,7 +472,7 @@
 	**   some 0x700 are actually a breakpoint ....
 	**   need to specify SIGTRAP instead of SIGBUS in those cases.....
 	*/
-	{ 0x700, SIGILL  },			/* program */
+	{ 0x700, SIGTRAP },			/* program */
 	{ 0x800, SIGILL  },			/* reserved */
 	{ 0x900, SIGILL  },			/* reserved */
 	{ 0xa00, SIGILL  },			/* reserved */
Index: arch/ppc/kernel/ppc405_setup.c
===================================================================
diff -u -r1.1.1.1 -r1.5
--- arch/ppc/kernel/ppc405_setup.c	2000/12/28 19:10:54	1.1.1.1
+++ arch/ppc/kernel/ppc405_setup.c	2000/12/30 04:34:11	1.5
@@ -66,8 +66,8 @@
 	unsigned int value;

 	/*
-	** Enable trap instruction as a debug interrupt instead of a program
-	** interrupt.
+	** Don't enable debug interrupts yet (MSR_DE) and don't
+	** convert traps to debug exceptions
 	**
 	** Don't just cram a value into BDCR0, so that if a JTAG debugger
 	** has enabled DBCR0_EDM it stays enabled.  (Counting on Boot ROM
@@ -75,10 +75,8 @@
 	*/

 	mtspr(SPRN_DBCR0,
-	      ((mfspr(SPRN_DBCR0) & DBCR0_EDM) | DBCR0_TDE | DBCR0_IDM));
+	      ((mfspr(SPRN_DBCR0) & DBCR0_EDM) | DBCR0_IDM));

-	_nmask_and_or_msr(0, MSR_DE);
-
 #ifdef CONFIG_KGDB
 	/*
          * ftr revisit
@@ -100,12 +98,12 @@
 	value += CPM_GPIO;
 #endif

-#if !defined(CONFIG_I2C_ALGOPPC405) && !defined(CONFIG_I2C_ADAPPPC405)
+#if !defined(CONFIG_PPC405_I2C_ALGO) && !defined(CONFIG_PPC405_I2C_ADAP)
 	value += CPM_IIC;
 #endif

 /* ftr revisit - check whether this bit exists on 405CR */
-#if !defined(CONFIG_IBM405_DMA) && !defined(CONFIG_IBM405CR)
+#if !defined(CONFIG_PPC405_DMA) && !defined(CONFIG_IBM405CR)
 	value += CPM_DMA;
 #endif

Index: arch/ppc/kernel/traps.c
===================================================================
diff -u -r1.1.1.2 -r1.4
--- arch/ppc/kernel/traps.c	2000/12/28 19:10:54	1.1.1.2
+++ arch/ppc/kernel/traps.c	2000/12/28 21:54:16	1.4
@@ -242,7 +242,7 @@

 	if (esr & ESR_PTR) {
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
-		if (debugger_bpt(regs))
+		if (!user_mode(regs) && debugger_bpt(regs))
 			return;
 #endif
 		_exception(SIGTRAP, regs);
@@ -373,6 +373,10 @@
 	unsigned long debug_status;

 	debug_status = mfspr(SPRN_DBSR);
+
+	if (!user_mode(regs))
+		printk("DebugException()  DBSR = 0x%lx  regs = 0x%p  NIP = 0x%lx\n",
+			debug_status, regs, regs->nip); /* ftrzzz */

 	if (debug_status & DBSR_TIE) {		/* trap instruction*/

Index: include/asm-ppc/processor.h
===================================================================
diff -u -r1.1.1.2 -r1.3
--- include/asm-ppc/processor.h	2000/12/28 19:10:26	1.1.1.2
+++ include/asm-ppc/processor.h	2000/12/28 21:54:16	1.3
@@ -46,7 +46,7 @@
 #ifdef CONFIG_IBM405

 #define MSR_KERNEL_DEBUG_TRAP	MSR_IR | MSR_DR | MSR_ME
-#define MSR_KERNEL		MSR_IR | MSR_DR | MSR_ME | MSR_DE
+#define MSR_KERNEL		MSR_IR | MSR_DR | MSR_ME

 #elif defined(CONFIG_APUS_FAST_EXCEPT)


--------------D3B42C3D92EB68A830A201AB--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

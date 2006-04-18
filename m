Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17476.31998.168122.413195@cargo.ozlabs.ibm.com>
Date: Tue, 18 Apr 2006 15:45:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
In-Reply-To: <1145048461.4223.38.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<1145048461.4223.38.camel@localhost.localdomain>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Looks good to me except that we need the same for ppc64 since the 970
> theorically has the same problem...

OK, does this look OK to everyone, before I send it off to Linus?  I
now use a bit in the thread_info rather than using the HID0 bits
themselves to indicate that we're napping, since the m[ft]spr might be
slow.  I added a `local_flags' field to the thread_info struct for
things that are only changed by the task itself and therefore don't
need to be accessed atomically.

This version does the same sort of change for the 970 as for 6xx.

Oh, and I also fixed a stupid bug in the 32-bit stack overflow code,
where we put &_end into r11, and then if there was a stack overflow,
saved registers into the stack frame pointed to by r11. :)

Paul.

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 54b48f3..8f85c5e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -91,6 +91,7 @@ #endif /* CONFIG_SPE */
 #endif /* CONFIG_PPC64 */
 
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index b3a9794..8866fd2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -128,37 +128,36 @@ #if defined(CONFIG_40x) || defined(CONFI
 	stw	r12,4(r11)
 #endif
 	b	3f
+
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
          * check for stack overflow
          */
+	lwz	r9,THREAD_INFO-THREAD(r12)
+	cmplw	r1,r9			/* if r1 <= current->thread_info */
+	ble-	stack_ovf		/* then the kernel stack overflowed */
+5:
 #ifdef CONFIG_6xx
-	mfspr	r11,SPRN_HID0
-	mtcr	r11
-BEGIN_FTR_SECTION
-	bt-	8,4f			/* Check DOZE */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-BEGIN_FTR_SECTION
-	bt-	9,4f			/* Check NAP */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+	tophys(r9,r9)			/* check local flags */
+	lwz	r12,TI_LOCAL_FLAGS(r9)
+	mtcrf	0x01,r12
+	bt-	31-TLF_NAPPING,4f
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
-	lwz	r11,THREAD_INFO-THREAD(r12)
-	cmplw	r1,r11			/* if r1 <= current->thread_info */
-	ble-	stack_ovf		/* then the kernel stack overflowed */
 3:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-	FIX_SRR1(r10,r12)
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
 
-#ifdef CONFIG_6xx	
-4:	b	power_save_6xx_restore
+#ifdef CONFIG_6xx
+4:	rlwinm	r12,r12,0,~_TLF_NAPPING
+	stw	r12,TI_LOCAL_FLAGS(r9)
+	b	power_save_6xx_restore
 #endif
 
 /*
@@ -167,10 +166,10 @@ #endif
  */
 stack_ovf:
 	/* sometimes we use a statically-allocated stack, which is OK. */
-	lis	r11,_end@h
-	ori	r11,r11,_end@l
-	cmplw	r1,r11
-	ble	3b			/* r1 <= &_end is OK */
+	lis	r12,_end@h
+	ori	r12,r12,_end@l
+	cmplw	r1,r12
+	ble	5b			/* r1 <= &_end is OK */
 	SAVE_NVGPRS(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	lis	r1,init_thread_union@ha
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a5ae04a..3b500dc 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -381,6 +381,7 @@ #define STD_EXCEPTION_COMMON_LITE(trap, 
 	.globl label##_common;				\
 label##_common:						\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
+	FINISH_NAP;					\
 	DISABLE_INTS;					\
 	bl	.ppc64_runlatch_on;			\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
@@ -388,6 +389,25 @@ label##_common:						\
 	b	.ret_from_except_lite
 
 /*
+ * When the idle code in power4_idle puts the CPU into NAP mode,
+ * it has to do so in a loop, and relies on the external interrupt
+ * and decrementer interrupt entry code to get it out of the loop.
+ * It sets the _TLF_NAPPING bit in current_thread_info()->local_flags
+ * to signal that it is in the loop and needs help to get out.
+ */
+#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
+#define FINISH_NAP				\
+BEGIN_FTR_SECTION				\
+	clrrdi	r11,r1,THREAD_SHIFT;		\
+	ld	r9,TI_LOCAL_FLAGS(r11);		\
+	andi.	r10,r9,_TLF_NAPPING;		\
+	bnel	power4_fixup_nap;		\
+END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
+#else
+#define FINISH_NAP
+#endif
+
+/*
  * Start of pSeries system interrupt routines
  */
 	. = 0x100
@@ -1034,12 +1054,22 @@ unrecov_slb:
 	.globl hardware_interrupt_entry
 hardware_interrupt_common:
 	EXCEPTION_PROLOG_COMMON(0x500, PACA_EXGEN)
+	FINISH_NAP
 hardware_interrupt_entry:
 	DISABLE_INTS
 	bl	.ppc64_runlatch_on
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite
+
+#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
+power4_fixup_nap:
+	andc	r9,r9,r10
+	std	r9,TI_LOCAL_FLAGS(r11)
+	ld	r10,_LINK(r1)		/* make idle task do the */
+	std	r10,_NIP(r1)		/* equivalent of a blr */
+	blr
+#endif
 
 	.align	7
 	.globl alignment_common
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 12a4efb..b45fa0e 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -22,8 +22,6 @@ #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
-#undef DEBUG
-
 	.text
 
 /*
@@ -109,12 +107,6 @@ BEGIN_FTR_SECTION
 	dcbf	0,r4
 	dcbf	0,r4
 END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
-#ifdef DEBUG
-	lis	r6,nap_enter_count@ha
-	lwz	r4,nap_enter_count@l(r6)
-	addi	r4,r4,1
-	stw	r4,nap_enter_count@l(r6)
-#endif	
 2:
 BEGIN_FTR_SECTION
 	/* Go to low speed mode on some 750FX */
@@ -144,48 +136,42 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	rlwinm	r9,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	lwz	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
+	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
+	stw	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
 	mfmsr	r7
 	ori	r7,r7,MSR_EE
 	oris	r7,r7,MSR_POW@h
-	sync
-	isync
+1:	sync
 	mtmsr	r7
 	isync
-	sync
-	blr
-	
+	b	1b
+
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
  * we are called with DR/IR still off and r2 containing physical
- * address of current.
+ * address of current.  R11 points to the exception frame (physical
+ * address).  We have to preserve r10.
  */
 _GLOBAL(power_save_6xx_restore)
-	mfspr	r11,SPRN_HID0
-	rlwinm.	r11,r11,0,10,8	/* Clear NAP & copy NAP bit !state to cr1 EQ */
-	cror	4*cr1+eq,4*cr0+eq,4*cr0+eq
-BEGIN_FTR_SECTION
-	rlwinm	r11,r11,0,9,7	/* Clear DOZE */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-	mtspr	SPRN_HID0, r11
-
-#ifdef DEBUG
-	beq	cr1,1f
-	lis	r11,(nap_return_count-KERNELBASE)@ha
-	lwz	r9,nap_return_count@l(r11)
-	addi	r9,r9,1
-	stw	r9,nap_return_count@l(r11)
-1:
-#endif
-	
-	rlwinm	r9,r1,0,0,18
-	tophys(r9,r9)
-	lwz	r11,TI_CPU(r9)
+	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
+	stw	r9,_NIP(r11)		/* make it do a blr */
+
+#ifdef CONFIG_SMP
+	mfspr	r12,SPRN_SPRG3
+	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
 	slwi	r11,r11,2
+#else
+	li	r11,0
+#endif
 	/* Todo make sure all these are in the same page
-	 * and load r22 (@ha part + CPU offset) only once
+	 * and load r11 (@ha part + CPU offset) only once
 	 */
 BEGIN_FTR_SECTION
-	beq	cr1,1f
+	mfspr	r9,SPRN_HID0
+	andis.	r9,r9,HID0_NAP@h
+	beq	1f
 	addis	r9,r11,(nap_save_msscr0-KERNELBASE)@ha
 	lwz	r9,nap_save_msscr0@l(r9)
 	mtspr	SPRN_MSSCR0, r9
@@ -210,10 +196,3 @@ _GLOBAL(nap_save_hid1)
 
 _GLOBAL(powersave_lowspeed)
 	.long	0
-
-#ifdef DEBUG
-_GLOBAL(nap_enter_count)
-	.space	4
-_GLOBAL(nap_return_count)
-	.space	4
-#endif
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 6dad1c0..d85c7c9 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -35,12 +35,16 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	clrrdi	r9,r1,THREAD_SHIFT	/* current thread_info */
+	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
+	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
+	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
 	mfmsr	r7
 	ori	r7,r7,MSR_EE
 	oris	r7,r7,MSR_POW@h
-	sync
+1:	sync
 	isync
 	mtmsrd	r7
 	isync
-	sync
-	blr
+	b	1b
+
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index ffc7462..88b553c 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -37,6 +37,8 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	struct restart_block restart_block;
+	unsigned long	local_flags;		/* private flags for thread */
+
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
@@ -142,6 +144,12 @@ #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCAL
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
 				 _TIF_NEED_RESCHED | _TIF_RESTORE_SIGMASK)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
+
+/* Bits in local_flags */
+/* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
+#define TLF_NAPPING		0	/* idle thread enabled NAP mode */
+
+#define _TLF_NAPPING		(1 << TLF_NAPPING)
 
 #endif /* __KERNEL__ */
 

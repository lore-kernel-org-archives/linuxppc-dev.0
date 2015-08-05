Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC5C01A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 14:03:01 +1000 (AEST)
Date: Wed, 5 Aug 2015 14:03:00 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alan Modra <amodra@gmail.com>, benh@kernel.crashing.org, Michael
 Ellerman <mpe@ellerman.id.au>, paulus@samba.org, Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>, Michael Gschwind <mkg@us.ibm.com>, Bill
 Schmidt <wschmidt@us.ibm.com>
Subject: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150805140300.218ef661@kryten>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/c2nftXCCDK1u3nAUxV4yG1o"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--MP_/c2nftXCCDK1u3nAUxV4yG1o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

While looking at traces of kernel workloads, I noticed places where gcc
used a large number of non volatiles. Some of these functions
did very little work, and we spent most of our time saving the
non volatiles to the stack and reading them back.

It made me wonder if we have the right ratio of volatile to non
volatile GPRs. Since the kernel is completely self contained, we could
potentially change that ratio.

Attached is a quick hack to gcc and the kernel to decrease the number
of non volatile GPRs to 8. I'm not sure if this is a good idea (and if
the volatile to non volatile ratio is right), but this gives us
something to play with.

Anton 
--MP_/c2nftXCCDK1u3nAUxV4yG1o
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=linux-volatiles.patch

powerpc: Reduce the number of non volatiles GPRs to 8

This requires a hacked gcc.

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: linux.junk/arch/powerpc/include/asm/exception-64s.h
===================================================================
--- linux.junk.orig/arch/powerpc/include/asm/exception-64s.h
+++ linux.junk/arch/powerpc/include/asm/exception-64s.h
@@ -336,6 +336,7 @@ do_kvm_##n:								\
 	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe   */ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
+	SAVE_10GPRS(14, r1);						   \
 	mflr	r9;			/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	std	r9,_LINK(r1);						   \
Index: linux.junk/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- linux.junk.orig/arch/powerpc/include/asm/ppc_asm.h
+++ linux.junk/arch/powerpc/include/asm/ppc_asm.h
@@ -77,8 +77,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 #ifdef __powerpc64__
 #define SAVE_GPR(n, base)	std	n,GPR0+8*(n)(base)
 #define REST_GPR(n, base)	ld	n,GPR0+8*(n)(base)
-#define SAVE_NVGPRS(base)	SAVE_8GPRS(14, base); SAVE_10GPRS(22, base)
-#define REST_NVGPRS(base)	REST_8GPRS(14, base); REST_10GPRS(22, base)
+#define SAVE_NVGPRS(base)	SAVE_8GPRS(24, base)
+#define REST_NVGPRS(base)	REST_8GPRS(24, base)
 #else
 #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
 #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
Index: linux.junk/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux.junk.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux.junk/arch/powerpc/kernel/asm-offsets.c
@@ -289,7 +289,6 @@ int main(void)
 	DEFINE(GPR11, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[11]));
 	DEFINE(GPR12, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[12]));
 	DEFINE(GPR13, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[13]));
-#ifndef CONFIG_PPC64
 	DEFINE(GPR14, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[14]));
 	DEFINE(GPR15, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[15]));
 	DEFINE(GPR16, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[16]));
@@ -308,7 +307,6 @@ int main(void)
 	DEFINE(GPR29, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[29]));
 	DEFINE(GPR30, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[30]));
 	DEFINE(GPR31, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[31]));
-#endif /* CONFIG_PPC64 */
 	/*
 	 * Note: these symbols include _ because they overlap with special
 	 * register names
Index: linux.junk/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux.junk.orig/arch/powerpc/kernel/entry_64.S
+++ linux.junk/arch/powerpc/kernel/entry_64.S
@@ -86,6 +86,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	std	r11,_XER(r1)
 	std	r11,_CTR(r1)
 	std	r9,GPR13(r1)
+
+	std	r14,GPR14(r1)
+	std	r15,GPR15(r1)
+	std	r16,GPR16(r1)
+	std	r17,GPR17(r1)
+	std	r18,GPR18(r1)
+	std	r19,GPR19(r1)
+	std	r20,GPR20(r1)
+	std	r21,GPR21(r1)
+	std	r22,GPR22(r1)
+	std	r23,GPR23(r1)
+
 	mflr	r10
 	/*
 	 * This clears CR0.SO (bit 28), which is the error indication on
@@ -112,6 +124,7 @@ BEGIN_FW_FTR_SECTION
 	cmpd	cr1,r11,r10
 	beq+	cr1,33f
 	bl	accumulate_stolen_time
+	trap
 	REST_GPR(0,r1)
 	REST_4GPRS(3,r1)
 	REST_2GPRS(7,r1)
@@ -225,7 +238,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECK
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	HMT_MEDIUM_LOW_HAS_PPR
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
-1:	ld	r2,GPR2(r1)
+1:
+	REST_10GPRS(14, r1)
+	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
@@ -405,10 +420,10 @@ _GLOBAL(ret_from_fork)
 _GLOBAL(ret_from_kernel_thread)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
-	mtlr	r14
-	mr	r3,r15
+	mtlr	r24
+	mr	r3,r25
 #if defined(_CALL_ELF) && _CALL_ELF == 2
-	mr	r12,r14
+	mr	r12,r24
 #endif
 	blrl
 	li	r3,0
@@ -540,8 +555,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEG
 	mtcrf	0xFF,r6
 
 	/* r3-r13 are destroyed -- Cort */
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+	REST_8GPRS(24, r1)
 
 	/* convert old thread to its task_struct for return value */
 	addi	r3,r3,-THREAD
@@ -771,6 +785,7 @@ fast_exception_return:
 	mtspr	SPRN_XER,r4
 
 	REST_8GPRS(5, r1)
+	REST_10GPRS(14, r1)
 
 	andi.	r0,r3,MSR_RI
 	beq-	unrecov_restore
Index: linux.junk/arch/powerpc/kernel/process.c
===================================================================
--- linux.junk.orig/arch/powerpc/kernel/process.c
+++ linux.junk/arch/powerpc/kernel/process.c
@@ -1207,12 +1207,12 @@ int copy_thread(unsigned long clone_flag
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		/* function */
 		if (usp)
-			childregs->gpr[14] = ppc_function_entry((void *)usp);
+			childregs->gpr[24] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = 1;
 #endif
-		childregs->gpr[15] = kthread_arg;
+		childregs->gpr[25] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;

--MP_/c2nftXCCDK1u3nAUxV4yG1o
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=gcc-volatiles.patch

powerpc: Reduce the number of non volatiles GPRs to 8

A quick hack to test this change on the Linux kernel.

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: gcc/gcc/config/rs6000/rs6000.h
===================================================================
--- gcc.orig/gcc/config/rs6000/rs6000.h
+++ gcc/gcc/config/rs6000/rs6000.h
@@ -1017,8 +1017,8 @@ enum data_align { align_abi, align_opt,
    Aside from that, you can include as many other registers as you like.  */
 
 #define CALL_USED_REGISTERS  \
-  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, FIXED_R13, 0, 0, \
-   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
+  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, FIXED_R13, 1, 1, \
+   1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, \
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, \
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,	   \
@@ -1039,8 +1039,8 @@ enum data_align { align_abi, align_opt,
    of `CALL_USED_REGISTERS'.  */
 
 #define CALL_REALLY_USED_REGISTERS  \
-  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, FIXED_R13, 0, 0, \
-   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
+  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, FIXED_R13, 1, 1, \
+   1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, \
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, \
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,	   \
@@ -1058,7 +1058,7 @@ enum data_align { align_abi, align_opt,
 
 #define FIRST_SAVED_ALTIVEC_REGNO (FIRST_ALTIVEC_REGNO+20)
 #define FIRST_SAVED_FP_REGNO	  (14+32)
-#define FIRST_SAVED_GP_REGNO	  (FIXED_R13 ? 14 : 13)
+#define FIRST_SAVED_GP_REGNO	  24
 
 /* List the order in which to allocate registers.  Each register must be
    listed once, even those in FIXED_REGISTERS.
@@ -1124,8 +1124,8 @@ enum data_align { align_abi, align_opt,
    MAYBE_R2_AVAILABLE						\
    9, 10, 8, 7, 6, 5, 4,					\
    3, EARLY_R12 11, 0,						\
-   31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19,		\
-   18, 17, 16, 15, 14, 13, LATE_R12				\
+   23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 			\
+   31, 30, 29, 28, 27, 26, 25, 24, 13, LATE_R12			\
    66, 65,							\
    1, MAYBE_R2_FIXED 67, 76,					\
    /* AltiVec registers.  */					\

--MP_/c2nftXCCDK1u3nAUxV4yG1o--

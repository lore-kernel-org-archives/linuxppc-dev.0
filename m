Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0BC7B71DF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/14] powerpc/85xx: Save scratch registers to thread info
	instead of using SPRGs.
Date: Fri, 20 May 2011 01:09:26 -0500
Message-Id: <1305871771-16334-9-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
Cc: Ashish Kalra <Ashish.Kalra@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ashish Kalra <Ashish.Kalra@freescale.com>

We expect this is actually faster, and we end up needing more space than we
can get from the SPRGs in some instances.  This is also useful when running
as a guest OS - SPRGs4-7 do not have guest versions.

8 slots are allocated in thread_info for this even though we only actually
use 4 of them - this allows space for future code to have more scratch
space (and we know we'll need it for things like hugetlb).

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/processor.h |    5 +++
 arch/powerpc/include/asm/reg.h       |    4 +-
 arch/powerpc/kernel/asm-offsets.c    |    3 ++
 arch/powerpc/kernel/head_booke.h     |   42 ++++++++++++++++++-----------
 arch/powerpc/kernel/head_fsl_booke.S |   49 ++++++++++++++++++---------------
 5 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index d50c2b6..eb11a44 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -20,6 +20,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
+#include <linux/cache.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
@@ -156,6 +157,10 @@ struct thread_struct {
 #endif
 	struct pt_regs	*regs;		/* Pointer to saved register state */
 	mm_segment_t	fs;		/* for get_fs() validation */
+#ifdef CONFIG_BOOKE
+	/* BookE base exception scratch space; align on cacheline */
+	unsigned long	normsave[8] ____cacheline_aligned;
+#endif
 #ifdef CONFIG_PPC32
 	void		*pgdir;		/* root of page-table tree */
 #endif
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fdec593..ef1d1d6 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -867,8 +867,8 @@
 #define SPRN_SPRG_WSCRATCH2	SPRN_SPRG4W
 #define SPRN_SPRG_RSCRATCH3	SPRN_SPRG5R
 #define SPRN_SPRG_WSCRATCH3	SPRN_SPRG5W
-#define SPRN_SPRG_RSCRATCH_MC	SPRN_SPRG6R
-#define SPRN_SPRG_WSCRATCH_MC	SPRN_SPRG6W
+#define SPRN_SPRG_RSCRATCH_MC	SPRN_SPRG1
+#define SPRN_SPRG_WSCRATCH_MC	SPRN_SPRG1
 #define SPRN_SPRG_RSCRATCH4	SPRN_SPRG7R
 #define SPRN_SPRG_WSCRATCH4	SPRN_SPRG7W
 #ifdef CONFIG_E200
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6887661..ea95441 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -82,6 +82,9 @@ int main(void)
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
 	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
+#ifdef CONFIG_BOOKE
+	DEFINE(THREAD_NORMSAVES, offsetof(struct thread_struct, normsave[0]));
+#endif
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index a0bf158..fc921bf 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -20,33 +20,43 @@
 	addi	reg,reg,val@l
 #endif
 
+/*
+ * Macro used to get to thread save registers.
+ * Note that entries 0-3 are used for the prolog code, and the remaining
+ * entries are available for specific exception use in the event a handler
+ * requires more than 4 scratch registers.
+ */
+#define THREAD_NORMSAVE(offset)	(THREAD_NORMSAVES + (offset * 4))
+
 #define NORMAL_EXCEPTION_PROLOG						     \
-	mtspr	SPRN_SPRG_WSCRATCH0,r10;/* save two registers to work with */\
-	mtspr	SPRN_SPRG_WSCRATCH1,r11;				     \
-	mtspr	SPRN_SPRG_WSCRATCH2,r1;					     \
-	mfcr	r10;			/* save CR in r10 for now	   */\
+	mtspr	SPRN_SPRG_WSCRATCH0, r10;	/* save one register */	     \
+	mfspr	r10, SPRN_SPRG_THREAD;					     \
+	stw	r11, THREAD_NORMSAVE(0)(r10);				     \
+	stw	r13, THREAD_NORMSAVE(2)(r10);				     \
+	mfcr	r13;			/* save CR in r13 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
+	mr	r11, r1;						     \
 	beq	1f;							     \
-	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	ALLOC_STACK_FRAME(r1, THREAD_SIZE);				     \
-1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
-	mr	r11,r1;							     \
-	stw	r10,_CCR(r11);          /* save various registers	   */\
+	/* if from user, start at top of this thread's kernel stack */       \
+	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
+1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
+	stw	r13, _CCR(r11);		/* save various registers */	     \
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
-	mfspr	r10,SPRN_SPRG_RSCRATCH0;					\
-	stw	r10,GPR10(r11);						     \
-	mfspr	r12,SPRN_SPRG_RSCRATCH1;				     \
+	mfspr	r13, SPRN_SPRG_RSCRATCH0;				     \
+	stw	r13, GPR10(r11);					     \
+	lwz	r12, THREAD_NORMSAVE(0)(r10);				     \
 	stw	r12,GPR11(r11);						     \
+	lwz	r13, THREAD_NORMSAVE(2)(r10); /* restore r13 */		     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRN_SPRG_RSCRATCH2;				     \
 	mfspr	r12,SPRN_SRR0;						     \
-	stw	r10,GPR1(r11);						     \
+	stw	r1, GPR1(r11);						     \
 	mfspr	r9,SPRN_SRR1;						     \
-	stw	r10,0(r11);						     \
+	stw	r1, 0(r11);						     \
+	mr	r1, r11;						     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
 	lis	r10, STACK_FRAME_REGS_MARKER@ha;/* exception frame marker */ \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 5ecf54c..985638d 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -346,11 +346,12 @@ interrupt_base:
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
 	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
-	mtspr	SPRN_SPRG_WSCRATCH1, r11
-	mtspr	SPRN_SPRG_WSCRATCH2, r12
-	mtspr	SPRN_SPRG_WSCRATCH3, r13
-	mfcr	r11
-	mtspr	SPRN_SPRG_WSCRATCH4, r11
+	mfspr	r10, SPRN_SPRG_THREAD
+	stw	r11, THREAD_NORMSAVE(0)(r10)
+	stw	r12, THREAD_NORMSAVE(1)(r10)
+	stw	r13, THREAD_NORMSAVE(2)(r10)
+	mfcr	r13
+	stw	r13, THREAD_NORMSAVE(3)(r10)
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -416,11 +417,12 @@ interrupt_base:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG_RSCRATCH4
+	mfspr	r10, SPRN_SPRG_THREAD
+	lwz	r11, THREAD_NORMSAVE(3)(r10)
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG_RSCRATCH3
-	mfspr	r12, SPRN_SPRG_RSCRATCH2
-	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	lwz	r13, THREAD_NORMSAVE(2)(r10)
+	lwz	r12, THREAD_NORMSAVE(1)(r10)
+	lwz	r11, THREAD_NORMSAVE(0)(r10)
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	DataStorage
 
@@ -432,11 +434,12 @@ interrupt_base:
 	 */
 	START_EXCEPTION(InstructionTLBError)
 	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
-	mtspr	SPRN_SPRG_WSCRATCH1, r11
-	mtspr	SPRN_SPRG_WSCRATCH2, r12
-	mtspr	SPRN_SPRG_WSCRATCH3, r13
-	mfcr	r11
-	mtspr	SPRN_SPRG_WSCRATCH4, r11
+	mfspr	r10, SPRN_SPRG_THREAD
+	stw	r11, THREAD_NORMSAVE(0)(r10)
+	stw	r12, THREAD_NORMSAVE(1)(r10)
+	stw	r13, THREAD_NORMSAVE(2)(r10)
+	mfcr	r13
+	stw	r13, THREAD_NORMSAVE(3)(r10)
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -496,11 +499,12 @@ interrupt_base:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
-	mfspr	r11, SPRN_SPRG_RSCRATCH4
+	mfspr	r10, SPRN_SPRG_THREAD
+	lwz	r11, THREAD_NORMSAVE(3)(r10)
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG_RSCRATCH3
-	mfspr	r12, SPRN_SPRG_RSCRATCH2
-	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	lwz	r13, THREAD_NORMSAVE(2)(r10)
+	lwz	r12, THREAD_NORMSAVE(1)(r10)
+	lwz	r11, THREAD_NORMSAVE(0)(r10)
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	InstructionStorage
 
@@ -621,11 +625,12 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	tlbwe
 
 	/* Done...restore registers and get out of here.  */
-	mfspr	r11, SPRN_SPRG_RSCRATCH4
+	mfspr	r10, SPRN_SPRG_THREAD
+	lwz	r11, THREAD_NORMSAVE(3)(r10)
 	mtcr	r11
-	mfspr	r13, SPRN_SPRG_RSCRATCH3
-	mfspr	r12, SPRN_SPRG_RSCRATCH2
-	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	lwz	r13, THREAD_NORMSAVE(2)(r10)
+	lwz	r12, THREAD_NORMSAVE(1)(r10)
+	lwz	r11, THREAD_NORMSAVE(0)(r10)
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	rfi					/* Force context change */
 
-- 
1.7.3.4

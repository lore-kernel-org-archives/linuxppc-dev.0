Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE21BB6FBB
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2012 16:59:11 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v2][PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
Date: Thu, 7 Jun 2012 14:56:43 +0800
Message-ID: <1339052203-4783-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In entry_64.S version of ret_from_except_lite, you'll notice that
in the !preempt case, after we've checked MSR_PR we test for any
TIF flag in _TIF_USER_WORK_MASK to decide whether to go to do_work
or not. However, in the preempt case, we do a convoluted trick to
test SIGPENDING only if PR was set and always test NEED_RESCHED ...
but we forget to test any other bit of _TIF_USER_WORK_MASK !!! So
that means that with preempt, we completely fail to test for things
like single step, syscall tracing, etc...

This should be fixed as the following path:

 - Test PR. If not set, go to resume_kernel, else continue.

 - If go resume_kernel, to do that original do_work.

 - If else, then always test for _TIF_USER_WORK_MASK to decide to do
that original user_work, else restore directly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
v2:
* reorganize the original do_work/user_work

 arch/powerpc/kernel/entry_64.S |   97 ++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ed1718f..5971c85 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -558,27 +558,54 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-#ifdef CONFIG_PREEMPT
 	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
-	li	r0,_TIF_NEED_RESCHED	/* bits to check */
 	ld	r3,_MSR(r1)
 	ld	r4,TI_FLAGS(r9)
-	/* Move MSR_PR bit in r3 to _TIF_SIGPENDING position in r0 */
-	rlwimi	r0,r3,32+TIF_SIGPENDING-MSR_PR_LG,_TIF_SIGPENDING
-	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING */
-	bne	do_work
-
-#else /* !CONFIG_PREEMPT */
-	ld	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r3,r3,MSR_PR
-	beq	restore		/* if not, just restore regs and return */
+	beq	resume_kernel
 
 	/* Check current_thread_info()->flags */
+	andi.	r0,r4,_TIF_USER_WORK_MASK
+	beq	restore
+
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	1f
+	bl	.restore_interrupts
+	bl	.schedule
+	b	.ret_from_except_lite
+
+1:	bl	.save_nvgprs
+	bl	.restore_interrupts
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.do_notify_resume
+	b	.ret_from_except
+
+resume_kernel:
+#ifdef CONFIG_PREEMPT
+	/* Check if we need to preempt */
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq+	restore
+	/* Check that preempt_count() == 0 and interrupts are enabled */
+	lwz	r8,TI_PREEMPT(r9)
+	cmpwi	cr1,r8,0
+	ld	r0,SOFTE(r1)
+	cmpdi	r0,0
+	crandc	eq,cr1*4+eq,eq
+	bne	restore
+
+	/*
+	 * Here we are preempting the current task. We want to make
+	 * sure we are soft-disabled first
+	 */
+	SOFT_DISABLE_INTS(r3,r4)
+1:	bl	.preempt_schedule_irq
+
+	/* Re-test flags and eventually loop */
 	clrrdi	r9,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r9)
-	andi.	r0,r4,_TIF_USER_WORK_MASK
-	bne	do_work
-#endif /* !CONFIG_PREEMPT */
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	bne	1b
+#endif /* CONFIG_PREEMPT */
 
 	.globl	fast_exc_return_irq
 fast_exc_return_irq:
@@ -759,50 +786,6 @@ restore_check_irq_replay:
 #endif /* CONFIG_PPC_BOOK3E */
 1:	b	.ret_from_except /* What else to do here ? */
  
-
-
-3:
-do_work:
-#ifdef CONFIG_PREEMPT
-	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
-	bne	user_work
-	/* Check that preempt_count() == 0 and interrupts are enabled */
-	lwz	r8,TI_PREEMPT(r9)
-	cmpwi	cr1,r8,0
-	ld	r0,SOFTE(r1)
-	cmpdi	r0,0
-	crandc	eq,cr1*4+eq,eq
-	bne	restore
-
-	/*
-	 * Here we are preempting the current task. We want to make
-	 * sure we are soft-disabled first
-	 */
-	SOFT_DISABLE_INTS(r3,r4)
-1:	bl	.preempt_schedule_irq
-
-	/* Re-test flags and eventually loop */
-	clrrdi	r9,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r9)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	bne	1b
-	b	restore
-
-user_work:
-#endif /* CONFIG_PREEMPT */
-
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	bl	.restore_interrupts
-	bl	.schedule
-	b	.ret_from_except_lite
-
-1:	bl	.save_nvgprs
-	bl	.restore_interrupts
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_notify_resume
-	b	.ret_from_except
-
 unrecov_restore:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
-- 
1.5.6

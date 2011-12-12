Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C27B2B70DD
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 20:11:19 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
Date: Mon, 12 Dec 2011 17:10:35 +0800
Message-ID: <1323681035-19350-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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

 - Test PR. If set, go to test_work_user, else continue.

 - In test_work_user, always test for _TIF_USER_WORK_MASK to decide to
go to do_work, maybe call it do_user_work

 - In test_work_kernel, test for _TIF_KERNEL_WORK_MASK which is set to
our new flag along with NEED_RESCHED if preempt is enabled and branch to
do_kernel_work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/entry_64.S |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d834425..9e70b9a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -571,27 +571,26 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r9,1		/* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-#ifdef CONFIG_PREEMPT
-	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
-	li	r0,_TIF_NEED_RESCHED	/* bits to check */
-	ld	r3,_MSR(r1)
-	ld	r4,TI_FLAGS(r9)
-	/* Move MSR_PR bit in r3 to _TIF_SIGPENDING position in r0 */
-	rlwimi	r0,r3,32+TIF_SIGPENDING-MSR_PR_LG,_TIF_SIGPENDING
-	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING */
-	bne	do_work
-
-#else /* !CONFIG_PREEMPT */
 	ld	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r3,r3,MSR_PR
-	beq	restore		/* if not, just restore regs and return */
+	bne	test_work_user
 
+	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
+	li	r0,_TIF_USER_WORK_MASK
+#ifdef CONFIG_PREEMPT
+	ori	r0,r0,_TIF_NEED_RESCHED
+#endif
+	ld	r4,TI_FLAGS(r9)
+	and.	r0,r4,r0	/* check NEED_RESCHED and maybe _TIF_USER_WORK_MASK */
+	bne	do_kernel_work
+	b	restore		/* if so, just restore regs and return */
+
+test_work_user:
 	/* Check current_thread_info()->flags */
 	clrrdi	r9,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_USER_WORK_MASK
-	bne	do_work
-#endif
+	bne	do_user_work
 
 restore:
 BEGIN_FW_FTR_SECTION
@@ -693,10 +692,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	b	.ret_from_except_lite		/* loop back and handle more */
 #endif
 
-do_work:
+do_kernel_work:
 #ifdef CONFIG_PREEMPT
-	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
-	bne	user_work
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
@@ -738,9 +735,9 @@ do_work:
 	bne	1b
 	b	restore
 
-user_work:
 #endif /* CONFIG_PREEMPT */
 
+do_user_work:
 	/* Enable interrupts */
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	1
-- 
1.5.6

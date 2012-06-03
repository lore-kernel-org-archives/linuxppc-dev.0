Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9334B6FC4
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2012 15:09:23 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v3 PATCH 2/3] ppc32/kprobe: complete kprobe and migrate exception
 frame
Date: Sun, 3 Jun 2012 13:07:41 +0800
Message-ID: <1338700063-30670-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1338700063-30670-1-git-send-email-tiejun.chen@windriver.com>
References: <1338700063-30670-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't emulate stwu since that may corrupt current exception stack.
So we will have to do real store operation in the exception return code.

Firstly we'll allocate a trampoline exception frame below the kprobed
function stack and copy the current exception frame to the trampoline.
Then we can do this real store operation to implement 'stwu', and reroute
the trampoline frame to r1 to complete this exception migration.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/entry_32.S |   43 +++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ba3aeb4..e7eefdf 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -829,19 +829,50 @@ restore_user:
 	bnel-	load_dbcr0
 #endif
 
-#ifdef CONFIG_PREEMPT
 	b	restore
 
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
-	/* check current_thread_info->preempt_count */
+	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
-	lwz	r0,TI_PREEMPT(r9)
-	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
-	bne	restore
 	lwz	r0,TI_FLAGS(r9)
+	andis.	r0,r0,_TIF_EMULATE_STACK_STORE@h
+	beq+	1f
+
+	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
+
+	lwz	r3,GPR1(r1)
+	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
+	mr	r4,r1			/* src:  current exception frame */
+	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
+	mr	r1,r3			/* Reroute the trampoline frame to r1 */
+	bl	memcpy			/* Copy from the original to the trampoline */
+
+	/* Do real store operation to complete stwu */
+	lwz	r5,GPR1(r1)
+	stw	r8,0(r5)
+
+	/* Clear _TIF_EMULATE_STACK_STORE flag */
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	lis	r11,_TIF_EMULATE_STACK_STORE@h
+	addi	r5,r9,TI_FLAGS
+0:	lwarx	r8,0,r5
+	andc	r8,r8,r11
+#ifdef CONFIG_IBM405_ERR77
+	dcbt	0,r5
+#endif
+	stwcx.	r8,0,r5
+	bne-	0b
+1:
+
+#ifdef CONFIG_PREEMPT
+	/* check current_thread_info->preempt_count */
+	lwz	r8,TI_PREEMPT(r9)
+	cmpwi	0,r8,0		/* if non-zero, just restore regs and return */
+	bne	restore
 	andi.	r0,r0,_TIF_NEED_RESCHED
 	beq+	restore
+	lwz	r3,_MSR(r1)	
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -862,8 +893,6 @@ resume_kernel:
 	 */
 	bl	trace_hardirqs_on
 #endif
-#else
-resume_kernel:
 #endif /* CONFIG_PREEMPT */
 
 	/* interrupts are hard-disabled at this point */
-- 
1.5.6

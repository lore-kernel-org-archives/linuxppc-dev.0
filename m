Return-Path: <npiggin@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGMT4DgTzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:05 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id w138so10418404oiw.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 02/14] powerpc/64: syscall avoid restore_math call if possible
Date: Fri,  2 Jun 2017 17:39:34 +1000
Message-Id: <20170602073946.8983-3-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The syscall exit code that branches to restore_math is quite
heavyweight on Book3S, consisting of 2 mtmsr instructions. This
case can happen even if restore_math decides there is nothing
to do due to lazy math restore.

Check for lazy restore before calling restore_math. Move most
of that case out of line.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 62 +++++++++++++++++++++++++++++-------------
 arch/powerpc/kernel/process.c  |  4 +++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index bfbad08a1207..019a6322b982 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -210,27 +210,17 @@ system_call:			/* label this so stack traces look sane */
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 
-	andi.	r0,r8,MSR_FP
-	beq 2f
+	/* If MSR_FP and MSR_VEC are set in user msr, then no need to restore */
+	li	r0,MSR_FP
 #ifdef CONFIG_ALTIVEC
-	andis.	r0,r8,MSR_VEC@h
-	bne	3f
+	oris	r0,r0,MSR_VEC@h
 #endif
-2:	addi    r3,r1,STACK_FRAME_OVERHEAD
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
-	bl	restore_math
-#ifdef CONFIG_PPC_BOOK3S
-	li	r11,0
-	mtmsrd	r11,1
-#endif
-	ld	r8,_MSR(r1)
-	ld	r3,RESULT(r1)
-	li	r11,-MAX_ERRNO
+	andc	r7,r8,r0
+	cmpd	r7,r0
+	bne	syscall_restore_math
+.Lsyscall_restore_math_cont:
 
-3:	cmpld	r3,r11
+	cmpld	r3,r11
 	ld	r5,_CCR(r1)
 	bge-	syscall_error
 .Lsyscall_error_cont:
@@ -263,7 +253,41 @@ syscall_error:
 	neg	r3,r3
 	std	r5,_CCR(r1)
 	b	.Lsyscall_error_cont
-	
+
+syscall_restore_math:
+	/*
+	 * Some initial tests from restore_math to avoid the heavyweight
+	 * C code entry and MSR manipulations.
+	 */
+	LOAD_REG_IMMEDIATE(r0, MSR_TS_MASK)
+	and.	r0,r0,r8
+	bne	1f
+
+	ld	r7,PACACURRENT(r13)
+	lbz	r0,THREAD+THREAD_LOAD_FP(r7)
+#ifdef CONFIG_ALTIVEC
+	lbz	r6,THREAD+THREAD_LOAD_VEC(r7)
+	add	r0,r0,r6
+#endif
+	cmpdi	r0,0
+	beq	.Lsyscall_restore_math_cont
+
+1:	addi    r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_PPC_BOOK3S
+	li	r10,MSR_RI
+	mtmsrd	r10,1		/* Restore RI */
+#endif
+	bl	restore_math
+#ifdef CONFIG_PPC_BOOK3S
+	li	r11,0
+	mtmsrd	r11,1
+#endif
+	/* Restore volatiles, reload MSR from updated one */
+	ld	r8,_MSR(r1)
+	ld	r3,RESULT(r1)
+	li	r11,-MAX_ERRNO
+	b	.Lsyscall_restore_math_cont
+
 /* Traced system call support */
 syscall_dotrace:
 	bl	save_nvgprs
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index baae104b16c7..5cbb8b1faf7e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -511,6 +511,10 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
+	/*
+	 * Syscall exit makes a similar initial check before branching
+	 * to restore_math. Keep them in synch.
+	 */
 	if (!msr_tm_active(regs->msr) &&
 		!current->thread.load_fp && !loadvec(current->thread))
 		return;
-- 
2.11.0

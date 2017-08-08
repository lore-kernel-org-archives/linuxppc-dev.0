Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWXh04LlzDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:56:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	schwab@linux-m68k.org
Subject: [PATCH] Revert "powerpc/64: Avoid restore_math call if possible in
 syscall exit"
Date: Tue,  8 Aug 2017 20:55:57 +1000
Message-Id: <1502189757-11623-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f.

As reported by Andreas, this commit is causing unrecoverable SLB misses in the
system call exit path:

  Unrecoverable exception 4100 at c00000000000a1ec
  Oops: Unrecoverable exception, sig: 6 [#1]
  SMP NR_CPUS=2 PowerMac
  ...
  CPU: 0 PID: 18626 Comm: rm Not tainted 4.13.0-rc3 #1
  task: c00000018335e080 task.stack: c000000139e50000
  NIP: c00000000000a1ec LR: c00000000000a118 CTR: 0000000000000000
  REGS: c000000139e53bb0 TRAP: 4100   Not tainted  (4.13.0-rc3)
  MSR: 9000000000001030 <SF,HV,ME,IR,DR> CR: 24000044  XER: 20000000 SOFTE: 1
  GPR00: 0000000000000000 c000000139e53e30 c000000000abb500 fffffffffffffffe
  GPR04: c0000001eb866298 0000000000000000 0000000000000000 c00000018335e080
  GPR08: 900000000000d032 0000000000000000 0000000000000002 fffffffffffff001
  GPR12: c000000139e50000 c00000000ffff000 00003fffa8c0dca0 00003fffa8c0dc88
  GPR16: 0000000010000000 0000000000000001 00003fffa8c0eaa0 0000000000000000
  GPR20: 00003fffa8c27528 00003fffa8c27b00 0000000000000000 0000000000000000
  GPR24: 00003fffa8c0d918 00003ffff1b3efa0 00003fffa8c26d68 0000000000000000
  GPR28: 00003fffa8c249e8 00003fffa8c263d0 00003fffa8c27550 00003ffff1b3ef10
  NIP [c00000000000a1ec] system_call_exit+0xc0/0x21c
  LR [c00000000000a118] system_call+0x58/0x6c
  Call Trace:
  [c000000139e53e30] [c00000000000a118] system_call+0x58/0x6c (unreliable)
  Instruction dump:
  64a51000 7c6300d0 f8a101a0 4bffff9c 3c000000 60000006 780007c6 64000000
  60000000 7c004039 4082001c e8ed0170 <88070b78> 88c70b79 7c003214 2c200000

This is caused by us trying to load THREAD_LOAD_FP with MSR_RI=0, and taking an
SLB miss on the thread struct.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Diagnosed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 60 +++++++++++++-----------------------------
 arch/powerpc/kernel/process.c  |  4 ---
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 49d8422767b4..e925c1c99c71 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -223,17 +223,27 @@ system_call_exit:
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	.Lsyscall_exit_work
 
-	/* If MSR_FP and MSR_VEC are set in user msr, then no need to restore */
-	li	r7,MSR_FP
+	andi.	r0,r8,MSR_FP
+	beq 2f
 #ifdef CONFIG_ALTIVEC
-	oris	r7,r7,MSR_VEC@h
+	andis.	r0,r8,MSR_VEC@h
+	bne	3f
 #endif
-	and	r0,r8,r7
-	cmpd	r0,r7
-	bne	.Lsyscall_restore_math
-.Lsyscall_restore_math_cont:
+2:	addi    r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_PPC_BOOK3S
+	li	r10,MSR_RI
+	mtmsrd	r10,1		/* Restore RI */
+#endif
+	bl	restore_math
+#ifdef CONFIG_PPC_BOOK3S
+	li	r11,0
+	mtmsrd	r11,1
+#endif
+	ld	r8,_MSR(r1)
+	ld	r3,RESULT(r1)
+	li	r11,-MAX_ERRNO
 
-	cmpld	r3,r11
+3:	cmpld	r3,r11
 	ld	r5,_CCR(r1)
 	bge-	.Lsyscall_error
 .Lsyscall_error_cont:
@@ -267,40 +277,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r5,_CCR(r1)
 	b	.Lsyscall_error_cont
 
-.Lsyscall_restore_math:
-	/*
-	 * Some initial tests from restore_math to avoid the heavyweight
-	 * C code entry and MSR manipulations.
-	 */
-	LOAD_REG_IMMEDIATE(r0, MSR_TS_MASK)
-	and.	r0,r0,r8
-	bne	1f
-
-	ld	r7,PACACURRENT(r13)
-	lbz	r0,THREAD+THREAD_LOAD_FP(r7)
-#ifdef CONFIG_ALTIVEC
-	lbz	r6,THREAD+THREAD_LOAD_VEC(r7)
-	add	r0,r0,r6
-#endif
-	cmpdi	r0,0
-	beq	.Lsyscall_restore_math_cont
-
-1:	addi    r3,r1,STACK_FRAME_OVERHEAD
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
-	bl	restore_math
-#ifdef CONFIG_PPC_BOOK3S
-	li	r11,0
-	mtmsrd	r11,1
-#endif
-	/* Restore volatiles, reload MSR from updated one */
-	ld	r8,_MSR(r1)
-	ld	r3,RESULT(r1)
-	li	r11,-MAX_ERRNO
-	b	.Lsyscall_restore_math_cont
-
 /* Traced system call support */
 .Lsyscall_dotrace:
 	bl	save_nvgprs
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9f3e2c932dcc..ec480966f9bf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -511,10 +511,6 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
-	/*
-	 * Syscall exit makes a similar initial check before branching
-	 * to restore_math. Keep them in synch.
-	 */
 	if (!msr_tm_active(regs->msr) &&
 		!current->thread.load_fp && !loadvec(current->thread))
 		return;
-- 
2.7.4

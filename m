Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 055791A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:29:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 2/3] powerpc/kernel: Prepare for seccomp-filter in the
 64-bit syscall path
Date: Fri, 15 May 2015 18:29:39 +1000
Message-Id: <1431678580-11160-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1431678580-11160-1-git-send-email-mpe@ellerman.id.au>
References: <1431678580-11160-1-git-send-email-mpe@ellerman.id.au>
Cc: strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support seccomp-filter we need to be able to cope with
seccomp potentially setting a return value for the syscall.

Currently this doesn't work, because we assume any failure from
do_syscall_trace_enter() should result in ENOSYS being returned to
userspace.

The complication is that we don't know if seccomp has set a return
value, in fact the failure may not even be caused by seccomp it may have
been from ptrace. So in some cases we should return ENOSYS, and in
others we should return whatever's in regs, but we don't know which at
this level.

The trick is to pre-fill regs->result with -ENOSYS, so that we return
that unless seccomp overwrites it with something else.

Note that it's negative ENOSYS, so that we still go via the
syscall_error path on the way out and set CR0[SO].

On the other hand in syscall_set_return_value() we set the return value
as it should be presented to userspace. That is mainly for consistency
with syscall_get_error().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscall.h | 13 +++++++++++++
 arch/powerpc/kernel/entry_64.S     | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ff21b7a2f0cc..3f61ef03a54a 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -50,6 +50,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
+	/*
+	 * We are setting the return value _as presented to userspace_.
+	 * So we set CR0[SO] and also negate error, making it positive.
+	 * That means we will _not_ go through the syscall_error path on the
+	 * exit to userspace.
+	 */
 	if (error) {
 		regs->ccr |= 0x10000000L;
 		regs->gpr[3] = -error;
@@ -57,6 +63,13 @@ static inline void syscall_set_return_value(struct task_struct *task,
 		regs->ccr &= ~0x10000000L;
 		regs->gpr[3] = val;
 	}
+
+	/*
+	 * Set regs->result to match r3. This mirrors the way a regular syscall
+	 * exit works. It also makes the return value juggling in
+	 * syscall_dotrace work.
+	 */
+	regs->result = regs->gpr[3];
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b55c393310f3..3c912d9047c4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -143,8 +143,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
-	bne	syscall_dotrace
-.Lsyscall_dotrace_cont:
+	bne	syscall_dotrace /* does not return */
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
@@ -235,27 +234,53 @@ syscall_error:
 	
 /* Traced system call support */
 syscall_dotrace:
+	/* Save non-volatile GPRs so seccomp/ptrace etc. can see them */
 	bl	save_nvgprs
 
+	/*
+	 * Seccomp may set regs->result, but we don't know at this level, so
+	 * preload result with ENOSYS here. That way below in the path to
+	 * .Lsyscall_exit we can load regs->result and get either ENOSYS, or
+	 * the value set by seccomp.
+	 */
+	li	r3,-ENOSYS
+	std	r3,RESULT(r1)
+
 	/* Get pt_regs into r3 */
 	mr	r3, r9
 	bl	do_syscall_trace_enter
+
 	/*
-	 * Restore argument registers possibly just changed.
-	 * We use the return value of do_syscall_trace_enter
-	 * for the call number to look up in the table (r0).
+	 * We use the return value of do_syscall_trace_enter() as the syscall
+	 * number. If the syscall was rejected for any reason
+	 * do_syscall_trace_enter() returns -1 and the test below against
+	 * NR_syscalls will fail.
 	 */
 	mr	r0,r3
+
+	/* Restore argument registers just clobbered and/or possibly changed. */
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
 	ld	r5,GPR5(r1)
 	ld	r6,GPR6(r1)
 	ld	r7,GPR7(r1)
 	ld	r8,GPR8(r1)
+
+	/* Repopulate r9 and r10 for the system_call path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	CURRENT_THREAD_INFO(r10, r1)
 	ld	r10,TI_FLAGS(r10)
-	b	.Lsyscall_dotrace_cont
+
+	/* Check the syscall number is valid */
+	cmpldi	0,r0,NR_syscalls
+	blt+	system_call
+
+	/*
+	 * Syscall number is bad, get the result, either ENOSYS from above or
+	 * something set by seccomp.
+	 */
+	ld	r3,RESULT(r1)
+	b	.Lsyscall_exit
 
 syscall_enosys:
 	li	r3,-ENOSYS
-- 
2.1.0

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A5C81A084F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 14:48:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove old compile time disabled syscall tracing code
Date: Wed, 14 Jan 2015 14:47:56 +1100
Message-Id: <1421207276-1737-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have code to do syscall tracing which is disabled at compile time by
default. It's not been touched since the dawn of time (ie. v2.6.12).

There are now better ways to do syscall tracing, ie. using the
raw_syscall, or syscall tracepoints.

For the specific case of tracing syscalls at boot on a system that
doesn't get to userspace, you can boot with:

  trace_event=syscalls tp_printk=on

Which will trace syscalls from boot, and echo all output to the console.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_32.S | 77 ------------------------------------------
 arch/powerpc/kernel/entry_64.S | 13 -------
 arch/powerpc/kernel/syscalls.c | 14 --------
 3 files changed, 104 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 10a093579191..cb8ef68a1ae5 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,9 +33,6 @@
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
 
-#undef SHOW_SYSCALLS
-#undef SHOW_SYSCALLS_TASK
-
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
  */
@@ -307,9 +304,6 @@ _GLOBAL(DoSyscall)
 	lwz	r11,_CCR(r1)	/* Clear SO bit in CR */
 	rlwinm	r11,r11,0,4,2
 	stw	r11,_CCR(r1)
-#ifdef SHOW_SYSCALLS
-	bl	do_show_syscall
-#endif /* SHOW_SYSCALLS */
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/* Return from syscalls can (and generally will) hard enable
 	 * interrupts. You aren't supposed to call a syscall with
@@ -352,9 +346,6 @@ syscall_dotrace_cont:
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
-#ifdef SHOW_SYSCALLS
-	bl	do_show_syscall_exit
-#endif
 	mr	r6,r3
 	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
@@ -523,74 +514,6 @@ syscall_exit_work:
 	bl	do_syscall_trace_leave
 	b	ret_from_except_full
 
-#ifdef SHOW_SYSCALLS
-do_show_syscall:
-#ifdef SHOW_SYSCALLS_TASK
-	lis	r11,show_syscalls_task@ha
-	lwz	r11,show_syscalls_task@l(r11)
-	cmp	0,r2,r11
-	bnelr
-#endif
-	stw	r31,GPR31(r1)
-	mflr	r31
-	lis	r3,7f@ha
-	addi	r3,r3,7f@l
-	lwz	r4,GPR0(r1)
-	lwz	r5,GPR3(r1)
-	lwz	r6,GPR4(r1)
-	lwz	r7,GPR5(r1)
-	lwz	r8,GPR6(r1)
-	lwz	r9,GPR7(r1)
-	bl	printk
-	lis	r3,77f@ha
-	addi	r3,r3,77f@l
-	lwz	r4,GPR8(r1)
-	mr	r5,r2
-	bl	printk
-	lwz	r0,GPR0(r1)
-	lwz	r3,GPR3(r1)
-	lwz	r4,GPR4(r1)
-	lwz	r5,GPR5(r1)
-	lwz	r6,GPR6(r1)
-	lwz	r7,GPR7(r1)
-	lwz	r8,GPR8(r1)
-	mtlr	r31
-	lwz	r31,GPR31(r1)
-	blr
-
-do_show_syscall_exit:
-#ifdef SHOW_SYSCALLS_TASK
-	lis	r11,show_syscalls_task@ha
-	lwz	r11,show_syscalls_task@l(r11)
-	cmp	0,r2,r11
-	bnelr
-#endif
-	stw	r31,GPR31(r1)
-	mflr	r31
-	stw	r3,RESULT(r1)	/* Save result */
-	mr	r4,r3
-	lis	r3,79f@ha
-	addi	r3,r3,79f@l
-	bl	printk
-	lwz	r3,RESULT(r1)
-	mtlr	r31
-	lwz	r31,GPR31(r1)
-	blr
-
-7:	.string	"syscall %d(%x, %x, %x, %x, %x, "
-77:	.string	"%x), current=%p\n"
-79:	.string	" -> %x\n"
-	.align	2,0
-
-#ifdef SHOW_SYSCALLS_TASK
-	.data
-	.globl	show_syscalls_task
-show_syscalls_task:
-	.long	-1
-	.text
-#endif
-#endif /* SHOW_SYSCALLS */
-
 /*
  * The fork/clone functions need to copy the full register set into
  * the child process. Therefore we need to save all the nonvolatile
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 194e46dcf08d..c6dcb560c295 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -49,8 +49,6 @@ exception_marker:
 	.section	".text"
 	.align 7
 
-#undef SHOW_SYSCALLS
-
 	.globl system_call_common
 system_call_common:
 	andi.	r10,r12,MSR_PR
@@ -142,13 +140,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	li	r10,1
 	std	r10,SOFTE(r1)
 
-#ifdef SHOW_SYSCALLS
-	bl	do_show_syscall
-	REST_GPR(0,r1)
-	REST_4GPRS(3,r1)
-	REST_2GPRS(7,r1)
-	addi	r9,r1,STACK_FRAME_OVERHEAD
-#endif
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
@@ -180,10 +171,6 @@ system_call:			/* label this so stack traces look sane */
 
 syscall_exit:
 	std	r3,RESULT(r1)
-#ifdef SHOW_SYSCALLS
-	bl	do_show_syscall_exit
-	ld	r3,RESULT(r1)
-#endif
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index cd9be9aa016d..b2702e87db0d 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -121,17 +121,3 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
 			     (u64)len_high << 32 | len_low, advice);
 }
-
-void do_show_syscall(unsigned long r3, unsigned long r4, unsigned long r5,
-		     unsigned long r6, unsigned long r7, unsigned long r8,
-		     struct pt_regs *regs)
-{
-	printk("syscall %ld(%lx, %lx, %lx, %lx, %lx, %lx) regs=%p current=%p"
-	       " cpu=%d\n", regs->gpr[0], r3, r4, r5, r6, r7, r8, regs,
-	       current, smp_processor_id());
-}
-
-void do_show_syscall_exit(unsigned long r3)
-{
-	printk(" -> %lx, current=%p cpu=%d\n", r3, current, smp_processor_id());
-}
-- 
2.1.0

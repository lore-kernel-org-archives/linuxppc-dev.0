Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5F591A0064
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 21:17:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kernel: Make syscall_exit a local label
Date: Fri,  5 Dec 2014 21:16:59 +1100
Message-Id: <1417774619-30858-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently when we back trace something that is in a syscall we see
something like this:

[c000000000000000] [c000000000000000] SyS_read+0x6c/0x110
[c000000000000000] [c000000000000000] syscall_exit+0x0/0x98

Although it's entirely correct, seeing syscall_exit at the bottom can be
confusing - we were exiting from a syscall and then called SyS_read() ?

If we instead change syscall_exit to be a local label we get something
more intuitive:

[c0000001fa46fde0] [c00000000026719c] SyS_read+0x6c/0x110
[c0000001fa46fe30] [c000000000009264] system_call+0x38/0xd0

ie. we were handling a system call, and it was SyS_read().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0905c8da90f1..d8828e50dbef 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -178,7 +178,7 @@ system_call:			/* label this so stack traces look sane */
 	mtctr   r12
 	bctrl			/* Call handler */
 
-syscall_exit:
+.Lsyscall_exit:
 	std	r3,RESULT(r1)
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall_exit
@@ -270,7 +270,7 @@ syscall_dotrace:
 
 syscall_enosys:
 	li	r3,-ENOSYS
-	b	syscall_exit
+	b	.Lsyscall_exit
 	
 syscall_exit_work:
 #ifdef CONFIG_PPC_BOOK3S
@@ -347,33 +347,33 @@ _GLOBAL(save_nvgprs)
 _GLOBAL(ppc_fork)
 	bl	save_nvgprs
 	bl	sys_fork
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ppc_vfork)
 	bl	save_nvgprs
 	bl	sys_vfork
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ppc_clone)
 	bl	save_nvgprs
 	bl	sys_clone
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ppc32_swapcontext)
 	bl	save_nvgprs
 	bl	compat_sys_swapcontext
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ppc64_swapcontext)
 	bl	save_nvgprs
 	bl	sys_swapcontext
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ret_from_fork)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
 	li	r3,0
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 _GLOBAL(ret_from_kernel_thread)
 	bl	schedule_tail
@@ -385,7 +385,7 @@ _GLOBAL(ret_from_kernel_thread)
 #endif
 	blrl
 	li	r3,0
-	b	syscall_exit
+	b	.Lsyscall_exit
 
 /*
  * This routine switches between two different tasks.  The process
-- 
1.9.1

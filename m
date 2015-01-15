Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113CB1A05EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 12:01:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Rename _TIF_SYSCALL_T_OR_A to _TIF_SYSCALL_DOTRACE
Date: Thu, 15 Jan 2015 12:01:42 +1100
Message-Id: <1421283702-30677-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once upon a time, at least 9 years ago (< 2.6.12), _TIF_SYSCALL_T_OR_A
meant "TRACE or AUDIT". But these days it means TRACE or AUDIT or
SECCOMP or TRACEPOINT or NOHZ.

All of those are implemented via syscall_dotrace() so rename the flag to
that to try and clarify things.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/thread_info.h | 2 +-
 arch/powerpc/kernel/entry_32.S         | 6 +++---
 arch/powerpc/kernel/entry_64.S         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ebc4f165690a..c1efa05613f0 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -124,7 +124,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+#define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
 				 _TIF_NOHZ)
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 10a093579191..da6379550fd2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -337,7 +337,7 @@ _GLOBAL(DoSyscall)
 #endif /* CONFIG_TRACE_IRQFLAGS */
 	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r11,TI_FLAGS(r10)
-	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
+	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
 	cmplwi	0,r0,NR_syscalls
@@ -364,7 +364,7 @@ ret_from_syscall:
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
 	blt+	syscall_exit_cont
@@ -501,7 +501,7 @@ syscall_exit_work:
 	subi	r12,r12,TI_FLAGS
 	
 4:	/* Anything which requires enabling interrupts? */
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
 	beq	ret_from_except
 
 	/* Re-enable interrupts. There is no need to trace that with
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 194e46dcf08d..3291ed148bdf 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -151,7 +151,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif
 	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
-	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
+	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	syscall_dotrace
 .Lsyscall_dotrace_cont:
 	cmpldi	0,r0,NR_syscalls
@@ -214,7 +214,7 @@ syscall_exit:
 
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
+	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmpld	r3,r11
 	ld	r5,_CCR(r1)
@@ -307,7 +307,7 @@ syscall_exit_work:
 
 4:	/* Anything else left to do? */
 	SET_DEFAULT_THREAD_PPR(r3, r10)		/* Set thread.ppr = 3 */
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
+	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
 	beq	ret_from_except_lite
 
 	/* Re-enable interrupts */
-- 
2.1.0

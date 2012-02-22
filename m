Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEF66B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 15:44:39 +1100 (EST)
Message-ID: <1329885727.20389.3.camel@pasglop>
Subject: [PATCH]  powerpc: Fix various issues with return to userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 22 Feb 2012 15:42:07 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@au1.ibm.com>, Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a few problems when returning to userspace. This is a
quick set of fixes for 3.3, I'll look into a more comprehensive
rework for 3.4. This fixes:

 - We kept interrupts soft-disabled when schedule'ing or calling
do_signal when returning to userspace as a result of a hardware
interrupt.

 - Rename do_signal to do_notify_resume like all other archs (and
do_signal_pending back to do_signal, which it was before Roland
changed it).

 - Add the missing call to key_replace_session_keyring() to
do_notify_resume().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 4f80cf1..3e57a00 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1213,7 +1213,7 @@ do_user_signal:			/* r10 contains MSR_KERNEL here */
 	stw	r3,_TRAP(r1)
 2:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r9
-	bl	do_signal
+	bl	do_notify_resume
 	REST_NVGPRS(r1)
 	b	recheck
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d834425..6597464 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -751,12 +751,16 @@ user_work:
 
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
+	li	r5,1
+	TRACE_AND_RESTORE_IRQ(r5);	
 	bl	.schedule
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+	li	r5,1
+	TRACE_AND_RESTORE_IRQ(r5);	
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_signal
+	bl	.do_notify_resume
 	b	.ret_from_except
 
 unrecov_restore:
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 2300426..ac6e437 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -11,6 +11,7 @@
 
 #include <linux/tracehook.h>
 #include <linux/signal.h>
+#include <linux/key.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -113,8 +114,9 @@ static void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
 	}
 }
 
-static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
+static int do_signal(struct pt_regs *regs)
 {
+	sigset_t *oldset;
 	siginfo_t info;
 	int signr;
 	struct k_sigaction ka;
@@ -123,7 +125,7 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 
 	if (current_thread_info()->local_flags & _TLF_RESTORE_SIGMASK)
 		oldset = &current->saved_sigmask;
-	else if (!oldset)
+	else
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
@@ -191,14 +193,16 @@ static int do_signal_pending(sigset_t *oldset, struct pt_regs *regs)
 	return ret;
 }
 
-void do_signal(struct pt_regs *regs, unsigned long thread_info_flags)
+void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 {
 	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal_pending(NULL, regs);
+		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		if (current->replacement_session_keyring)
+			key_replace_session_keyring();
 	}
 }
 
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 6c0ddfc..da7d838 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -12,8 +12,6 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-extern void do_signal(struct pt_regs *regs, unsigned long thread_info_flags);
-
 extern void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
 				  size_t frame_size, int is_32);
 extern void restore_sigmask(sigset_t *set);

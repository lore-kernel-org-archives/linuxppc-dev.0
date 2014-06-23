Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 038E71A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 14:17:50 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove ancient DEBUG_SIG code
Date: Mon, 23 Jun 2014 14:17:47 +1000
Message-Id: <1403497067-28512-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have some compile-time disabled debug code in signal_xx.c. It's from
some ancient time BG, almost certainly part of the original port, given
the very similar code on other arches.

The show_unhandled_signal logic, added in d0c3d534a438 (2.6.24) is
cleaner and prints more useful information, so drop the debug code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/signal_32.c | 9 ---------
 arch/powerpc/kernel/signal_64.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 4e47db6..1bc5a17 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -54,7 +54,6 @@
 
 #include "signal.h"
 
-#undef DEBUG_SIG
 
 #ifdef CONFIG_PPC64
 #define sys_rt_sigreturn	compat_sys_rt_sigreturn
@@ -1063,10 +1062,6 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	return 1;
 
 badframe:
-#ifdef DEBUG_SIG
-	printk("badframe in handle_rt_signal, regs=%p frame=%p newsp=%lx\n",
-	       regs, frame, newsp);
-#endif
 	if (show_unhandled_signals)
 		printk_ratelimited(KERN_INFO
 				   "%s[%d]: bad frame in handle_rt_signal32: "
@@ -1484,10 +1479,6 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	return 1;
 
 badframe:
-#ifdef DEBUG_SIG
-	printk("badframe in handle_signal, regs=%p frame=%p newsp=%lx\n",
-	       regs, frame, newsp);
-#endif
 	if (show_unhandled_signals)
 		printk_ratelimited(KERN_INFO
 				   "%s[%d]: bad frame in handle_signal32: "
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d501dc4..97c1e4b 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -38,7 +38,6 @@
 
 #include "signal.h"
 
-#define DEBUG_SIG 0
 
 #define GP_REGS_SIZE	min(sizeof(elf_gregset_t), sizeof(struct pt_regs))
 #define FP_REGS_SIZE	sizeof(elf_fpregset_t)
@@ -700,10 +699,6 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 	return 0;
 
 badframe:
-#if DEBUG_SIG
-	printk("badframe in sys_rt_sigreturn, regs=%p uc=%p &uc->uc_mcontext=%p\n",
-	       regs, uc, &uc->uc_mcontext);
-#endif
 	if (show_unhandled_signals)
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				   current->comm, current->pid, "rt_sigreturn",
@@ -809,10 +804,6 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 	return 1;
 
 badframe:
-#if DEBUG_SIG
-	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
-	       regs, frame, newsp);
-#endif
 	if (show_unhandled_signals)
 		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
 				   current->comm, current->pid, "setup_rt_frame",
-- 
1.9.1

Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:50 +1000
Subject: [PATCH 15/21] powerpc: consolidate sys_sigaltstack
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051555.8D50ADDF68@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

sys_sigaltstack is the same on 32bit and 64 and we can consolidate it
to signal.c.  The only difference is that the 32bit code uses ints
for the unused register paramaters and 64bit unsigned long.  I've
changed it to unsigned long because it's the same width on 32bit.

(I also wonder who came up with this awkward calling convention.. :))

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal.c    |    7 +++++++
 arch/powerpc/kernel/signal_32.c |    8 --------
 arch/powerpc/kernel/signal_64.c |    8 --------
 include/asm-powerpc/syscalls.h  |    7 -------
 4 files changed, 7 insertions(+), 23 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_32.c	2007-06-04 11:45:43.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_32.c	2007-06-04 11:45:55.000000000 +1000
@@ -253,14 +253,6 @@ long sys_sigsuspend(old_sigset_t mask)
  	return -ERESTARTNOHAND;
 }
 
-#ifdef CONFIG_PPC32
-long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss, int r5,
-		int r6, int r7, int r8, struct pt_regs *regs)
-{
-	return do_sigaltstack(uss, uoss, regs->gpr[1]);
-}
-#endif
-
 long sys_sigaction(int sig, struct old_sigaction __user *act,
 		struct old_sigaction __user *oact)
 {
Index: linux-cell/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal_64.c	2007-06-04 11:45:43.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal_64.c	2007-06-04 11:45:55.000000000 +1000
@@ -66,14 +66,6 @@ struct rt_sigframe {
 	char abigap[288];
 } __attribute__ ((aligned (16)));
 
-long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss, unsigned long r5,
-		     unsigned long r6, unsigned long r7, unsigned long r8,
-		     struct pt_regs *regs)
-{
-	return do_sigaltstack(uss, uoss, regs->gpr[1]);
-}
-
-
 /*
  * Set up the sigcontext for the signal frame.
  */
Index: linux-cell/include/asm-powerpc/syscalls.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/syscalls.h	2007-06-04 11:45:43.000000000 +1000
+++ linux-cell/include/asm-powerpc/syscalls.h	2007-06-04 11:45:55.000000000 +1000
@@ -43,16 +43,9 @@ asmlinkage long ppc_newuname(struct new_
 
 asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset,
 		size_t sigsetsize);
-
-#ifndef __powerpc64__
-asmlinkage long sys_sigaltstack(const stack_t __user *uss,
-		stack_t __user *uoss, int r5, int r6, int r7, int r8,
-		struct pt_regs *regs);
-#else /* __powerpc64__ */
 asmlinkage long sys_sigaltstack(const stack_t __user *uss,
 		stack_t __user *uoss, unsigned long r5, unsigned long r6,
 		unsigned long r7, unsigned long r8, struct pt_regs *regs);
-#endif /* __powerpc64__ */
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_SYSCALLS_H */
Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 11:45:50.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 11:45:55.000000000 +1000
@@ -62,3 +62,10 @@ void check_syscall_restart(struct pt_reg
 		regs->ccr |= 0x10000000;
 	}
 }
+
+long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
+		unsigned long r5, unsigned long r6, unsigned long r7,
+		unsigned long r8, struct pt_regs *regs)
+{
+	return do_sigaltstack(uss, uoss, regs->gpr[1]);
+}

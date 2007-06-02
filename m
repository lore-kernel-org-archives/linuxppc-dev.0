Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7848DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 20:25:10 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l52AP6o6022026
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Jun 2007 12:25:06 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l52AP6dh022024
	for linuxppc-dev@ozlabs.org; Sat, 2 Jun 2007 12:25:06 +0200
Date: Sat, 2 Jun 2007 12:25:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] consolidate sys_sigaltstack
Message-ID: <20070602102506.GA22008@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[note: this patchset is ontop of ben's ptrace patches, with the last one
 replaced by the version I posted]

sys_sigaltstack is the same on 32bit and 64 and we can consolidate it
to signal.c.  The only difference is that the 32bit code uses ints
for the unused register paramaters and 64bit unsigned long.  I've
changed it to unsigned long because it's the same width on 32bit.

(I also wonder who came up with this awkward calling convention.. :))


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_32.c	2007-06-02 11:14:48.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_32.c	2007-06-02 11:14:58.000000000 +0200
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
Index: linux-2.6/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal_64.c	2007-06-02 11:14:48.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal_64.c	2007-06-02 11:14:58.000000000 +0200
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
Index: linux-2.6/include/asm-powerpc/syscalls.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/syscalls.h	2007-06-02 11:06:36.000000000 +0200
+++ linux-2.6/include/asm-powerpc/syscalls.h	2007-06-02 11:14:58.000000000 +0200
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
Index: linux-2.6/arch/powerpc/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/signal.c	2007-06-02 11:14:48.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/signal.c	2007-06-02 11:15:09.000000000 +0200
@@ -60,3 +60,10 @@ void check_syscall_restart(struct pt_reg
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

Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203522.156783000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:08 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 08/13] powerpc: declare arch syscalls in <asm/syscalls.h>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc currently declares some of its own system calls
in <asm/unistd.h>, but not all of them. That place also
contains remainders of the now almost unused kernel syscall
hack.

 - Add a new <asm/syscalls.h> with clean declarations
 - Include that file from every source that implements one
   of these
 - Get rid of old declarations in <asm/unistd.h>

This patch is required as a base for implementing system
calls from an SPU, but also makes sense as a general
cleanup.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/include/asm-powerpc/syscalls.h
===================================================================
--- /dev/null
+++ linus-2.6/include/asm-powerpc/syscalls.h
@@ -0,0 +1,58 @@
+#ifndef __ASM_POWERPC_SYSCALLS_H
+#define __ASM_POWERPC_SYSCALLS_H
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <asm/signal.h>
+
+struct new_utsname;
+struct pt_regs;
+struct rtas_args;
+struct sigaction;
+
+asmlinkage unsigned long sys_mmap(unsigned long addr, size_t len,
+		unsigned long prot, unsigned long flags,
+		unsigned long fd, off_t offset);
+asmlinkage unsigned long sys_mmap2(unsigned long addr, size_t len,
+		unsigned long prot, unsigned long flags,
+		unsigned long fd, unsigned long pgoff);
+asmlinkage int sys_execve(unsigned long a0, unsigned long a1,
+		unsigned long a2, unsigned long a3, unsigned long a4,
+		unsigned long a5, struct pt_regs *regs);
+asmlinkage int sys_clone(unsigned long clone_flags, unsigned long usp,
+		int __user *parent_tidp, void __user *child_threadptr,
+		int __user *child_tidp, int p6, struct pt_regs *regs);
+asmlinkage int sys_fork(unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4, unsigned long p5,
+		unsigned long p6, struct pt_regs *regs);
+asmlinkage int sys_vfork(unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4, unsigned long p5,
+		unsigned long p6, struct pt_regs *regs);
+asmlinkage int sys_pipe(int __user *fildes);
+asmlinkage long sys_rt_sigaction(int sig,
+		const struct sigaction __user *act,
+		struct sigaction __user *oact, size_t sigsetsize);
+asmlinkage int sys_ipc(uint call, int first, unsigned long second,
+		long third, void __user *ptr, long fifth);
+asmlinkage long ppc64_personality(unsigned long personality);
+asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
+asmlinkage time_t sys64_time(time_t __user * tloc);
+asmlinkage long ppc_newuname(struct new_utsname __user * name);
+
+asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset,
+		size_t sigsetsize);
+
+#ifndef __powerpc64__
+asmlinkage long sys_sigaltstack(const stack_t __user *uss,
+		stack_t __user *uoss, int r5, int r6, int r7, int r8,
+		struct pt_regs *regs);
+#else /* __powerpc64__ */
+asmlinkage long sys_sigaltstack(const stack_t __user *uss,
+		stack_t __user *uoss, unsigned long r5, unsigned long r6,
+		unsigned long r7, unsigned long r8, struct pt_regs *regs);
+#endif /* __powerpc64__ */
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_POWERPC_SYSCALLS_H */
Index: linus-2.6/include/asm-powerpc/unistd.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/unistd.h
+++ linus-2.6/include/asm-powerpc/unistd.h
@@ -425,6 +425,7 @@ type name(type1 arg1, type2 arg2, type3 
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
+#include <asm/syscalls.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -460,44 +461,10 @@ type name(type1 arg1, type2 arg2, type3 
  * System call prototypes.
  */
 #ifdef __KERNEL_SYSCALLS__
-extern pid_t setsid(void);
-extern int write(int fd, const char *buf, off_t count);
-extern int read(int fd, char *buf, off_t count);
-extern off_t lseek(int fd, off_t offset, int count);
-extern int dup(int fd);
 extern int execve(const char *file, char **argv, char **envp);
-extern int open(const char *file, int flag, int mode);
-extern int close(int fd);
-extern pid_t waitpid(pid_t pid, int *wait_stat, int options);
 #endif /* __KERNEL_SYSCALLS__ */
 
 /*
- * Functions that implement syscalls.
- */
-unsigned long sys_mmap(unsigned long addr, size_t len, unsigned long prot,
-		       unsigned long flags, unsigned long fd, off_t offset);
-unsigned long sys_mmap2(unsigned long addr, size_t len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long pgoff);
-struct pt_regs;
-int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
-		unsigned long a3, unsigned long a4, unsigned long a5,
-		struct pt_regs *regs);
-int sys_clone(unsigned long clone_flags, unsigned long usp,
-		int __user *parent_tidp, void __user *child_threadptr,
-		int __user *child_tidp, int p6, struct pt_regs *regs);
-int sys_fork(unsigned long p1, unsigned long p2, unsigned long p3,
-		unsigned long p4, unsigned long p5, unsigned long p6,
-		struct pt_regs *regs);
-int sys_vfork(unsigned long p1, unsigned long p2, unsigned long p3,
-		unsigned long p4, unsigned long p5, unsigned long p6,
-		struct pt_regs *regs);
-int sys_pipe(int __user *fildes);
-struct sigaction;
-long sys_rt_sigaction(int sig, const struct sigaction __user *act,
-		      struct sigaction __user *oact, size_t sigsetsize);
-
-/*
  * "Conditional" syscalls
  *
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
Index: linus-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/process.c
+++ linus-2.6/arch/powerpc/kernel/process.c
@@ -46,6 +46,7 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
+#include <asm/syscalls.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #endif
Index: linus-2.6/arch/powerpc/kernel/rtas.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/rtas.c
+++ linus-2.6/arch/powerpc/kernel/rtas.c
@@ -32,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
+#include <asm/syscalls.h>
 
 struct rtas_t rtas = {
 	.lock = SPIN_LOCK_UNLOCKED
Index: linus-2.6/arch/powerpc/kernel/signal_32.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/signal_32.c
+++ linus-2.6/arch/powerpc/kernel/signal_32.c
@@ -42,6 +42,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/syscalls.h>
 #include <asm/sigcontext.h>
 #include <asm/vdso.h>
 #ifdef CONFIG_PPC64
Index: linus-2.6/arch/powerpc/kernel/signal_64.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/signal_64.c
+++ linus-2.6/arch/powerpc/kernel/signal_64.c
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/syscalls.h>
 #include <asm/vdso.h>
 
 #define DEBUG_SIG 0
Index: linus-2.6/arch/powerpc/kernel/syscalls.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/syscalls.c
+++ linus-2.6/arch/powerpc/kernel/syscalls.c
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
+#include <asm/syscalls.h>
 #include <asm/time.h>
 #include <asm/unistd.h>
 

--

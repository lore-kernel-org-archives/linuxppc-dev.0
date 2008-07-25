Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 0EFA3DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:21:53 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <b1c19245c1c76acaa6f0c10d917df6ffe3814250.1216966838.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] Wireup new syscalls
Date: Fri, 25 Jul 2008 16:21:51 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

signalfd4, eventfd2, epoll_create1, dup3, pipe2 and inotify_init1

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---

Tested on POWER6.

 include/asm-powerpc/syscalls.h |    1 +
 include/asm-powerpc/systbl.h   |    6 ++++++
 include/asm-powerpc/unistd.h   |    8 +++++++-
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/syscalls.h b/include/asm-powerpc/syscalls.h
index 2b8a458..eb8eb40 100644
--- a/include/asm-powerpc/syscalls.h
+++ b/include/asm-powerpc/syscalls.h
@@ -31,6 +31,7 @@ asmlinkage int sys_vfork(unsigned long p1, unsigned long p2,
 		unsigned long p3, unsigned long p4, unsigned long p5,
 		unsigned long p6, struct pt_regs *regs);
 asmlinkage long sys_pipe(int __user *fildes);
+asmlinkage long sys_pipe2(int __user *fildes, int flags);
 asmlinkage long sys_rt_sigaction(int sig,
 		const struct sigaction __user *act,
 		struct sigaction __user *oact, size_t sigsetsize);
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index ae7085c..e084272 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -316,3 +316,9 @@ COMPAT_SYS(fallocate)
 SYSCALL(subpage_prot)
 COMPAT_SYS_SPU(timerfd_settime)
 COMPAT_SYS_SPU(timerfd_gettime)
+COMPAT_SYS_SPU(signalfd4)
+SYSCALL_SPU(eventfd2)
+SYSCALL_SPU(epoll_create1)
+SYSCALL_SPU(dup3)
+SYSCALL_SPU(pipe2)
+SYSCALL(inotify_init1)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index ce91bb6..e07d0c7 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -335,10 +335,16 @@
 #define __NR_subpage_prot	310
 #define __NR_timerfd_settime	311
 #define __NR_timerfd_gettime	312
+#define __NR_signalfd4		313
+#define __NR_eventfd2		314
+#define __NR_epoll_create1	315
+#define __NR_dup3		316
+#define __NR_pipe2		317
+#define __NR_inotify_init1	318
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		313
+#define __NR_syscalls		319
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls


Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!

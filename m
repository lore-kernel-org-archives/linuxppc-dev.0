Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Sep 2008 15:48:45 +1000
Subject: [PATCH] powerpc: Reserve syscall number 319
Message-Id: <20080902054941.77DA3DDDF0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some stuff I'm working on that isn't released yet needs
a syscall number but I can't say what it's for until I
get permission to release it :-)

In the meantime, it would be nice if a number could be set
aside so the tools being developped to use that stuff don't
all need to be updated when things are eventually released.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I wonder if I'll get hanged for that one :-)

 arch/powerpc/include/asm/systbl.h |    1 +
 arch/powerpc/include/asm/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/systbl.h	2008-09-02 15:14:53.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/systbl.h	2008-09-02 15:14:54.000000000 +1000
@@ -322,3 +322,4 @@ SYSCALL_SPU(epoll_create1)
 SYSCALL_SPU(dup3)
 SYSCALL_SPU(pipe2)
 SYSCALL(inotify_init1)
+SYSCALL(ni_syscall)
Index: linux-work/arch/powerpc/include/asm/unistd.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/unistd.h	2008-09-02 15:11:55.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/unistd.h	2008-09-02 15:14:42.000000000 +1000
@@ -341,10 +341,11 @@
 #define __NR_dup3		316
 #define __NR_pipe2		317
 #define __NR_inotify_init1	318
+/* 319 is reserved */
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		319
+#define __NR_syscalls		320
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls

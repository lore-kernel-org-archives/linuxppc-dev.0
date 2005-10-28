Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Sat, 29 Oct 2005 01:16:43 +0200
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<200510290111.13867.arnd@arndb.de>
In-Reply-To: <200510290111.13867.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510290116.43753.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] reserve syscall numbers for Cell
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This creates two powerpc specific dummy system calls that will
later be used on the Cell platform to manage SPUs.

Reserve the system call numbers now so we don't accidentally
use the same numbers for different system calls.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

---
Please apply to merge tree

--- a/kernel/sys_ni.c	2005-10-29 00:46:21.000000000 +0200
+++ b/kernel/sys_ni.c	2005-10-29 00:47:37.000000000 +0200
@@ -90,3 +90,5 @@
 cond_syscall(sys32_ipc);
 cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
+cond_syscall(sys_spu_run);
+cond_syscall(sys_spu_create);
--- a/arch/powerpc/kernel/systbl.S	2005-10-29 00:39:49.000000000 +0200
+++ b/arch/powerpc/kernel/systbl.S	2005-10-29 00:44:48.000000000 +0200
@@ -319,3 +319,5 @@
 SYSCALL(inotify_init)
 SYSCALL(inotify_add_watch)
 SYSCALL(inotify_rm_watch)
+SYSCALL(spu_run)
+SYSCALL(spu_create)
--- a/include/asm-powerpc/unistd.h	2005-10-29 00:34:40.000000000 +0200
+++ b/include/asm-powerpc/unistd.h	2005-10-29 00:35:52.000000000 +0200
@@ -297,7 +297,9 @@
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277

-#define __NR_syscalls		278
+#define __NR_spu_run		278
+#define __NR_spu_create		279
+#define __NR_syscalls		280
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit

Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 2C76267FE4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:00:36 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAAK0ZbC014039
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:35 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAAK0Zl5014024
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:35 +0900 (JST)
Message-ID: <4554DA5E.3010103@am.sony.com>
Date: Fri, 10 Nov 2006 12:00:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/16] spufs: change ppc_rtas declaration to weak
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the definition of powerpc's cond_syscall() to use the standard gcc
weak attribute specifier which provides proper support for C linkage as
needed by spu_syscall_table[].

Fixes this powerpc build error with CONFIG_SPU_FS=y, CONFIG_PPC_RTAS=n:

 arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

 include/asm-powerpc/unistd.h |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: cell--common--6/include/asm-powerpc/unistd.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/unistd.h
+++ cell--common--6/include/asm-powerpc/unistd.h
@@ -445,7 +445,6 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <asm/syscalls.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -480,16 +479,9 @@
 
 /*
  * "Conditional" syscalls
- *
- * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
- * but it doesn't work on all toolchains, so we just do it by hand
  */
-#ifdef CONFIG_PPC32
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
-#else
-#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscall")
-#endif
-
+#define cond_syscall(x) \
+	asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")))
 
 #endif		/* __ASSEMBLY__ */
 #endif		/* __KERNEL__ */

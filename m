Return-Path: <arnd@arndb.de>
Message-Id: <20061120180520.902060000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:44:56 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 02/22] powerpc: change ppc_rtas declaration to weak
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>
Change the definition of powerpc's cond_syscall() to use the standard gcc
weak attribute specifier which provides proper support for C linkage as
needed by spu_syscall_table[].

Fixes this powerpc build error with CONFIG_SPU_FS=y, CONFIG_PPC_RTAS=n:

 arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 include/asm-powerpc/unistd.h |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: linux-2.6/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/unistd.h
+++ linux-2.6/include/asm-powerpc/unistd.h
@@ -446,7 +446,6 @@ type name(type1 arg1, type2 arg2, type3 
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <asm/syscalls.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -481,16 +480,9 @@ type name(type1 arg1, type2 arg2, type3 
 
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

--

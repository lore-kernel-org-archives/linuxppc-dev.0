Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJWS1XHhzDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:06:43 +1000 (AEST)
Message-Id: <dec3cf2521a8e5dfc78953363b1f55aaa261a052.1527609833.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/cell: fix build failure by disabling
 attribute-alias warning
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 16:06:39 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Latest GCC version emit the following warnings

As arch/powerpc code is built with -Werror, this breaks build with
GCC 8.1

This patch inhibits those warnings

  CC      arch/powerpc/platforms/cell/spu_syscalls.o
In file included from arch/powerpc/platforms/cell/spu_syscalls.c:26:
./include/linux/syscalls.h:233:18: error: 'sys_spu_create' alias between functions of incompatible types 'long int(const char *, unsigned int,  umode_t,  int)' {aka 'long int(const char *, unsigned int,  short unsigned int,  int)'} and 'long int(long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/platforms/cell/spu_syscalls.c:70:1: note: in expansion of macro 'SYSCALL_DEFINE4'
 SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:214:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/platforms/cell/spu_syscalls.c:70:1: note: in expansion of macro 'SYSCALL_DEFINE4'
 SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:233:18: error: 'sys_spu_run' alias between functions of incompatible types 'long int(int,  __u32 *, __u32 *)' {aka 'long int(int,  unsigned int *, unsigned int *)'} and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/platforms/cell/spu_syscalls.c:94:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/platforms/cell/spu_syscalls.c:94:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 ^~~~~~~~~~~~~~~

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: added '#pragma GCC diagnostic ignored "-Wpragmas"' to avoid build failure on old GCC

 arch/powerpc/platforms/cell/spu_syscalls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 263413a34823..7862279a82e4 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -67,6 +67,9 @@ static inline void spufs_calls_put(struct spufs_calls *calls) { }
 
 #endif /* CONFIG_SPU_FS_MODULE */
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpragmas"
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 	umode_t, mode, int, neighbor_fd)
 {
@@ -111,6 +114,7 @@ SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 	spufs_calls_put(calls);
 	return ret;
 }
+#pragma GCC diagnostic pop
 
 #ifdef CONFIG_COREDUMP
 int elf_coredump_extra_notes_size(void)
-- 
2.13.3

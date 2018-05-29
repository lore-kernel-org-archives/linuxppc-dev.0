Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w4M34W5yzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 16:58:39 +1000 (AEST)
Message-Id: <871bd59bfbec78acb31082df2c3f1be43658bcb5.1527576941.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: fix build failure by disabling attribute-alias
 warning
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 06:58:35 +0000 (UTC)
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

  CC      arch/powerpc/kernel/syscalls.o
In file included from arch/powerpc/kernel/syscalls.c:24:
./include/linux/syscalls.h:233:18: error: 'sys_mmap2' alias between functions of incompatible types 'long int(long unsigned int,  size_t,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:233:18: error: 'sys_mmap' alias between functions of incompatible types 'long int(long unsigned int,  size_t,  long unsigned int,  long unsigned int,  long unsigned int,  off_t)' {aka 'long int(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
 ^~~~~~~~~~~~~~~
  CC      arch/powerpc/kernel/signal_32.o
In file included from arch/powerpc/kernel/signal_32.c:31:
./include/linux/compat.h:74:18: error: 'compat_sys_swapcontext' alias between functions of incompatible types 'long int(struct ucontext32 *, struct ucontext32 *, int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~~~~~~~~
./include/linux/compat.h:58:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
  COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1041:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
 COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/compat.h:79:18: note: aliased declaration here
  asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~~~~~~~~
./include/linux/compat.h:58:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
  COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1041:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
 COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 ^~~~~~~~~~~~~~~~~~~~~~
  CC      arch/powerpc/kernel/signal_64.o
In file included from arch/powerpc/kernel/signal_64.c:27:
./include/linux/syscalls.h:233:18: error: 'sys_swapcontext' alias between functions of incompatible types 'long int(struct ucontext *, struct ucontext *, long int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_64.c:628:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
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
arch/powerpc/kernel/signal_64.c:628:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 ^~~~~~~~~~~~~~~
  CC      arch/powerpc/kernel/rtas.o
In file included from arch/powerpc/kernel/rtas.c:29:
./include/linux/syscalls.h:233:18: error: 'sys_rtas' alias between functions of incompatible types 'long int(struct rtas_args *)' and 'long int(long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:211:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/rtas.c:1054:1: note: in expansion of macro 'SYSCALL_DEFINE1'
 SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:211:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/rtas.c:1054:1: note: in expansion of macro 'SYSCALL_DEFINE1'
 SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 ^~~~~~~~~~~~~~~
  CC      arch/powerpc/kernel/pci_64.o
In file included from arch/powerpc/kernel/pci_64.c:23:
./include/linux/syscalls.h:233:18: error: 'sys_pciconfig_iobase' alias between functions of incompatible types 'long int(long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
arch/powerpc/kernel/pci_64.c:206:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
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
arch/powerpc/kernel/pci_64.c:206:1: note: in expansion of macro 'SYSCALL_DEFINE3'
 SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
 ^~~~~~~~~~~~~~~

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/pci_64.c    | 3 +++
 arch/powerpc/kernel/rtas.c      | 3 +++
 arch/powerpc/kernel/signal_32.c | 6 ++++++
 arch/powerpc/kernel/signal_64.c | 3 +++
 arch/powerpc/kernel/syscalls.c  | 3 +++
 arch/powerpc/mm/subpage-prot.c  | 3 +++
 6 files changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index dff28f903512..a8bf98c1cf0c 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -203,6 +203,8 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
 #define IOBASE_ISA_IO		3
 #define IOBASE_ISA_MEM		4
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
 			  unsigned long, in_devfn)
 {
@@ -256,6 +258,7 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
 
 	return -EOPNOTSUPP;
 }
+#pragma GCC diagnostic pop
 
 #ifdef CONFIG_NUMA
 int pcibus_to_node(struct pci_bus *bus)
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8afd146bc9c7..c1713cef1642 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1051,6 +1051,8 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 }
 
 /* We assume to be passed big endian arguments */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 {
 	struct rtas_args args;
@@ -1137,6 +1139,7 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 
 	return 0;
 }
+#pragma GCC diagnostic pop
 
 /*
  * Call early during boot, before mem init, to retrieve the RTAS
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 9cf8a03d3bc7..db1042f37b94 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1037,6 +1037,8 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
 }
 #endif
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 #ifdef CONFIG_PPC64
 COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		       struct ucontext __user *, new_ctx, int, ctx_size)
@@ -1132,6 +1134,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
+#pragma GCC diagnostic pop
 
 #ifdef CONFIG_PPC64
 COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
@@ -1228,6 +1231,8 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 #ifdef CONFIG_PPC32
 SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 			 int, ndbg, struct sig_dbg_op __user *, dbg)
@@ -1333,6 +1338,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 	return 0;
 }
 #endif
+#pragma GCC diagnostic pop
 
 /*
  * OK, we're invoking a handler
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 83d51bf586c7..d2e8da8cf27f 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -625,6 +625,8 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
 /*
  * Handle {get,set,swap}_context operations
  */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		struct ucontext __user *, new_ctx, long, ctx_size)
 {
@@ -690,6 +692,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 }
+#pragma GCC diagnostic pop
 
 
 /*
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 466216506eb2..d08119590185 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -62,6 +62,8 @@ static inline long do_mmap2(unsigned long addr, size_t len,
 	return ret;
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, unsigned long, pgoff)
@@ -75,6 +77,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
 {
 	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
 }
+#pragma GCC diagnostic pop
 
 #ifdef CONFIG_PPC32
 /*
diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
index 9d16ee251fc0..edf09fd4ba80 100644
--- a/arch/powerpc/mm/subpage-prot.c
+++ b/arch/powerpc/mm/subpage-prot.c
@@ -186,6 +186,8 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
  * in a 2-bit field won't allow writes to a page that is otherwise
  * write-protected.
  */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 		unsigned long, len, u32 __user *, map)
 {
@@ -269,3 +271,4 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
 	up_write(&mm->mmap_sem);
 	return err;
 }
+#pragma GCC diagnostic pop
-- 
2.13.3

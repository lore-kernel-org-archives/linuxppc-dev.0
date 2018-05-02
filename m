Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bf6r0kl5zF2T5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:21:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc/syscalls: switch rtas(2) to SYSCALL_DEFINE
Date: Wed,  2 May 2018 23:20:48 +1000
Message-Id: <20180502132051.28861-3-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[mpe: Update sys_ni.c for s/ppc_rtas/sys_rtas/]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/syscalls.h         | 2 +-
 arch/powerpc/include/asm/systbl.h           | 2 +-
 arch/powerpc/kernel/rtas.c                  | 3 ++-
 arch/powerpc/kernel/systbl.S                | 1 -
 arch/powerpc/kernel/systbl_chk.c            | 1 -
 arch/powerpc/platforms/cell/spu_callbacks.c | 1 -
 kernel/sys_ni.c                             | 2 +-
 7 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/asm/syscalls.h
index 1b90a3516a35..398171fdcd9f 100644
--- a/arch/powerpc/include/asm/syscalls.h
+++ b/arch/powerpc/include/asm/syscalls.h
@@ -16,7 +16,7 @@ asmlinkage long sys_mmap2(unsigned long addr, size_t len,
 		unsigned long prot, unsigned long flags,
 		unsigned long fd, unsigned long pgoff);
 asmlinkage long ppc64_personality(unsigned long personality);
-asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
+asmlinkage long sys_rtas(struct rtas_args __user *uargs);
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_SYSCALLS_H */
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index d61f9c96d916..b91701c0711a 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -260,7 +260,7 @@ COMPAT_SYS_SPU(utimes)
 COMPAT_SYS_SPU(statfs64)
 COMPAT_SYS_SPU(fstatfs64)
 SYSX(sys_ni_syscall,ppc_fadvise64_64,ppc_fadvise64_64)
-PPC_SYS_SPU(rtas)
+SYSCALL_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
 COMPAT_SYS(migrate_pages)
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 3f1c4fcbe0aa..8afd146bc9c7 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
+#include <linux/syscalls.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1050,7 +1051,7 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
 }
 
 /* We assume to be passed big endian arguments */
-asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
+SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 {
 	struct rtas_args args;
 	unsigned long flags;
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 7ccb7f81f8db..c7d5216d91d7 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -35,7 +35,6 @@
 #endif
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
-#define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
 .section .rodata,"a"
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 55323a620cfe..28476e811644 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -31,7 +31,6 @@
 
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
-#define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
 /* Just insert a marker for ni_syscalls */
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index a494028b2cdf..d5bb8c8d769a 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -44,7 +44,6 @@ static void *spu_syscall_table[] = {
 
 #define SYSCALL_SPU(func)	sys_##func,
 #define COMPAT_SYS_SPU(func)	sys_##func,
-#define PPC_SYS_SPU(func)	ppc_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
 #include <asm/systbl.h>
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 9791364925dc..3751a511e2b8 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -365,7 +365,7 @@ COND_SYSCALL(s390_pci_mmio_write);
 COND_SYSCALL_COMPAT(s390_ipc);
 
 /* powerpc */
-cond_syscall(ppc_rtas);
+COND_SYSCALL(rtas);
 COND_SYSCALL(spu_run);
 COND_SYSCALL(spu_create);
 COND_SYSCALL(subpage_prot);
-- 
2.14.1

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bf6s0fJ9zF2T9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:21:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] powerpc/syscalls: Add COMPAT_SPU_NEW() macro
Date: Wed,  2 May 2018 23:20:49 +1000
Message-Id: <20180502132051.28861-4-mpe@ellerman.id.au>
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

Currently the select system call is wired up with the SYSX_SPU()
macro. The SYSX_SPU() is not handled by systbl_chk.c, which means the
syscall number for select is not checked.

That hides the fact that the syscall number for select is actually
__NR__newselect not __NR_select.

In a following patch we'd like to drop ppc32_select() which means
select will become a regular COMPAT_SYS_SPU() syscall. But
COMPAT_SYS_SPU() can't deal with the fact that the syscall number is
actually __NR__newselect. We also can't just redefine __NR_select
because that's still used for the old select call.

So add a new COMPAT_NEW_SPU() that does the same thing as
COMPAT_SYS_SPU() except it encodes that we're using the new number.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/systbl.S                | 1 +
 arch/powerpc/kernel/systbl_chk.c            | 1 +
 arch/powerpc/platforms/cell/spu_callbacks.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index c7d5216d91d7..919a32746ede 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -35,6 +35,7 @@
 #endif
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define COMPAT_SPU_NEW(func)	COMPAT_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
 .section .rodata,"a"
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 28476e811644..4653258722ac 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -31,6 +31,7 @@
 
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define COMPAT_SPU_NEW(func)	COMPAT_SYS(_new##func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
 /* Just insert a marker for ni_syscalls */
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index d5bb8c8d769a..8ae86200ef6c 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -44,6 +44,7 @@ static void *spu_syscall_table[] = {
 
 #define SYSCALL_SPU(func)	sys_##func,
 #define COMPAT_SYS_SPU(func)	sys_##func,
+#define COMPAT_SPU_NEW(func)	sys_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
 #include <asm/systbl.h>
-- 
2.14.1

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VlmD3QjDzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 00:18:04 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/signal32: Use fault_in_pages_readable() to prefault
 user context
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Message-Id: <20180424141759.F02AF6C59D@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 24 Apr 2018 16:17:59 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use fault_in_pages_readable() to prefault user context
instead of open coding

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/signal_32.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 492f03451877..cfacb2726152 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/elf.h>
 #include <linux/ptrace.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #ifdef CONFIG_PPC64
 #include <linux/syscalls.h>
@@ -1045,7 +1046,6 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx,
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
-	unsigned char tmp __maybe_unused;
 	int ctx_has_vsx_region = 0;
 
 #ifdef CONFIG_PPC64
@@ -1109,9 +1109,8 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (!access_ok(VERIFY_READ, new_ctx, ctx_size)
-	    || __get_user(tmp, (u8 __user *) new_ctx)
-	    || __get_user(tmp, (u8 __user *) new_ctx + ctx_size - 1))
+	if (!access_ok(VERIFY_READ, new_ctx, ctx_size) ||
+	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
 		return -EFAULT;
 
 	/*
@@ -1231,7 +1230,6 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 {
 	struct sig_dbg_op op;
 	int i;
-	unsigned char tmp __maybe_unused;
 	unsigned long new_msr = regs->msr;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long new_dbcr0 = current->thread.debug.dbcr0;
@@ -1287,9 +1285,8 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 	current->thread.debug.dbcr0 = new_dbcr0;
 #endif
 
-	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx))
-	    || __get_user(tmp, (u8 __user *) ctx)
-	    || __get_user(tmp, (u8 __user *) (ctx + 1) - 1))
+	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx)) ||
+	    fault_in_pages_readable((u8 __user *)ctx, 1))
 		return -EFAULT;
 
 	/*
-- 
2.13.3

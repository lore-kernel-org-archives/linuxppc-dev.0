Return-Path: <gfpadovan@gmail.com>
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com
 [209.85.161.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR06d67xBzDrLN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 07:18:33 +1100 (AEDT)
Received: by mail-yw0-f182.google.com with SMTP id m126so90579635ywd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 13:18:33 -0700 (PDT)
From: Gustavo Padovan <gustavo@padovan.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: rename to_user_ptr to __to_user_ptr
Date: Thu, 17 Mar 2016 17:18:23 -0300
Message-Id: <1458245903-3937-1-git-send-email-gustavo@padovan.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

to_user_ptr() is a local macro defined by signal_32.c, rename it to
__to_user_ptr() as now we will have a global to_user_ptr() defined by
kernel.h that has a different meaning from this one.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 arch/powerpc/kernel/signal_32.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378..558acd6 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -129,8 +129,8 @@ static inline int get_sigset_t(sigset_t *set,
 	return 0;
 }
 
-#define to_user_ptr(p)		ptr_to_compat(p)
-#define from_user_ptr(p)	compat_ptr(p)
+#define __to_user_ptr(p)	ptr_to_compat(p)
+#define __from_user_ptr(p)	compat_ptr(p)
 
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
@@ -178,8 +178,8 @@ static inline int get_sigset_t(sigset_t *set, const sigset_t __user *uset)
 	return copy_from_user(set, uset, sizeof(*uset));
 }
 
-#define to_user_ptr(p)		((unsigned long)(p))
-#define from_user_ptr(p)	((void __user *)(p))
+#define __to_user_ptr(p)	((unsigned long)(p))
+#define __from_user_ptr(p)	((void __user *)(p))
 
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
@@ -992,7 +992,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	if (copy_siginfo_to_user(&rt_sf->info, &ksig->info)
 	    || __put_user(0, &rt_sf->uc.uc_flags)
 	    || __save_altstack(&rt_sf->uc.uc_stack, regs->gpr[1])
-	    || __put_user(to_user_ptr(&rt_sf->uc.uc_mcontext),
+	    || __put_user(__to_user_ptr(&rt_sf->uc.uc_mcontext),
 		    &rt_sf->uc.uc_regs)
 	    || put_sigset_t(&rt_sf->uc.uc_sigmask, oldset))
 		goto badframe;
@@ -1181,7 +1181,7 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
 		    || save_user_regs(regs, mctx, NULL, 0, ctx_has_vsx_region)
 		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
-		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
+		    || __put_user(__to_user_ptr(mctx), &old_ctx->uc_regs))
 			return -EFAULT;
 	}
 	if (new_ctx == NULL)
@@ -1414,14 +1414,14 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
+	if (__put_user(__to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 #ifdef CONFIG_PPC64
 	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
 #else
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 #endif
-	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
+	    || __put_user(__to_user_ptr(&frame->mctx), &sc->regs)
 	    || __put_user(ksig->sig, &sc->signal))
 		goto badframe;
 
@@ -1526,7 +1526,7 @@ long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 	} else
 #endif
 	{
-		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
+		sr = (struct mcontext __user *)__from_user_ptr(sigctx.regs);
 		addr = sr;
 		if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
 		    || restore_user_regs(regs, sr, 1))
-- 
2.5.0

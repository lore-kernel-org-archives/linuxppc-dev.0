Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17800.42626.422170.89079@cargo.ozlabs.ibm.com>
Date: Wed, 20 Dec 2006 13:57:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix register save area alignment for swapcontext syscall
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For 32-bit processes, the getcontext side of the swapcontext system
call (i.e. the saving of the context when the first argument is
non-NULL) has to set the ctx->uc_mcontext.uc_regs pointer to the place
where it saves the registers.  Which it does, but it doesn't ensure
that the pointer is 16-byte aligned.  16-byte alignment is needed
because the Altivec/VMX registers are saved in there, and they need to
be on a 16-byte boundary.

This fixes it by ensuring the appropriate alignment of the pointer.
This issue was pointed out by Jakub Jelinek.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e4ebe1a..6b405a3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -835,11 +835,21 @@ long sys_swapcontext(struct ucontext __u
 		return -EINVAL;
 
 	if (old_ctx != NULL) {
+		struct mcontext __user *mctx;
+
+		/*
+		 * old_ctx might not be 16-byte aligned, in which
+		 * case old_ctx->uc_mcontext won't be either.
+		 * Because we have the old_ctx->uc_pad2 field
+		 * before old_ctx->uc_mcontext, we need to round down
+		 * from &old_ctx->uc_mcontext to a 16-byte boundary.
+		 */
+		mctx = (struct mcontext __user *)
+			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
 		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
-		    || save_user_regs(regs, &old_ctx->uc_mcontext, 0)
+		    || save_user_regs(regs, mctx, 0)
 		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
-		    || __put_user(to_user_ptr(&old_ctx->uc_mcontext),
-			    &old_ctx->uc_regs))
+		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
 			return -EFAULT;
 	}
 	if (new_ctx == NULL)

Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDF4DDDDF6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 23:31:05 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix msr check in compat_sys_swapcontext
Date: Wed, 05 Nov 2008 13:30:57 +0100
Message-ID: <jeprlabbi6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new context may not be 16-byte aligned, so the real address of the
mcontext structure should be read from the uc_regs pointer instead of
directly using the (unaligned) uc_mcontext field.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index a6a4310..dc10720 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -941,9 +941,17 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 #ifdef CONFIG_PPC64
 	unsigned long new_msr = 0;
 
-	if (new_ctx &&
-	    get_user(new_msr, &new_ctx->uc_mcontext.mc_gregs[PT_MSR]))
-		return -EFAULT;
+	if (new_ctx) {
+		struct mcontext __user *mcp;
+		u32 cmcp;
+
+		/* Get pointer to the real mcontext. */
+		if (__get_user(cmcp, &new_ctx->uc_regs))
+			return -EFAULT;
+		mcp = (struct mcontext __user *)(u64)cmcp;
+		if (__get_user(new_msr, &mcp->mc_gregs[PT_MSR]))
+			return -EFAULT;
+	}
 	/*
 	 * Check that the context is not smaller than the original
 	 * size (with VMX but without VSX)

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

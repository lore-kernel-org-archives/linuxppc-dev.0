Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EC6067B3B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:29 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhr-0007S7-2P@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:31 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc user annotations: debug_setconetext(2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	3rd argument of sys_debug_setcontext() is also a userland pointer.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-ppc-i2c/arch/ppc/kernel/signal.c RC12-rc3-ppc-signal/arch/ppc/kernel/signal.c
--- RC12-rc3-ppc-i2c/arch/ppc/kernel/signal.c	Mon Apr 25 00:40:03 2005
+++ RC12-rc3-ppc-signal/arch/ppc/kernel/signal.c	Mon Apr 25 00:40:09 2005
@@ -511,7 +511,7 @@
 }
 
 int sys_debug_setcontext(struct ucontext __user *ctx,
-			 int ndbg, struct sig_dbg_op *dbg,
+			 int ndbg, struct sig_dbg_op __user *dbg,
 			 int r6, int r7, int r8,
 			 struct pt_regs *regs)
 {

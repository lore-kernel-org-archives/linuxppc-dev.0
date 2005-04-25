Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 595D667B2F
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:16 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhW-0007RQ-Tn@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:10 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc user annotations: sigcontext
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	sigcontext.regs is a userland pointer
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-sent/arch/ppc/kernel/signal.c RC12-rc3-ppc-sigcontext/arch/ppc/kernel/signal.c
--- RC12-rc3-sent/arch/ppc/kernel/signal.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-ppc-sigcontext/arch/ppc/kernel/signal.c	Mon Apr 25 00:40:03 2005
@@ -632,7 +632,7 @@
 	if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
-	    || __put_user((struct pt_regs *)frame, &sc->regs)
+	    || __put_user((struct pt_regs __user *)frame, &sc->regs)
 	    || __put_user(sig, &sc->signal))
 		goto badframe;
 
diff -urN RC12-rc3-sent/include/asm-ppc/sigcontext.h RC12-rc3-ppc-sigcontext/include/asm-ppc/sigcontext.h
--- RC12-rc3-sent/include/asm-ppc/sigcontext.h	Wed Feb  4 10:02:26 2004
+++ RC12-rc3-ppc-sigcontext/include/asm-ppc/sigcontext.h	Mon Apr 25 00:40:03 2005
@@ -9,7 +9,7 @@
 	int		signal;
 	unsigned long	handler;
 	unsigned long	oldmask;
-	struct pt_regs 	*regs;
+	struct pt_regs 	__user *regs;
 };
 
 #endif

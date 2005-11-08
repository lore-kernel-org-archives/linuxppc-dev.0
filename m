Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 8C7F3686E8
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 09:36:33 +1100 (EST)
Date: Tue, 8 Nov 2005 15:36:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
Message-ID: <20051108223631.GR3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Matt Mackall <mpm@selenic.com>
Subject: [PATCH 2.6.14] ppc32: Fix CONFIG_PRINTK=n building
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch is needed to allow PRINTK=n to work on ppc32.

Direct calls to printk from asm files can't be magically removed so we
have to do it manually.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6.14/arch/ppc/kernel/fpu.S
===================================================================
--- linux-2.6.14.orig/arch/ppc/kernel/fpu.S
+++ linux-2.6.14/arch/ppc/kernel/fpu.S
@@ -91,7 +91,9 @@ KernelFP:
 	ori	r3,r3,86f@l
 	mr	r4,r2			/* current */
 	lwz	r5,_NIP(r1)
+#ifdef CONFIG_PRINTK
 	bl	printk
+#endif
 	b	ret_from_except
 86:	.string	"floating point used in kernel (task=%p, pc=%x)\n"
 	.align	4,0
Index: linux-2.6.14/arch/ppc/kernel/head.S
===================================================================
--- linux-2.6.14.orig/arch/ppc/kernel/head.S
+++ linux-2.6.14/arch/ppc/kernel/head.S
@@ -846,7 +846,9 @@ KernelAltiVec:
 	ori	r3,r3,87f@l
 	mr	r4,r2		/* current */
 	lwz	r5,_NIP(r1)
+#ifdef CONFIG_PRINTK
 	bl	printk
+#endif
 	b	ret_from_except
 87:	.string	"AltiVec used in kernel  (task=%p, pc=%x)  \n"
 	.align	4,0
Index: linux-2.6.14/arch/ppc/kernel/head_fsl_booke.S
===================================================================
--- linux-2.6.14.orig/arch/ppc/kernel/head_fsl_booke.S
+++ linux-2.6.14/arch/ppc/kernel/head_fsl_booke.S
@@ -906,7 +906,9 @@ KernelSPE:
 	ori	r3,r3,87f@l
 	mr	r4,r2		/* current */
 	lwz	r5,_NIP(r1)
+#ifdef CONFIG_PRINTK
 	bl	printk
+#endif
 	b	ret_from_except
 87:	.string	"SPE used in kernel  (task=%p, pc=%x)  \n"
 	.align	4,0

-- 
Tom Rini
http://gate.crashing.org/~trini/

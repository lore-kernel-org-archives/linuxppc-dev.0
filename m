Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id B4EF7B7067
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Mar 2010 19:44:01 +1100 (EST)
Message-ID: <4B93674B.4090708@freemail.hu>
Date: Sun, 07 Mar 2010 09:43:55 +0100
From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: do not call prink when CONFIG_PRINTK is not defined
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Márton Németh <nm127@freemail.hu>

When printk() is disabled (CONFIG_PRINTK) at menu item
 General setup
 -> Configure standard kernel features (for small systems)
    -> Enable support for printk
then there should be no printk() calls at all.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -upr linux-2.6.33.orig/arch/powerpc/kernel/head_fsl_booke.S linux/arch/powerpc/kernel/head_fsl_booke.S
--- linux-2.6.33.orig/arch/powerpc/kernel/head_fsl_booke.S	2010-02-24 19:52:17.000000000 +0100
+++ linux/arch/powerpc/kernel/head_fsl_booke.S	2010-03-07 09:28:05.000000000 +0100
@@ -887,13 +887,17 @@ KernelSPE:
 	lwz	r3,_MSR(r1)
 	oris	r3,r3,MSR_SPE@h
 	stw	r3,_MSR(r1)	/* enable use of SPE after return */
+#ifdef CONFIG_PRINTK
 	lis	r3,87f@h
 	ori	r3,r3,87f@l
 	mr	r4,r2		/* current */
 	lwz	r5,_NIP(r1)
 	bl	printk
+#endif
 	b	ret_from_except
+#ifdef CONFIG_PRINTK
 87:	.string	"SPE used in kernel  (task=%p, pc=%x)  \n"
+#endif
 	.align	4,0

 #endif /* CONFIG_SPE */

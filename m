Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD72FDDD07
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 13:43:45 +1000 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: paulus@samba.org
Subject: [patch] use __attribute__ in asm-powerpc
Date: Sat, 14 Jul 2007 23:36:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707142336.10343.vapier@gentoo.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pretty much everyone uses "__attribute__" or "attribute", no one
uses "__attribute".  This patch tweaks the three places in asm-powerpc where
this comes up.  While only asm-powerpc/types.h is interesting (for userspace),
I did asm-powerpc/processor.h as well for consistency.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
index d947b16..2ce6ea6 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -153,9 +153,9 @@ struct thread_struct {
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
-	vector128	vr[32] __attribute((aligned(16)));
+	vector128	vr[32] __attribute__((aligned(16)));
 	/* AltiVec status */
-	vector128	vscr __attribute((aligned(16)));
+	vector128	vscr __attribute__((aligned(16)));
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
index 3b36375..a584341 100644
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -48,7 +48,7 @@ typedef unsigned long long __u64;
 
 typedef struct {
 	__u32 u[4];
-} __attribute((aligned(16))) __vector128;
+} __attribute__((aligned(16))) __vector128;
 
 #endif /* __ASSEMBLY__ */
 

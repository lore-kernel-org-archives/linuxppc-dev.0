Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B19367B8F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 18:30:05 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9C8cYAu010482
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 03:38:35 -0500
Subject: [PATCH 2/4] powerpc: support nested cpu features
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 18:29:59 +1000
Message-Id: <1160641799.4792.134.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds some macros that can be used with an explicit label in
order to nest cpu features. This should be used very careful but is
necessary for the upcoming cell TB fixup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-powerpc/cputable.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-11 13:20:08.000000000 +1000
+++ linux-cell/include/asm-powerpc/cputable.h	2006-10-11 13:20:26.000000000 +1000
@@ -431,30 +432,34 @@ static inline int cpu_has_feature(unsign
 
 #ifdef __ASSEMBLY__
 
-#define BEGIN_FTR_SECTION		98:
+#define BEGIN_FTR_SECTION_NESTED(label)	label:
+#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(98)
 
 #ifndef __powerpc64__
-#define END_FTR_SECTION(msk, val)		\
+#define END_FTR_SECTION_NESTED(msk, val, label) \
 99:						\
 	.section __ftr_fixup,"a";		\
 	.align 2;				\
 	.long msk;				\
 	.long val;				\
-	.long 98b;				\
+	.long label##b;				\
 	.long 99b;				\
 	.previous
 #else /* __powerpc64__ */
-#define END_FTR_SECTION(msk, val)		\
+#define END_FTR_SECTION_NESTED(msk, val, label) \
 99:						\
 	.section __ftr_fixup,"a";		\
 	.align 3;				\
 	.llong msk;				\
 	.llong val;				\
-	.llong 98b;				\
+	.llong label##b;				\
 	.llong 99b;	 			\
 	.previous
 #endif /* __powerpc64__ */
 
+#define END_FTR_SECTION(msk, val)		\
+	END_FTR_SECTION_NESTED(msk, val, 98)
+
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
 #endif /* __ASSEMBLY__ */

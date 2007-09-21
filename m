Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28520DDE3C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 00:48:02 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8LEkvt0004294
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 18:46:57 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8LEkvaX004291
	for linuxppc-dev@ozlabs.org; Fri, 21 Sep 2007 18:46:57 +0400
Date: Fri, 21 Sep 2007 18:46:57 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] PowerPC: Move 440EP(x) FPU setup from head_44x to
	cpu_setup_4xx
Message-ID: <20070921144657.GA4268@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921144149.GA4150@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PowerPC 440EP(x) FPU init is currently done in head_44x
under ifdefs. Since we should support more then one board
in the same kernel, we move FPU initialization code from head_44x
to cpu_setup_44x and add cpu_setup callbacks for 440EP(x).

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/cpu_setup_44x.S |   14 ++++++++++++++
 arch/powerpc/kernel/cputable.c      |    6 ++++++
 arch/powerpc/kernel/head_44x.S      |   10 ----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-21 16:18:35.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_44x.S	2007-09-21 16:17:03.000000000 +0400
@@ -17,3 +17,17 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 
+_GLOBAL(__setup_cpu_440ep)
+	b	__init_fpu_44x
+_GLOBAL(__setup_cpu_440epx)
+	b	__init_fpu_44x
+
+/* enable APU between CPU and FPU */
+_GLOBAL(__init_fpu_44x)
+	mfspr	r3,SPRN_CCR0
+	/* Clear DAPUIB flag in CCR0 */
+	rlwinm	r3,r3,0,12,10
+	mtspr	SPRN_CCR0,r3
+	isync
+	blr
+
diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-09-21 16:18:22.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-09-21 16:17:05.000000000 +0400
@@ -31,6 +31,8 @@
  * and ppc64
  */
 #ifdef CONFIG_PPC32
+extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1111,6 +1113,7 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
 	{
@@ -1121,6 +1124,7 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
 		.platform		= "ppc440",
 	},
 	{ /* 440EPX */
@@ -1131,6 +1135,8 @@
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440epx,
+		.platform		= "ppc440",
 	},
 	{ /* 440GRX */
 		.pvr_mask		= 0xf0000ffb,
diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
--- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-09-21 16:19:04.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-09-21 16:00:17.000000000 +0400
@@ -217,16 +217,6 @@
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
-#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
-	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
-	mfspr	r2,SPRN_CCR0
-	lis	r3,0xffef
-	ori	r3,r3,0xffff
-	and	r2,r2,r3
-	mtspr	SPRN_CCR0,r2
-	isync
-#endif
-
 	/*
 	 * This is where the main kernel code starts.
 	 */

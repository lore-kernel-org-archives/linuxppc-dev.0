Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate2.mot.com (motgate2.mot.com [144.189.100.101])
	by ozlabs.org (Postfix) with ESMTP id C825C2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 15:18:29 +1100 (EST)
Date: Wed, 10 Nov 2004 22:18:24 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0411102215510.19875@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Remove zero initializations in cpu_specs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew,

Remove initializations to zero in cpu_specs table at Tom Rini's 
suggestion.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-11-10 22:11:13 -06:00
+++ b/arch/ppc/kernel/cputable.c	2004-11-10 22:11:13 -06:00
@@ -94,7 +94,6 @@
 			PPC_FEATURE_UNIFIED_CACHE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_601
 	},
 	{	/* 603 */
@@ -107,7 +106,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_603
 	},
 	{	/* 603e */
@@ -120,7 +118,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_603
 	},
 	{	/* 603ev */
@@ -133,7 +130,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_603
 	},
 	{	/* 604 */
@@ -550,7 +546,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_603
 	},
 	{	/* All G2_LE (603e core, plus some) have the same pvr */
@@ -563,7 +558,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_603
 	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
@@ -576,7 +570,6 @@
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
 		.cpu_setup		= __setup_cpu_generic
 	},
 #endif /* CLASSIC_PPC */
@@ -691,7 +684,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
-		.num_pmcs		= 0,
 	},
 #endif /* CONFIG_8xx */
 #ifdef CONFIG_40x
@@ -704,8 +696,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_403 */
 	},
 	{	/* 403GCX */
 		.pvr_mask		= 0xffffff00,
@@ -716,8 +706,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_403 */
 	},
 	{	/* 403G ?? */
 		.pvr_mask		= 0xffff0000,
@@ -728,8 +716,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_403 */
 	},
 	{	/* 405GP */
 		.pvr_mask		= 0xffff0000,
@@ -741,8 +727,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* STB 03xxx */
 		.pvr_mask		= 0xffff0000,
@@ -754,8 +738,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* STB 04xxx */
 		.pvr_mask		= 0xffff0000,
@@ -767,8 +749,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* NP405L */
 		.pvr_mask		= 0xffff0000,
@@ -780,8 +760,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* NP4GS3 */
 		.pvr_mask		= 0xffff0000,
@@ -793,8 +771,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{   /* NP405H */
 		.pvr_mask		= 0xffff0000,
@@ -806,8 +782,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* 405GPr */
 		.pvr_mask		= 0xffff0000,
@@ -819,8 +793,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{   /* STBx25xx */
 		.pvr_mask		= 0xffff0000,
@@ -832,8 +804,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* 405LP */
 		.pvr_mask		= 0xffff0000,
@@ -844,8 +814,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 	{	/* Xilinx Virtex-II Pro  */
 		.pvr_mask		= 0xffff0000,
@@ -857,8 +825,6 @@
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_405 */
 	},
 
 #endif /* CONFIG_40x */
@@ -872,8 +838,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_440 */
 	},
 	{ 	/* 440GP Rev. C */
 		.pvr_mask		= 0xf0000fff,
@@ -884,8 +848,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_440 */
 	},
 	{ /* 440GX Rev. A */
 		.pvr_mask		= 0xf0000fff,
@@ -896,8 +858,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_440 */
 	},
 	{ /* 440GX Rev. B */
 		.pvr_mask		= 0xf0000fff,
@@ -908,8 +868,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_440 */
 	},
 	{ /* 440GX Rev. C */
 		.pvr_mask		= 0xf0000fff,
@@ -920,8 +878,6 @@
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0, /*__setup_cpu_440 */
 	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_E500
@@ -938,7 +894,6 @@
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= 0, /*__setup_cpu_e500 */
 	},
 #endif
 #if !CLASSIC_PPC
@@ -950,8 +905,6 @@
 		.cpu_user_features	= PPC_FEATURE_32,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.num_pmcs		= 0,
-		.cpu_setup		= 0,
 	}
 #endif /* !CLASSIC_PPC */
 };

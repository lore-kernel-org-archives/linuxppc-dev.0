Return-Path: <lee.nipper@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 7C3ABB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 21:17:22 +1000 (EST)
Received: by gyd10 with SMTP id 10so1145778gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 09 Jul 2010 04:17:20 -0700 (PDT)
From: Lee Nipper <lee.nipper@gmail.com>
To: jwboyer@linux.vnet.ibm.com
Subject: [PATCH] powerpc/40x: Distinguish AMCC PowerPC 405EX and 405EXr
	correctly
Date: Fri,  9 Jul 2010 06:17:16 -0500
Message-Id: <1278674236-4550-1-git-send-email-lee.nipper@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Lee Nipper <lee.nipper@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent AMCC 405EX Rev D without Security uses a PVR value
that matches the old 405EXr Rev A/B with Security.
The 405EX Rev D without Security would be shown
incorrectly as an 405EXr. The pvr_mask of 0xffff0004
is no longer sufficient to distinguish the 405EX from 405EXr.

This patch replaces 2 entries in the cpu_specs table
and adds 8 more, each using pvr_mask of 0xffff000f
and appropriate pvr_value to distinguish the AMCC
PowerPC 405EX and 405EXr instances.
The cpu_name for these entries now includes the
Rev, in similar fashion to the 440GX.

Signed-off-by: Lee Nipper <lee.nipper@gmail.com>
---
Patch applies against v2.6.35-rc4.
Tested with 405EX Rev C and Rev D.
Followed u-boot arch/powerpc/include/asm/processor.h for 405EX[r] PVR values.

 arch/powerpc/kernel/cputable.c |  118 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 87aa0f3..65e2b4e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1364,10 +1364,10 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
-	{	/* 405EX */
-		.pvr_mask		= 0xffff0004,
-		.pvr_value		= 0x12910004,
-		.cpu_name		= "405EX",
+	{	/* 405EX Rev. A/B with Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910007,
+		.cpu_name		= "405EX Rev. A/B",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
@@ -1377,10 +1377,114 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
-	{	/* 405EXr */
-		.pvr_mask		= 0xffff0004,
+	{	/* 405EX Rev. C without Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x1291000d,
+		.cpu_name		= "405EX Rev. C",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EX Rev. C with Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x1291000f,
+		.cpu_name		= "405EX Rev. C",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EX Rev. D without Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910003,
+		.cpu_name		= "405EX Rev. D",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EX Rev. D with Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910005,
+		.cpu_name		= "405EX Rev. D",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EXr Rev. A/B without Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910001,
+		.cpu_name		= "405EXr Rev. A/B",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EXr Rev. C without Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910009,
+		.cpu_name		= "405EXr Rev. C",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EXr Rev. C with Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x1291000b,
+		.cpu_name		= "405EXr Rev. C",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EXr Rev. D without Security */
+		.pvr_mask		= 0xffff000f,
 		.pvr_value		= 0x12910000,
-		.cpu_name		= "405EXr",
+		.cpu_name		= "405EXr Rev. D",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.mmu_features		= MMU_FTR_TYPE_40x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	},
+	{	/* 405EXr Rev. D with Security */
+		.pvr_mask		= 0xffff000f,
+		.pvr_value		= 0x12910002,
+		.cpu_name		= "405EXr Rev. D",
 		.cpu_features		= CPU_FTRS_40X,
 		.cpu_user_features	= PPC_FEATURE_32 |
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
-- 
1.6.0.4

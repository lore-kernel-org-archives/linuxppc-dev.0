Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBD76B710D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:26:24 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QG6o9c018095
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 11:06:51 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6A0EA618010
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 11:18:04 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QGI3cH468128
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 11:18:04 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0QGMZDP000864
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 09:22:35 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/476: define specific cpu table entry DD2 core
Date: Wed, 26 Jan 2011 10:17:58 -0600
Message-Id: <1296058679-21352-2-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296058679-21352-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296058679-21352-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The DD2 core still has some unstability.  Define CPU_FTR_476_DD2 to
enable workarounds in later patches.

This is based on an earlier, unreleased patch for DD1 by Ben Herrenschmidt.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    3 ++-
 arch/powerpc/kernel/cputable.c      |   22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index f0a211d..be3cdf9 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -154,6 +154,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
 #define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
 #define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
+#define CPU_FTR_476_DD2			ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
@@ -465,7 +466,7 @@ enum {
 	    CPU_FTRS_44X | CPU_FTRS_440x6 |
 #endif
 #ifdef CONFIG_PPC_47x
-	    CPU_FTRS_47X |
+	    CPU_FTRS_47X | CPU_FTR_476_DD2 |
 #endif
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 |
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 8d74a24..436e1e5 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1811,11 +1811,11 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
-	{ /* 476 core */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x11a50000,
+	{ /* 476 DD2 core */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x11a52080,
 		.cpu_name		= "476",
-		.cpu_features		= CPU_FTRS_47X,
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD2,
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_FPU,
 		.mmu_features		= MMU_FTR_TYPE_47x |
@@ -1839,6 +1839,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_47x,
 		.platform		= "ppc470",
 	},
+	{ /* 476 others */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x11a50000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
1.7.3.4

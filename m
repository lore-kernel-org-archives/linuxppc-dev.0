Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 936F11007D6
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 06:39:54 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q0IJdjA6031269
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 13:39:46 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Add initial e6500 cpu support
Date: Wed, 18 Jan 2012 13:39:40 -0600
Message-Id: <1326915580-19652-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
References: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add basic support for e6500 core in its single threaded mode.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h |   12 ++++++++----
 arch/powerpc/kernel/cputable.c      |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ad55a1c..b9219e9 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -390,6 +390,10 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC)
+#define CPU_FTRS_E6500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_DEBUG_LVL_EXC)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
@@ -442,7 +446,7 @@ extern const char *powerpc_base_platform;
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
-#define CPU_FTRS_POSSIBLE	(CPU_FTRS_E5500 | CPU_FTRS_A2)
+#define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500 | CPU_FTRS_A2)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
@@ -483,7 +487,7 @@ enum {
 #endif
 #ifdef CONFIG_E500
 	    CPU_FTRS_E500 | CPU_FTRS_E500_2 | CPU_FTRS_E500MC |
-	    CPU_FTRS_E5500 |
+	    CPU_FTRS_E5500 | CPU_FTRS_E6500 |
 #endif
 	    0,
 };
@@ -491,7 +495,7 @@ enum {
 
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_BOOK3E
-#define CPU_FTRS_ALWAYS		(CPU_FTRS_E5500 & CPU_FTRS_A2)
+#define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500 & CPU_FTRS_A2)
 #else
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
@@ -528,7 +532,7 @@ enum {
 #endif
 #ifdef CONFIG_E500
 	    CPU_FTRS_E500 & CPU_FTRS_E500_2 & CPU_FTRS_E500MC &
-	    CPU_FTRS_E5500 &
+	    CPU_FTRS_E5500 & CPU_FTRS_E6500 &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 81db9e2..4dccf51 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2019,6 +2019,24 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
 	},
+	{	/* e6500 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80400000,
+		.cpu_name		= "e6500",
+		.cpu_features		= CPU_FTRS_E6500,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
+			MMU_FTR_USE_TLBILX,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 4,
+		.oprofile_cpu_type	= "ppc/e6500",
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
+		.cpu_setup		= __setup_cpu_e5500,
+		.cpu_restore		= __restore_cpu_e5500,
+		.machine_check		= machine_check_e500mc,
+		.platform		= "ppce6500",
+	},
 #ifdef CONFIG_PPC32
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
-- 
1.7.3.4

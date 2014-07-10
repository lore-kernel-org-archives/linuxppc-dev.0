Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6D8A1A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:30 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/9] powerpc: Drop support for pre-POWER4 cpus
Date: Thu, 10 Jul 2014 12:29:18 +1000
Message-Id: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We inadvertently broke power3 support back in 3.4 with commit
f5339277eb8d "powerpc: Remove FW_FEATURE ISERIES from arch code".
No one noticed until at least 3.9.

By then we'd also broken it with the optimised memcpy, copy_to/from_user
and clear_user routines. We don't want to add any more complexity to
those just to support ancient cpus, so it seems like it's a good time to
drop support for power3 and earlier.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 18 +++-----
 arch/powerpc/kernel/cputable.c      | 90 -------------------------------------
 2 files changed, 6 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index bc2347774f0a..2721946780df 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -400,11 +400,6 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | \
-	    CPU_FTR_IABR | CPU_FTR_PPC_LE)
-#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | \
-	    CPU_FTR_IABR | \
-	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
@@ -466,10 +461,9 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_POSSIBLE	(CPU_FTRS_E6500 | CPU_FTRS_E5500 | CPU_FTRS_A2)
 #else
 #define CPU_FTRS_POSSIBLE	\
-	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
-	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 |	\
-	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
+	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
+	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
+	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
 #endif
 #else
 enum {
@@ -517,9 +511,9 @@ enum {
 #define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500 & CPU_FTRS_A2)
 #else
 #define CPU_FTRS_ALWAYS		\
-	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
-	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
-	    CPU_FTRS_POWER7 & CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
+	    (CPU_FTRS_POWER4 & CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
+	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
+	     CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 965291b4c2fa..4728c0885d83 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -123,96 +123,6 @@ extern void __restore_cpu_e6500(void);
 
 static struct cpu_spec __initdata cpu_specs[] = {
 #ifdef CONFIG_PPC_BOOK3S_64
-	{	/* Power3 */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00400000,
-		.cpu_name		= "POWER3 (630)",
-		.cpu_features		= CPU_FTRS_POWER3,
-		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power3",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "power3",
-	},
-	{	/* Power3+ */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00410000,
-		.cpu_name		= "POWER3 (630+)",
-		.cpu_features		= CPU_FTRS_POWER3,
-		.cpu_user_features	= COMMON_USER_PPC64|PPC_FEATURE_PPC_LE,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power3",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "power3",
-	},
-	{	/* Northstar */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00330000,
-		.cpu_name		= "RS64-II (northstar)",
-		.cpu_features		= CPU_FTRS_RS64,
-		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "rs64",
-	},
-	{	/* Pulsar */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00340000,
-		.cpu_name		= "RS64-III (pulsar)",
-		.cpu_features		= CPU_FTRS_RS64,
-		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "rs64",
-	},
-	{	/* I-star */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00360000,
-		.cpu_name		= "RS64-III (icestar)",
-		.cpu_features		= CPU_FTRS_RS64,
-		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "rs64",
-	},
-	{	/* S-star */
-		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x00370000,
-		.cpu_name		= "RS64-IV (sstar)",
-		.cpu_features		= CPU_FTRS_RS64,
-		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= PPC_OPROFILE_RS64,
-		.platform		= "rs64",
-	},
 	{	/* Power4 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00350000,
-- 
1.9.1

Return-Path: <joel.stan@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QT5D6tDmzF37Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 16:03:12 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id n2-v6so2617724pgq.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 23:03:12 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: Remove Power8 DD1 from cputable
Date: Wed, 11 Jul 2018 16:02:58 +1000
Message-Id: <20180711060258.14448-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was added to support an early version of Power8 that did not have
working doorbells. These machines were not publicly available, and all of
the internal users have long since upgraded.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/cputable.h | 15 +++++++--------
 arch/powerpc/kernel/cputable.c      | 19 -------------------
 2 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 9c0a3083571b..7711ebfb7d5f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -452,7 +452,6 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_PKEY)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
-#define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_POWER9 (CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -488,16 +487,16 @@ static inline void cpu_feature_keys_init(void) { }
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 | \
-	     CPU_FTRS_POWER8_DD1 | CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | \
-	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
+	     CPU_FTR_ALTIVEC_COMP | CPU_FTR_VSX_COMP | CPU_FTRS_POWER9 | \
+	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
 	     CPU_FTRS_POWER9_DD2_2)
 #else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
-	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
-	     CPU_FTRS_PA6T | CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | \
-	     CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
+	     CPU_FTRS_POWER8 | CPU_FTRS_CELL | CPU_FTRS_PA6T | \
+	     CPU_FTR_VSX_COMP | CPU_FTR_ALTIVEC_COMP | CPU_FTRS_POWER9 | \
+	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
 	     CPU_FTRS_POWER9_DD2_2)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
@@ -566,7 +565,7 @@ enum {
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define CPU_FTRS_ALWAYS \
 	    (CPU_FTRS_POSSIBLE & ~CPU_FTR_HVMODE & CPU_FTRS_POWER7 & \
-	     CPU_FTRS_POWER8E & CPU_FTRS_POWER8 & CPU_FTRS_POWER8_DD1 & \
+	     CPU_FTRS_POWER8E & CPU_FTRS_POWER8 & \
 	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
 	     CPU_FTRS_DT_CPU_BASE)
 #else
@@ -574,7 +573,7 @@ enum {
 	    (CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
 	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
-	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
+	     ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
 	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
 	     CPU_FTRS_DT_CPU_BASE)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c8fc9691f8c7..9169ffdbab08 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -447,25 +447,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
-	{	/* Power8 DD1: Does not support doorbell IPIs */
-		.pvr_mask		= 0xffffff00,
-		.pvr_value		= 0x004d0100,
-		.cpu_name		= "POWER8 (raw)",
-		.cpu_features		= CPU_FTRS_POWER8_DD1,
-		.cpu_user_features	= COMMON_USER_POWER8,
-		.cpu_user_features2	= COMMON_USER2_POWER8,
-		.mmu_features		= MMU_FTRS_POWER8,
-		.icache_bsize		= 128,
-		.dcache_bsize		= 128,
-		.num_pmcs		= 6,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power8",
-		.oprofile_type		= PPC_OPROFILE_INVALID,
-		.cpu_setup		= __setup_cpu_power8,
-		.cpu_restore		= __restore_cpu_power8,
-		.machine_check_early	= __machine_check_early_realmode_p8,
-		.platform		= "power8",
-	},
 	{	/* Power8 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004d0000,
-- 
2.17.1

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS7Td59hjzDqvT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 12:55:49 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so3366646pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 18:55:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 1/2] powerpc: add POWER9_DD20 feature
Date: Thu,  2 Nov 2017 12:55:34 +1100
Message-Id: <20171102015535.30843-2-npiggin@gmail.com>
In-Reply-To: <20171102015535.30843-1-npiggin@gmail.com>
References: <20171102015535.30843-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h |  5 ++++-
 arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4efc..194dc3006446 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -215,6 +215,7 @@ enum {
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
+#define CPU_FTR_POWER9_DD20		LONG_ASM_CONST(0x8000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -477,6 +478,7 @@ enum {
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
+#define CPU_FTRS_POWER9_DD20 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD20)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -495,7 +497,8 @@ enum {
 	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
-	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1)
+	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
+	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD20)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 760872916013..171820190de7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -547,6 +547,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
+	{	/* Power9 DD2.0 */
+		.pvr_mask		= 0xffffefff,
+		.pvr_value		= 0x004e0200,
+		.cpu_name		= "POWER9 (raw)",
+		.cpu_features		= CPU_FTRS_POWER9_DD20,
+		.cpu_user_features	= COMMON_USER_POWER9,
+		.cpu_user_features2	= COMMON_USER2_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power9",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power9,
+		.cpu_restore		= __restore_cpu_power9,
+		.flush_tlb		= __flush_tlb_power9,
+		.machine_check_early	= __machine_check_early_realmode_p9,
+		.platform		= "power9",
+	},
 	{	/* Power9 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004e0000,
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 7275fed271af..63b9d7edd63f 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -735,6 +735,8 @@ static __init void cpufeatures_cpu_quirks(void)
 	 */
 	if ((version & 0xffffff00) == 0x004e0100)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
+	else if ((version & 0xffffefff) == 0x004e0200)
+		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD20;
 }
 
 static void __init cpufeatures_setup_finished(void)
-- 
2.15.0

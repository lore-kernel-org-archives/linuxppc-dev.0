Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxhKZ0ymvzF1lT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 18:02:42 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH RFC 1/5] powerpc: Add a CPU feature bit for TM bug workarounds
 on POWER9 v2.2
Date: Thu,  8 Mar 2018 18:02:27 +1100
Message-Id: <1520492551-799-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1520492551-799-1-git-send-email-paulus@ozlabs.org>
References: <1520492551-799-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a CPU feature bit which is set for POWER9 "Nimbus" DD2.2
processors which will be used to enable the hypervisor to assist
hardware with the handling of checkpointed register values while
the CPU is in suspend state, in order to work around hardware
bugs.

When the dt_cpu_ftrs subsystem is in use, the software assistance
can be enabled using a "tm-suspend-hypervisor-assist" node in the
device tree.  In the absence of such a node, a quirk enables the
assistance for POWER9 "Nimbus" DD2.2 processors.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/cputable.h |  5 ++++-
 arch/powerpc/kernel/cputable.c      | 24 ++++++++++++++++++++++--
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  3 +++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a2c5c95..46343ac 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -203,6 +203,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_P9_TM_EMUL		LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
 #define CPU_FTR_POWER9_DD2_1		LONG_ASM_CONST(0x8000000000000000)
 
@@ -470,6 +471,7 @@ static inline void cpu_feature_keys_init(void) { }
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
 #define CPU_FTRS_POWER9_DD2_1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD2_1)
+#define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_P9_TM_EMUL)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -489,7 +491,8 @@ static inline void cpu_feature_keys_init(void) { }
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
 	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
-	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1)
+	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_1 | \
+	     CPU_FTRS_POWER9_DD2_2)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c40a9fc..68052ea 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -553,11 +553,31 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
-	{	/* Power9 DD 2.1 or later (see DD2.0 above) */
+	{	/* Power9 DD 2.1 */
+		.pvr_mask		= 0xffffefff,
+		.pvr_value		= 0x004e0201,
+		.cpu_name		= "POWER9 (raw)",
+		.cpu_features		= CPU_FTRS_POWER9_DD2_1,
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
+	{	/* Power9 DD2.2 or later */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004e0000,
 		.cpu_name		= "POWER9 (raw)",
-		.cpu_features		= CPU_FTRS_POWER9_DD2_1,
+		.cpu_features		= CPU_FTRS_POWER9_DD2_2,
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
 		.mmu_features		= MMU_FTRS_POWER9,
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 945e2c2..e181266 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -590,6 +590,7 @@ static struct dt_cpu_feature_match __initdata
 	{"virtual-page-class-key-protection", feat_enable, 0},
 	{"transactional-memory", feat_enable_tm, CPU_FTR_TM},
 	{"transactional-memory-v3", feat_enable_tm, 0},
+	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_EMUL},
 	{"idle-nap", feat_enable_idle_nap, 0},
 	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
 	{"idle-stop", feat_enable_idle_stop, 0},
@@ -709,6 +710,8 @@ static __init void cpufeatures_cpu_quirks(void)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
 	else if ((version & 0xffffefff) == 0x004e0201)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
+	else if ((version & 0xffffefff) == 0x004e0202)
+		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TM_EMUL;
 }
 
 static void __init cpufeatures_setup_finished(void)
-- 
2.7.4

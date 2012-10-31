Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: POWER8 cputable entry
Date: Wed, 31 Oct 2012 16:34:15 +1100
Message-Id: <1351661656-6986-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1351661656-6986-1-git-send-email-mikey@neuling.org>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |   12 ++++++++++--
 arch/powerpc/include/asm/mmu.h      |    1 +
 arch/powerpc/include/asm/reg.h      |    1 +
 arch/powerpc/kernel/cputable.c      |   21 +++++++++++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 21a0687..76f81bd 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -401,6 +401,14 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
+#define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -421,8 +429,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
-	    CPU_FTR_VSX)
+	    CPU_FTRS_POWER7 | CPU_FTRS_POWER8 | CPU_FTRS_CELL |		\
+	    CPU_FTRS_PA6T | CPU_FTR_VSX)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 5e38eed..691fd8a 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -101,6 +101,7 @@
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d24c141..7b44a6e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1029,6 +1029,7 @@
 #define PVR_970MP	0x0044
 #define PVR_970GX	0x0045
 #define PVR_POWER7p	0x004A
+#define PVR_POWER8	0x004B
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 361f6d9..216ff84 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -96,6 +96,10 @@ extern void __restore_cpu_e5500(void);
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
+#define COMMON_USER_POWER8	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
+				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
@@ -465,6 +469,23 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_restore		= __restore_cpu_power7,
 		.platform		= "power7+",
 	},
+	{	/* Power8 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x004b0000,
+		.cpu_name		= "POWER8 (raw)",
+		.cpu_features		= CPU_FTRS_POWER8,
+		.cpu_user_features	= COMMON_USER_POWER8,
+		.mmu_features		= MMU_FTRS_POWER8,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.cpu_setup		= __setup_cpu_power8,
+		.cpu_restore		= __restore_cpu_power8,
+		.platform		= "power8",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
-- 
1.7.9.5

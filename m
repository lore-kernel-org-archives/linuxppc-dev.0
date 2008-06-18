Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Subject: powerpc: Add cputable entry for POWER7
Date: Wed, 18 Jun 2008 10:47:26 +1000
Message-ID: <16237.1213750046@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a cputable entry for the POWER7 processor.  

Also tell firmware that we know about POWER7.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--- 
Paulus: please consider for your 2.6.27 tree.

 arch/powerpc/kernel/cputable.c  |   25 +++++++++++++++++++++++++
 arch/powerpc/kernel/misc.S      |    5 +++++
 arch/powerpc/kernel/prom_init.c |    1 +
 include/asm-powerpc/cputable.h  |   12 ++++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
@@ -52,6 +52,8 @@ extern void __setup_cpu_ppc970MP(unsigne
 extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_pa6t(void);
 extern void __restore_cpu_ppc970(void);
+extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_power7(void);
 #endif /* CONFIG_PPC64 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
@@ -68,6 +70,9 @@ extern void __restore_cpu_ppc970(void);
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE)
+#define COMMON_USER_POWER7	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
+				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
+				 PPC_FEATURE_TRUE_LE)
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
@@ -380,6 +385,26 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_generic,
 		.platform		= "power6",
 	},
+	{	/* Power7 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x003f0000,
+		.cpu_name		= "POWER7",
+		.cpu_features		= CPU_FTRS_POWER7,
+		.cpu_user_features	= COMMON_USER_POWER7,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.cpu_setup		= __setup_cpu_power7,
+		.cpu_restore		= __restore_cpu_power7,
+		.oprofile_cpu_type	= "ppc64/power7",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
+		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
+		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
+			POWER6_MMCRA_OTHER,
+		.platform		= "power7",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
@@ -116,3 +116,8 @@ _GLOBAL(longjmp)
 	mtlr	r0
 	mr	r3,r4
 	blr
+
+_GLOBAL(__setup_cpu_power7)
+_GLOBAL(__restore_cpu_power7)
+	/* place holder */
+	blr
Index: linux-2.6-ozlabs/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/prom_init.c
@@ -650,6 +650,7 @@ static void __init early_cmdline_parse(v
 static unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
+	W(0xffff0000), W(0x003f0000),	/* POWER7 */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
 	5 - 1,				/* 5 option vectors */
Index: linux-2.6-ozlabs/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/cputable.h
+++ linux-2.6-ozlabs/include/asm-powerpc/cputable.h
@@ -26,6 +26,7 @@
 #define PPC_FEATURE_PA6T		0x00000800
 #define PPC_FEATURE_HAS_DFP		0x00000400
 #define PPC_FEATURE_POWER6_EXT		0x00000200
+#define PPC_FEATURE_ARCH_2_06		0x00000100
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
@@ -376,6 +377,12 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
+#define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -391,7 +398,8 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT)
+	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
+	    CPU_FTR_1T_SEGMENT)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -431,7 +439,7 @@ enum {
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
 	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
-	    CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
+	    CPU_FTRS_POWER7 & CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
 #else
 enum {
 	CPU_FTRS_ALWAYS =

Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: oprofile support for POWER6
Date: Wed, 07 Jun 2006 11:23:54 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060607012359.D59C467B37@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

POWER6 moves some of the MMCRA bits and also requires some bits to be
cleared each PMU interrupt.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Anton Blanchard <anton@samba.org>
---
Paul: for your post 2.6.17 queue

 arch/powerpc/kernel/cputable.c          |   10 +++++++-
 arch/powerpc/oprofile/op_model_power4.c |   37 ++++++++++++--------------------
 include/asm-powerpc/cputable.h          |   11 ++++++---
 include/asm-powerpc/reg.h               |    4 +++
 4 files changed, 36 insertions(+), 26 deletions(-)

Index: linux-2.6-powerpc/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-powerpc/arch/powerpc/kernel/cputable.c
@@ -236,6 +236,8 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.oprofile_cpu_type	= "ppc64/power5",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_mmcra_sihv	= MMCRA_SIHV,
+		.oprofile_mmcra_sipr	= MMCRA_SIPR,
 		.platform		= "power5",
 	},
 	{	/* Power5 GS */
@@ -249,6 +251,8 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.oprofile_cpu_type	= "ppc64/power5+",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_mmcra_sihv	= MMCRA_SIHV,
+		.oprofile_mmcra_sipr	= MMCRA_SIPR,
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -259,9 +263,13 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.num_pmcs		= 6,
+		.num_pmcs		= 8,
 		.oprofile_cpu_type	= "ppc64/power6",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+ 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
+ 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
+ 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
+ 			POWER6_MMCRA_OTHER,
 		.platform		= "power6",
 	},
 	{	/* Cell Broadband Engine */
Index: linux-2.6-powerpc/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/oprofile/op_model_power4.c
+++ linux-2.6-powerpc/arch/powerpc/oprofile/op_model_power4.c
@@ -24,10 +24,6 @@
 static unsigned long reset_value[OP_MAX_COUNTER];
 
 static int oprofile_running;
-static int mmcra_has_sihv;
-/* Unfortunately these bits vary between CPUs */
-static unsigned long mmcra_sihv = MMCRA_SIHV;
-static unsigned long mmcra_sipr = MMCRA_SIPR;
 
 /* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
 static u32 mmcr0_val;
@@ -41,16 +37,6 @@ static void power4_reg_setup(struct op_c
 	int i;
 
 	/*
-	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
-	 * However we disable it on all POWER4 until we verify it works
-	 * (I was seeing some strange behaviour last time I tried).
-	 *
-	 * It has been verified to work on POWER5 so we enable it there.
-	 */
-	if (cpu_has_feature(CPU_FTR_MMCRA_SIHV))
-		mmcra_has_sihv = 1;
-
-	/*
 	 * The performance counter event settings are given in the mmcr0,
 	 * mmcr1 and mmcra values passed from the user in the
 	 * op_system_config structure (sys variable).
@@ -202,18 +188,19 @@ static unsigned long get_pc(struct pt_re
 	unsigned long mmcra;
 
 	/* Cant do much about it */
-	if (!mmcra_has_sihv)
+	if (!cur_cpu_spec->oprofile_mmcra_sihv)
 		return pc;
 
 	mmcra = mfspr(SPRN_MMCRA);
 
 	/* Were we in the hypervisor? */
-	if (firmware_has_feature(FW_FEATURE_LPAR) && (mmcra & mmcra_sihv))
+	if (firmware_has_feature(FW_FEATURE_LPAR) &&
+	    (mmcra & cur_cpu_spec->oprofile_mmcra_sihv))
 		/* function descriptor madness */
 		return *((unsigned long *)hypervisor_bucket);
 
 	/* We were in userspace, nothing to do */
-	if (mmcra & mmcra_sipr)
+	if (mmcra & cur_cpu_spec->oprofile_mmcra_sipr)
 		return pc;
 
 #ifdef CONFIG_PPC_RTAS
@@ -235,15 +222,14 @@ static unsigned long get_pc(struct pt_re
 	return pc;
 }
 
-static int get_kernel(unsigned long pc)
+static int get_kernel(unsigned long pc, unsigned long mmcra)
 {
 	int is_kernel;
 
-	if (!mmcra_has_sihv) {
+	if (!cur_cpu_spec->oprofile_mmcra_sihv) {
 		is_kernel = is_kernel_addr(pc);
 	} else {
-		unsigned long mmcra = mfspr(SPRN_MMCRA);
-		is_kernel = ((mmcra & mmcra_sipr) == 0);
+		is_kernel = ((mmcra & cur_cpu_spec->oprofile_mmcra_sipr) == 0);
 	}
 
 	return is_kernel;
@@ -257,9 +243,12 @@ static void power4_handle_interrupt(stru
 	int val;
 	int i;
 	unsigned int mmcr0;
+	unsigned long mmcra;
+
+	mmcra = mfspr(SPRN_MMCRA);
 
 	pc = get_pc(regs);
-	is_kernel = get_kernel(pc);
+	is_kernel = get_kernel(pc, mmcra);
 
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
@@ -287,6 +276,10 @@ static void power4_handle_interrupt(stru
 	 */
 	mmcr0 &= ~MMCR0_PMAO;
 
+	/* Clear the appropriate bits in the MMCRA */
+	mmcra &= ~cur_cpu_spec->oprofile_mmcra_clear;
+	mtspr(SPRN_MMCRA, mmcra);
+
 	/*
 	 * now clear the freeze bit, counting will not start until we
 	 * rfid from this exception, because only at that point will
Index: linux-2.6-powerpc/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6-powerpc.orig/include/asm-powerpc/cputable.h
+++ linux-2.6-powerpc/include/asm-powerpc/cputable.h
@@ -69,6 +69,13 @@ struct cpu_spec {
 	/* Processor specific oprofile operations */
 	enum powerpc_oprofile_type oprofile_type;
 
+	/* Bit locations inside the mmcra change */
+	unsigned long	oprofile_mmcra_sihv;
+	unsigned long	oprofile_mmcra_sipr;
+
+	/* Bits to clear during an oprofile exception */
+	unsigned long	oprofile_mmcra_clear;
+
 	/* Name of processor class, for the ELF AT_PLATFORM entry */
 	char		*platform;
 };
@@ -117,7 +124,6 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTR_SMT			ASM_CONST(0x0000010000000000)
 #define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0000020000000000)
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0000040000000000)
-#define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0000080000000000)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0000100000000000)
 #define CPU_FTR_PAUSE_ZERO		ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			ASM_CONST(0x0000400000000000)
@@ -134,7 +140,6 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTR_SMT			ASM_CONST(0x0)
 #define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0)
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0)
-#define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0)
 #define CPU_FTR_PURR			ASM_CONST(0x0)
 #endif
@@ -320,7 +325,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_MMCRA_SIHV | CPU_FTR_PURR)
+	    CPU_FTR_PURR)
 #define CPU_FTRS_POWER6 (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: linux-2.6-powerpc/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6-powerpc.orig/include/asm-powerpc/reg.h
+++ linux-2.6-powerpc/include/asm-powerpc/reg.h
@@ -443,6 +443,10 @@
 #define   MMCRA_SIHV	0x10000000UL /* state of MSR HV when SIAR set */
 #define   MMCRA_SIPR	0x08000000UL /* state of MSR PR when SIAR set */
 #define   MMCRA_SAMPLE_ENABLE 0x00000001UL /* enable sampling */
+#define   POWER6_MMCRA_SIHV   0x0000040000000000ULL
+#define   POWER6_MMCRA_SIPR   0x0000020000000000ULL
+#define   POWER6_MMCRA_THRM	0x00000020UL
+#define   POWER6_MMCRA_OTHER	0x0000000EUL
 #define SPRN_PMC1	787
 #define SPRN_PMC2	788
 #define SPRN_PMC3	789

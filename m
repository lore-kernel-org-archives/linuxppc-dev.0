Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F129DF6E8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 11:28:06 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH v2] Made FSL Book-E PMC support more generic
Date: Mon,  4 Feb 2008 18:27:55 -0600
Message-Id: <12021712751503-git-send-email-afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some of the more recent e300 cores have the same performance monitor
implementation as the e500.  e300 isn't book-e, so the name isn't
really appropriate.  In preparation for e300 support, rename a bunch
of fsl_booke things to say fsl_emb (Freescale Embedded Performance Monitors).

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/kernel/cputable.c                     |    4 +-
 arch/powerpc/kernel/pmc.c                          |    2 +-
 arch/powerpc/oprofile/Makefile                     |    2 +-
 arch/powerpc/oprofile/common.c                     |    6 +-
 .../{op_model_fsl_booke.c => op_model_fsl_emb.c}   |   28 ++++----
 arch/powerpc/platforms/Kconfig.cputype             |    4 +
 include/asm-powerpc/cputable.h                     |    2 +-
 include/asm-powerpc/oprofile_impl.h                |    2 +-
 include/asm-powerpc/reg.h                          |    4 +
 include/asm-powerpc/reg_booke.h                    |   62 -----------------
 include/asm-powerpc/reg_fsl_emb.h                  |   72 ++++++++++++++++++++
 11 files changed, 102 insertions(+), 86 deletions(-)
 rename arch/powerpc/oprofile/{op_model_fsl_booke.c => op_model_fsl_emb.c} (91%)
 create mode 100644 include/asm-powerpc/reg_fsl_emb.h

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a4c2771..98a1c9e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1435,7 +1435,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
-		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8540",
 	},
@@ -1453,7 +1453,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
-		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
diff --git a/arch/powerpc/kernel/pmc.c b/arch/powerpc/kernel/pmc.c
index ea04e0a..0516e2d 100644
--- a/arch/powerpc/kernel/pmc.c
+++ b/arch/powerpc/kernel/pmc.c
@@ -26,7 +26,7 @@
 
 static void dummy_perf(struct pt_regs *regs)
 {
-#if defined(CONFIG_FSL_BOOKE) && !defined(CONFIG_E200)
+#if defined(CONFIG_FSL_EMB_PERFMON)
 	mtpmr(PMRN_PMGC0, mfpmr(PMRN_PMGC0) & ~PMGC0_PMIE);
 #elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
 	if (cur_cpu_spec->pmc_type == PPC_PMC_IBM)
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index c5f64c3..2ef6b0d 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -15,5 +15,5 @@ oprofile-$(CONFIG_OPROFILE_CELL) += op_model_cell.o \
 		cell/spu_profiler.o cell/vma_map.o \
 		cell/spu_task_sync.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o op_model_pa6t.o
-oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
+oprofile-$(CONFIG_FSL_EMB_PERFMON) += op_model_fsl_emb.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index a28cce1..4908dc9 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -202,9 +202,9 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 			model = &op_model_7450;
 			break;
 #endif
-#ifdef CONFIG_FSL_BOOKE
-		case PPC_OPROFILE_BOOKE:
-			model = &op_model_fsl_booke;
+#if defined(CONFIG_FSL_EMB_PERFMON)
+		case PPC_OPROFILE_FSL_EMB:
+			model = &op_model_fsl_emb;
 			break;
 #endif
 		default:
diff --git a/arch/powerpc/oprofile/op_model_fsl_booke.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
similarity index 91%
rename from arch/powerpc/oprofile/op_model_fsl_booke.c
rename to arch/powerpc/oprofile/op_model_fsl_emb.c
index 183a28b..91596f6 100644
--- a/arch/powerpc/oprofile/op_model_fsl_booke.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -1,7 +1,5 @@
 /*
- * arch/powerpc/oprofile/op_model_fsl_booke.c
- *
- * Freescale Book-E oprofile support, based on ppc64 oprofile support
+ * Freescale Embedded oprofile support, based on ppc64 oprofile support
  * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
  *
  * Copyright (c) 2004 Freescale Semiconductor, Inc
@@ -22,7 +20,7 @@
 #include <asm/system.h>
 #include <asm/processor.h>
 #include <asm/cputable.h>
-#include <asm/reg_booke.h>
+#include <asm/reg_fsl_emb.h>
 #include <asm/page.h>
 #include <asm/pmc.h>
 #include <asm/oprofile_impl.h>
@@ -244,7 +242,7 @@ static void dump_pmcs(void)
 			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
 }
 
-static int fsl_booke_cpu_setup(struct op_counter_config *ctr)
+static int fsl_emb_cpu_setup(struct op_counter_config *ctr)
 {
 	int i;
 
@@ -262,7 +260,7 @@ static int fsl_booke_cpu_setup(struct op_counter_config *ctr)
 	return 0;
 }
 
-static int fsl_booke_reg_setup(struct op_counter_config *ctr,
+static int fsl_emb_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
 			     int num_ctrs)
 {
@@ -281,7 +279,7 @@ static int fsl_booke_reg_setup(struct op_counter_config *ctr,
 	return 0;
 }
 
-static int fsl_booke_start(struct op_counter_config *ctr)
+static int fsl_emb_start(struct op_counter_config *ctr)
 {
 	int i;
 
@@ -315,7 +313,7 @@ static int fsl_booke_start(struct op_counter_config *ctr)
 	return 0;
 }
 
-static void fsl_booke_stop(void)
+static void fsl_emb_stop(void)
 {
 	/* freeze counters */
 	pmc_stop_ctrs();
@@ -329,7 +327,7 @@ static void fsl_booke_stop(void)
 }
 
 
-static void fsl_booke_handle_interrupt(struct pt_regs *regs,
+static void fsl_emb_handle_interrupt(struct pt_regs *regs,
 				    struct op_counter_config *ctr)
 {
 	unsigned long pc;
@@ -362,10 +360,10 @@ static void fsl_booke_handle_interrupt(struct pt_regs *regs,
 	pmc_start_ctrs(1);
 }
 
-struct op_powerpc_model op_model_fsl_booke = {
-	.reg_setup		= fsl_booke_reg_setup,
-	.cpu_setup		= fsl_booke_cpu_setup,
-	.start			= fsl_booke_start,
-	.stop			= fsl_booke_stop,
-	.handle_interrupt	= fsl_booke_handle_interrupt,
+struct op_powerpc_model op_model_fsl_emb = {
+	.reg_setup		= fsl_emb_reg_setup,
+	.cpu_setup		= fsl_emb_cpu_setup,
+	.start			= fsl_emb_start,
+	.stop			= fsl_emb_stop,
+	.handle_interrupt	= fsl_emb_handle_interrupt,
 };
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7fc4110..eea2e70 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -94,6 +94,7 @@ config 8xx
 	bool
 
 config E500
+	select FSL_EMB_PERFMON
 	bool
 
 config PPC_FPU
@@ -115,6 +116,9 @@ config FSL_BOOKE
 	depends on E200 || E500
 	default y
 
+config FSL_EMB_PERFMON
+	bool
+
 config PTE_64BIT
 	bool
 	depends on 44x || E500
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 528ef18..1e79673 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -46,7 +46,7 @@ enum powerpc_oprofile_type {
 	PPC_OPROFILE_RS64 = 1,
 	PPC_OPROFILE_POWER4 = 2,
 	PPC_OPROFILE_G4 = 3,
-	PPC_OPROFILE_BOOKE = 4,
+	PPC_OPROFILE_FSL_EMB = 4,
 	PPC_OPROFILE_CELL = 5,
 	PPC_OPROFILE_PA6T = 6,
 };
diff --git a/include/asm-powerpc/oprofile_impl.h b/include/asm-powerpc/oprofile_impl.h
index 938fefb..95035c6 100644
--- a/include/asm-powerpc/oprofile_impl.h
+++ b/include/asm-powerpc/oprofile_impl.h
@@ -54,7 +54,7 @@ struct op_powerpc_model {
 	int num_counters;
 };
 
-extern struct op_powerpc_model op_model_fsl_booke;
+extern struct op_powerpc_model op_model_fsl_emb;
 extern struct op_powerpc_model op_model_rs64;
 extern struct op_powerpc_model op_model_power4;
 extern struct op_powerpc_model op_model_7450;
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 2408a29..0d62389 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -18,6 +18,10 @@
 #include <asm/reg_booke.h>
 #endif /* CONFIG_BOOKE || CONFIG_40x */
 
+#ifdef CONFIG_FSL_EMB_PERFMON
+#include <asm/reg_fsl_emb.h>
+#endif
+
 #ifdef CONFIG_8xx
 #include <asm/reg_8xx.h>
 #endif /* CONFIG_8xx */
diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
index 0405ef4..cf54a3f 100644
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -9,68 +9,6 @@
 #ifndef __ASM_POWERPC_REG_BOOKE_H__
 #define __ASM_POWERPC_REG_BOOKE_H__
 
-#ifndef __ASSEMBLY__
-/* Performance Monitor Registers */
-#define mfpmr(rn)	({unsigned int rval; \
-			asm volatile("mfpmr %0," __stringify(rn) \
-				     : "=r" (rval)); rval;})
-#define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
-#endif /* __ASSEMBLY__ */
-
-/* Freescale Book E Performance Monitor APU Registers */
-#define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
-#define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
-#define PMRN_PMC2	0x012	/* Performance Monitor Counter 1 */
-#define PMRN_PMC3	0x013	/* Performance Monitor Counter 1 */
-#define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
-#define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
-#define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
-#define PMRN_PMLCA3	0x093	/* PM Local Control A3 */
-
-#define PMLCA_FC	0x80000000	/* Freeze Counter */
-#define PMLCA_FCS	0x40000000	/* Freeze in Supervisor */
-#define PMLCA_FCU	0x20000000	/* Freeze in User */
-#define PMLCA_FCM1	0x10000000	/* Freeze when PMM==1 */
-#define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
-#define PMLCA_CE	0x04000000	/* Condition Enable */
-
-#define PMLCA_EVENT_MASK 0x007f0000	/* Event field */
-#define PMLCA_EVENT_SHIFT	16
-
-#define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
-#define PMRN_PMLCB1	0x111	/* PM Local Control B1 */
-#define PMRN_PMLCB2	0x112	/* PM Local Control B2 */
-#define PMRN_PMLCB3	0x113	/* PM Local Control B3 */
-
-#define PMLCB_THRESHMUL_MASK	0x0700	/* Threshhold Multiple Field */
-#define PMLCB_THRESHMUL_SHIFT	8
-
-#define PMLCB_THRESHOLD_MASK	0x003f	/* Threshold Field */
-#define PMLCB_THRESHOLD_SHIFT	0
-
-#define PMRN_PMGC0	0x190	/* PM Global Control 0 */
-
-#define PMGC0_FAC	0x80000000	/* Freeze all Counters */
-#define PMGC0_PMIE	0x40000000	/* Interrupt Enable */
-#define PMGC0_FCECE	0x20000000	/* Freeze countes on
-					   Enabled Condition or
-					   Event */
-
-#define PMRN_UPMC0	0x000	/* User Performance Monitor Counter 0 */
-#define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
-#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 1 */
-#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 1 */
-#define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
-#define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
-#define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
-#define PMRN_UPMLCA3	0x083	/* User PM Local Control A3 */
-#define PMRN_UPMLCB0	0x100	/* User PM Local Control B0 */
-#define PMRN_UPMLCB1	0x101	/* User PM Local Control B1 */
-#define PMRN_UPMLCB2	0x102	/* User PM Local Control B2 */
-#define PMRN_UPMLCB3	0x103	/* User PM Local Control B3 */
-#define PMRN_UPMGC0	0x180	/* User PM Global Control 0 */
-
-
 /* Machine State Register (MSR) Fields */
 #define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
 #define MSR_SPE		(1<<25)	/* Enable SPE */
diff --git a/include/asm-powerpc/reg_fsl_emb.h b/include/asm-powerpc/reg_fsl_emb.h
new file mode 100644
index 0000000..1e180a5
--- /dev/null
+++ b/include/asm-powerpc/reg_fsl_emb.h
@@ -0,0 +1,72 @@
+/*
+ * Contains register definitions for the Freescale Embedded Performance
+ * Monitor.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_POWERPC_REG_FSL_EMB_H__
+#define __ASM_POWERPC_REG_FSL_EMB_H__
+
+#ifndef __ASSEMBLY__
+/* Performance Monitor Registers */
+#define mfpmr(rn)	({unsigned int rval; \
+			asm volatile("mfpmr %0," __stringify(rn) \
+				     : "=r" (rval)); rval;})
+#define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
+#endif /* __ASSEMBLY__ */
+
+/* Freescale Book E Performance Monitor APU Registers */
+#define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
+#define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
+#define PMRN_PMC2	0x012	/* Performance Monitor Counter 1 */
+#define PMRN_PMC3	0x013	/* Performance Monitor Counter 1 */
+#define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
+#define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
+#define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
+#define PMRN_PMLCA3	0x093	/* PM Local Control A3 */
+
+#define PMLCA_FC	0x80000000	/* Freeze Counter */
+#define PMLCA_FCS	0x40000000	/* Freeze in Supervisor */
+#define PMLCA_FCU	0x20000000	/* Freeze in User */
+#define PMLCA_FCM1	0x10000000	/* Freeze when PMM==1 */
+#define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
+#define PMLCA_CE	0x04000000	/* Condition Enable */
+
+#define PMLCA_EVENT_MASK 0x007f0000	/* Event field */
+#define PMLCA_EVENT_SHIFT	16
+
+#define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
+#define PMRN_PMLCB1	0x111	/* PM Local Control B1 */
+#define PMRN_PMLCB2	0x112	/* PM Local Control B2 */
+#define PMRN_PMLCB3	0x113	/* PM Local Control B3 */
+
+#define PMLCB_THRESHMUL_MASK	0x0700	/* Threshhold Multiple Field */
+#define PMLCB_THRESHMUL_SHIFT	8
+
+#define PMLCB_THRESHOLD_MASK	0x003f	/* Threshold Field */
+#define PMLCB_THRESHOLD_SHIFT	0
+
+#define PMRN_PMGC0	0x190	/* PM Global Control 0 */
+
+#define PMGC0_FAC	0x80000000	/* Freeze all Counters */
+#define PMGC0_PMIE	0x40000000	/* Interrupt Enable */
+#define PMGC0_FCECE	0x20000000	/* Freeze countes on
+					   Enabled Condition or
+					   Event */
+
+#define PMRN_UPMC0	0x000	/* User Performance Monitor Counter 0 */
+#define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
+#define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
+#define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
+#define PMRN_UPMLCA3	0x083	/* User PM Local Control A3 */
+#define PMRN_UPMLCB0	0x100	/* User PM Local Control B0 */
+#define PMRN_UPMLCB1	0x101	/* User PM Local Control B1 */
+#define PMRN_UPMLCB2	0x102	/* User PM Local Control B2 */
+#define PMRN_UPMLCB3	0x103	/* User PM Local Control B3 */
+#define PMRN_UPMGC0	0x180	/* User PM Global Control 0 */
+
+
+#endif /* __ASM_POWERPC_REG_FSL_EMB_H__ */
+#endif /* __KERNEL__ */
-- 
1.5.0.2.230.gfbe3d-dirty

Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:21 +1100
Subject: [PATCH 1/21] [POWERPC] Reworking machine check handling and Fix
	440/440A
Message-Id: <20071221043925.42B40DDE30@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a cputable function pointer for the CPU-side machine
check handling. The semantic is still the same as the old one,
the one in ppc_md. overrides the one in cputable, though
ultimately we'll want to change that so the CPU gets first.

This removes CONFIG_440A which was a problem for multiplatform
kernels and instead fixes up the IVOR at runtime from a setup_cpu
function. The "A" version of the machine check also tweaks the
regs->trap value to differenciate the 2 versions at the C level.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/cpu_setup_44x.S |    9 +++
 arch/powerpc/kernel/cputable.c      |  105 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_44x.S      |   14 +++-
 arch/powerpc/kernel/head_booke.h    |    2 
 arch/powerpc/kernel/traps.c         |   62 ++++++++++++++++-----
 arch/powerpc/platforms/44x/Kconfig  |    5 -
 arch/ppc/kernel/traps.c             |   98 ++++++++++++++++++++++-----------
 include/asm-powerpc/cputable.h      |   13 ++++
 include/asm-powerpc/ptrace.h        |    3 -
 include/asm-powerpc/reg_booke.h     |    3 -
 include/asm-ppc/reg_booke.h         |    2 
 11 files changed, 258 insertions(+), 58 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/cpu_setup_44x.S	2007-10-15 11:19:35.000000000 +1000
+++ linux-merge/arch/powerpc/kernel/cpu_setup_44x.S	2007-12-20 11:35:40.000000000 +1100
@@ -23,11 +23,20 @@ _GLOBAL(__setup_cpu_440epx)
 	mflr	r4
 	bl	__init_fpu_44x
 	bl	__plb_disable_wrp
+	bl	__fixup_440A_mcheck
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_440grx)
 	b	__plb_disable_wrp
+_GLOBAL(__setup_cpu_440gx)
+_GLOBAL(__setup_cpu_440spe)
+	b	__fixup_440A_mcheck
 
+ /* Temporary fixup for arch/ppc until we kill the whole thing */
+#ifndef CONFIG_PPC_MERGE
+_GLOBAL(__fixup_440A_mcheck)
+	blr
+#endif
 
 /* enable APU between CPU and FPU */
 _GLOBAL(__init_fpu_44x)
Index: linux-merge/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/cputable.c	2007-12-20 11:34:43.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/cputable.c	2007-12-20 11:35:40.000000000 +1100
@@ -33,7 +33,9 @@ EXPORT_SYMBOL(cur_cpu_spec);
 #ifdef CONFIG_PPC32
 extern void __setup_cpu_440ep(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -85,6 +87,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "power3",
 	},
 	{	/* Power3+ */
@@ -99,6 +102,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "power3",
 	},
 	{	/* Northstar */
@@ -113,6 +117,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* Pulsar */
@@ -127,6 +132,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* I-star */
@@ -141,6 +147,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* S-star */
@@ -155,6 +162,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
+		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* Power4 */
@@ -169,6 +177,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	},
 	{	/* Power4+ */
@@ -183,6 +192,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	},
 	{	/* PPC970 */
@@ -200,6 +210,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970FX */
@@ -217,6 +228,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970MP DD1.0 - no DEEPNAP, use regular 970 init */
@@ -234,6 +246,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970MP */
@@ -251,6 +264,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970GX */
@@ -267,6 +281,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* Power5 GR */
@@ -286,6 +301,7 @@ static struct cpu_spec __initdata cpu_sp
 		 */
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
+		.machine_check		= machine_check_generic,
 		.platform		= "power5",
 	},
 	{	/* Power5++ */
@@ -301,6 +317,7 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
+		.machine_check		= machine_check_generic,
 		.platform		= "power5+",
 	},
 	{	/* Power5 GS */
@@ -317,6 +334,7 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
+		.machine_check		= machine_check_generic,
 		.platform		= "power5+",
 	},
 	{	/* POWER6 in P5+ mode; 2.04-compliant processor */
@@ -327,6 +345,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
+		.machine_check		= machine_check_generic,
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -346,6 +365,7 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
 			POWER6_MMCRA_OTHER,
+		.machine_check		= machine_check_generic,
 		.platform		= "power6x",
 	},
 	{	/* 2.05-compliant processor, i.e. Power6 "architected" mode */
@@ -356,6 +376,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
+		.machine_check		= machine_check_generic,
 		.platform		= "power6",
 	},
 	{	/* Cell Broadband Engine */
@@ -372,6 +393,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/cell-be",
 		.oprofile_type		= PPC_OPROFILE_CELL,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* PA Semi PA6T */
@@ -388,6 +410,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_pa6t,
 		.oprofile_cpu_type	= "ppc64/pa6t",
 		.oprofile_type		= PPC_OPROFILE_PA6T,
+		.machine_check		= machine_check_generic,
 		.platform		= "pa6t",
 	},
 	{	/* default match */
@@ -400,6 +423,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_IBM,
+		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC64 */
@@ -414,6 +438,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc601",
 	},
 	{	/* 603 */
@@ -425,6 +450,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* 603e */
@@ -436,6 +462,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* 603ev */
@@ -447,6 +474,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* 604 */
@@ -459,6 +487,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 2,
 		.cpu_setup		= __setup_cpu_604,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc604",
 	},
 	{	/* 604e */
@@ -471,6 +500,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_604,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc604",
 	},
 	{	/* 604r */
@@ -483,6 +513,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_604,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc604",
 	},
 	{	/* 604ev */
@@ -495,6 +526,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_604,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc604",
 	},
 	{	/* 740/750 (0x4202, don't support TAU ?) */
@@ -507,6 +539,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750CX (80100 and 8010x?) */
@@ -519,6 +552,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750CX (82201 and 82202) */
@@ -531,6 +565,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750CXe (82214) */
@@ -543,6 +578,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750CXe "Gekko" (83214) */
@@ -555,6 +591,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750CL */
@@ -567,6 +604,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 745/755 */
@@ -579,6 +617,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750FX rev 1.x */
@@ -591,6 +630,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750FX rev 2.0 must disable HID0[DPM] */
@@ -603,6 +643,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750FX (All revs except 2.0) */
@@ -615,6 +656,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750fx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 750GX */
@@ -627,6 +669,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750fx,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 740/750 (L2CR bit need fixup for 740) */
@@ -639,6 +682,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
 	{	/* 7400 rev 1.1 ? (no TAU) */
@@ -652,6 +696,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_7400,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
 	},
 	{	/* 7400 */
@@ -665,6 +710,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_7400,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
 	},
 	{	/* 7410 */
@@ -678,6 +724,7 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_7410,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
 	},
 	{	/* 7450 2.0 - no doze/nap */
@@ -693,6 +740,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.1 */
@@ -708,6 +756,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.3 and newer */
@@ -723,6 +772,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 1.x */
@@ -738,6 +788,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 2.0 */
@@ -753,6 +804,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 others */
@@ -768,6 +820,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.0 */
@@ -783,6 +836,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.1 */
@@ -798,6 +852,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.2 and later */
@@ -812,6 +867,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447A */
@@ -827,6 +883,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 7448 */
@@ -842,6 +899,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc7450",
 	},
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
@@ -853,6 +911,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* All G2_LE (603e core, plus some) have the same pvr */
@@ -864,6 +923,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* e300c1 (a 603e core, plus some) on 83xx */
@@ -875,6 +935,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* e300c2 (an e300c1 core, plus some, minus FPU) on 83xx */
@@ -886,6 +947,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* e300c3 (e300c1, plus one IU, half cache size) on 83xx */
@@ -908,6 +970,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_603,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
@@ -918,6 +981,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
 #endif /* CLASSIC_PPC */
@@ -944,6 +1008,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc403",
 	},
 	{	/* 403GCX */
@@ -955,6 +1020,7 @@ static struct cpu_spec __initdata cpu_sp
 		 	PPC_FEATURE_HAS_MMU | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc403",
 	},
 	{	/* 403G ?? */
@@ -965,6 +1031,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc403",
 	},
 	{	/* 405GP */
@@ -976,6 +1043,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* STB 03xxx */
@@ -987,6 +1055,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* STB 04xxx */
@@ -998,6 +1067,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* NP405L */
@@ -1009,6 +1079,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* NP4GS3 */
@@ -1020,6 +1091,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{   /* NP405H */
@@ -1031,6 +1103,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* 405GPr */
@@ -1042,6 +1115,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{   /* STBx25xx */
@@ -1053,6 +1127,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* 405LP */
@@ -1063,6 +1138,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* Xilinx Virtex-II Pro  */
@@ -1074,6 +1150,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* Xilinx Virtex-4 FX */
@@ -1085,6 +1162,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* 405EP */
@@ -1096,6 +1174,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 	{	/* 405EX */
@@ -1107,6 +1186,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
 
@@ -1120,6 +1200,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
@@ -1131,6 +1212,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{
@@ -1141,6 +1223,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
@@ -1152,6 +1235,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440ep,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{ /* 440GRX */
@@ -1163,6 +1247,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440grx,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{ /* Use logical PVR for 440EPx (logical pvr = pvr | 0x8) */
@@ -1174,6 +1259,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_440epx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. B */
@@ -1184,6 +1270,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440gp",
 	},
 	{	/* 440GP Rev. C */
@@ -1194,6 +1281,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440gp",
 	},
 	{ /* 440GX Rev. A */
@@ -1204,6 +1292,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. B */
@@ -1214,6 +1304,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. C */
@@ -1224,6 +1316,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. F */
@@ -1234,6 +1328,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440gx,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* 440SP Rev. A */
@@ -1244,6 +1340,7 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
 	{ /* 440SPe Rev. A */
@@ -1254,6 +1351,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features      = COMMON_USER_BOOKE,
 		.icache_bsize           = 32,
 		.dcache_bsize           = 32,
+		.cpu_setup		= __setup_cpu_440spe,
+		.machine_check		= machine_check_440A,
 		.platform               = "ppc440",
 	},
 	{ /* 440SPe Rev. B */
@@ -1264,6 +1363,8 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440spe,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 #endif /* CONFIG_44x */
@@ -1278,6 +1379,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
 	},
 	{	/* e200z6 */
@@ -1291,6 +1393,7 @@ static struct cpu_spec __initdata cpu_sp
 			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_UNIFIED_CACHE,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
 	},
 	{	/* e500 */
@@ -1307,6 +1410,7 @@ static struct cpu_spec __initdata cpu_sp
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
 		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.machine_check		= machine_check_e500,
 		.platform		= "ppc8540",
 	},
 	{	/* e500v2 */
@@ -1324,6 +1428,7 @@ static struct cpu_spec __initdata cpu_sp
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
 		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
 #endif
Index: linux-merge/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/head_44x.S	2007-12-11 15:07:22.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/head_44x.S	2007-12-20 11:35:40.000000000 +1100
@@ -289,11 +289,8 @@ interrupt_base:
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
-#ifdef CONFIG_440A
-	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#else
 	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#endif
+	MCHECK_EXCEPTION(0x0210, MachineCheckA, machine_check_exception)
 
 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
@@ -674,6 +671,15 @@ finish_tlb_load:
  */
 
 /*
+ * Adjust the machine check IVOR on 440A cores
+ */
+_GLOBAL(__fixup_440A_mcheck)
+	li	r3,MachineCheckA@l
+	mtspr	SPRN_IVOR1,r3
+	sync
+	blr
+
+/*
  * extern void giveup_altivec(struct task_struct *prev)
  *
  * The 44x core does not have an AltiVec unit.
Index: linux-merge/arch/powerpc/kernel/traps.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/traps.c	2007-12-20 11:34:43.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/traps.c	2007-12-20 11:35:40.000000000 +1100
@@ -334,18 +334,25 @@ static inline int check_io_access(struct
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
-static int generic_machine_check_exception(struct pt_regs *regs)
+#if defined(CONFIG_4xx)
+int machine_check_4xx(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
 
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
 		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
 	} else
 		printk("Data");
 	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
+
+	return 0;
+}
+
+int machine_check_440A(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	if (reason & ESR_IMCP){
 		printk("Instruction Synchronous Machine Check exception\n");
@@ -375,7 +382,13 @@ static int generic_machine_check_excepti
 		/* Clear MCSR */
 		mtspr(SPRN_MCSR, mcsr);
 	}
-#elif defined (CONFIG_E500)
+	return 0;
+}
+#elif defined(CONFIG_E500)
+int machine_check_e500(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -403,7 +416,14 @@ static int generic_machine_check_excepti
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
-#elif defined (CONFIG_E200)
+
+	return 0;
+}
+#elif defined(CONFIG_E200)
+int machine_check_e200(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -421,7 +441,14 @@ static int generic_machine_check_excepti
 		printk("Bus - Read Bus Error on data load\n");
 	if (reason & MCSR_BUS_WRERR)
 		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
+
+	return 0;
+}
+#else
+int machine_check_generic(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
 	switch (reason & 0x601F0000) {
@@ -451,22 +478,26 @@ static int generic_machine_check_excepti
 	default:
 		printk("Unknown values in msr\n");
 	}
-#endif /* CONFIG_4xx */
-
 	return 0;
 }
+#endif /* everything else */
 
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
 
-	/* See if any machine dependent calls */
+	/* See if any machine dependent calls. In theory, we would want
+	 * to call the CPU first, and call the ppc_md. one if the CPU
+	 * one returns a positive number. However there is existing code
+	 * that assumes the board gets a first chance, so let's keep it
+	 * that way for now and fix things later. --BenH.
+	 */
 	if (ppc_md.machine_check_exception)
 		recover = ppc_md.machine_check_exception(regs);
-	else
-		recover = generic_machine_check_exception(regs);
+	else if (cur_cpu_spec->machine_check)
+		recover = cur_cpu_spec->machine_check(regs);
 
-	if (recover)
+	if (recover > 0)
 		return;
 
 	if (user_mode(regs)) {
@@ -476,7 +507,12 @@ void machine_check_exception(struct pt_r
 	}
 
 #if defined(CONFIG_8xx) && defined(CONFIG_PCI)
-	/* the qspan pci read routines can cause machine checks -- Cort */
+	/* the qspan pci read routines can cause machine checks -- Cort
+	 *
+	 * yuck !!! that totally needs to go away ! There are better ways
+	 * to deal with that than having a wart in the mcheck handler.
+	 * -- BenH
+	 */
 	bad_page_fault(regs, regs->dar, SIGBUS);
 	return;
 #endif
Index: linux-merge/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/44x/Kconfig	2007-10-25 13:15:47.000000000 +1000
+++ linux-merge/arch/powerpc/platforms/44x/Kconfig	2007-12-20 11:36:04.000000000 +1100
@@ -62,11 +62,6 @@ config 440GX
 config 440SP
 	bool
 
-config 440A
-	bool
-	depends on 440GX || 440EPX
-	default y
-
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
Index: linux-merge/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/head_booke.h	2007-07-27 13:44:42.000000000 +1000
+++ linux-merge/arch/powerpc/kernel/head_booke.h	2007-12-20 11:35:40.000000000 +1100
@@ -166,7 +166,7 @@ label:
 	mfspr	r5,SPRN_ESR;					\
 	stw	r5,_ESR(r11);					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+	EXC_XFER_TEMPLATE(hdlr, n+4, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 			  NOCOPY, mcheck_transfer_to_handler,   \
 			  ret_from_mcheck_exc)
 
Index: linux-merge/include/asm-powerpc/ptrace.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/ptrace.h	2007-09-28 11:42:10.000000000 +1000
+++ linux-merge/include/asm-powerpc/ptrace.h	2007-12-20 11:35:40.000000000 +1100
@@ -106,7 +106,8 @@ extern int ptrace_put_reg(struct task_st
  */
 #define FULL_REGS(regs)		(((regs)->trap & 1) == 0)
 #ifndef __powerpc64__
-#define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) == 0)
+#define IS_CRITICAL_EXC(regs)	(((regs)->trap & 2) != 0)
+#define IS_MCHECK_EXC(regs)	(((regs)->trap & 4) != 0)
 #endif /* ! __powerpc64__ */
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
Index: linux-merge/include/asm-powerpc/reg_booke.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/reg_booke.h	2007-12-20 11:34:43.000000000 +1100
+++ linux-merge/include/asm-powerpc/reg_booke.h	2007-12-20 11:35:40.000000000 +1100
@@ -218,7 +218,6 @@
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
-#ifdef CONFIG_440A
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
 #define MCSR_DRB	0x20000000 /* Data Read PLB Error */
@@ -228,7 +227,7 @@
 #define MCSR_DCSP	0x02000000 /* D-Cache Search Parity Error */
 #define MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
 #define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
-#endif
+
 #ifdef CONFIG_E500
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
Index: linux-merge/include/asm-powerpc/cputable.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/cputable.h	2007-11-27 18:25:29.000000000 +1100
+++ linux-merge/include/asm-powerpc/cputable.h	2007-12-20 11:35:40.000000000 +1100
@@ -57,6 +57,14 @@ enum powerpc_pmc_type {
 	PPC_PMC_PA6T = 2,
 };
 
+struct pt_regs;
+
+extern int machine_check_generic(struct pt_regs *regs);
+extern int machine_check_4xx(struct pt_regs *regs);
+extern int machine_check_440A(struct pt_regs *regs);
+extern int machine_check_e500(struct pt_regs *regs);
+extern int machine_check_e200(struct pt_regs *regs);
+
 /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
@@ -97,6 +105,11 @@ struct cpu_spec {
 
 	/* Name of processor class, for the ELF AT_PLATFORM entry */
 	char		*platform;
+
+	/* Processor specific machine check handling. Return negative
+	 * if the error is fatal, 1 if it was fully recovered and 0 to
+	 * pass up (not CPU originated) */
+	int		(*machine_check)(struct pt_regs *regs);
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
Index: linux-merge/arch/ppc/kernel/traps.c
===================================================================
--- linux-merge.orig/arch/ppc/kernel/traps.c	2007-10-25 13:15:47.000000000 +1000
+++ linux-merge/arch/ppc/kernel/traps.c	2007-12-20 11:35:40.000000000 +1100
@@ -231,39 +231,25 @@ platform_machine_check(struct pt_regs *r
 {
 }
 
-void machine_check_exception(struct pt_regs *regs)
+#if defined(CONFIG_4xx)
+int machine_check_4xx(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
 
-	if (user_mode(regs)) {
-		regs->msr |= MSR_RI;
-		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		return;
-	}
-
-#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
-	/* the qspan pci read routines can cause machine checks -- Cort */
-	bad_page_fault(regs, regs->dar, SIGBUS);
-	return;
-#endif
-
-	if (debugger_fault_handler) {
-		debugger_fault_handler(regs);
-		regs->msr |= MSR_RI;
-		return;
-	}
-
-	if (check_io_access(regs))
-		return;
-
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
 		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
 	} else
 		printk("Data");
 	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
+
+	return 0;
+}
+
+int machine_check_440A(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	if (reason & ESR_IMCP){
 		printk("Instruction Synchronous Machine Check exception\n");
@@ -293,7 +279,13 @@ void machine_check_exception(struct pt_r
 		/* Clear MCSR */
 		mtspr(SPRN_MCSR, mcsr);
 	}
-#elif defined (CONFIG_E500)
+	return 0;
+}
+#elif defined(CONFIG_E500)
+int machine_check_e500(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -305,8 +297,6 @@ void machine_check_exception(struct pt_r
 		printk("Data Cache Push Parity Error\n");
 	if (reason & MCSR_DCPERR)
 		printk("Data Cache Parity Error\n");
-	if (reason & MCSR_GL_CI)
-		printk("Guarded Load or Cache-Inhibited stwcx.\n");
 	if (reason & MCSR_BUS_IAERR)
 		printk("Bus - Instruction Address Error\n");
 	if (reason & MCSR_BUS_RAERR)
@@ -318,12 +308,19 @@ void machine_check_exception(struct pt_r
 	if (reason & MCSR_BUS_RBERR)
 		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Write Data Bus Error\n");
+		printk("Bus - Read Data Bus Error\n");
 	if (reason & MCSR_BUS_IPERR)
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
-#elif defined (CONFIG_E200)
+
+	return 0;
+}
+#elif defined(CONFIG_E200)
+int machine_check_e200(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
 
@@ -341,7 +338,14 @@ void machine_check_exception(struct pt_r
 		printk("Bus - Read Bus Error on data load\n");
 	if (reason & MCSR_BUS_WRERR)
 		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
+
+	return 0;
+}
+#else
+int machine_check_generic(struct pt_regs *regs)
+{
+	unsigned long reason = get_mc_reason(regs);
+
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
 	switch (reason & 0x601F0000) {
@@ -371,7 +375,39 @@ void machine_check_exception(struct pt_r
 	default:
 		printk("Unknown values in msr\n");
 	}
-#endif /* CONFIG_4xx */
+	return 0;
+}
+#endif /* everything else */
+
+void machine_check_exception(struct pt_regs *regs)
+{
+	int recover = 0;
+
+	if (cur_cpu_spec->machine_check)
+		recover = cur_cpu_spec->machine_check(regs);
+	if (recover > 0)
+		return;
+
+	if (user_mode(regs)) {
+		regs->msr |= MSR_RI;
+		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
+		return;
+	}
+
+#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
+	/* the qspan pci read routines can cause machine checks -- Cort */
+	bad_page_fault(regs, regs->dar, SIGBUS);
+	return;
+#endif
+
+	if (debugger_fault_handler) {
+		debugger_fault_handler(regs);
+		regs->msr |= MSR_RI;
+		return;
+	}
+
+	if (check_io_access(regs))
+		return;
 
 	/*
 	 * Optional platform-provided routine to print out
Index: linux-merge/include/asm-ppc/reg_booke.h
===================================================================
--- linux-merge.orig/include/asm-ppc/reg_booke.h	2007-09-28 11:42:10.000000000 +1000
+++ linux-merge/include/asm-ppc/reg_booke.h	2007-12-20 11:35:40.000000000 +1100
@@ -207,7 +207,7 @@
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
-#ifdef CONFIG_440A
+#ifdef CONFIG_44x
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
 #define MCSR_DRB	0x20000000 /* Data Read PLB Error */

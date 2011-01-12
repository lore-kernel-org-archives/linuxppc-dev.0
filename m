Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:52:31 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 9/9] powerpc: machine_check_generic is wrong on 64bit
Message-ID: <20110112165231.09353a8c@kryten>
In-Reply-To: <20110112164318.753a435b@kryten>
References: <20110112164318.753a435b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Decoding machine checks is CPU specific and so machine_check_generic doesn't
do the right thing on 64bit chips. Luckily we never call into this code
because we call ppc_md.machine_check_exception instead if available.

Since we check cur_cpu_spec->machine_check before calling it, we may as
well remove machine_check_generic from 64bit archs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/cputable.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/cputable.c	2011-01-07 12:50:52.020438276 +1100
+++ powerpc.git/arch/powerpc/kernel/cputable.c	2011-01-11 13:46:52.891452379 +1100
@@ -116,7 +116,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "power3",
 	},
 	{	/* Power3+ */
@@ -132,7 +131,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "power3",
 	},
 	{	/* Northstar */
@@ -148,7 +146,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* Pulsar */
@@ -164,7 +161,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* I-star */
@@ -180,7 +176,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* S-star */
@@ -196,7 +191,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
-		.machine_check		= machine_check_generic,
 		.platform		= "rs64",
 	},
 	{	/* Power4 */
@@ -212,7 +206,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	},
 	{	/* Power4+ */
@@ -228,7 +221,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	},
 	{	/* PPC970 */
@@ -247,7 +239,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970FX */
@@ -266,7 +257,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970MP DD1.0 - no DEEPNAP, use regular 970 init */
@@ -285,7 +275,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970MP */
@@ -304,7 +293,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* PPC970GX */
@@ -322,7 +310,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc970",
 	},
 	{	/* Power5 GR */
@@ -343,7 +330,6 @@ static struct cpu_spec __initdata cpu_sp
 		 */
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
-		.machine_check		= machine_check_generic,
 		.platform		= "power5",
 	},
 	{	/* Power5++ */
@@ -360,7 +346,6 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
-		.machine_check		= machine_check_generic,
 		.platform		= "power5+",
 	},
 	{	/* Power5 GS */
@@ -378,7 +363,6 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
-		.machine_check		= machine_check_generic,
 		.platform		= "power5+",
 	},
 	{	/* POWER6 in P5+ mode; 2.04-compliant processor */
@@ -390,7 +374,6 @@ static struct cpu_spec __initdata cpu_sp
 		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.machine_check		= machine_check_generic,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5+",
@@ -413,7 +396,6 @@ static struct cpu_spec __initdata cpu_sp
 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
 			POWER6_MMCRA_OTHER,
-		.machine_check		= machine_check_generic,
 		.platform		= "power6x",
 	},
 	{	/* 2.05-compliant processor, i.e. Power6 "architected" mode */
@@ -425,7 +407,6 @@ static struct cpu_spec __initdata cpu_sp
 		.mmu_features		= MMU_FTR_HPTE_TABLE,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.machine_check		= machine_check_generic,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power6",
@@ -440,7 +421,6 @@ static struct cpu_spec __initdata cpu_sp
 			MMU_FTR_TLBIE_206,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.machine_check		= machine_check_generic,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.platform		= "power7",
@@ -482,7 +462,6 @@ static struct cpu_spec __initdata cpu_sp
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/cell-be",
 		.oprofile_type		= PPC_OPROFILE_CELL,
-		.machine_check		= machine_check_generic,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* PA Semi PA6T */
@@ -500,7 +479,6 @@ static struct cpu_spec __initdata cpu_sp
 		.cpu_restore		= __restore_cpu_pa6t,
 		.oprofile_cpu_type	= "ppc64/pa6t",
 		.oprofile_type		= PPC_OPROFILE_PA6T,
-		.machine_check		= machine_check_generic,
 		.platform		= "pa6t",
 	},
 	{	/* default match */
@@ -514,7 +492,6 @@ static struct cpu_spec __initdata cpu_sp
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_IBM,
-		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC_BOOK3S_64 */

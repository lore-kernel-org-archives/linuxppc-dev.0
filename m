Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C709DDE3EA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 19:14:02 +1100 (EST)
Date: Thu, 25 Jan 2007 02:19:51 -0600
To: paulus@samba.org
Subject: [PATCH] [2/4] powerpc: Add PMC type to cputable
Message-ID: <20070125081951.GC10716@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add cputable entries for which type of PMC implementation the processor
has.

I've only filled in the current 64-bit processors, the unfilled default
value will have same behaviour as before so it can be done over time
as needed.

Also tidy up the dummy_perf implementation a bit, aggregating it into
one function with ifdefs instead of several.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/kernel/pmc.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/pmc.c
+++ powerpc/arch/powerpc/kernel/pmc.c
@@ -19,38 +19,21 @@
 #include <asm/processor.h>
 #include <asm/pmc.h>
 
-#if defined(CONFIG_FSL_BOOKE) && !defined(CONFIG_E200)
-static void dummy_perf(struct pt_regs *regs)
-{
-	unsigned int pmgc0 = mfpmr(PMRN_PMGC0);
-
-	pmgc0 &= ~PMGC0_PMIE;
-	mtpmr(PMRN_PMGC0, pmgc0);
-}
-#elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
-
-#ifndef MMCR0_PMAO
-#define MMCR0_PMAO	0
+#ifndef MMCR0_PMA0
+#define MMCR0_PMA0	0
 #endif
 
-/* Ensure exceptions are disabled */
 static void dummy_perf(struct pt_regs *regs)
 {
-	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
-
-	mmcr0 &= ~(MMCR0_PMXE|MMCR0_PMAO);
-	mtspr(SPRN_MMCR0, mmcr0);
-}
+#if defined(CONFIG_FSL_BOOKE) && !defined(CONFIG_E200)
+	mtpmr(PMRN_PMGC0, mfpmr(PMRN_PMGC0) & ~PMGC0_PMIE);
+#elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMA0));
 #else
-/* Ensure exceptions are disabled */
-static void dummy_perf(struct pt_regs *regs)
-{
-	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
-
-	mmcr0 &= ~(MMCR0_PMXE);
-	mtspr(SPRN_MMCR0, mmcr0);
-}
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_PMXE);
 #endif
+}
+
 
 static DEFINE_SPINLOCK(pmc_owner_lock);
 static void *pmc_owner_caller; /* mostly for debugging */
Index: powerpc/include/asm-powerpc/cputable.h
===================================================================
--- powerpc.orig/include/asm-powerpc/cputable.h
+++ powerpc/include/asm-powerpc/cputable.h
@@ -50,6 +50,12 @@ enum powerpc_oprofile_type {
 	PPC_OPROFILE_CELL = 5,
 };
 
+enum powerpc_pmc_type {
+	PPC_PMC_DEFAULT = 0,
+	PPC_PMC_IBM = 1,
+	PPC_PMC_PA6T = 2,
+};
+
 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
 	unsigned int	pvr_mask;
@@ -65,6 +71,7 @@ struct cpu_spec {
 
 	/* number of performance monitor counters */
 	unsigned int	num_pmcs;
+	enum powerpc_pmc_type pmc_type;
 
 	/* this is called to initialize various CPU bits like L1 cache,
 	 * BHT, SPD, etc... from head.S before branching to identify_machine
Index: powerpc/arch/powerpc/kernel/cputable.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/cputable.c
+++ powerpc/arch/powerpc/kernel/cputable.c
@@ -86,6 +86,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -99,6 +100,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -112,6 +114,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -125,6 +128,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -138,6 +142,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -151,6 +156,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -164,6 +170,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -177,6 +184,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -191,6 +199,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
@@ -207,6 +216,8 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
@@ -239,6 +250,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
@@ -253,6 +265,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power5",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		/* SIHV / SIPR bits are implemented on POWER4+ (GQ)
@@ -271,6 +284,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power5+",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= MMCRA_SIHV,
@@ -321,6 +335,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power6",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
  		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
@@ -340,6 +355,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/cell-be",
 		.oprofile_type		= PPC_OPROFILE_CELL,
 		.platform		= "ppc-cell-be",
@@ -353,6 +369,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_PA6T,
 		.platform		= "pa6t",
 	},
 	{	/* default match */
@@ -364,6 +381,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC64 */

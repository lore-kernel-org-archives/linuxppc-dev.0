Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18180.27001.959843.273645@cargo.ozlabs.ibm.com>
Date: Thu, 4 Oct 2007 14:18:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix performance monitor on machines with logical PVR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some IBM machines supply a "logical" PVR (processor version register)
value in the device tree in the cpu nodes rather than the real PVR.
This is used for instance to indicate that the processors in a POWER6
partition have been configured by the hypervisor to run in POWER5+
mode rather than POWER6 mode.  To cope with this, we call identify_cpu
a second time with the logical PVR value (the first call is with the
real PVR value in the very early setup code).

However, POWER5+ machines can also supply a logical PVR value, and use
the same value (the value that indicates a v2.04 architecture
compliant processor).  This causes problems for code that uses the
performance monitor (such as oprofile), because the PMU registers are
different in POWER6 (even in POWER5+ mode) from the real POWER5+.

This change works around this problem by taking out the PMU
information from the cputable entries for the logical PVR values, and
changing identify_cpu so that the second call to it won't overwrite
the PMU information that was established by the first call (the one
with the real PVR), but does update the other fields.

So that we can create a mixed cputable entry, we now make cur_cpu_spec
point to a single static struct cpu_spec, and copy stuff from
cpu_specs[i] into it.  This has the side-effect that we can now make
cpu_specs[] be initdata.

Signed-off-by: Paul Mackerras <paulus@samba.org>

---
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b03a442..8662cf0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -71,7 +71,7 @@ extern void __restore_cpu_ppc970(void);
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
-static struct cpu_spec cpu_specs[] = {
+static struct cpu_spec __initdata cpu_specs[] = {
 #ifdef CONFIG_PPC64
 	{	/* Power3 */
 		.pvr_mask		= 0xffff0000,
@@ -327,14 +327,6 @@ static struct cpu_spec cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.num_pmcs		= 6,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power6",
-		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
-		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
-		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
-			POWER6_MMCRA_OTHER,
 		.platform		= "power5+",
 	},
 	{	/* Power6 */
@@ -364,14 +356,6 @@ static struct cpu_spec cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.num_pmcs		= 6,
-		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power6",
-		.oprofile_type		= PPC_OPROFILE_POWER4,
- 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
- 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
- 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
- 			POWER6_MMCRA_OTHER,
 		.platform		= "power6",
 	},
 	{	/* Cell Broadband Engine */
@@ -1316,18 +1300,37 @@ static struct cpu_spec cpu_specs[] = {
 #endif /* CONFIG_PPC32 */
 };
 
-struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr)
+static struct cpu_spec the_cpu_spec;
+
+struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 {
 	struct cpu_spec *s = cpu_specs;
-	struct cpu_spec **cur = &cur_cpu_spec;
+	struct cpu_spec *t = &the_cpu_spec;
 	int i;
 
 	s = PTRRELOC(s);
-	cur = PTRRELOC(cur);
+	t = PTRRELOC(t);
 
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
 		if ((pvr & s->pvr_mask) == s->pvr_value) {
-			*cur = cpu_specs + i;
+			/*
+			 * If we are overriding a previous value derived
+			 * from the real PVR with a new value obtained
+			 * using a logical PVR value, don't modify the
+			 * performance monitor fields.
+			 */
+			if (t->num_pmcs && !s->num_pmcs) {
+				t->cpu_name = s->cpu_name;
+				t->cpu_features = s->cpu_features;
+				t->cpu_user_features = s->cpu_user_features;
+				t->icache_bsize = s->icache_bsize;
+				t->dcache_bsize = s->dcache_bsize;
+				t->cpu_setup = s->cpu_setup;
+				t->cpu_restore = s->cpu_restore;
+				t->platform = s->platform;
+			} else
+				*t = *s;
+			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
 			/* ppc64 and booke expect identify_cpu to also call 
 			 * setup_cpu for that processor. I will consolidate

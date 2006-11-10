Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.18605.290921.614022@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 20:38:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Distinguish POWER6 partition modes and tell userspace
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds code to look at the properties firmware puts in the device
tree to determine what compatibility mode the partition is in on
POWER6 machines, and set the ELF aux vector AT_HWCAP and AT_PLATFORM
entries appropriately.

Specifically, we look at the cpu-version property in the cpu node(s).
If that contains a "logical" PVR value (of the form 0x0f00000x), we
call identify_cpu again with this PVR value.  A value of 0x0f000000
indicates the partition is in POWER5+ compatibility mode, and a value
of 0x0f000001 indicates "POWER6 architected" mode, with various
extensions disabled.  We also look for various other properties:
ibm,dfp, ibm,purr and ibm,spurr.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index bfd499e..20025ed 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -276,10 +276,45 @@ static struct cpu_spec cpu_specs[] = {
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
 		.platform		= "power5+",
 	},
+	{	/* POWER6 in P5+ mode; 2.04-compliant processor */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000000,
+		.cpu_name		= "POWER5+",
+		.cpu_features		= CPU_FTRS_POWER5,
+		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.oprofile_cpu_type	= "ppc64/power6",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+ 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
+ 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
+ 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
+ 			POWER6_MMCRA_OTHER,
+		.platform		= "power5+",
+	},
 	{	/* Power6 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003e0000,
-		.cpu_name		= "POWER6",
+		.cpu_name		= "POWER6 (raw)",
+		.cpu_features		= CPU_FTRS_POWER6,
+		.cpu_user_features	= COMMON_USER_POWER6 |
+			PPC_FEATURE_POWER6_EXT,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.oprofile_cpu_type	= "ppc64/power6",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+ 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
+ 		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
+ 		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
+ 			POWER6_MMCRA_OTHER,
+		.platform		= "power6x",
+	},
+	{	/* 2.05-compliant processor, i.e. Power6 "architected" mode */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000001,
+		.cpu_name		= "POWER6 (architected)",
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6,
 		.icache_bsize		= 128,
@@ -1169,19 +1204,15 @@ static struct cpu_spec cpu_specs[] = {
 #endif /* CONFIG_PPC32 */
 };
 
-struct cpu_spec *identify_cpu(unsigned long offset)
+struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr)
 {
 	struct cpu_spec *s = cpu_specs;
 	struct cpu_spec **cur = &cur_cpu_spec;
-	unsigned int pvr = mfspr(SPRN_PVR);
 	int i;
 
 	s = PTRRELOC(s);
 	cur = PTRRELOC(cur);
 
-	if (*cur != NULL)
-		return PTRRELOC(*cur);
-
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
 		if ((pvr & s->pvr_mask) == s->pvr_value) {
 			*cur = cpu_specs + i;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bdb412d..75e06e3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -538,35 +538,31 @@ static struct ibm_pa_feature {
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
 };
 
-static void __init check_cpu_pa_features(unsigned long node)
+static void __init scan_features(unsigned long node, unsigned char *ftrs,
+				 unsigned long tablelen,
+				 struct ibm_pa_feature *fp,
+				 unsigned long ft_size)
 {
-	unsigned char *pa_ftrs;
-	unsigned long len, tablelen, i, bit;
-
-	pa_ftrs = of_get_flat_dt_prop(node, "ibm,pa-features", &tablelen);
-	if (pa_ftrs == NULL)
-		return;
+	unsigned long i, len, bit;
 
 	/* find descriptor with type == 0 */
 	for (;;) {
 		if (tablelen < 3)
 			return;
-		len = 2 + pa_ftrs[0];
+		len = 2 + ftrs[0];
 		if (tablelen < len)
 			return;		/* descriptor 0 not found */
-		if (pa_ftrs[1] == 0)
+		if (ftrs[1] == 0)
 			break;
 		tablelen -= len;
-		pa_ftrs += len;
+		ftrs += len;
 	}
 
 	/* loop over bits we know about */
-	for (i = 0; i < ARRAY_SIZE(ibm_pa_features); ++i) {
-		struct ibm_pa_feature *fp = &ibm_pa_features[i];
-
-		if (fp->pabyte >= pa_ftrs[0])
+	for (i = 0; i < ft_size; ++i, ++fp) {
+		if (fp->pabyte >= ftrs[0])
 			continue;
-		bit = (pa_ftrs[2 + fp->pabyte] >> (7 - fp->pabit)) & 1;
+		bit = (ftrs[2 + fp->pabyte] >> (7 - fp->pabit)) & 1;
 		if (bit ^ fp->invert) {
 			cur_cpu_spec->cpu_features |= fp->cpu_features;
 			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftrs;
@@ -577,16 +573,59 @@ static void __init check_cpu_pa_features
 	}
 }
 
+static void __init check_cpu_pa_features(unsigned long node)
+{
+	unsigned char *pa_ftrs;
+	unsigned long tablelen;
+
+	pa_ftrs = of_get_flat_dt_prop(node, "ibm,pa-features", &tablelen);
+	if (pa_ftrs == NULL)
+		return;
+
+	scan_features(node, pa_ftrs, tablelen,
+		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
+}
+
+static struct feature_property {
+	const char *name;
+	u32 min_value;
+	unsigned long cpu_feature;
+	unsigned long cpu_user_ftr;
+} feature_properties[] __initdata = {
+#ifdef CONFIG_ALTIVEC
+	{"altivec", 0, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
+	{"ibm,vmx", 1, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
+#endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+	{"ibm,dfp", 1, 0, PPC_FEATURE_HAS_DFP},
+	{"ibm,purr", 1, CPU_FTR_PURR, 0},
+	{"ibm,spurr", 1, CPU_FTR_SPURR, 0},
+#endif /* CONFIG_PPC64 */
+};
+
+static void __init check_cpu_feature_properties(unsigned long node)
+{
+	unsigned long i;
+	struct feature_property *fp = feature_properties;
+	const u32 *prop;
+
+	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
+		prop = of_get_flat_dt_prop(node, fp->name, NULL);
+		if (prop && *prop >= fp->min_value) {
+			cur_cpu_spec->cpu_features |= fp->cpu_feature;
+			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftr;
+		}
+	}
+}
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
 {
 	static int logical_cpuid = 0;
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-#ifdef CONFIG_ALTIVEC
-	u32 *prop;
-#endif
-	u32 *intserv;
+	const u32 *prop;
+	const u32 *intserv;
 	int i, nthreads;
 	unsigned long len;
 	int found = 0;
@@ -643,24 +682,27 @@ static int __init early_init_dt_scan_cpu
 			intserv[i]);
 		boot_cpuid = logical_cpuid;
 		set_hard_smp_processor_id(boot_cpuid, intserv[i]);
-	}
 
-#ifdef CONFIG_ALTIVEC
-	/* Check if we have a VMX and eventually update CPU features */
-	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,vmx", NULL);
-	if (prop && (*prop) > 0) {
-		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
-		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
-	}
-
-	/* Same goes for Apple's "altivec" property */
-	prop = (u32 *)of_get_flat_dt_prop(node, "altivec", NULL);
-	if (prop) {
-		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
-		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+		/*
+		 * PAPR defines "logical" PVR values for cpus that
+		 * meet various levels of the architecture:
+		 * 0x0f000000	Architecture version 2.04
+		 * 0x0f000001	Architecture version 2.05
+		 * If the cpu-version property in the cpu node contains
+		 * such a value, we call identify_cpu again with the
+		 * logical PVR value in order to use the cpu feature
+		 * bits appropriate for the architecture level.
+		 *
+		 * A POWER6 partition in "POWER6 architected" mode
+		 * uses the 0x0f000001 PVR value; in POWER5+ mode
+		 * it uses 0x0f000000.
+		 */
+		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
+		if (prop && (*prop & 0xff000000) == 0x0f000000)
+			identify_cpu(0, *prop);
 	}
-#endif /* CONFIG_ALTIVEC */
 
+	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index b917616..447d794 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -627,6 +627,7 @@ static void __init early_cmdline_parse(v
 /* Option vector 3: processor options supported */
 #define OV3_FP			0x80	/* floating point */
 #define OV3_VMX			0x40	/* VMX/Altivec */
+#define OV3_DFP			0x20	/* decimal FP */
 
 /* Option vector 5: PAPR/OF options supported */
 #define OV5_LPAR		0x80	/* logical partitioning supported */
@@ -668,7 +669,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 3: processor options supported */
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV3_FP | OV3_VMX,
+	OV3_FP | OV3_VMX | OV3_DFP,
 
 	/* option vector 4: IBM PAPR implementation */
 	2 - 2,				/* length */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a4c2964..f594079 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -101,7 +101,7 @@ unsigned long __init early_init(unsigned
 	 * Identify the CPU type and fix up code sections
 	 * that depend on which cpu we have.
 	 */
-	spec = identify_cpu(offset);
+	spec = identify_cpu(offset, mfspr(SPRN_PVR));
 
 	do_feature_fixups(spec->cpu_features,
 			  PTRRELOC(&__start___ftr_fixup),
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1627896..cc86287 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -171,7 +171,7 @@ void __init setup_paca(int cpu)
 void __init early_setup(unsigned long dt_ptr)
 {
 	/* Identify CPU type */
-	identify_cpu(0);
+	identify_cpu(0, mfspr(SPRN_PVR));
 
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
 	setup_paca(0);
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 27faeca..3c506af 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -313,7 +313,7 @@ early_init(int r3, int r4, int r5)
 	 * Identify the CPU type and fix up code sections
 	 * that depend on which cpu we have.
 	 */
-	spec = identify_cpu(offset);
+	spec = identify_cpu(offset, mfspr(SPRN_PVR));
 	do_feature_fixups(spec->cpu_features,
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index a9a4014..af157fd 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -24,6 +24,8 @@
 #define PPC_FEATURE_ICACHE_SNOOP	0x00002000
 #define PPC_FEATURE_ARCH_2_05		0x00001000
 #define PPC_FEATURE_PA6T		0x00000800
+#define PPC_FEATURE_HAS_DFP		0x00000400
+#define PPC_FEATURE_POWER6_EXT		0x00000200
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
@@ -91,7 +93,7 @@ extern struct cpu_spec		*cur_cpu_spec;
 
 extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 
-extern struct cpu_spec *identify_cpu(unsigned long offset);
+extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
 
@@ -148,6 +150,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
 #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
+#define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -332,7 +335,13 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE)
+#define CPU_FTRS_POWER6X (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
+	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | \
+	    CPU_FTR_SPURR | CPU_FTR_REAL_LE)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 6f73469..b8cffcd 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -697,7 +697,7 @@ void * __init iSeries_early_setup(void)
 	/* Identify CPU type. This is done again by the common code later
 	 * on but calling this function multiple times is fine.
 	 */
-	identify_cpu(0);
+	identify_cpu(0, mfspn(SPRN_PVR));
 
 	powerpc_firmware_features |= FW_FEATURE_ISERIES;
 	powerpc_firmware_features |= FW_FEATURE_LPAR;

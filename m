Return-Path: <galak@freescale.com>
Date: Tue, 27 Sep 2005 15:13:12 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509271511410.8012@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: make cur_cpu_spec a single pointer instead of an
 array on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If someone can test this on ppc32 and ppc32/SMP that would be helpful.  I 
tried this out on a 834x (603 core) and it works ok, but would like to 
make sure it works on pmac & pmac/SMP.  Also, this requires the previous 
patch that unifies cputable.h

- kumar

---

Changed ppc32 so that cur_cpu_spec is just a single pointer for all CPUs.
Additionally, made call_setup_cpu check to see if the cpu_setup pointer
is NULL or not before calling the function.  This lets remove the dummy
cpu_setup calls that just return.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 5624cf5d26b1c9318daceb92b605096cac58e206
tree 5ce3efa2a7c170406834f5d84786d1e1597cc87c
parent 1545c0ecc0c5f6bd96a1882e782f8a1f3c67179b
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 27 Sep 2005 15:11:13 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 27 Sep 2005 15:11:13 -0500

 arch/powerpc/kernel/head.S                   |    6 -----
 arch/powerpc/oprofile/common.c               |    6 ++---
 arch/powerpc/platforms/powermac/pmac_setup.c |    2 +-
 arch/ppc/kernel/cpu_setup_6xx.S              |    2 --
 arch/ppc/kernel/cpu_setup_power4.S           |    2 --
 arch/ppc/kernel/cputable.c                   |   33 ++++++++++----------------
 arch/ppc/kernel/head.S                       |    6 -----
 arch/ppc/kernel/misc.S                       |   22 ++++++++---------
 arch/ppc/kernel/setup.c                      |   14 ++++++-----
 arch/ppc/platforms/4xx/ebony.c               |    2 +-
 arch/ppc/platforms/pmac_setup.c              |    2 +-
 arch/ppc/platforms/radstone_ppc7d.c          |    8 +++---
 arch/ppc/syslib/ibm440gx_common.c            |    6 ++---
 include/asm-powerpc/cputable.h               |   16 -------------
 include/asm-powerpc/elf.h                    |    4 +--
 15 files changed, 43 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/kernel/head.S b/arch/powerpc/kernel/head.S
--- a/arch/powerpc/kernel/head.S
+++ b/arch/powerpc/kernel/head.S
@@ -1059,7 +1059,6 @@ __secondary_start:
 
 	lis	r3,-KERNELBASE@h
 	mr	r4,r24
-	bl	identify_cpu
 	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
 #ifdef CONFIG_6xx
 	lis	r3,-KERNELBASE@h
@@ -1109,11 +1108,6 @@ __secondary_start:
  * Those generic dummy functions are kept for CPUs not
  * included in CONFIG_6xx
  */
-_GLOBAL(__setup_cpu_power3)
-	blr
-_GLOBAL(__setup_cpu_generic)
-	blr
-
 #if !defined(CONFIG_6xx) && !defined(CONFIG_POWER4)
 _GLOBAL(__save_cpu_setup)
 	blr
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -155,8 +155,6 @@ static int op_powerpc_create_files(struc
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 #ifndef __powerpc64__
-	int cpu_id = smp_processor_id();
-
 #ifdef CONFIG_FSL_BOOKE
 	model = &op_model_fsl_booke;
 #else
@@ -167,9 +165,9 @@ int __init oprofile_arch_init(struct opr
 	if (NULL == cpu_type)
 		return -ENOMEM;
 
-	sprintf(cpu_type, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
+	sprintf(cpu_type, "ppc/%s", cur_cpu_spec->cpu_name);
 
-	model->num_counters = cur_cpu_spec[cpu_id]->num_pmcs;
+	model->num_counters = cur_cpu_spec->num_pmcs;
 
 	ops->cpu_type = cpu_type;
 #else /* __powerpc64__ */
diff --git a/arch/powerpc/platforms/powermac/pmac_setup.c b/arch/powerpc/platforms/powermac/pmac_setup.c
--- a/arch/powerpc/platforms/powermac/pmac_setup.c
+++ b/arch/powerpc/platforms/powermac/pmac_setup.c
@@ -445,7 +445,7 @@ static int pmac_pm_enter(suspend_state_t
 	enable_kernel_fp();
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
 		enable_kernel_altivec();
 #endif /* CONFIG_ALTIVEC */
 
diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S
+++ b/arch/ppc/kernel/cpu_setup_6xx.S
@@ -17,8 +17,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
-_GLOBAL(__setup_cpu_601)
-	blr
 _GLOBAL(__setup_cpu_603)
 	b	setup_common_caches
 _GLOBAL(__setup_cpu_604)
diff --git a/arch/ppc/kernel/cpu_setup_power4.S b/arch/ppc/kernel/cpu_setup_power4.S
--- a/arch/ppc/kernel/cpu_setup_power4.S
+++ b/arch/ppc/kernel/cpu_setup_power4.S
@@ -63,8 +63,6 @@ _GLOBAL(__970_cpu_preinit)
 	isync
 	blr
 
-_GLOBAL(__setup_cpu_power4)
-	blr
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -14,23 +14,22 @@
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <linux/init.h>
+#include <linux/module.h>
+
+#include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
 
-struct cpu_spec* cur_cpu_spec[NR_CPUS];
+struct cpu_spec* cur_cpu_spec = NULL;
 
-extern void __setup_cpu_601(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_603(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_604(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_750(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_750cx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_750fx(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_7400(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_7410(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_745x(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_power3(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_power4(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_ppc970(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-extern void __setup_cpu_generic(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
+extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_750cx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_750fx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
 		     !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
@@ -62,7 +61,6 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_UNIFIED_CACHE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_601
 	},
 	{	/* 603 */
 		.pvr_mask		= 0xffff0000,
@@ -451,7 +449,6 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_PPC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_generic
 	},
 #endif /* CLASSIC_PPC */
 #ifdef CONFIG_PPC64BRIDGE
@@ -464,7 +461,6 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3
 	},
 	{	/* Power3+ */
 		.pvr_mask		= 0xffff0000,
@@ -475,7 +471,6 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3
 	},
 	{	/* I-star */
 		.pvr_mask		= 0xffff0000,
@@ -486,7 +481,6 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3
 	},
 	{	/* S-star */
 		.pvr_mask		= 0xffff0000,
@@ -497,7 +491,6 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3
 	},
 #endif /* CONFIG_PPC64BRIDGE */
 #ifdef CONFIG_POWER4
diff --git a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S
+++ b/arch/ppc/kernel/head.S
@@ -1059,7 +1059,6 @@ __secondary_start:
 
 	lis	r3,-KERNELBASE@h
 	mr	r4,r24
-	bl	identify_cpu
 	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
 #ifdef CONFIG_6xx
 	lis	r3,-KERNELBASE@h
@@ -1109,11 +1108,6 @@ __secondary_start:
  * Those generic dummy functions are kept for CPUs not
  * included in CONFIG_6xx
  */
-_GLOBAL(__setup_cpu_power3)
-	blr
-_GLOBAL(__setup_cpu_generic)
-	blr
-
 #if !defined(CONFIG_6xx) && !defined(CONFIG_POWER4)
 _GLOBAL(__save_cpu_setup)
 	blr
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -125,9 +125,8 @@ _GLOBAL(identify_cpu)
 1:
 	addis	r6,r3,cur_cpu_spec@ha
 	addi	r6,r6,cur_cpu_spec@l
-	slwi	r4,r4,2
 	sub	r8,r8,r3
-	stwx	r8,r4,r6
+	stw	r8,0(r6)
 	blr
 
 /*
@@ -186,19 +185,18 @@ _GLOBAL(do_cpu_ftr_fixups)
  *
  * Setup function is called with:
  *   r3 = data offset
- *   r4 = CPU number
- *   r5 = ptr to CPU spec (relocated)
+ *   r4 = ptr to CPU spec (relocated)
  */
 _GLOBAL(call_setup_cpu)
-	addis	r5,r3,cur_cpu_spec@ha
-	addi	r5,r5,cur_cpu_spec@l
-	slwi	r4,r24,2
-	lwzx	r5,r4,r5
+	addis	r4,r3,cur_cpu_spec@ha
+	addi	r4,r4,cur_cpu_spec@l
+	lwz	r4,0(r4)
+	add	r4,r4,r3
+	lwz	r5,CPU_SPEC_SETUP(r4)
+	cmpi	0,r5,0
 	add	r5,r5,r3
-	lwz	r6,CPU_SPEC_SETUP(r5)
-	add	r6,r6,r3
-	mtctr	r6
-	mr	r4,r24
+	beqlr
+	mtctr	r5
 	bctr
 
 #if defined(CONFIG_CPU_FREQ_PMAC) && defined(CONFIG_6xx)
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -188,18 +188,18 @@ int show_cpuinfo(struct seq_file *m, voi
 	seq_printf(m, "processor\t: %d\n", i);
 	seq_printf(m, "cpu\t\t: ");
 
-	if (cur_cpu_spec[i]->pvr_mask)
-		seq_printf(m, "%s", cur_cpu_spec[i]->cpu_name);
+	if (cur_cpu_spec->pvr_mask)
+		seq_printf(m, "%s", cur_cpu_spec->cpu_name);
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[i]->cpu_features & CPU_FTR_ALTIVEC)
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
 		seq_printf(m, ", altivec supported");
 #endif
 	seq_printf(m, "\n");
 
 #ifdef CONFIG_TAU
-	if (cur_cpu_spec[i]->cpu_features & CPU_FTR_TAU) {
+	if (cur_cpu_spec->cpu_features & CPU_FTR_TAU) {
 #ifdef CONFIG_TAU_AVERAGE
 		/* more straightforward, but potentially misleading */
 		seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
@@ -754,12 +754,12 @@ void __init setup_arch(char **cmdline_p)
 	 * for a possibly more accurate value.
 	 */
 	if (cpu_has_feature(CPU_FTR_SPLIT_ID_CACHE)) {
-		dcache_bsize = cur_cpu_spec[0]->dcache_bsize;
-		icache_bsize = cur_cpu_spec[0]->icache_bsize;
+		dcache_bsize = cur_cpu_spec->dcache_bsize;
+		icache_bsize = cur_cpu_spec->icache_bsize;
 		ucache_bsize = 0;
 	} else
 		ucache_bsize = dcache_bsize = icache_bsize
-			= cur_cpu_spec[0]->dcache_bsize;
+			= cur_cpu_spec->dcache_bsize;
 
 	/* reboot on panic */
 	panic_timeout = 180;
diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c
+++ b/arch/ppc/platforms/4xx/ebony.c
@@ -91,7 +91,7 @@ ebony_calibrate_decr(void)
 	 * on Rev. C silicon then errata forces us to
 	 * use the internal clock.
 	 */
-	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GP Rev. B") == 0)
+	if (strcmp(cur_cpu_spec->cpu_name, "440GP Rev. B") == 0)
 		freq = EBONY_440GP_RB_SYSCLK;
 	else
 		freq = EBONY_440GP_RC_SYSCLK;
diff --git a/arch/ppc/platforms/pmac_setup.c b/arch/ppc/platforms/pmac_setup.c
--- a/arch/ppc/platforms/pmac_setup.c
+++ b/arch/ppc/platforms/pmac_setup.c
@@ -448,7 +448,7 @@ static int pmac_pm_enter(suspend_state_t
 	enable_kernel_fp();
 
 #ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
 		enable_kernel_altivec();
 #endif /* CONFIG_ALTIVEC */
 
diff --git a/arch/ppc/platforms/radstone_ppc7d.c b/arch/ppc/platforms/radstone_ppc7d.c
--- a/arch/ppc/platforms/radstone_ppc7d.c
+++ b/arch/ppc/platforms/radstone_ppc7d.c
@@ -1185,18 +1185,18 @@ static void __init ppc7d_setup_arch(void
 		ROOT_DEV = Root_HDA1;
 #endif
 
-	if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450) ||
-	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+	if ((cur_cpu_spec->cpu_features & CPU_FTR_SPEC7450) ||
+	    (cur_cpu_spec->cpu_features & CPU_FTR_L3CR))
 		/* 745x is different.  We only want to pass along enable. */
 		_set_L2CR(L2CR_L2E);
-	else if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR)
+	else if (cur_cpu_spec->cpu_features & CPU_FTR_L2CR)
 		/* All modules have 1MB of L2.  We also assume that an
 		 * L2 divisor of 3 will work.
 		 */
 		_set_L2CR(L2CR_L2E | L2CR_L2SIZ_1MB | L2CR_L2CLK_DIV3
 			  | L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);
 
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR)
+	if (cur_cpu_spec->cpu_features & CPU_FTR_L3CR)
 		/* No L3 cache */
 		_set_L3CR(0);
 
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -236,9 +236,9 @@ void __init ibm440gx_l2c_setup(struct ib
 	/* Disable L2C on rev.A, rev.B and 800MHz version of rev.C,
 	   enable it on all other revisions
 	 */
-	if (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. A") == 0 ||
-			strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. B") == 0
-			|| (strcmp(cur_cpu_spec[0]->cpu_name, "440GX Rev. C")
+	if (strcmp(cur_cpu_spec->cpu_name, "440GX Rev. A") == 0 ||
+			strcmp(cur_cpu_spec->cpu_name, "440GX Rev. B") == 0
+			|| (strcmp(cur_cpu_spec->cpu_name, "440GX Rev. C")
 				== 0 && p->cpu > 667000000))
 		ibm440gx_l2c_disable();
 	else
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -25,11 +25,7 @@
 struct cpu_spec;
 struct op_powerpc_model;
 
-#ifdef __powerpc64__
 typedef	void (*cpu_setup_t)(unsigned long offset, struct cpu_spec* spec);
-#else /* __powerpc64__ */
-typedef	void (*cpu_setup_t)(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
-#endif /* __powerpc64__ */
 
 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
@@ -51,23 +47,15 @@ struct cpu_spec {
 	 * BHT, SPD, etc... from head.S before branching to identify_machine
 	 */
 	cpu_setup_t	cpu_setup;
-#ifdef __powerpc64__
 
 	/* Used by oprofile userspace to select the right counters */
 	char		*oprofile_cpu_type;
 
 	/* Processor specific oprofile operations */
 	struct op_powerpc_model *oprofile_model;
-#endif /* __powerpc64__ */
 };
 
-extern struct cpu_spec		cpu_specs[];
-
-#ifdef __powerpc64__
 extern struct cpu_spec		*cur_cpu_spec;
-#else /* __powerpc64__ */
-extern struct cpu_spec		*cur_cpu_spec[];
-#endif /* __powerpc64__ */
 
 #endif /* __ASSEMBLY__ */
 
@@ -398,11 +386,7 @@ static inline int cpu_has_feature(unsign
 {
 	return (CPU_FTRS_ALWAYS & feature) ||
 	       (CPU_FTRS_POSSIBLE
-#ifndef __powerpc64__
-		& cur_cpu_spec[0]->cpu_features
-#else
 		& cur_cpu_spec->cpu_features
-#endif
 		& feature);
 }
 
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -212,15 +212,13 @@ extern int dump_task_fpu(struct task_str
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
-#ifdef __powerpc64__
 # define ELF_HWCAP	(cur_cpu_spec->cpu_user_features)
+#ifdef __powerpc64__
 # define ELF_PLAT_INIT(_r, load_addr)	do { \
 	memset(_r->gpr, 0, sizeof(_r->gpr)); \
 	_r->ctr = _r->link = _r->xer = _r->ccr = 0; \
 	_r->gpr[2] = load_addr; \
 } while (0)
-#else
-# define ELF_HWCAP	(cur_cpu_spec[0]->cpu_user_features)
 #endif /* __powerpc64__ */
 
 /* This yields a string that ld.so will use to load implementation

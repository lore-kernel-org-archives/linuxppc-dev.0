Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Aug 2008 14:23:51 +1000
Subject: [PATCH 2/2] powerpc: Make CPU sysfs PMC & cache topology used on
	32-bit
Message-Id: <20080818042425.5FD0CDDF0B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The file arch/powerpc/kernel/sysfs.c is currently only compiled
for 64-bit kernels. It contain code to register CPU sysdevs in
sysfs and add various properties such as cache topology and
raw access by root to PMCs. A lot of that can be re-used as
is on 32-bits.

This makes the file built for both, with appropriate ifdef'ing
for the few bits that are really 64-bit specific, and adds some
support for the raw PMCs for 75x and 74xx processors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/cputable.h     |    1 
 arch/powerpc/kernel/Makefile            |    4 -
 arch/powerpc/kernel/cputable.c          |   24 +++++++
 arch/powerpc/kernel/setup_32.c          |   11 ---
 arch/powerpc/kernel/sysfs.c             |  106 ++++++++++++++++++++++++++------
 arch/powerpc/oprofile/op_model_power4.c |    4 -
 6 files changed, 117 insertions(+), 33 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/Makefile	2008-08-12 13:13:58.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2008-08-18 12:43:43.000000000 +1000
@@ -27,13 +27,13 @@ endif
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   init_task.o process.o systbl.o idle.o \
-				   signal.o
+				   signal.o sysfs.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
 				   cpu_setup_pa6t.o \
-				   firmware.o sysfs.o nvram_64.o
+				   firmware.o nvram_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2008-07-28 09:48:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2008-08-18 12:43:43.000000000 +1000
@@ -610,6 +610,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750cx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -623,6 +624,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750cx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -636,6 +638,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750cx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -649,6 +652,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -662,6 +666,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -675,6 +680,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -688,6 +694,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -701,6 +708,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750fx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -714,6 +722,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750fx,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -727,6 +736,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
@@ -741,6 +751,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_7400,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
@@ -755,6 +766,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_7400,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
@@ -769,6 +781,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_7410,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc7400",
@@ -783,6 +796,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -799,6 +813,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -815,6 +830,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -831,6 +847,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -847,6 +864,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -863,6 +881,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -879,6 +898,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -895,6 +915,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -910,6 +931,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -926,6 +948,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
@@ -942,6 +965,7 @@ static struct cpu_spec __initdata cpu_sp
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= PPC_OPROFILE_G4,
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2008-07-24 14:05:58.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_32.c	2008-08-18 12:43:43.000000000 +1000
@@ -209,23 +209,12 @@ EXPORT_SYMBOL(nvram_sync);
 
 #endif /* CONFIG_NVRAM */
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
 int __init ppc_init(void)
 {
-	int cpu;
-
 	/* clear the progress line */
 	if (ppc_md.progress)
 		ppc_md.progress("             ", 0xffff);
 
-	/* register CPU devices */
-	for_each_possible_cpu(cpu) {
-		struct cpu *c = &per_cpu(cpu_devices, cpu);
-		c->hotpluggable = 1;
-		register_cpu(c, cpu);
-	}
-
 	/* call platform init */
 	if (ppc_md.init != NULL) {
 		ppc_md.init();
Index: linux-work/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/sysfs.c	2008-07-30 13:26:51.000000000 +1000
+++ linux-work/arch/powerpc/kernel/sysfs.c	2008-08-18 14:13:16.000000000 +1000
@@ -15,18 +15,24 @@
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/prom.h>
-#include <asm/paca.h>
-#include <asm/lppaca.h>
 #include <asm/machdep.h>
 #include <asm/smp.h>
 
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+#include <asm/lppaca.h>
+#endif
+
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 static DEFINE_PER_CPU(struct kobject *, cache_toplevel);
 
-/* SMT stuff */
+/*
+ * SMT snooze delay stuff, 64-bit only for now
+ */
+
+#ifdef CONFIG_PPC64
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
 /* Time in microseconds we delay before sleeping in the idle loop */
 DEFINE_PER_CPU(unsigned long, smt_snooze_delay) = { 100 };
 
@@ -106,7 +112,7 @@ static int __init setup_smt_snooze_delay
 }
 __setup("smt-snooze-delay=", setup_smt_snooze_delay);
 
-#endif /* CONFIG_PPC_MULTIPLATFORM */
+#endif /* CONFIG_PPC64 */
 
 /*
  * Enabling PMCs will slow partition context switch times so we only do
@@ -115,7 +121,7 @@ __setup("smt-snooze-delay=", setup_smt_s
 
 static DEFINE_PER_CPU(char, pmcs_enabled);
 
-void ppc64_enable_pmcs(void)
+void ppc_enable_pmcs(void)
 {
 	/* Only need to enable them once */
 	if (__get_cpu_var(pmcs_enabled))
@@ -126,7 +132,7 @@ void ppc64_enable_pmcs(void)
 	if (ppc_md.enable_pmcs)
 		ppc_md.enable_pmcs();
 }
-EXPORT_SYMBOL(ppc64_enable_pmcs);
+EXPORT_SYMBOL(ppc_enable_pmcs);
 
 /* XXX convert to rusty's on_one_cpu */
 static unsigned long run_on_cpu(unsigned long cpu,
@@ -154,7 +160,7 @@ static unsigned long read_##NAME(unsigne
 } \
 static unsigned long write_##NAME(unsigned long val) \
 { \
-	ppc64_enable_pmcs(); \
+	ppc_enable_pmcs(); \
 	mtspr(ADDRESS, val); \
 	return 0; \
 } \
@@ -184,28 +190,53 @@ static ssize_t __used \
  * that are implemented on the current processor
  */
 
+#ifdef CONFIG_PPC64
+#define HAS_PPC_PMC_CLASSIC	1
+#define HAS_PPC_PMC_IBM		1
+#define HAS_PPC_PMC_PA6T	1
+#elif CONFIG_6xx
+#define HAS_PPC_PMC_CLASSIC	1
+#define HAS_PPC_PMC_IBM		1
+#define HAS_PPC_PMC_G4		1
+#endif
+
+
+#ifdef HAS_PPC_PMC_CLASSIC
 SYSFS_PMCSETUP(mmcr0, SPRN_MMCR0);
 SYSFS_PMCSETUP(mmcr1, SPRN_MMCR1);
-SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
 SYSFS_PMCSETUP(pmc1, SPRN_PMC1);
 SYSFS_PMCSETUP(pmc2, SPRN_PMC2);
 SYSFS_PMCSETUP(pmc3, SPRN_PMC3);
 SYSFS_PMCSETUP(pmc4, SPRN_PMC4);
 SYSFS_PMCSETUP(pmc5, SPRN_PMC5);
 SYSFS_PMCSETUP(pmc6, SPRN_PMC6);
+
+#ifdef HAS_PPC_PMC_G4
+SYSFS_PMCSETUP(mmcr2, SPRN_MMCR2);
+#endif
+
+#ifdef CONFIG_PPC64
 SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
 SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
+
+SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
 SYSFS_PMCSETUP(purr, SPRN_PURR);
 SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 
+static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
+static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
+static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
+static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
+#endif /* CONFIG_PPC64 */
+
+#ifdef HAS_PPC_PMC_PA6T
 SYSFS_PMCSETUP(pa6t_pmc0, SPRN_PA6T_PMC0);
 SYSFS_PMCSETUP(pa6t_pmc1, SPRN_PA6T_PMC1);
 SYSFS_PMCSETUP(pa6t_pmc2, SPRN_PA6T_PMC2);
 SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
-
 #ifdef CONFIG_DEBUG_KERNEL
 SYSFS_PMCSETUP(hid0, SPRN_HID0);
 SYSFS_PMCSETUP(hid1, SPRN_HID1);
@@ -236,28 +267,37 @@ SYSFS_PMCSETUP(tsr1, SPRN_PA6T_TSR1);
 SYSFS_PMCSETUP(tsr2, SPRN_PA6T_TSR2);
 SYSFS_PMCSETUP(tsr3, SPRN_PA6T_TSR3);
 #endif /* CONFIG_DEBUG_KERNEL */
+#endif /* HAS_PPC_PMC_PA6T */
 
-static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
-static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
-static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
-static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
-
+#ifdef HAS_PPC_PMC_IBM
 static struct sysdev_attribute ibm_common_attrs[] = {
 	_SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0),
 	_SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1),
 };
+#endif /* HAS_PPC_PMC_G4 */
+
+#ifdef HAS_PPC_PMC_G4
+static struct sysdev_attribute g4_common_attrs[] = {
+	_SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0),
+	_SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1),
+	_SYSDEV_ATTR(mmcr2, 0600, show_mmcr2, store_mmcr2),
+};
+#endif /* HAS_PPC_PMC_G4 */
 
-static struct sysdev_attribute ibm_pmc_attrs[] = {
+static struct sysdev_attribute classic_pmc_attrs[] = {
 	_SYSDEV_ATTR(pmc1, 0600, show_pmc1, store_pmc1),
 	_SYSDEV_ATTR(pmc2, 0600, show_pmc2, store_pmc2),
 	_SYSDEV_ATTR(pmc3, 0600, show_pmc3, store_pmc3),
 	_SYSDEV_ATTR(pmc4, 0600, show_pmc4, store_pmc4),
 	_SYSDEV_ATTR(pmc5, 0600, show_pmc5, store_pmc5),
 	_SYSDEV_ATTR(pmc6, 0600, show_pmc6, store_pmc6),
+#ifdef CONFIG_PPC64
 	_SYSDEV_ATTR(pmc7, 0600, show_pmc7, store_pmc7),
 	_SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8),
+#endif
 };
 
+#ifdef HAS_PPC_PMC_PA6T
 static struct sysdev_attribute pa6t_attrs[] = {
 	_SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0),
 	_SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1),
@@ -298,6 +338,8 @@ static struct sysdev_attribute pa6t_attr
 	_SYSDEV_ATTR(tsr3, 0600, show_tsr3, store_tsr3),
 #endif /* CONFIG_DEBUG_KERNEL */
 };
+#endif /* HAS_PPC_PMC_PA6T */
+#endif /* HAS_PPC_PMC_CLASSIC */
 
 struct cache_desc {
 	struct kobject kobj;
@@ -588,23 +630,36 @@ static void __cpuinit register_cpu_onlin
 	struct sysdev_attribute *attrs, *pmc_attrs;
 	int i, nattrs;
 
+#ifdef CONFIG_PPC64
 	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
 			cpu_has_feature(CPU_FTR_SMT))
 		sysdev_create_file(s, &attr_smt_snooze_delay);
+#endif
 
 	/* PMC stuff */
 	switch (cur_cpu_spec->pmc_type) {
+#ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
 		nattrs = sizeof(ibm_common_attrs) / sizeof(struct sysdev_attribute);
-		pmc_attrs = ibm_pmc_attrs;
+		pmc_attrs = classic_pmc_attrs;
 		break;
+#endif /* HAS_PPC_PMC_IBM */
+#ifdef HAS_PPC_PMC_G4
+	case PPC_PMC_G4:
+		attrs = g4_common_attrs;
+		nattrs = sizeof(g4_common_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = classic_pmc_attrs;
+		break;
+#endif /* HAS_PPC_PMC_G4 */
+#ifdef HAS_PPC_PMC_PA6T
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
 		nattrs = sizeof(pa6t_attrs) / sizeof(struct sysdev_attribute);
 		pmc_attrs = NULL;
 		break;
+#endif /* HAS_PPC_PMC_PA6T */
 	default:
 		attrs = NULL;
 		nattrs = 0;
@@ -618,6 +673,7 @@ static void __cpuinit register_cpu_onlin
 		for (i = 0; i < cur_cpu_spec->num_pmcs; i++)
 			sysdev_create_file(s, &pmc_attrs[i]);
 
+#ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_create_file(s, &attr_mmcra);
 
@@ -629,6 +685,7 @@ static void __cpuinit register_cpu_onlin
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_create_file(s, &attr_dscr);
+#endif /* CONFIG_PPC64 */
 
 	create_cache_info(s);
 }
@@ -671,17 +728,28 @@ static void unregister_cpu_online(unsign
 
 	/* PMC stuff */
 	switch (cur_cpu_spec->pmc_type) {
+#ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
 		nattrs = sizeof(ibm_common_attrs) / sizeof(struct sysdev_attribute);
-		pmc_attrs = ibm_pmc_attrs;
+		pmc_attrs = classic_pmc_attrs;
+		break;
+#endif /* HAS_PPC_PMC_IBM */
+#ifdef HAS_PPC_PMC_G4
+	case PPC_PMC_G4:
+		attrs = g4_common_attrs;
+		nattrs = sizeof(g4_common_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = classic_pmc_attrs;
 		break;
+#endif /* HAS_PPC_PMC_G4 */
+#ifdef HAS_PPC_PMC_PA6T
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
 		nattrs = sizeof(pa6t_attrs) / sizeof(struct sysdev_attribute);
 		pmc_attrs = NULL;
 		break;
+#endif /* HAS_PPC_PMC_PA6T */
 	default:
 		attrs = NULL;
 		nattrs = 0;
@@ -695,6 +763,7 @@ static void unregister_cpu_online(unsign
 		for (i = 0; i < cur_cpu_spec->num_pmcs; i++)
 			sysdev_remove_file(s, &pmc_attrs[i]);
 
+#ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_remove_file(s, &attr_mmcra);
 
@@ -706,6 +775,7 @@ static void unregister_cpu_online(unsign
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_remove_file(s, &attr_dscr);
+#endif /* CONFIG_PPC64 */
 
 	remove_cache_info(s);
 }
Index: linux-work/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- linux-work.orig/arch/powerpc/oprofile/op_model_power4.c	2008-07-07 13:43:08.000000000 +1000
+++ linux-work/arch/powerpc/oprofile/op_model_power4.c	2008-08-18 12:43:43.000000000 +1000
@@ -64,7 +64,7 @@ static int power4_reg_setup(struct op_co
 	return 0;
 }
 
-extern void ppc64_enable_pmcs(void);
+extern void ppc_enable_pmcs(void);
 
 /*
  * Older CPUs require the MMCRA sample bit to be always set, but newer 
@@ -91,7 +91,7 @@ static int power4_cpu_setup(struct op_co
 	unsigned int mmcr0 = mmcr0_val;
 	unsigned long mmcra = mmcra_val;
 
-	ppc64_enable_pmcs();
+	ppc_enable_pmcs();
 
 	/* set the freeze bit */
 	mmcr0 |= MMCR0_FC;
Index: linux-work/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-08-12 13:13:58.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-08-18 12:43:43.000000000 +1000
@@ -62,6 +62,7 @@ enum powerpc_pmc_type {
 	PPC_PMC_DEFAULT = 0,
 	PPC_PMC_IBM = 1,
 	PPC_PMC_PA6T = 2,
+	PPC_PMC_G4 = 3,
 };
 
 struct pt_regs;

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 096E3DE24C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:19:34 +1100 (EST)
Date: Sun, 28 Jan 2007 21:25:57 -0600
To: paulus@samba.org
Subject: [PATCH] [4/4] powerpc: PA6T PMC support [v2]
Message-ID: <20070129032557.GG6412@lixom.net>
References: <20070129032143.GC6412@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070129032143.GC6412@lixom.net>
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

Support for PA6T-style PMC registers.

PMCs are completely implementation-dependent on PPC, and PA6T numbers them
differently from the IBM model.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/kernel/sysfs.c
===================================================================
--- merge.orig/arch/powerpc/kernel/sysfs.c
+++ merge/arch/powerpc/kernel/sysfs.c
@@ -169,6 +169,11 @@ static ssize_t __attribute_used__ \
 	return count; \
 }
 
+
+/* Let's define all possible registers, we'll only hook up the ones
+ * that are implemented on the current processor
+ */
+
 SYSFS_PMCSETUP(mmcr0, SPRN_MMCR0);
 SYSFS_PMCSETUP(mmcr1, SPRN_MMCR1);
 SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
@@ -184,55 +189,87 @@ SYSFS_PMCSETUP(purr, SPRN_PURR);
 SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 
-static SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0);
-static SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1);
+SYSFS_PMCSETUP(pa6t_pmc0, PA6T_SPRN_PMC0);
+SYSFS_PMCSETUP(pa6t_pmc1, PA6T_SPRN_PMC1);
+SYSFS_PMCSETUP(pa6t_pmc2, PA6T_SPRN_PMC2);
+SYSFS_PMCSETUP(pa6t_pmc3, PA6T_SPRN_PMC3);
+SYSFS_PMCSETUP(pa6t_pmc4, PA6T_SPRN_PMC4);
+SYSFS_PMCSETUP(pa6t_pmc5, PA6T_SPRN_PMC5);
+
+
 static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
-static SYSDEV_ATTR(pmc1, 0600, show_pmc1, store_pmc1);
-static SYSDEV_ATTR(pmc2, 0600, show_pmc2, store_pmc2);
-static SYSDEV_ATTR(pmc3, 0600, show_pmc3, store_pmc3);
-static SYSDEV_ATTR(pmc4, 0600, show_pmc4, store_pmc4);
-static SYSDEV_ATTR(pmc5, 0600, show_pmc5, store_pmc5);
-static SYSDEV_ATTR(pmc6, 0600, show_pmc6, store_pmc6);
-static SYSDEV_ATTR(pmc7, 0600, show_pmc7, store_pmc7);
-static SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8);
-static SYSDEV_ATTR(purr, 0600, show_purr, NULL);
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
 static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
+static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
+
+static struct sysdev_attribute ibm_common_attrs[] = {
+	_SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0),
+	_SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1),
+};
+
+static struct sysdev_attribute ibm_pmc_attrs[] = {
+	_SYSDEV_ATTR(pmc1, 0600, show_pmc1, store_pmc1),
+	_SYSDEV_ATTR(pmc2, 0600, show_pmc2, store_pmc2),
+	_SYSDEV_ATTR(pmc3, 0600, show_pmc3, store_pmc3),
+	_SYSDEV_ATTR(pmc4, 0600, show_pmc4, store_pmc4),
+	_SYSDEV_ATTR(pmc5, 0600, show_pmc5, store_pmc5),
+	_SYSDEV_ATTR(pmc6, 0600, show_pmc6, store_pmc6),
+	_SYSDEV_ATTR(pmc7, 0600, show_pmc7, store_pmc7),
+	_SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8),
+};
+
+static struct sysdev_attribute pa6t_attrs[] = {
+	_SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0),
+	_SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1),
+	_SYSDEV_ATTR(pmc0, 0600, show_pa6t_pmc0, store_pa6t_pmc0),
+	_SYSDEV_ATTR(pmc1, 0600, show_pa6t_pmc1, store_pa6t_pmc1),
+	_SYSDEV_ATTR(pmc2, 0600, show_pa6t_pmc2, store_pa6t_pmc2),
+	_SYSDEV_ATTR(pmc3, 0600, show_pa6t_pmc3, store_pa6t_pmc3),
+	_SYSDEV_ATTR(pmc4, 0600, show_pa6t_pmc4, store_pa6t_pmc4),
+	_SYSDEV_ATTR(pmc5, 0600, show_pa6t_pmc5, store_pa6t_pmc5),
+};
+
 
 static void register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
+	struct sysdev_attribute *attrs, *pmc_attrs;
+	int i, nattrs;
 
 	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
 			cpu_has_feature(CPU_FTR_SMT))
 		sysdev_create_file(s, &attr_smt_snooze_delay);
 
 	/* PMC stuff */
+	switch (cur_cpu_spec->pmc_type) {
+	case PPC_PMC_IBM:
+		attrs = ibm_common_attrs;
+		nattrs = sizeof(ibm_common_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = ibm_pmc_attrs;
+		break;
+	case PPC_PMC_PA6T:
+		/* PA Semi starts counting at PMC0 */
+		attrs = pa6t_attrs;
+		nattrs = sizeof(pa6t_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = NULL;
+		break;
+	default:
+		attrs = NULL;
+		nattrs = 0;
+		pmc_attrs = NULL;
+	}
 
-	sysdev_create_file(s, &attr_mmcr0);
-	sysdev_create_file(s, &attr_mmcr1);
+	for (i = 0; i < nattrs; i++)
+		sysdev_create_file(s, &attrs[i]);
+
+	if (pmc_attrs)
+		for (i = 0; i < cur_cpu_spec->num_pmcs; i++)
+			sysdev_create_file(s, &pmc_attrs[i]);
 
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_create_file(s, &attr_mmcra);
 
-	if (cur_cpu_spec->num_pmcs >= 1)
-		sysdev_create_file(s, &attr_pmc1);
-	if (cur_cpu_spec->num_pmcs >= 2)
-		sysdev_create_file(s, &attr_pmc2);
-	if (cur_cpu_spec->num_pmcs >= 3)
-		sysdev_create_file(s, &attr_pmc3);
-	if (cur_cpu_spec->num_pmcs >= 4)
-		sysdev_create_file(s, &attr_pmc4);
-	if (cur_cpu_spec->num_pmcs >= 5)
-		sysdev_create_file(s, &attr_pmc5);
-	if (cur_cpu_spec->num_pmcs >= 6)
-		sysdev_create_file(s, &attr_pmc6);
-	if (cur_cpu_spec->num_pmcs >= 7)
-		sysdev_create_file(s, &attr_pmc7);
-	if (cur_cpu_spec->num_pmcs >= 8)
-		sysdev_create_file(s, &attr_pmc8);
-
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
 
@@ -248,6 +285,8 @@ static void unregister_cpu_online(unsign
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
+	struct sysdev_attribute *attrs, *pmc_attrs;
+	int i, nattrs;
 
 	BUG_ON(!c->hotpluggable);
 
@@ -256,30 +295,34 @@ static void unregister_cpu_online(unsign
 		sysdev_remove_file(s, &attr_smt_snooze_delay);
 
 	/* PMC stuff */
+	switch (cur_cpu_spec->pmc_type) {
+	case PPC_PMC_IBM:
+		attrs = ibm_common_attrs;
+		nattrs = sizeof(ibm_common_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = ibm_pmc_attrs;
+		break;
+	case PPC_PMC_PA6T:
+		/* PA Semi starts counting at PMC0 */
+		attrs = pa6t_attrs;
+		nattrs = sizeof(pa6t_attrs) / sizeof(struct sysdev_attribute);
+		pmc_attrs = NULL;
+		break;
+	default:
+		attrs = NULL;
+		nattrs = 0;
+		pmc_attrs = NULL;
+	}
 
-	sysdev_remove_file(s, &attr_mmcr0);
-	sysdev_remove_file(s, &attr_mmcr1);
+	for (i = 0; i < nattrs; i++)
+		sysdev_remove_file(s, &attrs[i]);
+
+	if (pmc_attrs)
+		for (i = 0; i < cur_cpu_spec->num_pmcs; i++)
+			sysdev_remove_file(s, &pmc_attrs[i]);
 
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_remove_file(s, &attr_mmcra);
 
-	if (cur_cpu_spec->num_pmcs >= 1)
-		sysdev_remove_file(s, &attr_pmc1);
-	if (cur_cpu_spec->num_pmcs >= 2)
-		sysdev_remove_file(s, &attr_pmc2);
-	if (cur_cpu_spec->num_pmcs >= 3)
-		sysdev_remove_file(s, &attr_pmc3);
-	if (cur_cpu_spec->num_pmcs >= 4)
-		sysdev_remove_file(s, &attr_pmc4);
-	if (cur_cpu_spec->num_pmcs >= 5)
-		sysdev_remove_file(s, &attr_pmc5);
-	if (cur_cpu_spec->num_pmcs >= 6)
-		sysdev_remove_file(s, &attr_pmc6);
-	if (cur_cpu_spec->num_pmcs >= 7)
-		sysdev_remove_file(s, &attr_pmc7);
-	if (cur_cpu_spec->num_pmcs >= 8)
-		sysdev_remove_file(s, &attr_pmc8);
-
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
 
Index: merge/include/asm-powerpc/reg.h
===================================================================
--- merge.orig/include/asm-powerpc/reg.h
+++ merge/include/asm-powerpc/reg.h
@@ -462,6 +462,13 @@
 #define SPRN_SIAR	780
 #define SPRN_SDAR	781
 
+#define PA6T_SPRN_PMC0	787
+#define PA6T_SPRN_PMC1	788
+#define PA6T_SPRN_PMC2	789
+#define PA6T_SPRN_PMC3	790
+#define PA6T_SPRN_PMC4	791
+#define PA6T_SPRN_PMC5	792
+
 #else /* 32-bit */
 #define SPRN_MMCR0	952	/* Monitor Mode Control Register 0 */
 #define   MMCR0_FC	0x80000000UL /* freeze counters */
Index: merge/arch/powerpc/kernel/pmc.c
===================================================================
--- merge.orig/arch/powerpc/kernel/pmc.c
+++ merge/arch/powerpc/kernel/pmc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 
 #include <asm/processor.h>
+#include <asm/cputable.h>
 #include <asm/pmc.h>
 
 #ifndef MMCR0_PMA0
@@ -28,7 +29,8 @@ static void dummy_perf(struct pt_regs *r
 #if defined(CONFIG_FSL_BOOKE) && !defined(CONFIG_E200)
 	mtpmr(PMRN_PMGC0, mfpmr(PMRN_PMGC0) & ~PMGC0_PMIE);
 #elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
-	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMA0));
+	if (cur_cpu_spec->pmc_type == PPC_PMC_IBM)
+		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMA0));
 #else
 	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_PMXE);
 #endif

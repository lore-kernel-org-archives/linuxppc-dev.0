Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70C372C0353
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 18:02:19 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 12:32:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3D5081258054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 12:33:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1B720l643843782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 12:32:00 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1B723dW021949
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 12:32:04 +0530
Subject: [PATCH v1 1/2] powernv: cpufreq driver for powernv platform
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Tue, 11 Feb 2014 12:32:01 +0530
Message-ID: <20140211070201.21159.31101.stgit@drishya>
In-Reply-To: <20140211065757.21159.49689.stgit@drishya>
References: <20140211065757.21159.49689.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Backend driver to dynamically set voltage and frequency on
IBM POWER non-virtualized platforms.  Power management SPRs
are used to set the required PState.

This driver works in conjunction with cpufreq governors
like 'ondemand' to provide a demand based frequency and
voltage setting on IBM POWER non-virtualized platforms.

PState table is obtained from OPAL v3 firmware through device
tree.

powernv_cpufreq back-end driver would parse the relevant device-tree
nodes and initialise the cpufreq subsystem on powernv platform.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/reg.h    |    4 +
 drivers/cpufreq/Kconfig.powerpc   |    9 +
 drivers/cpufreq/Makefile          |    1 
 drivers/cpufreq/powernv-cpufreq.c |  275 +++++++++++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 90c06ec..84f92ca 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -271,6 +271,10 @@
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
 #define SPRN_IC		0x350	/* Virtual Instruction Count */
 #define SPRN_VTB	0x351	/* Virtual Time Base */
+#define SPRN_PMICR	0x354   /* Power Management Idle Control Reg */
+#define SPRN_PMSR	0x355   /* Power Management Status Reg */
+#define SPRN_PMCR	0x374	/* Power Management Control Register */
+
 /* HFSCR and FSCR bit numbers are the same */
 #define FSCR_TAR_LG	8	/* Enable Target Address Register */
 #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index ca0021a..4a91ab1 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -54,3 +54,12 @@ config PPC_PASEMI_CPUFREQ
 	help
 	  This adds the support for frequency switching on PA Semi
 	  PWRficient processors.
+
+config POWERNV_CPUFREQ
+       tristate "CPU frequency scaling for IBM POWERNV platform"
+       depends on PPC_POWERNV
+       select CPU_FREQ_TABLE
+       default y
+       help
+	 This adds support for CPU frequency switching on IBM POWERNV
+	 platform
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 7494565..0dbb963 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_PPC_CORENET_CPUFREQ)   += ppc-corenet-cpufreq.o
 obj-$(CONFIG_CPU_FREQ_PMAC)		+= pmac32-cpufreq.o
 obj-$(CONFIG_CPU_FREQ_PMAC64)		+= pmac64-cpufreq.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ)	+= pasemi-cpufreq.o
+obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 
 ##################################################################################
 # Other platform drivers
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
new file mode 100644
index 0000000..ea3b630
--- /dev/null
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -0,0 +1,275 @@
+/*
+ * POWERNV cpufreq driver for the IBM POWER processors
+ *
+ * (C) Copyright IBM 2014
+ *
+ * Author: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt)	"powernv-cpufreq: " fmt
+
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <asm/cputhreads.h>
+
+/* FIXME: Make this per-core */
+static DEFINE_MUTEX(freq_switch_mutex);
+
+#define POWERNV_MAX_PSTATES	256
+
+static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
+
+/*
+ * Initialize the freq table based on data obtained
+ * from the firmware passed via device-tree
+ */
+
+static int init_powernv_pstates(void)
+{
+	struct device_node *power_mgt;
+	int nr_pstates = 0;
+	int pstate_min, pstate_max, pstate_nominal;
+	const __be32 *pstate_ids, *pstate_freqs;
+	int i;
+	u32 len_ids, len_freqs;
+
+	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
+	if (!power_mgt) {
+		pr_warn("power-mgt node not found\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
+		pr_warn("ibm,pstate-min node not found\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
+		pr_warn("ibm,pstate-max node not found\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
+				 &pstate_nominal)) {
+		pr_warn("ibm,pstate-nominal not found\n");
+		return -ENODEV;
+	}
+	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
+		pstate_nominal, pstate_max);
+
+	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
+	if (!pstate_ids) {
+		pr_warn("ibm,pstate-ids not found\n");
+		return -ENODEV;
+	}
+
+	pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
+				      &len_freqs);
+	if (!pstate_freqs) {
+		pr_warn("ibm,pstate-frequencies-mhz not found\n");
+		return -ENODEV;
+	}
+
+	WARN_ON(len_ids != len_freqs);
+	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
+	WARN_ON(!nr_pstates);
+
+	pr_debug("NR PStates %d\n", nr_pstates);
+	for (i = 0; i < nr_pstates; i++) {
+		u32 id = be32_to_cpu(pstate_ids[i]);
+		u32 freq = be32_to_cpu(pstate_freqs[i]);
+
+		pr_debug("PState id %d freq %d MHz\n", id, freq);
+		powernv_freqs[i].driver_data = id;
+		powernv_freqs[i].frequency = freq * 1000; /* kHz */
+	}
+	/* End of list marker entry */
+	powernv_freqs[i].driver_data = 0;
+	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
+
+	return 0;
+}
+
+static struct freq_attr *powernv_cpu_freq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+/* Helper routines */
+
+/* Access helpers to power mgt SPR */
+
+static inline unsigned long get_pmspr(unsigned long sprn)
+{
+	switch (sprn) {
+	case SPRN_PMCR:
+		return mfspr(SPRN_PMCR);
+
+	case SPRN_PMICR:
+		return mfspr(SPRN_PMICR);
+
+	case SPRN_PMSR:
+		return mfspr(SPRN_PMSR);
+	}
+	BUG();
+}
+
+static inline void set_pmspr(unsigned long sprn, unsigned long val)
+{
+	switch (sprn) {
+	case SPRN_PMCR:
+		mtspr(SPRN_PMCR, val);
+		return;
+
+	case SPRN_PMICR:
+		mtspr(SPRN_PMICR, val);
+		return;
+
+	case SPRN_PMSR:
+		mtspr(SPRN_PMSR, val);
+		return;
+	}
+	BUG();
+}
+
+static void set_pstate(void *pstate)
+{
+	unsigned long val;
+	unsigned long pstate_ul = *(unsigned long *) pstate;
+
+	val = get_pmspr(SPRN_PMCR);
+	val = val & 0x0000ffffffffffffULL;
+	/* Set both local and global PStates */
+	val = val | (pstate_ul << 56) | (pstate_ul << 48);
+	pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);
+	set_pmspr(SPRN_PMCR, val);
+}
+
+static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
+{
+	unsigned long val = (unsigned long)powernv_freqs[new_index].driver_data;
+
+	/*
+	 * Use smp_call_function to send IPI and execute the
+	 * mtspr on target cpu.  We could do that without IPI
+	 * if current CPU is within policy->cpus (core)
+	 */
+
+	val = val & 0xFF;
+	smp_call_function_any(cpus, set_pstate, &val, 1);
+	return 0;
+}
+
+static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	int base, i;
+
+#ifdef CONFIG_SMP
+	base = cpu_first_thread_sibling(policy->cpu);
+
+	for (i = 0; i < threads_per_core; i++)
+		cpumask_set_cpu(base + i, policy->cpus);
+#endif
+	policy->cpuinfo.transition_latency = 25000;
+
+	/* Print frequency table */
+	for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
+		pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
+
+	policy->cur = powernv_freqs[0].frequency;
+	cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
+	return cpufreq_frequency_table_cpuinfo(policy, powernv_freqs);
+}
+
+static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, powernv_freqs);
+}
+
+static int powernv_cpufreq_target(struct cpufreq_policy *policy,
+			      unsigned int target_freq,
+			      unsigned int relation)
+{
+	int rc;
+	struct cpufreq_freqs freqs;
+	unsigned int new_index;
+
+	cpufreq_frequency_table_target(policy, powernv_freqs, target_freq,
+				       relation, &new_index);
+
+	freqs.old = policy->cur;
+	freqs.new = powernv_freqs[new_index].frequency;
+	freqs.cpu = policy->cpu;
+
+	mutex_lock(&freq_switch_mutex);
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
+
+	pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
+		 policy->cpu,
+		 powernv_freqs[new_index].frequency,
+		 new_index,
+		 powernv_freqs[new_index].driver_data);
+
+	rc = powernv_set_freq(policy->cpus, new_index);
+
+	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
+	mutex_unlock(&freq_switch_mutex);
+
+	return rc;
+}
+
+static struct cpufreq_driver powernv_cpufreq_driver = {
+	.verify		= powernv_cpufreq_verify,
+	.target		= powernv_cpufreq_target,
+	.init		= powernv_cpufreq_cpu_init,
+	.exit		= powernv_cpufreq_cpu_exit,
+	.name		= "powernv-cpufreq",
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.attr		= powernv_cpu_freq_attr,
+};
+
+static int __init powernv_cpufreq_init(void)
+{
+	int rc = 0;
+
+	/* Discover pstates from device tree and init */
+
+	rc = init_powernv_pstates();
+
+	if (rc) {
+		pr_info("powernv-cpufreq disabled\n");
+		return rc;
+	}
+
+	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
+	return rc;
+}
+
+static void __exit powernv_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&powernv_cpufreq_driver);
+}
+
+module_init(powernv_cpufreq_init);
+module_exit(powernv_cpufreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>");

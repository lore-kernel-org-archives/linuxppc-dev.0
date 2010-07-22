Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE73D100B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 10:57:26 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6M0vN2M013352
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:23 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6M0vQV11843200
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6M0vPjg013080
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 10:57:26 +1000
Subject: [PATCH v4 2/2] powerpc: add support for new hcall H_BEST_ENERGY
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 22 Jul 2010 06:27:17 +0530
Message-ID: <20100722005716.12905.32487.stgit@drishya.in.ibm.com>
In-Reply-To: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
References: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Create sysfs interface to export data from H_BEST_ENERGY hcall
	that can be used by administrative tools on supported pseries
	platforms for energy management	optimizations.

	/sys/device/system/cpu/pseries_(de)activate_hint_list and
	/sys/device/system/cpu/cpuN/pseries_(de)activate_hint will provide
	hints for activation and deactivation of cpus respectively.

	These hints are abstract number given by the hypervisor based
	on the extended knowledge the hypervisor has regarding the
	current system topology and resource mappings.

	The activate and the deactivate sysfs entry is for the two
	distinct operations that we could do for energy savings.  When
	we have more capacity than required, we could deactivate few
	core to save energy.  The choice of the core to deactivate
	will be based on /sys/devices/system/cpu/deactivate_hint_list.
	The comma separated list of cpus (cores) will be the preferred
	choice.  If we have to activate some of the deactivated cores,
	then /sys/devices/system/cpu/activate_hint_list will be used.

	The per-cpu file
	/sys/device/system/cpu/cpuN/pseries_(de)activate_hint further
	provide more fine grain information by exporting the value of
	the hint itself.

	Added new driver module
		arch/powerpc/platforms/pseries/pseries_energy.c
	under new config option CONFIG_PSERIES_ENERGY

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h               |    3 
 arch/powerpc/platforms/pseries/Kconfig          |   10 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_energy.c |  326 +++++++++++++++++++++++
 4 files changed, 339 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 5119b7d..34b66e0 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -231,7 +231,8 @@
 #define H_GET_EM_PARMS		0x2B8
 #define H_SET_MPP		0x2D0
 #define H_GET_MPP		0x2D4
-#define MAX_HCALL_OPCODE	H_GET_MPP
+#define H_BEST_ENERGY		0x2F4
+#define MAX_HCALL_OPCODE	H_BEST_ENERGY
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index c667f0f..8323622 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -33,6 +33,16 @@ config PSERIES_MSI
        depends on PCI_MSI && EEH
        default y
 
+config PSERIES_ENERGY
+	tristate "pSeries energy management capabilities driver"
+	depends on PPC_PSERIES
+	default y
+	help
+	  Provides interface to platform energy management capabilities
+	  on supported PSERIES platforms.
+	  Provides: /sys/devices/system/cpu/pseries_(de)activation_hint_list
+	  and /sys/devices/system/cpu/cpuN/pseries_(de)activation_hint
+
 config SCANLOG
 	tristate "Scanlog dump interface"
 	depends on RTAS_PROC && PPC_PSERIES
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 3dbef30..32ae72e 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
+obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
 obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
new file mode 100644
index 0000000..e217ea3
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -0,0 +1,326 @@
+/*
+ * POWER platform energy management driver
+ * Copyright (C) 2010 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This pseries platform device driver provides access to
+ * platform energy management capabilities.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <asm/cputhreads.h>
+#include <asm/page.h>
+#include <asm/hvcall.h>
+
+
+#define MODULE_VERS "1.0"
+#define MODULE_NAME "pseries_energy"
+
+/* Driver flags */
+
+static int sysfs_entries;
+
+/* Helper routines */
+
+/*
+ * Routine to detect firmware support for hcall
+ * return 1 if H_BEST_ENERGY is supported
+ * else return 0
+ */
+
+static int check_for_h_best_energy(void)
+{
+	struct device_node *rtas = NULL;
+	const char *hypertas, *s;
+	int length;
+	int rc = 0;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (!rtas)
+		return 0;
+
+	hypertas = of_get_property(rtas, "ibm,hypertas-functions", &length);
+	if (!hypertas) {
+		of_node_put(rtas);
+		return 0;
+	}
+
+	/* hypertas will have list of strings with hcall names */
+	for (s = hypertas; s < hypertas + length; s += strlen(s) + 1) {
+		if (!strncmp("hcall-best-energy-1", s, 19)) {
+			rc = 1; /* Found the string */
+			break;
+		}
+	}
+	of_node_put(rtas);
+	return rc;
+}
+
+/* Helper Routines to convert between drc_index to cpu numbers */
+
+static u32 cpu_to_drc_index(int cpu)
+{
+	struct device_node *dn = NULL;
+	const int *indexes;
+	int i;
+	int rc = 1;
+	u32 ret = 0;
+
+	dn = of_find_node_by_path("/cpus");
+	if (dn == NULL)
+		goto err;
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+	if (indexes == NULL)
+		goto err_of_node_put;
+	/* Convert logical cpu number to core number */
+	i = cpu_core_of_thread(cpu);
+	/*
+	 * The first element indexes[0] is the number of drc_indexes
+	 * returned in the list.  Hence i+1 will get the drc_index
+	 * corresponding to core number i.
+	 */
+	WARN_ON(i > indexes[0]);
+	ret = indexes[i + 1];
+	rc = 0;
+
+err_of_node_put:
+	of_node_put(dn);
+err:
+	if (rc)
+		printk(KERN_WARNING "cpu_to_drc_index(%d) failed", cpu);
+	return ret;
+}
+
+static int drc_index_to_cpu(u32 drc_index)
+{
+	struct device_node *dn = NULL;
+	const int *indexes;
+	int i, cpu = 0;
+	int rc = 1;
+
+	dn = of_find_node_by_path("/cpus");
+	if (dn == NULL)
+		goto err;
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+	if (indexes == NULL)
+		goto err_of_node_put;
+	/*
+	 * First element in the array is the number of drc_indexes
+	 * returned.  Search through the list to find the matching
+	 * drc_index and get the core number
+	 */
+	for (i = 0; i < indexes[0]; i++) {
+		if (indexes[i + 1] == drc_index)
+			break;
+	}
+	/* Convert core number to logical cpu number */
+	cpu = cpu_first_thread_of_core(i);
+	rc = 0;
+
+err_of_node_put:
+	of_node_put(dn);
+err:
+	if (rc)
+		printk(KERN_WARNING "drc_index_to_cpu(%d) failed", drc_index);
+	return cpu;
+}
+
+/*
+ * pseries hypervisor call H_BEST_ENERGY provides hints to OS on
+ * preferred logical cpus to activate or deactivate for optimized
+ * energy consumption.
+ */
+
+#define FLAGS_MODE1	0x004E200000080E01
+#define FLAGS_MODE2	0x004E200000080401
+#define FLAGS_ACTIVATE  0x100
+
+static ssize_t get_best_energy_list(char *page, int activate)
+{
+	int rc, cnt, i, cpu;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long flags = 0;
+	u32 *buf_page;
+	char *s = page;
+
+	buf_page = (u32 *) get_zeroed_page(GFP_KERNEL);
+	if (!buf_page)
+		return -ENOMEM;
+
+	flags = FLAGS_MODE1;
+	if (activate)
+		flags |= FLAGS_ACTIVATE;
+
+	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
+				0, 0, 0, 0, 0, 0);
+	if (rc != H_SUCCESS) {
+		free_page((unsigned long) buf_page);
+		return -EINVAL;
+	}
+
+	cnt = retbuf[0];
+	for (i = 0; i < cnt; i++) {
+		cpu = drc_index_to_cpu(buf_page[2*i+1]);
+		if ((cpu_online(cpu) && !activate) ||
+		    (!cpu_online(cpu) && activate))
+			s += sprintf(s, "%d,", cpu);
+	}
+	if (s > page) { /* Something to show */
+		s--; /* Suppress last comma */
+		s += sprintf(s, "\n");
+	}
+
+	free_page((unsigned long) buf_page);
+	return s-page;
+}
+
+static ssize_t get_best_energy_data(struct sys_device *dev,
+					char *page, int activate)
+{
+	int rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long flags = 0;
+
+	flags = FLAGS_MODE2;
+	if (activate)
+		flags |= FLAGS_ACTIVATE;
+
+	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags,
+				cpu_to_drc_index(dev->id),
+				0, 0, 0, 0, 0, 0, 0);
+
+	if (rc != H_SUCCESS)
+		return -EINVAL;
+
+	return sprintf(page, "%lu\n", retbuf[1] >> 32);
+}
+
+/* Wrapper functions */
+
+static ssize_t cpu_activate_hint_list_show(struct sysdev_class *class,
+			struct sysdev_class_attribute *attr, char *page)
+{
+	return get_best_energy_list(page, 1);
+}
+
+static ssize_t cpu_deactivate_hint_list_show(struct sysdev_class *class,
+			struct sysdev_class_attribute *attr, char *page)
+{
+	return get_best_energy_list(page, 0);
+}
+
+static ssize_t percpu_activate_hint_show(struct sys_device *dev,
+			struct sysdev_attribute *attr, char *page)
+{
+	return get_best_energy_data(dev, page, 1);
+}
+
+static ssize_t percpu_deactivate_hint_show(struct sys_device *dev,
+			struct sysdev_attribute *attr, char *page)
+{
+	return get_best_energy_data(dev, page, 0);
+}
+
+/*
+ * Create sysfs interface:
+ * /sys/devices/system/cpu/pseries_activate_hint_list
+ * /sys/devices/system/cpu/pseries_deactivate_hint_list
+ *	Comma separated list of cpus to activate or deactivate
+ * /sys/devices/system/cpu/cpuN/pseries_activate_hint
+ * /sys/devices/system/cpu/cpuN/pseries_deactivate_hint
+ *	Per-cpu value of the hint
+ */
+
+struct sysdev_class_attribute attr_cpu_activate_hint_list =
+		_SYSDEV_CLASS_ATTR(pseries_activate_hint_list, 0444,
+		cpu_activate_hint_list_show, NULL);
+
+struct sysdev_class_attribute attr_cpu_deactivate_hint_list =
+		_SYSDEV_CLASS_ATTR(pseries_deactivate_hint_list, 0444,
+		cpu_deactivate_hint_list_show, NULL);
+
+struct sysdev_attribute attr_percpu_activate_hint =
+		_SYSDEV_ATTR(pseries_activate_hint, 0444,
+		percpu_activate_hint_show, NULL);
+
+struct sysdev_attribute attr_percpu_deactivate_hint =
+		_SYSDEV_ATTR(pseries_deactivate_hint, 0444,
+		percpu_deactivate_hint_show, NULL);
+
+static int __init pseries_energy_init(void)
+{
+	int cpu, err;
+	struct sys_device *cpu_sys_dev;
+
+	if (!check_for_h_best_energy()) {
+		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
+		return 0;
+	}
+	/* Create the sysfs files */
+	err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_activate_hint_list.attr);
+	if (!err)
+		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_deactivate_hint_list.attr);
+
+	if (err)
+		return err;
+	for_each_possible_cpu(cpu) {
+		cpu_sys_dev = get_cpu_sysdev(cpu);
+		err = sysfs_create_file(&cpu_sys_dev->kobj,
+				&attr_percpu_activate_hint.attr);
+		if (err)
+			break;
+		err = sysfs_create_file(&cpu_sys_dev->kobj,
+				&attr_percpu_deactivate_hint.attr);
+		if (err)
+			break;
+	}
+
+	if (err)
+		return err;
+
+	sysfs_entries = 1; /* Removed entries on cleanup */
+	return 0;
+
+}
+
+static void __exit pseries_energy_cleanup(void)
+{
+	int cpu;
+	struct sys_device *cpu_sys_dev;
+
+	if (!sysfs_entries)
+		return;
+
+	/* Remove the sysfs files */
+	sysfs_remove_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_activate_hint_list.attr);
+
+	sysfs_remove_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_deactivate_hint_list.attr);
+
+	for_each_possible_cpu(cpu) {
+		cpu_sys_dev = get_cpu_sysdev(cpu);
+		sysfs_remove_file(&cpu_sys_dev->kobj,
+				&attr_percpu_activate_hint.attr);
+		sysfs_remove_file(&cpu_sys_dev->kobj,
+				&attr_percpu_deactivate_hint.attr);
+	}
+}
+
+module_init(pseries_energy_init);
+module_exit(pseries_energy_cleanup);
+MODULE_DESCRIPTION("Driver for pSeries platform energy management");
+MODULE_AUTHOR("Vaidyanathan Srinivasan");
+MODULE_LICENSE("GPL");

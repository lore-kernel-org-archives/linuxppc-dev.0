Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F240B7CEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 05:18:36 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o23IIWRg007159
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Mar 2010 23:48:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o23IIW8N2486318
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Mar 2010 23:48:32 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o23IIVoX016100
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Mar 2010 23:48:32 +0530
Date: Wed, 3 Mar 2010 23:48:22 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Subject: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100303181822.GH5439@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A new hypervisor call H_BEST_ENERGY is supported in IBM pseries ppc64
platform in order to exports platform energy management capabilities
to user space administrative tools.

This hypervisor calls provides hints or suggested list of cpus to
activate or deactivate for optimized energy management.  The following
patch add a new pseries specific device driver that will export such
platform energy management related information over sysfs interface
for use by user space administrative tools.

The device driver exports the following sysfs files:

/sys/device/system/cpu/pseries_(de)activate_hint_list and
/sys/device/system/cpu/cpuN/pseries_(de)activate_hint.

Typical usage:

# cat /sys/devices/system/cpu/pseries_activate_hint_list
16,20,24
# cat /sys/devices/system/cpu/pseries_deactivate_hint_list
0,4,8,12

Comma separated list of recommended cpu numbers to activate or
deactivate.

cat /sys/device/system/cpu/cpuN/pseries_(de)activate_hint
will provide a single integer value returned by the platform
for that cpu.

Please let me know your comments and suggestions.

Thanks,
Vaidy
---
        powerpc: add support for new hcall H_BEST_ENERGY

	Create sysfs interface to export data from H_BEST_ENERGY hcall
	that can be used by administrative tools on supported pseries
	platforms for energy management	optimizations.

	/sys/device/system/cpu/pseries_(de)activate_hint_list and
	/sys/device/system/cpu/cpuN/pseries_(de)activate_hint will provide
	hints for activation and deactivation of cpus respectively.

	Added new driver module
		arch/powerpc/platforms/pseries/pseries_energy.c
	under new config option CONFIG_PSERIES_ENERGY

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h               |    3 
 arch/powerpc/kernel/setup-common.c              |    2 
 arch/powerpc/platforms/pseries/Kconfig          |   10 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_energy.c |  246 +++++++++++++++++++++++
 5 files changed, 261 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index f027581..396599f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -230,7 +230,8 @@
 #define H_ENABLE_CRQ		0x2B0
 #define H_SET_MPP		0x2D0
 #define H_GET_MPP		0x2D4
-#define MAX_HCALL_OPCODE	H_GET_MPP
+#define H_BEST_ENERGY		0x2F4
+#define MAX_HCALL_OPCODE	H_BEST_ENERGY
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 03dd6a2..fbd93e3 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -359,6 +359,8 @@ void __init check_for_initrd(void)
 #ifdef CONFIG_SMP
 
 int threads_per_core, threads_shift;
+EXPORT_SYMBOL_GPL(threads_per_core);
+
 cpumask_t threads_core_mask;
 
 static void __init cpu_init_thread_core_maps(int tpc)
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index c667f0f..b3dd108 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -33,6 +33,16 @@ config PSERIES_MSI
        depends on PCI_MSI && EEH
        default y
 
+config PSERIES_ENERGY
+	tristate "pseries energy management capabilities driver"
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
index 0ff5174..3813977 100644
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
index 0000000..0390188
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -0,0 +1,246 @@
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
+/* Helper Routines to convert between drc_index to cpu numbers */
+
+static u32 cpu_to_drc_index(int cpu)
+{
+	struct device_node *dn = NULL;
+	const int *indexes;
+	int i;
+	dn = of_find_node_by_name(dn, "cpus");
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+	/* Convert logical cpu number to core number */
+	i = cpu / threads_per_core;
+	/*
+	 * The first element indexes[0] is the number of drc_indexes
+	 * returned in the list.  Hence i+1 will get the drc_index
+	 * corresponding to core number i.
+	 */
+	WARN_ON(i > indexes[0]);
+	return indexes[i + 1];
+}
+
+static int drc_index_to_cpu(u32 drc_index)
+{
+	struct device_node *dn = NULL;
+	const int *indexes;
+	int i, cpu;
+	dn = of_find_node_by_name(dn, "cpus");
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
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
+	cpu = i * threads_per_core;
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
+
+	if (!buf_page)
+		return 0;
+
+	flags = FLAGS_MODE1;
+	if (activate)
+		flags |= FLAGS_ACTIVATE;
+
+	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
+				0, 0, 0, 0, 0, 0);
+
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
+						char *page)
+{
+	return get_best_energy_list(page, 1);
+}
+
+static ssize_t cpu_deactivate_hint_list_show(struct sysdev_class *class,
+						char *page)
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
+ * 	Comma separated list of cpus to activate or deactivate
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
+	/* Create the sysfs files */
+	err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_activate_hint_list.attr);
+	if (!err)
+		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+				&attr_cpu_deactivate_hint_list.attr);
+
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
+	return err;
+
+}
+
+static void __exit pseries_energy_cleanup(void)
+{
+	int cpu;
+	struct sys_device *cpu_sys_dev;
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
+MODULE_DESCRIPTION("Driver for pseries platform energy management");
+MODULE_AUTHOR("Vaidyanathan Srinivasan");
+MODULE_LICENSE("GPL");

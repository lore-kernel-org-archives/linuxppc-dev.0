Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 6FACAB6F0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 15:45:24 +1000 (EST)
Received: from neuling.org (localhost [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id BCDA6C4CAC
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 15:45:23 +1000 (EST)
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: add support for new hcall H_BEST_ENERGY
In-reply-to: <20100623060415.4957.24478.stgit@drishya.in.ibm.com>
References: <20100623060122.4957.33819.stgit@drishya.in.ibm.com>
	<20100623060415.4957.24478.stgit@drishya.in.ibm.com>
Date: Mon, 28 Jun 2010 11:44:31 +1000
Message-ID: <25049.1277689471@neuling.org>
From: Michael Neuling <mikey@neuling.org>
Resent-Message-Id: <20100628054523.C2546C8886@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlab.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaidy,

> 	Create sysfs interface to export data from H_BEST_ENERGY hcall
> 	that can be used by administrative tools on supported pseries
> 	platforms for energy management	optimizations.
> 
> 	/sys/device/system/cpu/pseries_(de)activate_hint_list and
> 	/sys/device/system/cpu/cpuN/pseries_(de)activate_hint will provide
> 	hints for activation and deactivation of cpus respectively.
> 
> 	Added new driver module
> 		arch/powerpc/platforms/pseries/pseries_energy.c
> 	under new config option CONFIG_PSERIES_ENERGY

Can you provide some documentation on how to use these hints and what
format they are provided from sysfs.  Looks like two separate interfaces
two the same thing (one a comma sep list and 1 per cpu, why do need
both?).  What is the difference between activate and deactivate, with
out me having to read PAPR :-) ??

Other comments below.

> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hvcall.h               |    3 
>  arch/powerpc/platforms/pseries/Kconfig          |   10 +
>  arch/powerpc/platforms/pseries/Makefile         |    1 
>  arch/powerpc/platforms/pseries/pseries_energy.c |  258 +++++++++++++++++++++
++
>  4 files changed, 271 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvc
all.h
> index 5119b7d..34b66e0 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -231,7 +231,8 @@
>  #define H_GET_EM_PARMS		0x2B8
>  #define H_SET_MPP		0x2D0
>  #define H_GET_MPP		0x2D4
> -#define MAX_HCALL_OPCODE	H_GET_MPP
> +#define H_BEST_ENERGY		0x2F4
> +#define MAX_HCALL_OPCODE	H_BEST_ENERGY
> 
>  #ifndef __ASSEMBLY__
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/
pseries/Kconfig
> index c667f0f..b3dd108 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -33,6 +33,16 @@ config PSERIES_MSI
>         depends on PCI_MSI && EEH
>         default y
> 
> +config PSERIES_ENERGY

Probably need a less generic name.  PSERIES_ENERGY_MANAGEMENT?
PSERIES_ENERGY_HOTPLUG_HINTS?

> +	tristate "pseries energy management capabilities driver"
> +	depends on PPC_PSERIES
> +	default y
> +	help
> +	  Provides interface to platform energy management capabilities
> +	  on supported PSERIES platforms.
> +	  Provides: /sys/devices/system/cpu/pseries_(de)activation_hint_list
> +	  and /sys/devices/system/cpu/cpuN/pseries_(de)activation_hint
> +
>  config SCANLOG
>  	tristate "Scanlog dump interface"
>  	depends on RTAS_PROC && PPC_PSERIES
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms
/pseries/Makefile
> index 3dbef30..32ae72e 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_e
vent.o eeh_sysfs.o
>  obj-$(CONFIG_KEXEC)	+= kexec.o
>  obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
>  obj-$(CONFIG_PSERIES_MSI)	+= msi.o
> +obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
> 
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
>  obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/p
latforms/pseries/pseries_energy.c
> new file mode 100644
> index 0000000..9a936b1
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -0,0 +1,258 @@
> +/*
> + * POWER platform energy management driver
> + * Copyright (C) 2010 IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This pseries platform device driver provides access to
> + * platform energy management capabilities.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/seq_file.h>
> +#include <linux/sysdev.h>
> +#include <linux/cpu.h>
> +#include <linux/of.h>
> +#include <asm/cputhreads.h>
> +#include <asm/page.h>
> +#include <asm/hvcall.h>
> +
> +
> +#define MODULE_VERS "1.0"

Argh, I hate module versions... but this one is less of an issue since
it doesn't seem to be being used anyway :-)

> +#define MODULE_NAME "pseries_energy"

Unused too.

> +
> +/* Helper Routines to convert between drc_index to cpu numbers */
> +
> +static u32 cpu_to_drc_index(int cpu)
> +{
> +	struct device_node *dn = NULL;
> +	const int *indexes;
> +	int i;
> +	dn = of_find_node_by_path("/cpus");
> +	if (dn == NULL)
> +		goto err;

Humm, I not sure this is really needed.  If you don't have /cpus you are
probably not going to boot.

> +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +	if (indexes == NULL)
> +		goto err;

These checks should probably be moved to module init rather than /sfs
read time.  If they fail, don't load the module and print a warning.  

These HCALLS and device-tree entire aren't going to be dynamic.

> +	/* Convert logical cpu number to core number */
> +	i = cpu_core_of_thread(cpu);
> +	/*
> +	 * The first element indexes[0] is the number of drc_indexes
> +	 * returned in the list.  Hence i+1 will get the drc_index
> +	 * corresponding to core number i.
> +	 */
> +	WARN_ON(i > indexes[0]);
> +	return indexes[i + 1];
> +err:
> +	printk(KERN_WARNING "cpu_to_drc_index(%d) failed", cpu);
> +	return 0;
> +}
> +
> +static int drc_index_to_cpu(u32 drc_index)
> +{
> +	struct device_node *dn = NULL;
> +	const int *indexes;
> +	int i, cpu;
> +	dn = of_find_node_by_path("/cpus");
> +	if (dn == NULL)
> +		goto err;

same here

> +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +	if (indexes == NULL)
> +		goto err;
> +	/*
> +	 * First element in the array is the number of drc_indexes
> +	 * returned.  Search through the list to find the matching
> +	 * drc_index and get the core number
> +	 */
> +	for (i = 0; i < indexes[0]; i++) {
> +		if (indexes[i + 1] == drc_index)
> +			break;
> +	}
> +	/* Convert core number to logical cpu number */
> +	cpu = cpu_first_thread_of_core(i);
> +	return cpu;
> +err:
> +	printk(KERN_WARNING "drc_index_to_cpu(%d) failed", drc_index);
> +	return 0;
> +}
> +
> +/*
> + * pseries hypervisor call H_BEST_ENERGY provides hints to OS on
> + * preferred logical cpus to activate or deactivate for optimized
> + * energy consumption.
> + */
> +
> +#define FLAGS_MODE1	0x004E200000080E01
> +#define FLAGS_MODE2	0x004E200000080401
> +#define FLAGS_ACTIVATE  0x100
> +
> +static ssize_t get_best_energy_list(char *page, int activate)
> +{
> +	int rc, cnt, i, cpu;
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +	unsigned long flags = 0;
> +	u32 *buf_page;
> +	char *s = page;
> +
> +	buf_page = (u32 *) get_zeroed_page(GFP_KERNEL);
> +	if (!buf_page)
> +		return -ENOMEM;
> +
> +	flags = FLAGS_MODE1;
> +	if (activate)
> +		flags |= FLAGS_ACTIVATE;
> +
> +	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
> +				0, 0, 0, 0, 0, 0);
> +	if (rc != H_SUCCESS) {
> +		free_page((unsigned long) buf_page);
> +		return -EINVAL;
> +	}
> +
> +	cnt = retbuf[0];
> +	for (i = 0; i < cnt; i++) {
> +		cpu = drc_index_to_cpu(buf_page[2*i+1]);
> +		if ((cpu_online(cpu) && !activate) ||
> +		    (!cpu_online(cpu) && activate))
> +			s += sprintf(s, "%d,", cpu);
> +	}
> +	if (s > page) { /* Something to show */
> +		s--; /* Suppress last comma */
> +		s += sprintf(s, "\n");
> +	}
> +
> +	free_page((unsigned long) buf_page);
> +	return s-page;
> +}
> +
> +static ssize_t get_best_energy_data(struct sys_device *dev,
> +					char *page, int activate)
> +{
> +	int rc;
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +	unsigned long flags = 0;
> +
> +	flags = FLAGS_MODE2;
> +	if (activate)
> +		flags |= FLAGS_ACTIVATE;
> +
> +	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags,
> +				cpu_to_drc_index(dev->id),
> +				0, 0, 0, 0, 0, 0, 0);
> +
> +	if (rc != H_SUCCESS)
> +		return -EINVAL;
> +
> +	return sprintf(page, "%lu\n", retbuf[1] >> 32);
> +}
> +
> +/* Wrapper functions */
> +
> +static ssize_t cpu_activate_hint_list_show(struct sysdev_class *class,
> +			struct sysdev_class_attribute *attr, char *page)
> +{
> +	return get_best_energy_list(page, 1);
> +}
> +
> +static ssize_t cpu_deactivate_hint_list_show(struct sysdev_class *class,
> +			struct sysdev_class_attribute *attr, char *page)
> +{
> +	return get_best_energy_list(page, 0);
> +}
> +
> +static ssize_t percpu_activate_hint_show(struct sys_device *dev,
> +			struct sysdev_attribute *attr, char *page)
> +{
> +	return get_best_energy_data(dev, page, 1);
> +}
> +
> +static ssize_t percpu_deactivate_hint_show(struct sys_device *dev,
> +			struct sysdev_attribute *attr, char *page)
> +{
> +	return get_best_energy_data(dev, page, 0);
> +}
> +
> +/*
> + * Create sysfs interface:
> + * /sys/devices/system/cpu/pseries_activate_hint_list
> + * /sys/devices/system/cpu/pseries_deactivate_hint_list
> + * 	Comma separated list of cpus to activate or deactivate
> + * /sys/devices/system/cpu/cpuN/pseries_activate_hint
> + * /sys/devices/system/cpu/cpuN/pseries_deactivate_hint
> + *	Per-cpu value of the hint

Do we really need both interfaces?  Seems like awk could generate one
from the other in userspace?

> + */
> +
> +struct sysdev_class_attribute attr_cpu_activate_hint_list =
> +		_SYSDEV_CLASS_ATTR(pseries_activate_hint_list, 0444,
> +		cpu_activate_hint_list_show, NULL);
> +
> +struct sysdev_class_attribute attr_cpu_deactivate_hint_list =
> +		_SYSDEV_CLASS_ATTR(pseries_deactivate_hint_list, 0444,
> +		cpu_deactivate_hint_list_show, NULL);
> +
> +struct sysdev_attribute attr_percpu_activate_hint =
> +		_SYSDEV_ATTR(pseries_activate_hint, 0444,
> +		percpu_activate_hint_show, NULL);
> +
> +struct sysdev_attribute attr_percpu_deactivate_hint =
> +		_SYSDEV_ATTR(pseries_deactivate_hint, 0444,
> +		percpu_deactivate_hint_show, NULL);

> +
> +static int __init pseries_energy_init(void)
> +{
> +	int cpu, err;
> +	struct sys_device *cpu_sys_dev;
> +
> +	/* Create the sysfs files */
> +	err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
> +				&attr_cpu_activate_hint_list.attr);
> +	if (!err)
> +		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
> +				&attr_cpu_deactivate_hint_list.attr);
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_sys_dev = get_cpu_sysdev(cpu);
> +		err = sysfs_create_file(&cpu_sys_dev->kobj,
> +				&attr_percpu_activate_hint.attr);
> +		if (err)
> +			break;
> +		err = sysfs_create_file(&cpu_sys_dev->kobj,
> +				&attr_percpu_deactivate_hint.attr);
> +		if (err)
> +			break;
> +	}
> +	return err;
> +
> +}
> +
> +static void __exit pseries_energy_cleanup(void)
> +{
> +	int cpu;
> +	struct sys_device *cpu_sys_dev;
> +
> +	/* Remove the sysfs files */
> +	sysfs_remove_file(&cpu_sysdev_class.kset.kobj,
> +				&attr_cpu_activate_hint_list.attr);
> +
> +	sysfs_remove_file(&cpu_sysdev_class.kset.kobj,
> +				&attr_cpu_deactivate_hint_list.attr);
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_sys_dev = get_cpu_sysdev(cpu);
> +		sysfs_remove_file(&cpu_sys_dev->kobj,
> +				&attr_percpu_activate_hint.attr);
> +		sysfs_remove_file(&cpu_sys_dev->kobj,
> +				&attr_percpu_deactivate_hint.attr);
> +	}
> +}
> +
> +module_init(pseries_energy_init);
> +module_exit(pseries_energy_cleanup);
> +MODULE_DESCRIPTION("Driver for pseries platform energy management");

Needs a less generic description. 

> +MODULE_AUTHOR("Vaidyanathan Srinivasan");
> +MODULE_LICENSE("GPL");
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AECF8B7D57
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 12:07:07 +1000 (EST)
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: svaidy@linux.vnet.ibm.com
In-Reply-To: <20100303181822.GH5439@dirshya.in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 12:04:49 +1000
Message-ID: <1270605889.13812.117.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-03-03 at 23:48 +0530, Vaidyanathan Srinivasan wrote:
> Hi,

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 03dd6a2..fbd93e3 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -359,6 +359,8 @@ void __init check_for_initrd(void)
>  #ifdef CONFIG_SMP
>  
>  int threads_per_core, threads_shift;
> +EXPORT_SYMBOL_GPL(threads_per_core);

While I agree it should be exported for the APIs in cputhread.h to be
usable from a module, this variable shouldn't be -used- directly, but
only via the API functions in there.

 .../...

> +
> +#define MODULE_VERS "1.0"
> +#define MODULE_NAME "pseries_energy"
> +
> +/* Helper Routines to convert between drc_index to cpu numbers */
> +
> +static u32 cpu_to_drc_index(int cpu)
> +{
> +	struct device_node *dn = NULL;
> +	const int *indexes;
> +	int i;
> +	dn = of_find_node_by_name(dn, "cpus");

Check the result. Also that's not a nice way to do that, you should look
for /cpus by path I reckon.

> +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);

Check the result here too.

> +	/* Convert logical cpu number to core number */
> +	i = cpu / threads_per_core;

Don't use that variable as I said earlier. Use cpu_thread_to_core()

> +	/*
> +	 * The first element indexes[0] is the number of drc_indexes
> +	 * returned in the list.  Hence i+1 will get the drc_index
> +	 * corresponding to core number i.
> +	 */
> +	WARN_ON(i > indexes[0]);
> +	return indexes[i + 1];
> +}
> +
> +static int drc_index_to_cpu(u32 drc_index)
> +{
> +	struct device_node *dn = NULL;
> +	const int *indexes;
> +	int i, cpu;
> +	dn = of_find_node_by_name(dn, "cpus");
> +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);

Same comments, check results and use /cpus path

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
> +	cpu = i * threads_per_core;

Here's more annoying as we don't have an API in cputhread.h for that.

In fact, we have a confusion in there since cpu_first_thread_in_core()
doesn't actually take a core number ...

I'm going to recommend a complicated approach but that's the best in the
long run:

 - First do a patch that renames cpu_first_thread_in_core() to something
clearer like cpu_first_thread_in_same_core() or cpu_leftmost_sibling()
(I think I prefer the later). Rename the few users in
arch/powerpc/mm/mmu_context_nohash.c and arch/powerpc/kernel/smp.c

 - Then do a patch that adds a cpu_first_thread_of_core() that takes a
core number, basically does:

static inline int cpu_first_thread_of_core(int core)
{
	return core << threads_shift;
}

 - Then add your modified H_BEST_ENERGY patch on top of it using the
above two as pre-reqs :-)

> +	return cpu;
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
> +
Why that blank line ?

> +	if (!buf_page)
> +		return 0;

So here you return 0 instead of -ENOMEM

> +	flags = FLAGS_MODE1;
> +	if (activate)
> +		flags |= FLAGS_ACTIVATE;
> +
> +	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
> +				0, 0, 0, 0, 0, 0);
> +
> +	

Again, no need for a blank line before xx = foo() and if (xx)

> if (rc != H_SUCCESS) {
> +		free_page((unsigned long) buf_page);
> +		return -EINVAL;
> +	}

And here you return an error code. Which one is right ?

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
> +						char *page)
> +{
> +	return get_best_energy_list(page, 1);
> +}
> +
> +static ssize_t cpu_deactivate_hint_list_show(struct sysdev_class *class,
> +						char *page)
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
> +MODULE_AUTHOR("Vaidyanathan Srinivasan");
> +MODULE_LICENSE("GPL");
> 

Cheers,
Ben.

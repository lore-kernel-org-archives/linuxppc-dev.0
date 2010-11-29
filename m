Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E018DB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 14:44:47 +1100 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Poll VPA for topology changes and
	update NUMA maps
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <20101109232501.17098.55112.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101109232436.17098.20055.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<20101109232501.17098.55112.sendpatchset@manic8ball.ltc.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 14:44:19 +1100
Message-ID: <1291002259.32570.274.camel@pasglop>
Mime-Version: 1.0
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, mjwolf@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-09 at 16:25 -0700, Jesse Larrew wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> This patch sets a timer during boot that will periodically poll the
> associativity change counters in the VPA. When a change in 
> associativity is detected, it retrieves the new associativity domain 
> information via the H_HOME_NODE_ASSOCIATIVITY hcall and updates the 
> NUMA node maps and sysfs entries accordingly. Note that since the 
> ibm,associativity device tree property does not exist on configurations 
> with both NUMA and SPLPAR enabled, no device tree updates are necessary.
> 
> Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> ---

No fundamental objection, just quick nits before I merge:
> +
> +/* Vrtual Processor Home Node (VPHN) support */
> +#define VPHN_NR_CHANGE_CTRS (8)
> +static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
> +static cpumask_t cpu_associativity_changes_mask;
> +static void topology_work_fn(struct work_struct *work);
> +static DECLARE_WORK(topology_work, topology_work_fn);

Remove the prototype for topology_work_fn() and puts the DECLARE_WORK
right below the function itself.

> +static void topology_timer_fn(unsigned long ignored);
> +static struct timer_list topology_timer =
> +	TIMER_INITIALIZER(topology_timer_fn, 0, 0);

Same deal.

> +static void set_topology_timer(void);
> +int stop_topology_update(void);
> +
> +/*
> + * Store the current values of the associativity change counters in the
> + * hypervisor.
> + */
> +static void setup_cpu_associativity_change_counters(void)
> +{
> +	int cpu = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		int i = 0;
> +		u8 *counts = vphn_cpu_change_counts[cpu];
> +		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
> +
> +		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
> +			counts[i] = hypervisor_counts[i];
> +		}
> +	}
> +
> +	return;
> +}
> +
> +/*
> + * The hypervisor maintains a set of 8 associativity change counters in
> + * the VPA of each cpu that correspond to the associativity levels in the
> + * ibm,associativity-reference-points property. When an associativity
> + * level changes, the corresponding counter is incremented.
> + *
> + * Set a bit in cpu_associativity_changes_mask for each cpu whose home
> + * node associativity levels have changed.
> + */
> +static void update_cpu_associativity_changes_mask(void)
> +{
> +	int cpu = 0;
> +	cpumask_t *changes = &cpu_associativity_changes_mask;
> +
> +	cpumask_clear(changes);
> +
> +	for_each_possible_cpu(cpu) {
> +		int i;
> +		u8 *counts = vphn_cpu_change_counts[cpu];
> +		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
> +
> +		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
> +			if (hypervisor_counts[i] > counts[i]) {
> +				counts[i] = hypervisor_counts[i];
> +
> +				if (!(cpumask_test_cpu(cpu, changes)))
> +					cpumask_set_cpu(cpu, changes);
> +			}
> +		}

This is a tad sub-optimal. I'd just set a local variable, and
after the inside loop set the cpumask bit when that variable is set.

Also, keep another variable that accumulate all bits set and return
its value so you don't have to re-check the mask in the caller.

cpumask operations can be expensive.
 
> +	}
> +
> +	return;

You don't need a return; at the end of a function.

> +}
> +
> +/* 6 64-bit registers unpacked into 12 32-bit associativity values */
> +#define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32))
> +
> +/*
> + * Convert the associativity domain numbers returned from the hypervisor
> + * to the sequence they would appear in the ibm,associativity property.
> + */
> +static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
> +{
> +	int i = 0;
> +	int nr_assoc_doms = 0;
> +	const u16 *field = (const u16*) packed;
> +
> +#define VPHN_FIELD_UNUSED	(0xffff)
> +#define VPHN_FIELD_MSB		(0x8000)
> +#define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
> +
> +	for (i = 0; i < VPHN_ASSOC_BUFSIZE; i++) {
> +		if (*field == VPHN_FIELD_UNUSED) {
> +			/* All significant fields processed, and remaining
> +			 * fields contain the reserved value of all 1's.
> +			 * Just store them.
> +			 */
> +			unpacked[i] = *((u32*)field);
> +			field += 2;
> +		}
> +		else if (*field & VPHN_FIELD_MSB) {
> +			/* Data is in the lower 15 bits of this field */
> +			unpacked[i] = *field & VPHN_FIELD_MASK;
> +			field++;
> +			nr_assoc_doms++;
> +		}
> +		else {
> +			/* Data is in the lower 15 bits of this field
> +			 * concatenated with the next 16 bit field
> +			 */
> +			unpacked[i] = *((u32*)field);
> +			field += 2;
> +			nr_assoc_doms++;
> +		}
> +	}
> +
> +	return nr_assoc_doms;
> +}
> +
> +/*
> + * Retrieve the new associativity information for a virtual processor's
> + * home node.
> + */
> +static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
> +{
> +	long rc = 0;
> +	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
> +	u64 flags = 1;
> +	int hwcpu = get_hard_smp_processor_id(cpu);
> +
> +	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
> +	vphn_unpack_associativity(retbuf, associativity);
> +
> +	return rc;
> +}
> +
> +static long
> +vphn_get_associativity(unsigned long cpu, unsigned int *associativity)
> +{

Nowadays, we prefer keeping the "static long" and the function name on
the same line. If you really want to avoid >80 col (I don't care myself
much as long as you stick below 100) then move the second argument down
one line.

> +	long rc = 0;
> +
> +	rc = hcall_vphn(cpu, associativity);
> +
> +	switch (rc) {
> +	case H_FUNCTION:
> +		printk(KERN_INFO
> +			"VPHN is not supported. Disabling polling...\n");
> +		stop_topology_update();
> +		break;
> +	case H_HARDWARE:
> +		printk(KERN_ERR
> +			"hcall_vphn() experienced a hardware fault "
> +			"preventing VPHN. Disabling polling...\n");
> +		stop_topology_update();
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * Update the node maps and sysfs entries for each cpu whose home node
> + * has changed.
> + */
> +int arch_update_cpu_topology(void)
> +{
> +	int cpu = 0, nid = 0, old_nid = 0;
> +	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
> +	struct sys_device *sysdev = NULL;
> +
> +	for_each_cpu_mask(cpu, cpu_associativity_changes_mask) {
> +		vphn_get_associativity(cpu, associativity);
> +		nid = associativity_to_nid(associativity);
> +
> +		if (nid < 0 || !node_online(nid))
> +			nid = first_online_node;
> +
> +		old_nid = numa_cpu_lookup_table[cpu];
> +
> +		/* Disable hotplug while we update the cpu
> +		 * masks and sysfs.
> +		 */
> +		get_online_cpus();
> +		unregister_cpu_under_node(cpu, old_nid);
> +		unmap_cpu_from_node(cpu);
> +		map_cpu_to_node(cpu, nid);
> +		register_cpu_under_node(cpu, nid);
> +		put_online_cpus();
> +
> +		sysdev = get_cpu_sysdev(cpu);
> +		if (sysdev)
> +			kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
> +	}
> +
> +	return 1;
> +}

That looks terribly expensive. Might be worth considering adding a way
to sysfs to "mv" an object around in the future.

> +static void topology_work_fn(struct work_struct *work)
> +{
> +	rebuild_sched_domains();
> +}
> +
> +void topology_schedule_update(void)
> +{
> +	schedule_work(&topology_work);
> +}
> +
> +static void topology_timer_fn(unsigned long ignored)
> +{
> +	update_cpu_associativity_changes_mask();
> +	if (!cpumask_empty(&cpu_associativity_changes_mask))
> +		topology_schedule_update();
> +	set_topology_timer();
> +}

I wonder if we really need that cpumask and timer overall. We might be
better off just having a per-cpu copy of the counters and check them in
the timer interrupt, it's low enough overhead don't you think ?

> +static void set_topology_timer(void)
> +{
> +	topology_timer.data = 0;
> +	topology_timer.expires = jiffies + 60 * HZ;
> +	add_timer(&topology_timer);
> +}
> +
> +/*
> + * Start polling for VPHN associativity changes.
> + */
> +int start_topology_update(void)
> +{
> +	int rc = 0;
> +
> +	if (firmware_has_feature(FW_FEATURE_VPHN)) {
> +		setup_cpu_associativity_change_counters();
> +		init_timer_deferrable(&topology_timer);
> +		set_topology_timer();
> +		rc = 1;
> +	}
> +
> +	return rc;
> +}
> +__initcall(start_topology_update);
> +
> +/*
> + * Disable polling for VPHN associativity changes.
> + */
> +int stop_topology_update(void)
> +{
> +	return del_timer(&topology_timer);
> +}

del_timer_sync() ?

Cheers,
Ben.

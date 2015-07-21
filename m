Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E76E1A0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 19:46:06 +1000 (AEST)
In-Reply-To: <55887781.2040709@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [4/6] pseries: Add CPU dlpar remove functionality
Message-Id: <20150721094606.46025140E0F@ozlabs.org>
Date: Tue, 21 Jul 2015 19:46:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-22-06 at 21:00:49 UTC, Nathan Fontenot wrote:
> Add the ability to dlpar remove CPUs via hotplug rtas events, either by
> specifying the drc-index of the CPU to remove or providing a count of cpus 
> to remove.
> 
> To accomplish we create a list of possible dr cpus and their drc indexes

What does "dr" mean? I know but not everyone does. If it's an acronymn it
should be uppercase and spelt out at its first usage.

> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 7890b2f..49b7196 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -506,6 +507,207 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>  	return rc;
>  }
>  
> +static struct device_node *cpu_drc_index_to_dn(struct device_node *parent,
> +					       u32 drc_index)
> +{
> +	struct device_node *dn;
> +	u32 my_index;
> +	int rc;
> +
> +	for_each_child_of_node(parent, dn) {
> +		if (of_node_cmp(dn->type, "cpu") != 0)
> +			continue;

parent is always "/cpus", so I wonder if this should just be:

	for_each_node_by_type(dn, "cpu") {

And then you don't need parent in here at all.

Or do we realistically expect to be looking for cpus under a node other than "/cpus" ?

> +		rc = of_property_read_u32(dn, "ibm,my-drc-index", &my_index);
> +		if (rc)
> +			continue;
> +
> +		if (my_index == drc_index)
> +			break;
> +	}
> +
> +	return dn;
> +}
> +
> +static int dlpar_cpu_remove_by_index(struct device_node *parent,
> +				     u32 drc_index)
> +{
> +	struct device_node *dn;
> +	int rc;
> +
> +	dn = cpu_drc_index_to_dn(parent, drc_index);
> +	if (!dn)
> +		return -ENODEV;
> +
> +	rc = dlpar_cpu_remove(dn, drc_index);
> +	of_node_put(dn);
> +	return rc;
> +}
> +
> +static int dlpar_cpus_possible(struct device_node *parent)
> +{
> +	int dr_cpus_possible;
> +
> +	/* The first u32 in the ibm,drc-indexes property is the numnber
> +	 * of drc entries in the property, which is the possible number
> +	 * number of dr capable cpus.
> +	 */
> +	of_property_read_u32(parent, "ibm,drc-indexes", &dr_cpus_possible);
> +	return dr_cpus_possible;
> +}
> +
> +struct dr_cpu {
> +	u32     drc_index;
> +	bool    present;
> +	bool    modified;
> +};
> +
> +static struct dr_cpu *get_dlpar_cpus(struct device_node *parent)
> +{
> +	struct device_node *dn;
> +	struct property *prop;
> +	struct dr_cpu *dr_cpus;
> +	const __be32 *p;
> +	u32 drc_index;
> +	int dr_cpus_possible, index;
> +	bool first;
> +
> +	dr_cpus_possible = dlpar_cpus_possible(parent);
> +	dr_cpus = kcalloc(dr_cpus_possible, sizeof(*dr_cpus), GFP_KERNEL);
> +	if (!dr_cpus)
> +		return NULL;
> +
> +	first = true;
> +	index = 0;
> +	of_property_for_each_u32(parent, "ibm,drc-indexes", prop, p,
> +				 drc_index) {
> +		if (first) {

What about:

		if (index == 0) {

Then you don't need first at all?

> +			/* The first entry is the number of drc indexes in
> +			 * the property, skip it.
> +			 */
> +			first = false;
> +			continue;
> +		}
> +
> +		dr_cpus[index].drc_index = drc_index;
> +
> +		dn = cpu_drc_index_to_dn(parent, drc_index);

The outer loop is iterating over all drc indexes (ie. one per cpu usually?),
and then cpu_drc_index_to_dn() will iterate over all cpus.

So that's n^2 for n = nr_cpus which is not ideal.

I realise we can't do much better, but what we can do is limit the number of
iterations of the outer loop. Because usually we will be here because we want
to offline less than nr_cpus cpus.

ie. if I ask to offline 1 cpu on a 4096 cpu system we will still do up to 16M
iterations in here, when all we needed to do was one iteration of the outer
loop.

So I think this routine should take the number of cpus we're trying to remove
and only iterate until it's found that many.

> +		if (dn) {
> +			dr_cpus[index].present = true;
> +			of_node_put(dn);
> +		}

Why do we put non present ones in the dr_cpus array at all? It just means you
have to skip them later? (in two separate places)

> +
> +		index++;
> +	}
> +
> +	return dr_cpus;
> +}
> +
> +static int dlpar_cpu_remove_by_count(struct device_node *parent,
> +				     u32 cpus_to_remove)
> +{
> +	struct dr_cpu *dr_cpus;
> +	int dr_cpus_removed = 0;
> +	int dr_cpus_present = 0;
> +	int dr_cpus_possible;
> +	int i, rc;
> +
> +	pr_info("Attempting to hot-remove %d CPUs\n", cpus_to_remove);
> +
> +	dr_cpus = get_dlpar_cpus(parent);

So I think this should be:

> +	dr_cpus = get_dlpar_cpus(parent, cpus_to_remove);

> +	if (!dr_cpus) {
> +		pr_info("Could not gather dr CPU info\n");
> +		return -EINVAL;
> +	}

And get_dlpar_cpus() should return cpus_to_remove worth of present cpus, or it
should error, meaning the below then won't be needed:

> +	dr_cpus_possible = dlpar_cpus_possible(parent);
> +
> +	for (i = 0; i < dr_cpus_possible; i++) {
> +		if (dr_cpus[i].present)
> +			dr_cpus_present++;
> +	}
> +
> +	/* Validate the available CPUs to remove.
> +	 * NOTE: we can't remove the last CPU.
> +	 */
> +	if (cpus_to_remove >= dr_cpus_present) {
> +		pr_err("Insufficient CPUs (%d) to satisfy remove request\n",
> +		       dr_cpus_present);
> +		kfree(dr_cpus);
> +		return -EINVAL;
> +	}
> +

Having only present cpus in dr_cpus should also simplify this loop because you
don't need to skip non-present ones:

> +	for (i = 0; i < dr_cpus_possible; i++) {
> +		if (dr_cpus_removed == cpus_to_remove)
> +			break;
> +
> +		if (!dr_cpus[i].present)
> +			continue;
> +
> +		rc = dlpar_cpu_remove_by_index(parent, dr_cpus[i].drc_index);
> +		if (!rc) {
> +			dr_cpus_removed++;
> +			dr_cpus[i].modified = true;
> +		}

else .. ?

Surely you should bail on the first error?

Definitely you should, because you're going to undo everything below anyway:

> +	}
> +
> +	if (dr_cpus_removed != cpus_to_remove) {
> +		pr_info("CPU hot-remove failed, adding any removed CPUs\n");
> +
> +		for (i = 0; i < dr_cpus_possible; i++) {
> +			if (!dr_cpus[i].modified)
> +				continue;

And if you bail on the first error above you shouldn't need modified, instead
you just iterate in reverse from i using a new counter, eg. j.

> +
> +			rc = dlpar_cpu_add(parent, dr_cpus[i].drc_index);
> +			if (rc)
> +				pr_info("Failed to re-add CPU (%x)\n",
> +					dr_cpus[i].drc_index);
> +		}
> +
> +		rc = -EINVAL;
> +	} else {
> +		rc = 0;
> +	}
> +
> +	kfree(dr_cpus);
> +	return rc;
> +}
> +
> +int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
> +{
> +	struct device_node *parent;
> +	u32 count, drc_index;
> +	int rc;
> +
> +	count = hp_elog->_drc_u.drc_count;
> +	drc_index = hp_elog->_drc_u.drc_index;

Those both need be32_to_cpu().

   arch/powerpc/platforms/pseries/hotplug-cpu.c:750:15: warning: incorrect type in assignment (different base types)
   arch/powerpc/platforms/pseries/hotplug-cpu.c:750:15:    expected unsigned int [unsigned] [usertype] count
   arch/powerpc/platforms/pseries/hotplug-cpu.c:750:15:    got restricted __be32 [usertype] drc_count
   arch/powerpc/platforms/pseries/hotplug-cpu.c:751:19: warning: incorrect type in assignment (different base types)
   arch/powerpc/platforms/pseries/hotplug-cpu.c:751:19:    expected unsigned int [unsigned] [usertype] drc_index
   arch/powerpc/platforms/pseries/hotplug-cpu.c:751:19:    got restricted __be32 [usertype] drc_index


Though looking closer I don't see where we ever pass or receive a
pseries_hp_errorlog to or from firmware? So I'm a bit confused why we're
bothering with the __be32 shenanigans. Hopefully I've just missed a detail
somewhere.

> +	parent = of_find_node_by_path("/cpus");
> +	if (!parent)
> +		return -ENODEV;
> +
> +	lock_device_hotplug();
> +
> +	switch (hp_elog->action) {
> +	case PSERIES_HP_ELOG_ACTION_REMOVE:
> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
> +			rc = dlpar_cpu_remove_by_count(parent, count);
> +		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> +			rc = dlpar_cpu_remove_by_index(parent, drc_index);
> +		else
> +			rc = -EINVAL;
> +		break;
> +	default:
> +		pr_err("Invalid action (%d) specified\n", hp_elog->action);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	unlock_device_hotplug();
> +	of_node_put(parent);
> +	return rc;
> +}
> +
>  #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
>  
>  static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 8411c27..58892f1 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -66,11 +66,16 @@ extern int dlpar_release_drc(u32 drc_index);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
> +int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);

I don't think this should be under CONFIG_MEMORY_HOTPLUG ?


cheers

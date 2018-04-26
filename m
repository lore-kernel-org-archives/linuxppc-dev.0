Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40X5Sl3nhzzF252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 04:39:19 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QIYjVX021974
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 14:39:16 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hkhyu5w6h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 14:39:16 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 14:39:15 -0400
Subject: Re: [RFC v2 3/3] postmigration/memory: Associativity &
 ibm,dynamic-memory-v2
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <28b32a01-3214-90be-9d24-9c717673fe5b@linux.vnet.ibm.com>
 <5b82e3ba-a92f-2c05-0922-d7f8c31df534@linux.vnet.ibm.com>
 <78156b9a-0b05-9d90-8c31-b3e04f581f94@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 13:39:11 -0500
MIME-Version: 1.0
In-Reply-To: <78156b9a-0b05-9d90-8c31-b3e04f581f94@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <366cdd1d-6026-473b-bf19-47834cd3bbd7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2018 04:35 PM, Michael Bringmann wrote:
> See below.
> 
> On 04/24/2018 12:17 PM, Nathan Fontenot wrote:
>> On 02/26/2018 02:53 PM, Michael Bringmann wrote:
>>> postmigration/memory: Now apply changes to the associativity of memory
>>> blocks described by the 'ibm,dynamic-memory-v2' property regarding
>>> the topology of LPARS in Post Migration events.
>>>
>>> * Extend the previous work done for the 'ibm,associativity-lookup-array'
>>>   to apply to either property 'ibm,dynamic-memory' or
>>>   'ibm,dynamic-memory-v2', whichever is present.
>>> * Add new code to parse the 'ibm,dynamic-memory-v2' property looking
>>>   for differences in block 'assignment', associativity indexes per
>>>   block, and any other difference currently known.
>>> * Rewrite some of the original code to parse the 'ibm,dynamic-memory'
>>>   property to take advantage of LMB parsing code.
>>>
>>> When block differences are recognized, the memory block may be removed,
>>> added, or updated depending upon the state of the new device tree
>>> property and differences from the migrated value of the property.
>>>
>>
>> The only thing we need to check during LPM is affinity updates, memory
>> is not added or removed as part of LPM.
>>
>> I think a slightly different approach to this may be worth considering.
>> One of the goals of the drmem.c code was to remove the need to parse the
>> device tree for memory directly. For this update, I think we could modify
>> the code that builds the drmem_info data so that it can return a drmem_info
>> struct instead of assuming to set the global one.
>>
>> This change would allow you to do a straight compare on the global vs. the
>> new info from the updated device tree property. I think this would be cleaner
>> and may be able to use the same routine for V1 and V2 properties.
> 
> The code dealing with the 'ibm,associativity' array updated cleanly to use
> the same function to scan the LMBs regardless of the version of the properties.
> 
> The code dealing with changes to 'ibm,dynamic-memory-v2' is a mirror of the
> code in 'pseries_update_drconf_memory' that deals with changes to the property
> 'ibm,dynamic-memory', so it should also be updated.  On the other hand, do we
> need to consider the memory requirements of creating/cloning the drmem_info
> structure to provide a copy based on the new 'dynamic-memory' property?
> Or is this not an issue?

If done correctly, using the drmem code to create a drmem_info struct from
the new memory property would allow us to use the same comparison routine
for v1 and v2 versions of the property.

The size of the drmem_info data is not big enough to be concerned about
memory requirements when making a copy. 

-Nathan

> 
>>
>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>> ---
>>> Changes in RFC v2:
>>>   -- Reuse existing parser code from 'drmem.c' in parsing property
>>>      'imb,dynamic-memory-v2' for migration.
>>>   -- Fix crash during migration that occurs on non-VPHN systems
>>>      when attempting to reset topology timer.
>>>   -- Change section of a support function + variable from __init 
>>>      to normal runtime to make them visible to migration code.
>>> ---
>>>  arch/powerpc/include/asm/drmem.h                |    8 +
>>>  arch/powerpc/mm/drmem.c                         |   23 ++-
>>>  arch/powerpc/mm/numa.c                          |    3 
>>>  arch/powerpc/platforms/pseries/hotplug-memory.c |  175 +++++++++++++++++++----
>>>  drivers/of/fdt.c                                |    4 -
>>>  include/linux/of_fdt.h                          |    2 
>>>  6 files changed, 170 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
>>> index 47a7012..e4773c9 100644
>>> --- a/arch/powerpc/include/asm/drmem.h
>>> +++ b/arch/powerpc/include/asm/drmem.h
>>> @@ -92,6 +92,14 @@ void __init walk_drmem_lmbs(struct device_node *dn,
>>>  			void (*func)(struct drmem_lmb *, const __be32 **));
>>>  int drmem_update_dt(void);
>>>
>>> +void walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *data,
>>> +			void (*func)(struct drmem_lmb *, const __be32 **));
>>> +
>>> +void read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>> +			const __be32 **prop);
>>> +void walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *data,
>>> +			void (*func)(struct drmem_lmb *, const __be32 **));
>>> +
>>>  #ifdef CONFIG_PPC_PSERIES
>>>  void __init walk_drmem_lmbs_early(unsigned long node,
>>>  			void (*func)(struct drmem_lmb *, const __be32 **));
>>> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
>>> index 31dbe14..e47a6e0 100644
>>> --- a/arch/powerpc/mm/drmem.c
>>> +++ b/arch/powerpc/mm/drmem.c
>>> @@ -192,7 +192,7 @@ int drmem_update_dt(void)
>>>  	return rc;
>>>  }
>>>
>>> -static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
>>> +static void read_drconf_v1_cell(struct drmem_lmb *lmb,
>>>  				       const __be32 **prop)
>>>  {
>>>  	const __be32 *p = *prop;
>>> @@ -208,7 +208,7 @@ static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
>>>  	*prop = p;
>>>  }
>>>
>>> -static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
>>> +void walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *data,
>>>  			void (*func)(struct drmem_lmb *, const __be32 **))
>>>  {
>>>  	struct drmem_lmb lmb;
>>> @@ -218,11 +218,12 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
>>>
>>>  	for (i = 0; i < n_lmbs; i++) {
>>>  		read_drconf_v1_cell(&lmb, &prop);
>>> -		func(&lmb, &usm);
>>> +		func(&lmb, &data);
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL(walk_drmem_v1_lmbs);
>>>
>>> -static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>> +void read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>>  				       const __be32 **prop)
>>>  {
>>>  	const __be32 *p = *prop;
>>> @@ -235,8 +236,9 @@ static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
>>>
>>>  	*prop = p;
>>>  }
>>> +EXPORT_SYMBOL(read_drconf_v2_cell);
>>>
>>> -static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
>>> +void walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *data,
>>>  			void (*func)(struct drmem_lmb *, const __be32 **))
>>>  {
>>>  	struct of_drconf_cell_v2 dr_cell;
>>> @@ -258,10 +260,11 @@ static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
>>>  			lmb.aa_index = dr_cell.aa_index;
>>>  			lmb.flags = dr_cell.flags;
>>>
>>> -			func(&lmb, &usm);
>>> +			func(&lmb, &data);
>>>  		}
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL(walk_drmem_v2_lmbs);
>>>
>>>  #ifdef CONFIG_PPC_PSERIES
>>>  void __init walk_drmem_lmbs_early(unsigned long node,
>>> @@ -280,12 +283,12 @@ void __init walk_drmem_lmbs_early(unsigned long node,
>>>
>>>  	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
>>>  	if (prop) {
>>> -		__walk_drmem_v1_lmbs(prop, usm, func);
>>> +		walk_drmem_v1_lmbs(prop, usm, func);
>>>  	} else {
>>>  		prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2",
>>>  					   &len);
>>>  		if (prop)
>>> -			__walk_drmem_v2_lmbs(prop, usm, func);
>>> +			walk_drmem_v2_lmbs(prop, usm, func);
>>>  	}
>>>
>>>  	memblock_dump_all();
>>> @@ -340,11 +343,11 @@ void __init walk_drmem_lmbs(struct device_node *dn,
>>>
>>>  	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
>>>  	if (prop) {
>>> -		__walk_drmem_v1_lmbs(prop, usm, func);
>>> +		walk_drmem_v1_lmbs(prop, usm, func);
>>>  	} else {
>>>  		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
>>>  		if (prop)
>>> -			__walk_drmem_v2_lmbs(prop, usm, func);
>>> +			walk_drmem_v2_lmbs(prop, usm, func);
>>>  	}
>>>  }
>>>
>>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>>> index 0e573f9..2545fea 100644
>>> --- a/arch/powerpc/mm/numa.c
>>> +++ b/arch/powerpc/mm/numa.c
>>> @@ -1395,7 +1395,8 @@ static void topology_timer_fn(struct timer_list *unused)
>>>
>>>  static void reset_topology_timer(void)
>>>  {
>>> -	mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
>>> +	if (vphn_enabled)
>>> +		mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
>>
>> This really looks like a bug fix that should be in a different patch.
> 
> Okay.
> 
>>
>> -Nathan
> 
> Thanks.
> Michael
> 
>>
>>>  }
>>>
>>>  #ifdef CONFIG_SMP
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> index b63181d..bf717e2 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> @@ -1051,49 +1051,155 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>>>  	return rc;
>>>  }
>>>
>>> -struct assoc_arrays {
>>> -	u32 n_arrays;
>>> -	u32 array_sz;
>>> -	const __be32 *arrays;
>>> -};
>>> +static inline int pseries_memory_v2_find_drc(u32 drc_index,
>>> +			u64 *base_addr, unsigned long memblock_size,
>>> +			struct of_drconf_cell_v2 *dm)
>>> +{
>>> +	if ((dm->drc_index <= drc_index) &&
>>> +		(drc_index <= (dm->drc_index + dm->seq_lmbs - 1))) {
>>> +		int offset = drc_index - dm->drc_index;
>>> +
>>> +		(*base_addr) = dm->base_addr +
>>> +				(offset * memblock_size);
>>> +	} else if (drc_index > (dm->drc_index +
>>> +				dm->seq_lmbs - 1)) {
>>> +		return -1;
>>> +	} else if (dm->drc_index > drc_index) {
>>> +		return -1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>>
>>> -static int pseries_update_ala_memory_aai(int aa_index,
>>> -					struct property *dmprop)
>>> +static int pseries_update_drconf_memory_v2(struct of_reconfig_data *pr)
>>>  {
>>> -	struct of_drconf_cell *drmem;
>>> -	u32 entries;
>>> -	__be32 *p;
>>> -	int i;
>>> -	int rc = 0;
>>> +	const __be32 *new_drmem, *old_drmem;
>>> +	unsigned long memblock_size;
>>> +	u32 new_lmb_sets, old_lmb_sets;
>>> +	u64 old_base_addr;
>>> +	int i, rc = 0;
>>>
>>> -	p = (__be32 *) dmprop->value;
>>> -	if (!p)
>>> +	if (rtas_hp_event)
>>> +		return 0;
>>> +
>>> +	memblock_size = pseries_memory_block_size();
>>> +	if (!memblock_size)
>>>  		return -EINVAL;
>>>
>>>  	/* The first int of the property is the number of lmb's
>>>  	 * described by the property. This is followed by an array
>>> -	 * of of_drconf_cell entries. Get the number of entries
>>> -	 * and skip to the array of of_drconf_cell's.
>>> +	 * of of_drconf_cell_v2 entries. Get the number of entries
>>> +	 * and skip to the array of of_drconf_cell_v2's.
>>>  	 */
>>> -	entries = be32_to_cpu(*p++);
>>> -	drmem = (struct of_drconf_cell *)p;
>>> +	old_drmem = (__be32 *) pr->old_prop->value;
>>> +	if (!old_drmem)
>>> +		return -EINVAL;
>>> +	old_lmb_sets = of_read_number(old_drmem++, 1);
>>>
>>> -	for (i = 0; i < entries; i++) {
>>> -		if ((be32_to_cpu(drmem[i].aa_index) != aa_index) &&
>>> -			(be32_to_cpu(drmem[i].flags) & DRCONF_MEM_ASSIGNED)) {
>>> -			rc = dlpar_memory_readd_by_index(
>>> -				be32_to_cpu(drmem[i].drc_index));
>>> +	new_drmem = (__be32 *)pr->prop->value;
>>> +	new_lmb_sets = of_read_number(new_drmem++, 1);
>>> +
>>> +	for (i = 0; i < old_lmb_sets; i++) {
>>> +		int j;
>>> +		struct of_drconf_cell_v2 old_cell, new_cell;
>>> +
>>> +		read_drconf_v2_cell(&old_cell, &old_drmem);
>>> +		read_drconf_v2_cell(&new_cell, &new_drmem);
>>> +
>>> +		for (j = 0; j < new_cell.seq_lmbs; j++) {
>>> +			if (pseries_memory_v2_find_drc(
>>> +				new_cell.drc_index + j,
>>> +				&old_base_addr,
>>> +				memblock_size,
>>> +				&old_cell))
>>> +				continue;
>>> +
>>> +			if ((old_cell.flags &
>>> +					DRCONF_MEM_ASSIGNED) &&
>>> +			    (!(new_cell.flags &
>>> +					DRCONF_MEM_ASSIGNED))) {
>>> +				rc = pseries_remove_memblock(
>>> +					old_base_addr,
>>> +					memblock_size);
>>> +			} else if ((!(old_cell.flags &
>>> +					DRCONF_MEM_ASSIGNED)) &&
>>> +				   (new_cell.flags &
>>> +					DRCONF_MEM_ASSIGNED)) {
>>> +				rc = memblock_add(
>>> +					old_base_addr, memblock_size);
>>> +			} else if ((old_cell.aa_index !=
>>> +				    new_cell.aa_index) &&
>>> +				   (new_cell.flags &
>>> +					DRCONF_MEM_ASSIGNED)) {
>>> +				dlpar_memory_readd_by_index(
>>> +					new_cell.drc_index + j);
>>> +			}
>>>  		}
>>>  	}
>>>
>>> -	return rc;
>>> +	return 0;
>>> +}
>>> +
>>> +struct assoc_arrays {
>>> +	u32 n_arrays;
>>> +	u32 array_sz;
>>> +	const __be32 *arrays;
>>> +};
>>> +
>>> +struct update_ala_memory_aai_struct {
>>> +	int aa_index;
>>> +};
>>> +
>>> +static void update_ala_memory_aai_cb(struct drmem_lmb *lmb,
>>> +					const __be32 **data)
>>> +{
>>> +	struct update_ala_memory_aai_struct *updt =
>>> +		(struct update_ala_memory_aai_struct *)*data;
>>> +
>>> +	if ((lmb->aa_index != updt->aa_index) &&
>>> +		(lmb->flags & DRCONF_MEM_ASSIGNED))
>>> +		dlpar_memory_readd_by_index(lmb->drc_index);
>>> +}
>>> +
>>> +static int pseries_update_ala_memory_aai_v1(int aa_index,
>>> +				const __be32 *dmprop)
>>> +{
>>> +	struct update_ala_memory_aai_struct data = {
>>> +		aa_index };
>>> +
>>> +	walk_drmem_v1_lmbs(dmprop, (const __be32 *)&data,
>>> +			update_ala_memory_aai_cb);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int pseries_update_ala_memory_aai_v2(int aa_index,
>>> +				const __be32 *dmprop)
>>> +{
>>> +	struct update_ala_memory_aai_struct data = {
>>> +		aa_index };
>>> +
>>> +	walk_drmem_v2_lmbs(dmprop, (const __be32 *)&data,
>>> +			update_ala_memory_aai_cb);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int pseries_update_ala_memory_aai(int v1, int aa_index,
>>> +				const __be32 *dmprop)
>>> +{
>>> +	if (v1)
>>> +		return pseries_update_ala_memory_aai_v1(aa_index, dmprop);
>>> +	else
>>> +		return pseries_update_ala_memory_aai_v2(aa_index, dmprop);
>>>  }
>>>
>>>  static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>>>  {
>>>  	struct assoc_arrays new_ala, old_ala;
>>>  	struct device_node *dn;
>>> -	struct property *dmprop;
>>> +	const __be32 *dmprop;
>>> +	bool v1 = true;
>>>  	__be32 *p;
>>>  	int i, lim;
>>>
>>> @@ -1104,10 +1210,15 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>>>  	if (!dn)
>>>  		return -ENODEV;
>>>
>>> -	dmprop = of_find_property(dn, "ibm,dynamic-memory", NULL);
>>> +	dmprop = of_get_property(dn, "ibm,dynamic-memory", NULL);
>>>  	if (!dmprop) {
>>> -		of_node_put(dn);
>>> -		return -ENODEV;
>>> +		v1 = false;
>>> +		dmprop = of_get_property(dn, "ibm,dynamic-memory-v2",
>>> +					NULL);
>>> +		if (!dmprop) {
>>> +			of_node_put(dn);
>>> +			return -ENODEV;
>>> +		}
>>>  	}
>>>
>>>  	/*
>>> @@ -1149,11 +1260,11 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>>>  						new_ala.array_sz))
>>>  				continue;
>>>
>>> -			pseries_update_ala_memory_aai(i, dmprop);
>>> +			pseries_update_ala_memory_aai(v1, i, dmprop);
>>>  		}
>>>
>>>  		for (i = lim; i < new_ala.n_arrays; i++)
>>> -			pseries_update_ala_memory_aai(i, dmprop);
>>> +			pseries_update_ala_memory_aai(v1, i, dmprop);
>>>
>>>  	} else {
>>>  		/* Update all entries representing these rows;
>>> @@ -1161,7 +1272,7 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>>>  		 * have equivalent values.
>>>  		 */
>>>  		for (i = 0; i < lim; i++)
>>> -			pseries_update_ala_memory_aai(i, dmprop);
>>> +			pseries_update_ala_memory_aai(v1, i, dmprop);
>>>  	}
>>>
>>>  	of_node_put(dn);
>>> @@ -1184,6 +1295,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>>>  	case OF_RECONFIG_UPDATE_PROPERTY:
>>>  		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
>>>  			err = pseries_update_drconf_memory(rd);
>>> +		if (!strcmp(rd->prop->name, "ibm,dynamic-memory-v2"))
>>> +			err = pseries_update_drconf_memory_v2(rd);
>>>  		if (!strcmp(rd->prop->name,
>>>  				"ibm,associativity-lookup-arrays"))
>>>  			err = pseries_update_ala_memory(rd);
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 4675e5a..00df576 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -539,7 +539,7 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>>
>>>  /* Everything below here references initial_boot_params directly. */
>>> -int __initdata dt_root_addr_cells;
>>> +int dt_root_addr_cells;
>>>  int __initdata dt_root_size_cells;
>>>
>>>  void *initial_boot_params;
>>> @@ -1013,7 +1013,7 @@ int __init early_init_dt_scan_root(unsigned long node, const char *uname,
>>>  	return 1;
>>>  }
>>>
>>> -u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
>>> +u64 dt_mem_next_cell(int s, const __be32 **cellp)
>>>  {
>>>  	const __be32 *p = *cellp;
>>>
>>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>>> index 013c541..14c8681 100644
>>> --- a/include/linux/of_fdt.h
>>> +++ b/include/linux/of_fdt.h
>>> @@ -40,7 +40,7 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>>>  				   struct device_node **mynodes);
>>>
>>>  /* TBD: Temporary export of fdt globals - remove when code fully merged */
>>> -extern int __initdata dt_root_addr_cells;
>>> +extern int dt_root_addr_cells;
>>>  extern int __initdata dt_root_size_cells;
>>>  extern void *initial_boot_params;
>>>
>>
> 

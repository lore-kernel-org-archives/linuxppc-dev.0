Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1E721A08C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:24:23 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 10:54:19 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 10BAFE0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 10:54:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45OT1B64290840
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 10:54:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45OFGk008199
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 10:54:16 +0530
Date: Thu, 4 Dec 2014 16:24:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/8] PCI/hotplug/rpa: Create PCI slot properly
Message-ID: <20141204052413.GA22633@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416869365-7671-6-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416956697.5089.11.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416956697.5089.11.camel@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 10:04:57AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
>> When loading rpaphp.ko on a P7 box, I didn't see any PCI slots
>> created under /sys/bus/pci/slots as expected. It seems that the
>> RPA PCI slot stuff has been broken for long time. The driver
>> doesn't use the properties of PCI device-tree nodes properly to
>> populate PCI slots: device-tree node property "ibm,my-drc-index"
>> is the identifier of hotpluggable PCI slot. The (direct or indirect)
>> parent device-tree node should have properties associated with the
>> "ibm,my-drc-index", which are "ibm,drc-indexes","ibm,drc-names",
>> "ibm,drc-types", "ibm,drc-power-domains".
>> 
>> The patch parses above device-tree node properties to create PCI
>> slots properly. One PCI slot is created for PCI device-tree node,
>> which has meaningful "ibm,my-drc-index".
>
>Nathan, can you review this ?
>

Ben had the suggestion to have separate drivers for pSeries and PowerNV.
So this patch isn't related to PowerNV PCI hotplug any more. I'll send
reworked patch (including the cleanup one) separately and put Nathan to
the cc list.

Thanks,
Gavin

>Cheers,
>Ben.
>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/hotplug/rpaphp.h      |   2 +-
>>  drivers/pci/hotplug/rpaphp_core.c | 205 ++++++++++++++------------------------
>>  2 files changed, 74 insertions(+), 133 deletions(-)
>> 
>> diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
>> index b2593e8..39ddbdf 100644
>> --- a/drivers/pci/hotplug/rpaphp.h
>> +++ b/drivers/pci/hotplug/rpaphp.h
>> @@ -92,7 +92,7 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state);
>>  /* rpaphp_core.c */
>>  int rpaphp_add_slot(struct device_node *dn);
>>  int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
>> -		char **drc_name, char **drc_type, int *drc_power_domain);
>> +		char **drc_name, char **drc_type, int *drc_power);
>>  
>>  /* rpaphp_slot.c */
>>  void dealloc_slot_struct(struct slot *slot);
>> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
>> index ff800df..a639c5c 100644
>> --- a/drivers/pci/hotplug/rpaphp_core.c
>> +++ b/drivers/pci/hotplug/rpaphp_core.c
>> @@ -165,119 +165,76 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
>>  	return speed;
>>  }
>>  
>> -static int get_children_props(struct device_node *dn, const int **drc_indexes,
>> -		const int **drc_names, const int **drc_types,
>> -		const int **drc_power_domains)
>> +static int parse_drc_props(struct device_node *dn, u32 drc_index,
>> +			   char **drc_name, char **drc_type, u32 *drc_power)
>>  {
>> -	const int *indexes, *names, *types, *domains;
>> +	const u32 *indexes, *names, *types, *domains;
>> +	char *name, *type;
>> +	struct device_node *parent = dn;
>> +	u32 i;
>> +
>> +	while ((parent = of_get_parent(parent))) {
>> +		indexes = of_get_property(parent, "ibm,drc-indexes", NULL);
>> +		names   = of_get_property(parent, "ibm,drc-names", NULL);
>> +		types   = of_get_property(parent, "ibm,drc-types", NULL);
>> +		domains = of_get_property(parent, "ibm,drc-power-domains", NULL);
>> +
>> +		if (!indexes || !names || !types || !domains) {
>> +			of_node_put(parent);
>> +			continue;
>> +		}
>>  
>> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>> -	names = of_get_property(dn, "ibm,drc-names", NULL);
>> -	types = of_get_property(dn, "ibm,drc-types", NULL);
>> -	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
>> +		name = (char *)&names[1];
>> +		type = (char *)&types[1];
>> +		for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>> +			if (be32_to_cpu(indexes[i + 1]) != drc_index) {
>> +				name += (strlen(name) + 1);
>> +				type += (strlen(type) + 1);
>> +				continue;
>> +			}
>>  
>> -	/* Slot does not have dynamically-removable children */
>> -	if (!indexes || !names || !types || !domains)
>> -		return -EINVAL;
>> +			/* Matched index */
>> +			if (drc_name)
>> +				*drc_name = name;
>> +			if (drc_type)
>> +				*drc_type = type;
>> +			if (drc_power)
>> +				*drc_power = be32_to_cpu(domains[i + 1]);
>> +
>> +			of_node_put(parent);
>> +			return 0;
>> +		}
>>  
>> -	if (drc_indexes)
>> -		*drc_indexes = indexes;
>> -	/* &drc_names[1] contains NULL terminated slot names */
>> -	if (drc_names)
>> -		*drc_names = names;
>> -	/* &drc_types[1] contains NULL terminated slot types */
>> -	if (drc_types)
>> -		*drc_types = types;
>> -	if (drc_power_domains)
>> -		*drc_power_domains = domains;
>> +		/* Next level parent */
>> +		of_node_put(parent);
>> +	}
>>  
>> -	return 0;
>> +	return -ENODEV;
>>  }
>>  
>> -/* To get the DRC props describing the current node, first obtain it's
>> +/*
>> + * To get the DRC props describing the current node, first obtain it's
>>   * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
>>   * the my-drc-index for correlation, and obtain the requested properties.
>>   */
>>  int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
>> -		char **drc_name, char **drc_type, int *drc_power_domain)
>> +			 char **drc_name, char **drc_type, int *drc_power)
>>  {
>> -	const int *indexes, *names;
>> -	const int *types, *domains;
>> -	const unsigned int *my_index;
>> -	char *name_tmp, *type_tmp;
>> -	int i, rc;
>> +	const u32 *my_index;
>>  
>> +	/* Check if node is capable of hotplug */
>>  	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
>> -	/* Node isn't DLPAR/hotplug capable */
>>  	if (!my_index)
>>  		return -EINVAL;
>> +	if (drc_index)
>> +		*drc_index = be32_to_cpu(*my_index);
>>  
>> -	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
>> -	if (rc < 0)
>> -		return -EINVAL;
>> -
>> -	name_tmp = (char *) &names[1];
>> -	type_tmp = (char *) &types[1];
>> -
>> -	/* Iterate through parent properties, looking for my-drc-index */
>> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>> -		if ((unsigned int) indexes[i + 1] == *my_index) {
>> -			if (drc_name)
>> -				*drc_name = name_tmp;
>> -			if (drc_type)
>> -				*drc_type = type_tmp;
>> -			if (drc_index)
>> -				*drc_index = be32_to_cpu(*my_index);
>> -			if (drc_power_domain)
>> -				*drc_power_domain = be32_to_cpu(domains[i+1]);
>> -			return 0;
>> -		}
>> -		name_tmp += (strlen(name_tmp) + 1);
>> -		type_tmp += (strlen(type_tmp) + 1);
>> -	}
>> -
>> -	return -EINVAL;
>> +	return parse_drc_props(dn, be32_to_cpu(*my_index),
>> +			       drc_name, drc_type, drc_power);
>>  }
>>  EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
>>  
>>  /**
>> - * is_php_dn() - return true if this is a hotpluggable pci slot, else false
>> - * @dn: target &device_node
>> - * @indexes: passed to get_children_props()
>> - * @names: passed to get_children_props()
>> - * @types: returned from get_children_props()
>> - * @power_domains:
>> - *
>> - * This routine will return true only if the device node is
>> - * a hotpluggable slot. This routine will return false
>> - * for built-in pci slots (even when the built-in slots are
>> - * dlparable.)
>> - */
>> -static bool is_php_dn(struct device_node *dn,
>> -		      const int **indexes, const int **names,
>> -		      const int **types, const int **power_domains)
>> -{
>> -	const int *drc_types;
>> -	const char *drc_type_str;
>> -	char *endptr;
>> -	unsigned long val;
>> -	int rc;
>> -
>> -	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
>> -	if (rc < 0)
>> -		return false;
>> -
>> -	/* PCI Hotplug nodes have an integer for drc_type */
>> -	drc_type_str = (char *)&drc_types[1];
>> -	val = simple_strtoul(drc_type_str, &endptr, 10);
>> -	if (endptr == drc_type_str)
>> -		return false;
>> -
>> -	*types = drc_types;
>> -	return true;
>> -}
>> -
>> -/**
>>   * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
>>   * @dn: device node of slot
>>   *
>> @@ -295,52 +252,36 @@ static bool is_php_dn(struct device_node *dn,
>>   */
>>  int rpaphp_add_slot(struct device_node *dn)
>>  {
>> +	char *name, *type, *endptr;
>> +	int index, power_domain;
>>  	struct slot *slot;
>> -	int retval = 0;
>> -	int i;
>> -	const int *indexes, *names, *types, *power_domains;
>> -	char *name, *type;
>> -
>> -	if (!dn->name || strcmp(dn->name, "pci"))
>> -		return 0;
>> +	int val, ret;
>>  
>> -	/* If this is not a hotplug slot, return without doing anything. */
>> -	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
>> -		return 0;
>> -
>> -	dbg("Entry %s: dn->full_name=%s\n", __func__, dn->full_name);
>> -
>> -	/* register PCI devices */
>> -	name = (char *) &names[1];
>> -	type = (char *) &types[1];
>> -	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
>> -		int index;
>> -
>> -		index = be32_to_cpu(indexes[i + 1]);
>> -		slot = alloc_slot_struct(dn, index, name,
>> -					 be32_to_cpu(power_domains[i + 1]));
>> -		if (!slot)
>> -			return -ENOMEM;
>> -
>> -		slot->type = simple_strtoul(type, NULL, 10);
>> -
>> -		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
>> -				index, name, type);
>> +	/* Get and parse the hotplug properties */
>> +	ret = rpaphp_get_drc_props(dn, &index, &name, &type, &power_domain);
>> +	if (ret)
>> +		return ret;
>>  
>> -		retval = rpaphp_enable_slot(slot);
>> -		if (!retval)
>> -			retval = rpaphp_register_slot(slot);
>> +	/* PCI Hotplug nodes have an integer for drc_type */
>> +	val = simple_strtoul(type, &endptr, 10);
>> +	if (endptr == type)
>> +		return -EINVAL;
>>  
>> -		if (retval)
>> -			dealloc_slot_struct(slot);
>> +	slot = alloc_slot_struct(dn, index, name, power_domain);
>> +	if (!slot)
>> +		return -ENOMEM;
>>  
>> -		name += strlen(name) + 1;
>> -		type += strlen(type) + 1;
>> -	}
>> -	dbg("%s - Exit: rc[%d]\n", __func__, retval);
>> +	slot->type = val;
>> +	ret = rpaphp_enable_slot(slot);
>> +	if (!ret)
>> +		ret = rpaphp_register_slot(slot);
>> +	if (ret)
>> +		goto fail;
>>  
>> -	/* XXX FIXME: reports a failure only if last entry in loop failed */
>> -	return retval;
>> +	return 0;
>> +fail:
>> +	dealloc_slot_struct(slot);
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(rpaphp_add_slot);
>>  
>
>

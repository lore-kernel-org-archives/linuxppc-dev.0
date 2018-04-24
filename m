Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VqNh0rWjzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 03:01:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3OH17kI105425
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 13:01:21 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hj61ks5mt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 13:01:19 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 24 Apr 2018 13:01:14 -0400
Subject: Re: [RFC v2 2/3] postmigration/memory: Review assoc lookup array
 changes
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <02fbce66-e91a-e553-21da-b9deedc2c528@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 12:01:10 -0500
MIME-Version: 1.0
In-Reply-To: <02fbce66-e91a-e553-21da-b9deedc2c528@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <69529aa2-aa7d-5107-0fa8-a0c9ad06420a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/26/2018 02:53 PM, Michael Bringmann wrote:
> postmigration/memory: In an LPAR migration scenario, the property
> "ibm,associativity-lookup-arrays" may change.  In the event that a
> row of the array differs, locate all assigned memory blocks with that
> 'aa_index' and 're-add' them to the system memory block data structures.
> In the process of the 're-add', the appropriate entry of the property
> 'ibm,dynamic-memory' would be updated as well as any other applicable
> system data structures.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in RFC v2:
>   -- Simplify code to update memory nodes during mobility checks.
>      Remove functions to generate extra HP_ELOG messages in favor
>      of direct function calls to dlpar_memory_readd_by_index.
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  120 +++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 2341eae..b63181d 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -1051,6 +1051,123 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>  	return rc;
>  }
> 
> +struct assoc_arrays {
> +	u32 n_arrays;
> +	u32 array_sz;
> +	const __be32 *arrays;
> +};
> +
> +static int pseries_update_ala_memory_aai(int aa_index,
> +					struct property *dmprop)
> +{
> +	struct of_drconf_cell *drmem;
> +	u32 entries;
> +	__be32 *p;
> +	int i;
> +	int rc = 0;
> +
> +	p = (__be32 *) dmprop->value;
> +	if (!p)
> +		return -EINVAL;
> +
> +	/* The first int of the property is the number of lmb's
> +	 * described by the property. This is followed by an array
> +	 * of of_drconf_cell entries. Get the number of entries
> +	 * and skip to the array of of_drconf_cell's.
> +	 */
> +	entries = be32_to_cpu(*p++);
> +	drmem = (struct of_drconf_cell *)p;
> +
> +	for (i = 0; i < entries; i++) {
> +		if ((be32_to_cpu(drmem[i].aa_index) != aa_index) &&
> +			(be32_to_cpu(drmem[i].flags) & DRCONF_MEM_ASSIGNED)) {
> +			rc = dlpar_memory_readd_by_index(
> +				be32_to_cpu(drmem[i].drc_index));
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static int pseries_update_ala_memory(struct of_reconfig_data *pr)
> +{
> +	struct assoc_arrays new_ala, old_ala;
> +	struct device_node *dn;
> +	struct property *dmprop;
> +	__be32 *p;
> +	int i, lim;
> +
> +	if (rtas_hp_event)
> +		return 0;
> +
> +	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (!dn)
> +		return -ENODEV;
> +
> +	dmprop = of_find_property(dn, "ibm,dynamic-memory", NULL);
> +	if (!dmprop) {
> +		of_node_put(dn);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The layout of the ibm,associativity-lookup-arrays
> +	 * property is a number N indicating the number of
> +	 * associativity arrays, followed by a number M
> +	 * indicating the size of each associativity array,
> +	 * followed by a list of N associativity arrays.
> +	 */
> +
> +	p = (__be32 *) pr->old_prop->value;
> +	if (!p) {
> +		of_node_put(dn);
> +		return -EINVAL;
> +	}
> +	old_ala.n_arrays = of_read_number(p++, 1);
> +	old_ala.array_sz = of_read_number(p++, 1);
> +	old_ala.arrays = p;
> +
> +	p = (__be32 *) pr->prop->value;
> +	if (!p) {
> +		of_node_put(dn);
> +		return -EINVAL;
> +	}
> +	new_ala.n_arrays = of_read_number(p++, 1);
> +	new_ala.array_sz = of_read_number(p++, 1);
> +	new_ala.arrays = p;
> +
> +	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
> +			new_ala.n_arrays;
> +
> +	if (old_ala.array_sz == new_ala.array_sz) {
> +
> +		for (i = 0; i < lim; i++) {
> +			int index = (i * new_ala.array_sz);
> +
> +			if (!memcmp(&old_ala.arrays[index],
> +						&new_ala.arrays[index],
> +						new_ala.array_sz))
> +				continue;
> +
> +			pseries_update_ala_memory_aai(i, dmprop);
> +		}
> +
> +		for (i = lim; i < new_ala.n_arrays; i++)
> +			pseries_update_ala_memory_aai(i, dmprop);
> +
> +	} else {
> +		/* Update all entries representing these rows;
> +		 * as all rows have different sizes, none can
> +		 * have equivalent values.
> +		 */
> +		for (i = 0; i < lim; i++)
> +			pseries_update_ala_memory_aai(i, dmprop);
> +	}
> +
> +	of_node_put(dn);
> +	return 0;
> +}

The two routines above should be updated to use the in-kernel drmem array instead
of looking up the dynamic-memory property in the device tree.

-Nathan

> +
>  static int pseries_memory_notifier(struct notifier_block *nb,
>  				   unsigned long action, void *data)
>  {
> @@ -1067,6 +1184,9 @@ static int pseries_memory_notifier(struct notifier_block *nb,
>  	case OF_RECONFIG_UPDATE_PROPERTY:
>  		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
>  			err = pseries_update_drconf_memory(rd);
> +		if (!strcmp(rd->prop->name,
> +				"ibm,associativity-lookup-arrays"))
> +			err = pseries_update_ala_memory(rd);
>  		break;
>  	}
>  	return notifier_from_errno(err);
> 

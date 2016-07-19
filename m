Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rv7tW20KtzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 04:32:02 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6JISqte128999
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:32:00 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r9fehu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:31:59 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 19 Jul 2016 12:31:59 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DF1B73E40063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 12:31:56 -0600 (MDT)
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Implemented indexed-count hotplug
 memory add
To: Sahil Mehta <smehta@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <f3a63611-ae4d-be48-64d7-88a7ac7c1091@linux.vnet.ibm.com>
 <f128910f-59ed-bdd6-afef-af8d287e77e6@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 19 Jul 2016 11:31:55 -0700
MIME-Version: 1.0
In-Reply-To: <f128910f-59ed-bdd6-afef-af8d287e77e6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <578E721B.4050406@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2016 08:07 AM, Sahil Mehta wrote:
> Indexed-count add for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be assigned (NOT
> that <count> lmbs will be added). Because of Qemu's per-DIMM memory
> management, the addition of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count add reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>
> ---
> v2:	-remove potential memory leak when parsing command
> 	-use u32s drc_index and count instead of u32 ic[]
> 	 in dlpar_memory
> 
>  arch/powerpc/include/asm/rtas.h                 |    2
>  arch/powerpc/platforms/pseries/dlpar.c          |   34 +++++++-
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  100 +++++++++++++++++++++--
>  3 files changed, 124 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 51400ba..f46b271 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -307,6 +307,7 @@ struct pseries_hp_errorlog {
>  	union {
>  		__be32	drc_index;
>  		__be32	drc_count;
> +		__be32	indexed_count[2];
>  		char	drc_name[1];
>  	} _drc_u;
>  };
> @@ -322,6 +323,7 @@ struct pseries_hp_errorlog {
>  #define PSERIES_HP_ELOG_ID_DRC_NAME	1
>  #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
>  #define PSERIES_HP_ELOG_ID_DRC_COUNT	3
> +#define PSERIES_HP_ELOG_ID_IC		4

For consistency it would be nice if this had the same prefix, namely
PSERIES_HP_ELOG_ID_DRC_XXX, as the previous types. Otherwise, we need to
remember that indexed count is named slightly different.

-Tyrel

> 
>  struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
>  					      uint16_t section_id);
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 2b93ae8..2a6dc9e 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -345,11 +345,17 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
>  	switch (hp_elog->id_type) {
>  	case PSERIES_HP_ELOG_ID_DRC_COUNT:
>  		hp_elog->_drc_u.drc_count =
> -					be32_to_cpu(hp_elog->_drc_u.drc_count);
> +				be32_to_cpu(hp_elog->_drc_u.drc_count);
>  		break;
>  	case PSERIES_HP_ELOG_ID_DRC_INDEX:
>  		hp_elog->_drc_u.drc_index =
> -					be32_to_cpu(hp_elog->_drc_u.drc_index);
> +				be32_to_cpu(hp_elog->_drc_u.drc_index);
> +		break;
> +	case PSERIES_HP_ELOG_ID_IC:
> +		hp_elog->_drc_u.indexed_count[0] =
> +				be32_to_cpu(hp_elog->_drc_u.indexed_count[0]);
> +		hp_elog->_drc_u.indexed_count[1] =
> +				be32_to_cpu(hp_elog->_drc_u.indexed_count[1]);
>  	}
> 
>  	switch (hp_elog->resource) {
> @@ -409,7 +415,29 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
>  		goto dlpar_store_out;
>  	}
> 
> -	if (!strncmp(arg, "index", 5)) {
> +	if (!strncmp(arg, "indexed-count", 13)) {
> +		u32 index, count;
> +		char *cstr, *istr;
> +
> +		hp_elog->id_type = PSERIES_HP_ELOG_ID_IC;
> +		arg += strlen("indexed-count ");
> +
> +		cstr = kstrdup(arg, GFP_KERNEL);
> +		istr = strchr(cstr, ' ');
> +		*istr++ = '\0';
> +
> +		if (kstrtou32(cstr, 0, &count) || kstrtou32(istr, 0, &index)) {
> +			rc = -EINVAL;
> +			pr_err("Invalid index or count : \"%s\"\n", buf);
> +			kfree(cstr);
> +			goto dlpar_store_out;
> +		}
> +
> +		kfree(cstr);
> +
> +		hp_elog->_drc_u.indexed_count[0] = cpu_to_be32(count);
> +		hp_elog->_drc_u.indexed_count[1] = cpu_to_be32(index);
> +	} else if (!strncmp(arg, "index", 5)) {
>  		u32 index;
> 
>  		hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 2ce1385..d7942ca 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -701,6 +701,83 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
>  	return rc;
>  }
> 
> +static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
> +				  struct property *prop)
> +{
> +	struct of_drconf_cell *lmbs;
> +	u32 num_lmbs, *p;
> +	int i, rc;
> +	int lmbs_available = 0, start_index = 0, end_index;
> +
> +	pr_info("Attempting to hot-add %u LMB(s) at index %x\n",
> +		lmbs_to_add, drc_index);
> +
> +	if (lmbs_to_add == 0)
> +		return -EINVAL;
> +
> +	p = prop->value;
> +	num_lmbs = *p++;
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	/* Navigate to drc_index */
> +	while (start_index < num_lmbs) {
> +		if (lmbs[start_index].drc_index == drc_index)
> +			break;
> +
> +		start_index++;
> +	}
> +
> +	end_index = start_index + lmbs_to_add;
> +
> +	/* Validate that there are enough LMBs to satisfy the request */
> +	for (i = start_index; i < end_index; i++) {
> +		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
> +			break;
> +
> +		lmbs_available++;
> +	}
> +
> +	if (lmbs_available < lmbs_to_add)
> +		return -EINVAL;
> +
> +	for (i = start_index; i < end_index; i++) {
> +		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
> +			continue;
> +
> +		rc = dlpar_add_lmb(&lmbs[i]);
> +		if (rc)
> +			break;
> +
> +		lmbs[i].reserved = 1;
> +	}
> +
> +	if (rc) {
> +		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
> +
> +		for (i = start_index; i < end_index; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			rc = dlpar_remove_lmb(&lmbs[i]);
> +			if (rc)
> +				pr_err("Failed to remove LMB, drc index %x\n",
> +				       be32_to_cpu(lmbs[i].drc_index));
> +		}
> +		rc = -EINVAL;
> +	} else {
> +		for (i = start_index; i < end_index; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			pr_info("Memory at %llx (drc index %x) was hot-added\n",
> +				lmbs[i].base_addr, lmbs[i].drc_index);
> +			lmbs[i].reserved = 0;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  {
>  	struct device_node *dn;
> @@ -708,9 +785,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  	u32 count, drc_index;
>  	int rc;
> 
> -	count = hp_elog->_drc_u.drc_count;
> -	drc_index = hp_elog->_drc_u.drc_index;
> -
>  	lock_device_hotplug();
> 
>  	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> @@ -727,19 +801,27 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
> 
>  	switch (hp_elog->action) {
>  	case PSERIES_HP_ELOG_ACTION_ADD:
> -		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
> +			count = hp_elog->_drc_u.drc_count;
>  			rc = dlpar_memory_add_by_count(count, prop);
> -		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> +		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
> +			drc_index = hp_elog->_drc_u.drc_index;
>  			rc = dlpar_memory_add_by_index(drc_index, prop);
> -		else
> +		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_IC) {
> +			count = hp_elog->_drc_u.indexed_count[0];
> +			drc_index = hp_elog->_drc_u.indexed_count[1];
> +			rc = dlpar_memory_add_by_ic(count, drc_index, prop);
> +		} else
>  			rc = -EINVAL;
>  		break;
>  	case PSERIES_HP_ELOG_ACTION_REMOVE:
> -		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
> +			count = hp_elog->_drc_u.drc_count;
>  			rc = dlpar_memory_remove_by_count(count, prop);
> -		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> +		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
> +			drc_index = hp_elog->_drc_u.drc_index;
>  			rc = dlpar_memory_remove_by_index(drc_index, prop);
> -		else
> +		} else
>  			rc = -EINVAL;
>  		break;
>  	default:
> 
> On 07/18/2016 10:04 AM, Sahil Mehta wrote:
>> Indexed-count memory management allows addition and removal of contiguous
>> lmb blocks with a single command. When compared to the series of calls
>> previously required to manage contiguous blocks, indexed-count decreases
>> command frequency and reduces risk of buffer overflow.
>>
>> Changes in v2:
>> --------------
>> -[PATCH 1/2]:	-remove potential memory leak when parsing command
>> 		-use u32s drc_index and count instead of u32 ic[]
>> 		 in dlpar_memory
>> -[PATCH 2/2]:	-use u32s drc_index and count instead of u32 ic[]
>> 		 in dlpar_memory
>>
>> -Sahil Mehta
>> ---
>>  include/asm/rtas.h                 |    2
>>  platforms/pseries/dlpar.c          |   34 ++++++
>>  platforms/pseries/hotplug-memory.c |  184 +++++++++++++++++++++++++++++++++++--
>>  3 files changed, 208 insertions(+), 12 deletions(-)
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

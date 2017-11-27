Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylx34532ZzDrV9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 06:01:04 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARJ0ZFx135647
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:01:01 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2egnad9pry-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:00:57 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 12:00:07 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vARJ019u4063578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:00:04 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 295106E038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:00:04 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 08E026E04C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:00:03 -0700 (MST)
Subject: Re: [PATCH V4 2/4] pseries/drc-info: Search DRC properties for CPU
 indexes
To: linuxppc-dev@lists.ozlabs.org
References: <0c773d7c-d83e-b76c-41f7-82b8e0883e6d@linux.vnet.ibm.com>
 <06d00587-377e-6f06-365b-33f072af0919@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 13:00:03 -0600
MIME-Version: 1.0
In-Reply-To: <06d00587-377e-6f06-365b-33f072af0919@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d8e60269-17c9-4a73-5025-203d8e50da53@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

On 11/20/2017 09:35 AM, Nathan Fontenot wrote:
> On 11/16/2017 02:11 PM, Michael Bringmann wrote:
>> pseries/drc-info: Provide parallel routines to convert between
>> drc_index and CPU numbers at runtime, using the older device-tree
>> properties ("ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
>> and "ibm,drc-power-domains"), or the new property "ibm,drc-info".
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> Changes in V4:
>>   -- Rename of_one_drc_info to of_read_drc_info_cell
>>   -- Fix some spacing within expressions
>>   -- Make some style corrections
>> ---
>>  arch/powerpc/include/asm/prom.h                 |   15 +++
>>  arch/powerpc/platforms/pseries/of_helpers.c     |   60 ++++++++++
>>  arch/powerpc/platforms/pseries/pseries_energy.c |  138 ++++++++++++++++++-----
>>  3 files changed, 185 insertions(+), 28 deletions(-)
>>

...

>> +
>> +		value = info->value;
>> +		value = (void *)of_prop_next_u32(info, value,
>> +						&num_set_entries);
> 
> Missed this the first time, but setting value twice seems a bit odd.
> This should be able to be collapsed into;
> 
> 		value = (void *)of_prop_next_u32(info, NULL, &num_set_entries);

Okay
> 
>> +		if (!value)
>> +			goto err_of_node_put;
>> +
>> +		for (j = 0; j < num_set_entries; j++) {
>> +
>> +			of_read_drc_info_cell(&info, &value, &drc);
>> +			if (strncmp(drc.drc_type, "CPU", 3))
>> +				goto err;
>> +
>> +			if (thread_index < drc.last_drc_index)
>> +				break;
>> +
>> +			WARN_ON(((thread_index - drc.drc_index_start) %
>> +					drc.sequential_inc) != 0);
> 
> The WARN_ON that you have here, and in the code below, really fell like they
> should be in of_read_drc_info_cell. These are checks on reading the info in
> the drc-info property.

Remove unnecessary WARN_ON() checks.

> 
>> +		}
>> +
>> +		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
>> +	} else {
>> +		const __be32 *indexes;
>> +
>> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>> +		if (indexes == NULL)
>> +			goto err_of_node_put;
>> +
>> +		/*
>> +		 * The first element indexes[0] is the number of drc_indexes
>> +		 * returned in the list.  Hence thread_index+1 will get the
>> +		 * drc_index corresponding to core number thread_index.
>> +		 */
>> +		WARN_ON(thread_index > indexes[0]);
>> +		ret = indexes[thread_index + 1];
>> +	}
>> +
>>  	rc = 0;
>>
>>  err_of_node_put:
>> @@ -72,34 +111,77 @@ static int drc_index_to_cpu(u32 drc_index)
>>  {
>>  	struct device_node *dn = NULL;
>>  	const int *indexes;
>> -	int i, cpu = 0;
>> +	int thread_index = 0, cpu = 0;
>>  	int rc = 1;
>>
>>  	dn = of_find_node_by_path("/cpus");
>>  	if (dn == NULL)
>>  		goto err;
>> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>> -	if (indexes == NULL)
>> -		goto err_of_node_put;
>> -	/*
>> -	 * First element in the array is the number of drc_indexes
>> -	 * returned.  Search through the list to find the matching
>> -	 * drc_index and get the core number
>> -	 */
>> -	for (i = 0; i < indexes[0]; i++) {
>> -		if (indexes[i + 1] == drc_index)
>> +
>> +	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
>> +		struct property *info = NULL;
>> +		struct of_drc_info drc;
>> +		int j;
>> +		u32 num_set_entries;
>> +		const __be32 *value;
>> +
>> +		info = of_find_property(dn, "ibm,drc-info", NULL);
>> +		if (info == NULL)
>> +			goto err_of_node_put;
>> +
>> +		value = info->value;
>> +		value = (void *)of_prop_next_u32(info, value,
>> +						&num_set_entries);

Okay.

> 
> Same here as mentioned above.
> 
> -Nathan
> 
>> +		if (!value)
>> +			goto err_of_node_put;
>> +
>> +		for (j = 0; j < num_set_entries; j++) {
>> +
>> +			of_read_drc_info_cell(&info, &value, &drc);
>> +			if (strncmp(drc.drc_type, "CPU", 3))
>> +				goto err;
>> +
>> +			WARN_ON(drc_index < drc.drc_index_start);
>> +			WARN_ON(((drc_index - drc.drc_index_start) %
>> +					drc.sequential_inc) != 0);
>> +
>> +			if (drc_index > drc.last_drc_index) {
>> +				cpu += drc.num_sequential_elems;
>> +				continue;
>> +			}
>> +			cpu += ((drc_index - drc.drc_index_start) /
>> +				drc.sequential_inc);
>> +
>> +			thread_index = cpu_first_thread_of_core(cpu);
>> +			rc = 0;
>>  			break;
>> +		}
>> +	} else {
>> +		unsigned long int i;
>> +
>> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
>> +		if (indexes == NULL)
>> +			goto err_of_node_put;
>> +		/*
>> +		 * First element in the array is the number of drc_indexes
>> +		 * returned.  Search through the list to find the matching
>> +		 * drc_index and get the core number
>> +		 */
>> +		for (i = 0; i < indexes[0]; i++) {
>> +			if (indexes[i + 1] == drc_index)
>> +				break;
>> +		}
>> +		/* Convert core number to logical cpu number */
>> +		thread_index = cpu_first_thread_of_core(i);
>> +		rc = 0;
>>  	}
>> -	/* Convert core number to logical cpu number */
>> -	cpu = cpu_first_thread_of_core(i);
>> -	rc = 0;
>>
>>  err_of_node_put:
>>  	of_node_put(dn);
>>  err:
>>  	if (rc)
>>  		printk(KERN_WARNING "drc_index_to_cpu(%d) failed", drc_index);
>> -	return cpu;
>> +	return thread_index;
>>  }
>>
>>  /*
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

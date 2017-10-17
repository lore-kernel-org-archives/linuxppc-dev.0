Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGhp76bRCzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 04:22:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HHKDei076256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 13:22:20 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dnkyyevs4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 13:22:19 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 11:22:19 -0600
Subject: Re: [PATCH 1/2] powerpc/nodes: Ensure enough nodes avail for
 operations
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
References: <d62dd6c7-7676-5fe0-4f63-baada9213908@linux.vnet.ibm.com>
 <871sm3l1c1.fsf@concordia.ellerman.id.au>
 <a915cc6d-09fc-8a64-21c2-5bd89123d2e4@linux.vnet.ibm.com>
 <94ac2dd9-625c-d453-adf5-32703efaebcc@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 12:22:11 -0500
MIME-Version: 1.0
In-Reply-To: <94ac2dd9-625c-d453-adf5-32703efaebcc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <095d9828-b9d9-8dc7-8ef4-5dd7bf34c31d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/17/2017 12:02 PM, Nathan Fontenot wrote:
> On 10/17/2017 11:14 AM, Michael Bringmann wrote:
>> See below.
>>
>> On 10/16/2017 07:33 AM, Michael Ellerman wrote:
>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>
>>>> powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
>>>
>>> This is a powerpc-only patch, so saying "systems like PowerPC" is
>>> confusing. What you should be saying is "On pseries systems".
>>>
>>>> or memory resources, it may occur that the new resources are to be
>>>> inserted into nodes that were not used for these resources at bootup.
>>>> In the kernel, any node that is used must be defined and initialized
>>>> at boot.
>>>>
>>>> This patch extracts the value of the lowest domain level (number of
>>>> allocable resources) from the "rtas" device tree property
>>>> "ibm,current-associativity-domains" or the device tree property
>>>
>>> What is current associativity domains? I've not heard of it, where is it
>>> documented, and what does it mean.
>>>
>>> Why would use the "current" set vs the "max"? I thought the whole point
>>> was to discover the maximum possible set of nodes that could be
>>> hotplugged.
>>>
>>>> "ibm,max-associativity-domains" to use as the maximum number of nodes
>>>> to setup as possibly available in the system.  This new setting will
>>>> override the instruction,
>>>>
>>>>     nodes_and(node_possible_map, node_possible_map, node_online_map);
>>>>
>>>> presently seen in the function arch/powerpc/mm/numa.c:initmem_init().
>>>>
>>>> If the property is not present at boot, no operation will be performed
>>>> to define or enable additional nodes.
>>>>
>>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>>> ---
>>>>  arch/powerpc/mm/numa.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 47 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>>>> index ec098b3..b385cd0 100644
>>>> --- a/arch/powerpc/mm/numa.c
>>>> +++ b/arch/powerpc/mm/numa.c
>>>> @@ -892,6 +892,51 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>>>  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
>>>>  }
>>>>  
>>>> +static void __init node_associativity_setup(void)
>>>
>>> This should really be called "find_possible_nodes()" or something more
>>> descriptive.
>>
>> Okay.
>>>
>>>> +{
>>>> +	struct device_node *rtas;
>>>> +
>>>> +	rtas = of_find_node_by_path("/rtas");
>>>> +	if (rtas) {
>>>
>>> If you just short-circuit that return the whole function body can be
>>> deintented, making it significantly more readable.
>>>
>>> ie:
>>> +	rtas = of_find_node_by_path("/rtas");
>>> +	if (!rtas)
>>> +		return;
>>
>> Okay.
>>
>>>
>>>> +		const __be32 *prop;
>>>> +		u32 len, entries, numnodes, i;
>>>> +
>>>> +		prop = of_get_property(rtas,
>>>> +					"ibm,current-associativity-domains", &len);
>>>
>>> Please don't use of_get_property() in new code, we have much better
>>> accessors these days, which do better error checking and handle the
>>> endian conversions for you.
>>>
>>> In this case you'd use eg:
>>>
>>> 	u32 entries;
>>> 	rc = of_property_read_u32(rtas, "ibm,current-associativity-domains", &entries);
>>
>> The property 'ibm,current-associativity-domains' has the same format as the property
>> 'ibm,max-associativity-domains' i.e. it is an integer array.  The accessor of_property_read_32,
>> however, expects it to be an integer singleton value.  Instead, it needs:
> 
> I think for this case where the property is an array of values you could use
> of_property_count_elems_of_size() to get the number of elements in the array
> and then use of_property_read_u32_array() to read the array.
> 
> -Nathan

We only need one value from the array which is why I am using,

>>>> +		numnodes = of_read_number(&prop[min_common_depth], 1);

With this implementation I do not need to allocate memory for
an array, nor execute code to read all elements of the array.

Michael

> 
>>
>>>
>>>> +		if (!prop || len < sizeof(unsigned int)) {
>>>> +			prop = of_get_property(rtas,
>>>> +					"ibm,max-associativity-domains", &len);
>>                         if (!prop || len < sizeof(unsigned int))
>>>> +				goto endit;
>>>> +		}
>>>> +
>>>> +		entries = of_read_number(prop++, 1);
>>>> +
>>>> +		if (len < (entries * sizeof(unsigned int)))
>>>> +			goto endit;
>>>> +
>>>> +		if ((0 <= min_common_depth) && (min_common_depth <= (entries-1)))
>>>> +			entries = min_common_depth;
>>>> +		else
>>>> +			entries -= 1;
>>> 			^
>>>                         You can't just guess that will be the right entry.
>>>
>>> If min_common_depth is < 0 the function should have just returned
>>> immediately at the top.
>>
>> Okay.
>>
>>>
>>> If min_common_depth is outside the range of the property that's a buggy
>>> device tree, you should print a warning and return.
>>>
>>>> +		numnodes = of_read_number(&prop[entries], 1);
>>>
>>> 	u32 num_nodes;
>>> 	rc = of_property_read_u32_index(rtas, "ibm,current-associativity-domains", min_common_depth, &num_nodes);
>>>> +
>>>> +		printk(KERN_INFO "numa: Nodes = %d (mcd = %d)\n", numnodes,
>>>> +			min_common_depth);
>>>> +
>>>> +		for (i = 0; i < numnodes; i++) {
>>>> +			if (!node_possible(i)) {
>>>> +				setup_node_data(i, 0, 0);
>>>
>>> Do we actually need to setup the NODE_DATA() yet? Doing it now ensures
>>> it will not be allocated node local, which sucks.
>>
>> Okay.
>>
>>>
>>>> +				node_set(i, node_possible_map);
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +
>>>> +endit:
>>>
>>> "out" would be the normal name.
>>
>> Okay.
>>
>>>
>>>> +	if (rtas)
>>>> +		of_node_put(rtas);
>>>> +}
>>>> +
>>>>  void __init initmem_init(void)
>>>>  {
>>>>  	int nid, cpu;
>>>> @@ -911,6 +956,8 @@ void __init initmem_init(void)
>>>>  	 */
>>>
>>> You need to update the comment above here which is contradicted by the
>>> new function you're adding.
>>
>> Okay.
>>
>>>
>>>>  	nodes_and(node_possible_map, node_possible_map, node_online_map);
>>>>  
>>>> +	node_associativity_setup();
>>>> +
>>>>  	for_each_online_node(nid) {
>>>>  		unsigned long start_pfn, end_pfn;
>>>>  
>>>
>>> cheers
>>>
>>>
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

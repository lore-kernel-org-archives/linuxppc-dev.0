Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DC0F1A05FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:00:08 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 05:00:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 33DDF2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:00:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TIxjNN52822210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:59:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TIxV5T032258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:59:32 +1000
Message-ID: <560ADFDB.6090106@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 00:30:43 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  4/5] powerpc:numa Add helper functions to maintain
 chipid to nid mapping
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150928173245.GD48470@linux.vnet.ibm.com>
In-Reply-To: <20150928173245.GD48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 11:02 PM, Nishanth Aravamudan wrote:
> On 27.09.2015 [23:59:12 +0530], Raghavendra K T wrote:
>> Create arrays that maps serial nids and sparse chipids.
>>
>> Note: My original idea had only two arrays of chipid to nid map. Final
>> code is inspired by driver/acpi/numa.c that maps a proximity node with
>> a logical node by Takayoshi Kochi <t-kochi@bq.jp.nec.com>, and thus
>> uses an additional chipid_map nodemask. The mask helps in first unused
>> nid easily by knowing first unset bit in the mask.
>>
>> No change in functionality.
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index dd2073b..f015cad 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -63,6 +63,11 @@ static int form1_affinity;
>>   static int distance_ref_points_depth;
>>   static const __be32 *distance_ref_points;
>>   static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
>> +static nodemask_t chipid_map = NODE_MASK_NONE;
>> +static int chipid_to_nid_map[MAX_NUMNODES]
>> +				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };
>
> Hrm, conceptually there are *more* chips than nodes, right? So what
> guarantees we won't see > MAX_NUMNODES chips?

You are correct that nid <= chipids.
and #nids = #chipids when all possible slots are populated. Considering
we assume that maximum chip slots are no more than MAX_NUMNODES,


how about having

#define MAX_CHIPNODES MAX_NUMNODES
and
chipid_to_nid_map[MAX_CHIPNODES] = { [0 ... MAX_CHIPNODES - 1] = ..

>
>> +static int nid_to_chipid_map[MAX_NUMNODES]
>> +				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };
>>
>>   /*
>>    * Allocate node_to_cpumask_map based on number of available nodes
>> @@ -133,6 +138,48 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
>>   	return 0;
>>   }
>>
>> +int chipid_to_nid(int chipid)
>> +{
>> +	if (chipid < 0)
>> +		return NUMA_NO_NODE;
>
> Do you really want to support these cases? Or should they be
> bugs/warnings indicating that you got an unexpected input? Or at least
> WARN_ON_ONCE?
>

Right. Querying for nid of an invalid chipid should be atleast
WARN_ON_ONCE(). But 'll check once if there is any valid scenario
before the change.

>> +	return chipid_to_nid_map[chipid];
>> +}
>> +
>> +int nid_to_chipid(int nid)
>> +{
>> +	if (nid < 0)
>> +		return NUMA_NO_NODE;
>> +	return nid_to_chipid_map[nid];
>> +}
>> +
>> +static void __map_chipid_to_nid(int chipid, int nid)
>> +{
>> +	if (chipid_to_nid_map[chipid] == NUMA_NO_NODE
>> +	     || nid < chipid_to_nid_map[chipid])
>> +		chipid_to_nid_map[chipid] = nid;
>> +	if (nid_to_chipid_map[nid] == NUMA_NO_NODE
>> +	    || chipid < nid_to_chipid_map[nid])
>> +		nid_to_chipid_map[nid] = chipid;
>> +}
>
> chip <-> node mapping is a static (physical) concept, right? Should we
> emit some debugging if for some reason we get a runtime call to remap
> an already mapped chip to a new node?
>

Good point. Already mapped chipid to a different nid is unexpected
whereas mapping chipid to same nid is expected.(because mapping comes
from cpus belonging to same node).

WARN_ON() should suffice here?


>> +
>> +int map_chipid_to_nid(int chipid)
>> +{
>> +	int nid;
>> +
>> +	if (chipid < 0 || chipid >= MAX_NUMNODES)
>> +		return NUMA_NO_NODE;
>> +
>> +	nid = chipid_to_nid_map[chipid];
>> +	if (nid == NUMA_NO_NODE) {
>> +		if (nodes_weight(chipid_map) >= MAX_NUMNODES)
>> +			return NUMA_NO_NODE;
>
> If you create a KVM guest with a bogus topology, doesn't this just start
> losing NUMA information for very high-noded guests?
>

'll try to see if it is possible to hit this case, ideally we should
not allow more than MAX_NUMNODES for chipids and we should abort early.

>> +		nid = first_unset_node(chipid_map);
>> +		__map_chipid_to_nid(chipid, nid);
>> +		node_set(nid, chipid_map);
>> +	}
>> +	return nid;
>> +}
>> +
>>   int numa_cpu_lookup(int cpu)
>>   {
>>   	return numa_cpu_lookup_table[cpu];
>> @@ -264,7 +311,6 @@ out:
>>   	return chipid;
>>   }
>>
>> -
>
> stray change?
>

yep, will correct that.

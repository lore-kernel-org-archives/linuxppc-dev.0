Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ55h0DhFzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 22:28:39 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4QCSZtE144325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:28:36 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ap80e499e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:28:36 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 26 May 2017 08:28:34 -0400
Subject: Re: [PATCH V2 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20170525171932.29159.89311.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <9b006866-5a8e-dc05-d603-bfe8eb02eef2@linux.vnet.ibm.com>
 <20170526132305.19ef3590@firefly.ozlabs.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Fri, 26 May 2017 07:28:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170526132305.19ef3590@firefly.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <895fac95-bd7a-7006-5fef-5b9f75882bcb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>  arch/powerpc/mm/numa.c |    7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 15c2dd5..18f3038 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -907,13 +907,6 @@ void __init initmem_init(void)
>>  
>>  	memblock_dump_all();
>>  
>> -	/*
>> -	 * Reduce the possible NUMA nodes to the online NUMA nodes,
>> -	 * since we do not support node hotplug. This ensures that  we
>> -	 * lower the maximum NUMA node ID to what is actually present.
>> -	 */
>> -	nodes_and(node_possible_map, node_possible_map, node_online_map);
>> -
> 
> There is an overhead with turning this off if you have too many cgroups
> with the memory controller. I think this fix was added for a pathological
> test case. On my system I see 84 cgroups with 1 node, so the probable
> overhead is 84*255*sizeof(struct mem_cgroup_tree_per_node).
> 
> I tried some patches to reduce the overhead, but those need more overhauling
> and rework.

Is there some other way to add a node to a dynamic, running system without
crashing?  I have not encountered one as yet.

> Balbir Singh.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

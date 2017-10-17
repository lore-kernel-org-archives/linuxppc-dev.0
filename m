Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGdrr2vnwzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 02:09:32 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HF9D9X014079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 11:09:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dnkpkt59r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 11:09:16 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 09:08:59 -0600
Subject: Re: [PATCH 2/2] powerpc/hotplug: Ensure nodes initialized for hotplug
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
 <87y3objlrk.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 10:08:51 -0500
MIME-Version: 1.0
In-Reply-To: <87y3objlrk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <240499bb-081e-fb9e-1083-bd4c72ef404c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/16/2017 07:54 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU,
>> it may occur that the new resources are to be inserted into nodes
>> that were not used for memory resources at bootup.  Many different
>> configurations of PowerPC resources may need to be supported depending
>> upon the environment.
> 
> Give me some detail please?!

Configurations that demonstrated problems included 'memoryless' nodes
that possessed only CPUs at boot, and nodes that contained neither CPUs
nor memory at boot.  The calculations in the kernel resulted in a different
node use layout on many SAP HANA configured systems.

> 
>> This patch fixes some problems encountered at
> 
> What problems?

The previous implementation collapsed all node assignments after affinity
calculations to use only those nodes that had memory at boot.  This
resulted in calculation and configuration differences between the FSP
code and the Linux kernel.

> 
>> runtime with configurations that support memory-less nodes, but which
>> allow CPUs to be added at and after boot.
> 
> How does it fix those problems?

The change involves completing the initialization of nodes that were not
used at boot, but which were selected by VPHN affinity calculations during
subsequent hotplug operations.

Michael

> 
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index b385cd0..e811dd1 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -1325,6 +1325,17 @@ static long vphn_get_associativity(unsigned long cpu,
>>  	return rc;
>>  }
>>  
>> +static int verify_node_preparation(int nid)
>> +{
> 
> I would not expect a function called "verify" ...
> 
>> +	if ((NODE_DATA(nid) == NULL) ||
>> +	    (NODE_DATA(nid)->node_spanned_pages == 0)) {
>> +		if (try_online_node(nid))
> 
> .. to do something like online a node.
> 
>> +			return first_online_node;
>> +	}
>> +
>> +	return nid;
>> +}
>> +
>>  /*
>>   * Update the CPU maps and sysfs entries for a single CPU when its NUMA
>>   * characteristics change. This function doesn't perform any locking and is
>> @@ -1433,9 +1444,11 @@ int numa_update_cpu_topology(bool cpus_locked)
>>  		/* Use associativity from first thread for all siblings */
>>  		vphn_get_associativity(cpu, associativity);
>>  		new_nid = associativity_to_nid(associativity);
>> -		if (new_nid < 0 || !node_online(new_nid))
>> +		if (new_nid < 0 || !node_possible(new_nid))
>>  			new_nid = first_online_node;
>>  
>> +		new_nid = verify_node_preparation(new_nid);
> 
> You're being called part-way through CPU hotplug here, are we sure it's
> safe to go and do memory hotplug from there? What's the locking
> situation?
> 
> cheers
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

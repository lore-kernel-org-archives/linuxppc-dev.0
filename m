Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycXty3b4QzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 05:28:26 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFIQvBU071907
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 13:28:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8qjdk0gw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 13:28:23 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 11:28:23 -0700
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vAFISK5G10092914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 11:28:20 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A8E56A03D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 11:28:20 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.161])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id 6CB586A03F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 11:28:20 -0700 (MST)
Subject: Re: [PATCH 2/2] powerpc/hotplug: Ensure nodes initialized for hotplug
To: linuxppc-dev@lists.ozlabs.org
References: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
 <87y3objlrk.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 12:28:19 -0600
MIME-Version: 1.0
In-Reply-To: <87y3objlrk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <3be6fd7b-36ec-3beb-21ce-1def39ef0938@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello:
    See below.

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

The most important characteristics that I have observed are:

* Dedicated vs. shared resources.  Shared resources require information
  such as the VPHN hcall for CPU assignment to nodes.
* memoryless nodes at boot.  Nodes need to be defined as 'possible' at
  boot for operation with other code modules.  Previously, the powerpc
  code would limit the set of possible/online nodes to those which have
  memory assigned at boot.  Subsequent add/remove of CPUs or memory would
  only work with this subset of possible nodes.
* memoryless nodes with CPUs at boot.  Due to the previous restriction on
  nodes, nodes that had CPUs but no memory were being collapsed into other
  nodes that did have memory at boot.  In practice this meant that the
  node assignment presented by the runtime kernel differed from the affinity
  and associativity attirbutes presented by the device tree or VPHN hcalls.
  Nodes that might be known to the pHyp were not 'possible' in the runtime
  kernel because they did not have memory at boot.

> 
>> This patch fixes some problems encountered at
> 
> What problems?

This patch set fixes a couple of problems.

* Nodes known to powerpc to be memoryless at boot, but to have CPUs in them
  are allowed to be 'possible' and 'online'.  Memory allocations for those
  nodes are taken from another node that does have memory until and if memory
  is hot-added to the node.
* Nodes which have no resources assigned at boot, but which may still be
  referenced subsequently by affinity or associativity attributes, are kept
  in the list of 'possible' nodes for powerpc.  Hot-add of memory or CPUs
  to the system can reference these nodes and bring them online instead of
  redirecting the resources to the set of nodes known to have memory at boot.

> 
>> runtime with configurations that support memory-less nodes, but which
>> allow CPUs to be added at and after boot.
> 
> How does it fix those problems?

This problem was fixed in a couple of ways.  First, the code now checks
whether the node to which a CPU is mapped by 'numa_update_cpu_topology' /
'arch_update_cpu_topology' has been initialized and has memory available.
If either test is false, a call is made to 'try_online_node()' to finish
the data structure initialization.  Only if we are unable to initialize
the node at this point will the CPU node assignment be collapsed into an
existing node.  After initialization by 'try_online_node()', calls to
'local_memory_node' no longer crash for these memoryless nodes.

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

We have changed the function name to 'find_cpu_nid'.

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

We are not doing memory hotplug.  We are initializing a node that may be used
by CPUs or memory before it can be referenced as invalid by a CPU hotplug
operation.  CPU hotplug operations are protected by a range of APIs including
cpu_maps_update_begin/cpu_maps_update_done, cpus_read/write_lock / cpus_read/write_unlock,
device locks, and more.  Memory hotplug operations, including try_online_node,
are protected by mem_hotplug_begin/mem_hotplug_done, device locks, and more.
In the case of CPUs being hot-added to a previously memoryless node, the
try_online_node operation occurs wholly within the CPU locks with no overlap.
Using HMC hot-add/hot-remove operations, I have been able to add and remove
CPUs to any possible node without failures.  HMC operations involve a degree
self-serialization, though.

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

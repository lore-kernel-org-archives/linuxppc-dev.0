Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylz8m41sDzDrJJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 07:36:08 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARKYxkv130020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 15:36:06 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2egpygr318-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 15:36:05 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 13:36:05 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vARKa2gY64487510
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:36:02 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 221876E041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:36:02 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 005586E038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:36:01 -0700 (MST)
Subject: Re: [PATCH V7 3/3] hotplug/cpu: Fix crash with memoryless nodes
To: linuxppc-dev@lists.ozlabs.org
References: <3445a368-d2d4-f908-5f0e-df7bbd659e07@linux.vnet.ibm.com>
 <08960615-15b4-1a14-a10b-9f0053c8163e@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 14:36:01 -0600
MIME-Version: 1.0
In-Reply-To: <08960615-15b4-1a14-a10b-9f0053c8163e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <73c6417b-5120-7915-cfac-2c187543e965@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

On 11/20/2017 10:50 AM, Nathan Fontenot wrote:
> On 11/16/2017 11:28 AM, Michael Bringmann wrote:
>> On powerpc systems with shared configurations of CPUs and memory and
>> memoryless nodes at boot, an event ordering problem was observed on
>> a SLES12 build platforms with the hot-add of CPUs to the memoryless
>> nodes.
>>
>> * The most common error occurred when the memory SLAB driver attempted
>>   to reference the memoryless node to which a CPU was being added
>>   before the kernel had finished initializing all of the data structures
>>   for the CPU and exited 'device_online' under DLPAR/hot-add.
>>
>>   Normally the memoryless node would be initialized through the call
>>   path device_online ... arch_update_cpu_topology ... find_cpu_nid
>>   ...  try_online_node.  This patch ensures that the powerpc node will
>>   be initialized as early as possible, even if it was memoryless and
>>   CPU-less at the point when we are trying to hot-add a new CPU to it.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> Changes in V7:
>>   -- Make function find_cpu_nid() externally visible/usable so that
>>      it may be used from hotplug-cpu.c
>> ---
>>  arch/powerpc/mm/numa.c                       |    3 ++-
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c |    3 +++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 163f4cc..d6d4f7c 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -1310,7 +1310,7 @@ static long vphn_get_associativity(unsigned long cpu,
>>  	return rc;
>>  }
>>
>> -static inline int find_cpu_nid(int cpu)
>> +int find_cpu_nid(int cpu)
>>  {
>>  	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
>>  	int new_nid;
>> @@ -1343,6 +1343,7 @@ static inline int find_cpu_nid(int cpu)
>>  #endif
>>  	}
>>
>> +	printk(KERN_INFO "%s:%d cpu %d nid %d\n", __FUNCTION__, __LINE__, cpu, new_nid);
> 
> This seems like a more likely pr_debug statement.

Yes.  Changed.

>>  	return new_nid;
>>  }
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index a7d14aa7..df8c732 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -340,6 +340,8 @@ static void pseries_remove_processor(struct device_node *np)
>>  	cpu_maps_update_done();
>>  }
>>
>> +extern int find_cpu_nid(int cpu);
>> +
>>  static int dlpar_online_cpu(struct device_node *dn)
>>  {
>>  	int rc = 0;
>> @@ -364,6 +366,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>>  					!= CPU_STATE_OFFLINE);
>>  			cpu_maps_update_done();
>>  			timed_topology_update(1);
>> +			find_cpu_nid(cpu);
> 
> We don't use the returned node from this call, so I'm not sure why it gets
> called. Perhaps its the possible call to try_online_node() that may get called
> in find_cpu_nid(), if so perhpas naming the routine something slightly
> different would be good, like find_and_online_cpu_nid?

The function find_cpu_nid() gets called here for its operations to ensure that
the node is online and initialized during the 'device_online()' operation for
the new CPU that immediately follows.  As I tried to explain in the patch
description, I ran into a case during the SLES12 SP3 backport test where failure
to initialize/online the node early on led to a crash in the memory SLAB driver.
I don't know why that driver was being called so early, but ensuring that the
node was setup as early as possible provided the simplest and smallest patch.

As all of the functionality had been placed in the function 'find_cpu_nid' in
'numa.c' during a previous patch, I reused it here.  Though I did not need
the actual node Id during the call dlpar_online_cpu().

Yes, I can provide a separate calling interface named 'find_and_online_cpu_nid'
for the call from 'dlpar_online_cpu'.  They would both do the same operations.

Or I could just use the new name for the current implementation of 'find_cpu_nid',
instead, and migrate that name to the previous patches.

If I don't hear any further remarks on this point, I will implement/migrate
the function name 'find_and_online_cpu_nid' in the next version of this patch.

> 
> -Nathan

Michael

>>  			rc = device_online(get_cpu_device(cpu));
>>  			if (rc)
>>  				goto out;
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

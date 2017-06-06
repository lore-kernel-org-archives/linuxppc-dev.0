Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whxdT5w3CzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 02:16:29 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v56GDj9a106690
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 12:16:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awp6byfgg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 12:16:25 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 12:16:24 -0400
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
 <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
 <8760g9qwfd.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 6 Jun 2017 11:16:20 -0500
MIME-Version: 1.0
In-Reply-To: <8760g9qwfd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/06/2017 04:48 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> On 06/01/2017 04:36 AM, Michael Ellerman wrote:
>>> Do you actually see mention of nodes 0 and 8 in the dmesg?
>>
>> When the 'numa.c' code is built with debug messages, and the system was
>> given that configuration by pHyp, yes, I did.
>>
>>> What does it say?
>>
>> The debug message for each core thread would be something like,
>>
>>     removing cpu 64 from node 0
>>     adding cpu 64 to node 8
>>
>> repeated for all 8 threads of the CPU, and usually with the messages
>> for all of the CPUs coming out intermixed on the console/dmesg log.
> 
> OK. I meant what do you see at boot.

Here is an example with nodes 0,2,6,7, node 0 starts out empty:

[    0.000000] Initmem setup node 0
[    0.000000]   NODE_DATA [mem 0x3bff7d6300-0x3bff7dffff]
[    0.000000]     NODE_DATA(0) on node 7
[    0.000000] Initmem setup node 2 [mem 0x00000000-0x13ffffffff]
[    0.000000]   NODE_DATA [mem 0x13ffff6300-0x13ffffffff]
[    0.000000] Initmem setup node 6 [mem 0x1400000000-0x34afffffff]
[    0.000000]   NODE_DATA [mem 0x34afff6300-0x34afffffff]
[    0.000000] Initmem setup node 7 [mem 0x34b0000000-0x3bffffffff]
[    0.000000]   NODE_DATA [mem 0x3bff7cc600-0x3bff7d62ff]

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x0000003bffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   2: [mem 0x0000000000000000-0x00000013ffffffff]
[    0.000000]   node   6: [mem 0x0000001400000000-0x00000034afffffff]
[    0.000000]   node   7: [mem 0x00000034b0000000-0x0000003bffffffff]
[    0.000000] Could not find start_pfn for node 0
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
[    0.000000] Initmem setup node 2 [mem 0x0000000000000000-0x00000013ffffffff]
[    0.000000] Initmem setup node 6 [mem 0x0000001400000000-0x00000034afffffff]
[    0.000000] Initmem setup node 7 [mem 0x00000034b0000000-0x0000003bffffffff]
[    0.000000] percpu: Embedded 3 pages/cpu @c000003bf8000000 s155672 r0 d40936 u262144
[    0.000000] Built 4 zonelists in Node order, mobility grouping on.  Total pages: 3928320

and,

[root@ltcalpine2-lp20 ~]# numactl --hardware
available: 4 nodes (0,2,6-7)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 2 cpus: 16 17 18 19 20 21 22 23 32 33 34 35 36 37 38 39 56 57 58 59 60 61 62 63
node 2 size: 81792 MB
node 2 free: 81033 MB
node 6 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31 40 41 42 43 44 45 46 47
node 6 size: 133743 MB
node 6 free: 133097 MB
node 7 cpus: 48 49 50 51 52 53 54 55
node 7 size: 29877 MB
node 7 free: 29599 MB
node distances:
node   0   2   6   7
  0:  10  40  40  40
  2:  40  10  40  40
  6:  40  40  10  20
  7:  40  40  20  10
[root@ltcalpine2-lp20 ~]#

> 
> I'm curious how we're discovering node 0 and 8 at all if neither has any
> memory or CPUs assigned at boot.

Both are in the memory associativity lookup arrays.  And we are circling
back to the 

> 
>>> Right. So it's not that you're hot adding memory into a previously
>>> unseen node as you implied in earlier mails.
>>
>> In the sense that the nodes were defined in the device tree, that is correct.
> 
> Where are they defined in the device tree? That's what I'm trying to understand.

The nodes for memory are defined one time in "ibm,associativity-lookup-arrays".
I wish that there was an official set of node properties in the device-tree,
instead of having them be the values of other properties.

> 
>> In the sense that those nodes are currently deleted from node_possible_map in
>> 'numa.c' by the instruction 'node_and(node_possible_map,node_possible_map,
>> node_online_map);', the nodes are no longer available to place memory or CPU.
> 
> Yeah I understand that part.
> 
>> Okay, I can try to insert code that extracts all of the nodes from the
>> ibm,associativity-lookup-arrays property and merge them with the nodes
>> put into the online map from the CPUs that were found previously during
>> boot of the powerpc code.
> 
> Hmm, will that work?

The nodes are defined in the associativity lookup array, so they have at least
been reserved for us by the pHyp.  On the other hand, if we are only to use
nodes that have resources at boot, why are there extra node values specified?

What I am not 100% clear on -- and why I preferred letting all possible nodes
originally defined, still be possible for subsequent hot-add operations -- is
whether the nodes to be used for hot-added CPUs would always be a subset of
the nodes used for hot-added memory.

* The hot-added CPUs in Shared CPU configurations may be mapped to nodes by
  the value returned to the kernel by the VPHN hcall.

* So far in my tests, this has not been a problem, but I could not be positive
  from the PAPR.

> 
> Looking at PAPR it's not clear to me that it will work for nodes that
> have no memory assigned at boot.
> 
>   This property is used to duplicate the function of the
>   “ibm,associativity” property in a /memory node. Each “assigned” LMB
>   represented has an index valued between 0 and M-1 which is used as in
>   index into this table to select which associativity list to use for
>   the LMB. “unassigned” LMBs are place holders for potential DLPAR
>   additions, for which the associativity list index is meaningless and
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   is given the reserved value of -1. This static property, need only
>   contain values relevant for the LMBs presented in the
>   “ibm,dynamicreconfiguration-memory” node; for a dynamic LPAR addition
>   of a new LMB, the device tree fragment reported by the
>   ibm,configure-connector RTAS function is a /memory node, with the
>   inclusion of the “ibm,associativity” device tree property defined in
>   Section C.6.2.2‚ “Properties of the Children of Root‚” on page 1059.

I don't see any place that builds new /memory nodes in conjunction with
hot-added memory.  The code for powerpc treats the definitions provided
by 'ibm,dynamic-reconfiguration-memory' as the primary reference wherever
hot-added memory comes into play.  It looks like the '/memory' properties
are backups or used for the 'pseries' according to one comment.

> 
>>> What does your device tree look like? Can you send us the output of:
>>>
>>>  $ lsprop /proc/device-tree
> 
> Thanks. I forgot that lsprop will truncate long properties, I actually
> wanted to see all of the ibm,dynamic-memory property.
> 
> But looking at the code I see the only place we set a nid online is if
> there is a CPU assigned to it:
> 
> static int __init parse_numa_properties(void)
> {
> ...
> 	for_each_present_cpu(i) {
>         	...
> 		cpu = of_get_cpu_node(i, NULL);
> 		nid = of_node_to_nid_single(cpu);
>                 ...
> 		node_set_online(nid);
> 	}
> 
> Or for memory nodes (same function):
> 
> 	for_each_node_by_type(memory, "memory") {
>         	...
> 		nid = of_node_to_nid_single(memory);
>                 ...
> 		node_set_online(nid);
>                 ...
> 	}
> 
> Or for entries in ibm,dynamic-memory that are assigned:
> 
> static void __init parse_drconf_memory(struct device_node *memory)
> {
> 	...
> 	for (; n != 0; --n) {
>         	...
> 		/* skip this block if the reserved bit is set in flags (0x80)
> 		   or if the block is not assigned to this partition (0x8) */
> 		if ((drmem.flags & DRCONF_MEM_RESERVED)
> 		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
> 			continue;
> 
> 		...
> 		do {
>                 	...
> 			nid = of_drconf_to_nid_single(&drmem, &aa);
> 			node_set_online(nid);
>                         ...
> 		} while (--ranges);
> 	}
> }
> 
> 
> So I don't see from that how we can even be aware that node 0 and 8
> exist at boot based on that. Maybe there's another path I'm missing
> though.

We don't 'fill in' the nodes, but we are aware that they exist per the 'ibm,associativity-lookup-arrays'
or the responsed provided by the pHyp to the VPHN hcall.  We don't associate either of these resources
to them, but does that mean that the nodes do not exist?

The code currently says that only nodes booted with resources "exist" i.e. it can't hot-add new nodes,
but is that a just a problem of the kernel implementation?  I think so.

However, this is the problem for users running systems that hot-add a lot of resources are concerned.

They see the associativity arrays (and 'hypinfo' table internal to the pHyp), and they ask why the
kernel only records new resources into the boot-time nodes, while pHyp appears to distribute across
all of the memory nodes specified to the LPAR of the kernel at boot.

I think that all of those nodes specified by the pHyp should exist to the kernel, and that we are
trying to find the best way to make them visible here.

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

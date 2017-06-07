Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjS5517przDqNq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 22:08:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
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
 <ba7d7010-44ed-cc20-661c-2078f0f522b7@linux.vnet.ibm.com>
Date: Wed, 07 Jun 2017 22:08:40 +1000
Message-ID: <87tw3sdmpj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> On 06/06/2017 04:48 AM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> On 06/01/2017 04:36 AM, Michael Ellerman wrote:
>>>> Do you actually see mention of nodes 0 and 8 in the dmesg?
>>>
>>> When the 'numa.c' code is built with debug messages, and the system was
>>> given that configuration by pHyp, yes, I did.
>>>
>>>> What does it say?
>>>
>>> The debug message for each core thread would be something like,
>>>
>>>     removing cpu 64 from node 0
>>>     adding cpu 64 to node 8
>>>
>>> repeated for all 8 threads of the CPU, and usually with the messages
>>> for all of the CPUs coming out intermixed on the console/dmesg log.
>> 
>> OK. I meant what do you see at boot.
>
> Here is an example with nodes 0,2,6,7, node 0 starts out empty:
>
> [    0.000000] Initmem setup node 0
> [    0.000000]   NODE_DATA [mem 0x3bff7d6300-0x3bff7dffff]
> [    0.000000]     NODE_DATA(0) on node 7
> [    0.000000] Initmem setup node 2 [mem 0x00000000-0x13ffffffff]
> [    0.000000]   NODE_DATA [mem 0x13ffff6300-0x13ffffffff]
> [    0.000000] Initmem setup node 6 [mem 0x1400000000-0x34afffffff]
> [    0.000000]   NODE_DATA [mem 0x34afff6300-0x34afffffff]
> [    0.000000] Initmem setup node 7 [mem 0x34b0000000-0x3bffffffff]
> [    0.000000]   NODE_DATA [mem 0x3bff7cc600-0x3bff7d62ff]
>
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x0000003bffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   2: [mem 0x0000000000000000-0x00000013ffffffff]
> [    0.000000]   node   6: [mem 0x0000001400000000-0x00000034afffffff]
> [    0.000000]   node   7: [mem 0x00000034b0000000-0x0000003bffffffff]
> [    0.000000] Could not find start_pfn for node 0
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
> [    0.000000] Initmem setup node 2 [mem 0x0000000000000000-0x00000013ffffffff]
> [    0.000000] Initmem setup node 6 [mem 0x0000001400000000-0x00000034afffffff]
> [    0.000000] Initmem setup node 7 [mem 0x00000034b0000000-0x0000003bffffffff]
> [    0.000000] percpu: Embedded 3 pages/cpu @c000003bf8000000 s155672 r0 d40936 u262144
> [    0.000000] Built 4 zonelists in Node order, mobility grouping on.  Total pages: 3928320
>
> and,
>
> [root@ltcalpine2-lp20 ~]# numactl --hardware
> available: 4 nodes (0,2,6-7)
> node 0 cpus:
> node 0 size: 0 MB
> node 0 free: 0 MB
> node 2 cpus: 16 17 18 19 20 21 22 23 32 33 34 35 36 37 38 39 56 57 58 59 60 61 62 63
> node 2 size: 81792 MB
> node 2 free: 81033 MB
> node 6 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31 40 41 42 43 44 45 46 47
> node 6 size: 133743 MB
> node 6 free: 133097 MB
> node 7 cpus: 48 49 50 51 52 53 54 55
> node 7 size: 29877 MB
> node 7 free: 29599 MB
> node distances:
> node   0   2   6   7
>   0:  10  40  40  40
>   2:  40  10  40  40
>   6:  40  40  10  20
>   7:  40  40  20  10
> [root@ltcalpine2-lp20 ~]#

What kernel is that running?

And can you show me the full ibm,dynamic-memory and lookup-arrays
properties for that system?

cheers

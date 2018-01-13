Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJNvz24r0zDqTr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 13:33:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/kernel: Add 'ibm,
 thread-groups' property for CPU allocation
In-Reply-To: <d7825e1c-ca1f-3bbe-be41-897b3e98e928@linux.vnet.ibm.com>
References: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
 <d7825e1c-ca1f-3bbe-be41-897b3e98e928@linux.vnet.ibm.com>
Date: Sat, 13 Jan 2018 13:33:33 +1100
Message-ID: <87tvvqbi82.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> On 01/08/2018 11:19 AM, Michael Bringmann wrote:
>> Add code to parse the new property 'ibm,thread-groups" when it is
>> present.  The content of this property explicitly defines the number
>> of threads per core as well as the PowerPC 'threads_core_mask'.
>> The design provides a common device-tree for both P9 normal core and
>> P9 fused core systems.  The new property has been observed to be
>> available on P9 pHyp systems, but it is not always present on
>> OpenPower BMC systems.
>> 
>> The property updates the kernel to know which CPUs/threads of each
>> core are actually present, and then use the map when adding cores
>> to the system at boot, or during hotplug operations.
>> 
>> * Previously, the information about the number of threads per core
>>   was inferred solely from the "ibm,ppc-interrupt-server#s" property
>>   in the system device tree.
>> * Also previous to this property, The mask of threads per CPU was
>>   inferred to be a strict linear series from 0..(nthreads-1).
>> * After reading the "ibm,thread-group" property, we can determine
>>   the number of threads per core to be the 'bitmask weight' of the
>>   CPU thread mask.
>> * Also after reading the property, we can determine which of the
>>   possible threads we are allowed to online for each CPU.  It is no
>>   longer a simple linear sequence, but may be discontinuous e.g.
>>   activate threads 1,2,3,5,6,7 on a core instead of 0-5 sequentially.
>> 
>> Implementation of the "ibm,thread-groups" property is spread across
>> a few files in the powerpc specific code:
>> 
>> * prom.c: Parse the property and create 'ppc_thread_group_mask'.
>>           Use the mask in operation of early_init_dt_scan_cpus().
>> * setup-common.c: Import 'ppc_thread_group_mask' and use the value
>>           in the operation of cpu_init_thread_core_maps(), and
>>           smp_setup_cpu_maps.
>> * hotplug-cpu.c: Use 'ppc_thread_group_mask' in several locations
>>           where the code previously expected to iterate over a
>>           linear series of active threads (0..nthreads-1).
>> 
>> Note that the "ibm,thread-groups" property also includes semantics
>> of 'thread-group' i.e. define one or more subgroups of the available
>> threads, each group of threads to be used for a specific class of
>> task.  Translating thread group semantics into Linux kernel features
>> is TBD.
>
> One thing I don't see addressed in the comments or in the code is
> migration support. I think we need to update the thread group mask
> post-migration to reflect the threads per core on the new system.

Normally I'd agree with you, but I don't see any prospect of the kernel
surviving if the threads per core changes across a migration. We'll have
data structures allocated based on the old value and things will
definitely crash if the value increases. If it shrinks maybe we'd get
away with it, but either way is dicey.

If there's an expectation that we'll be able to migrate between systems
with different settings then we have a much bigger problem.

cheers

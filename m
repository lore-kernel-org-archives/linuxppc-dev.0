Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K39221tBzF3Jg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 11:17:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Track LMB nid instead of using device
 tree
In-Reply-To: <514f0192-4403-4305-1c2b-41dc752bcd36@linux.vnet.ibm.com>
References: <153677072365.15599.14388703259401466198.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87h8ikkckz.fsf@concordia.ellerman.id.au>
 <514f0192-4403-4305-1c2b-41dc752bcd36@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 11:17:57 +1000
Message-ID: <878t3q5q9m.fsf@concordia.ellerman.id.au>
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
> On 09/19/2018 11:38 PM, Michael Ellerman wrote:
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>>> When removing memory we need to remove the memory from the node
>>> it was added to instead of looking up the node it should be in
>>> in the device tree.
>>>
>>> During testing we have seen scenarios where the affinity for a
>>> LMB changes due to a partition migration or PRRN event. In these
>>> cases the node the LMB exists in may not match the node the device
>>> tree indicates it belongs in. This can lead to a system crash
>>> when trying to DLAPR remove the LMB after a migration or PRRN
>>> event. The current code looks up the node in the device tree to
>>> remove the LMB from, the crash occurs when we try to offline this
>>> node and it does not have any data, i.e. node_data[nid] == NULL.
>> 
>> This isn't building for 32-bit etc:
>> 
>> arch/powerpc/mm/drmem.c: In function 'init_drmem_v1_lmbs':
>> arch/powerpc/mm/drmem.c:371:14: error: implicit declaration of function 'memory_add_physaddr_to_nid' [-Werror=implicit-function-declaration]
>>    lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
>>               ^
>> cc1: all warnings being treated as errors
>> scripts/Makefile.build:317: recipe for target 'arch/powerpc/mm/drmem.o' failed
>> 
>> See the failed checks here:
>>   https://patchwork.ozlabs.org/patch/969150/
>> 
>> 
>> Probably drmem.c should only be compiled for 64-bit NUMA etc.
>
> Looks like the root cause is that memory hotplug relies on sparsemem which
> is not supported on 32-bit.

Yeah that could be it.

Making drmem.c built just for MEMORY_HOTPLUG would make sense.

> This patch is also going to need a refresh to apply cleanly due to other
> patches that have gone in. I'll re-submit after looking at the build break issues more.

OK thanks.

cheers

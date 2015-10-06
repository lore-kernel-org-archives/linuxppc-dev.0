Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B02611A0013
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 22:14:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 6 Oct 2015 21:14:50 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9195E2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 22:14:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t96BEYf126935370
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 22:14:42 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t96BEDSH030964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 22:14:13 +1100
Message-ID: <5613AD3C.7040709@linux.vnet.ibm.com>
Date: Tue, 06 Oct 2015 16:45:08 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 cl@linux.com, nacc@linux.vnet.ibm.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  0/5] powerpc:numa Add serial nid support
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1444127145.16578.8.camel@ellerman.id.au>
In-Reply-To: <1444127145.16578.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/06/2015 03:55 PM, Michael Ellerman wrote:
> On Sun, 2015-09-27 at 23:59 +0530, Raghavendra K T wrote:
>> Problem description:
>> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
>> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
>> got from device tree is naturally mapped (directly) to nid.
>>
>> Potential side effect of that is:
>>
>> 1) There are several places in kernel that assumes serial node numbering.
>> and memory allocations assume that all the nodes from 0-(highest nid)
>> exist inturn ending up allocating memory for the nodes that does not exist.
>
> Is it several? Or lots?
>
> If it's several, ie. more than two but not lots, then we should probably just
> fix those places. Or is that /really/ hard for some reason?
>

It is several and I did attempt to fix them. But the rest of the places
(like memcg, work queue, scheduler and so on) are tricky to fix because
the memory allocations are glued with other things.
and similar fix may be expected in future too..


> Do we ever get whole nodes hotplugged in under PowerVM? I don't think so, but I
> don't remember for sure.
>

Even on powervm we do have discontiguous  numa nodes. [Adding more to 
it, we could even end up creating a dummy node 0 just to make kernel
happy]
for e.g.,
available: 2 nodes (0,7)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 7 cpus: 0 1 2 3 4 5 6 7
node 7 size: 10240 MB
node 7 free: 8174 MB
node distances:
node   0   7
   0:  10  40
   7:  40  10

note that node zero neither has any cpu nor memory.

>> 2) For virtualization use cases (such as qemu, libvirt, openstack), mapping
>> sparse nid of the host system to contiguous nids of guest (numa affinity,
>> placement) could be a challenge.
>
> Can you elaborate? That's a bit vague.

one e.g., i can think of: (though libvirt/openstack people will know 
more about it) suppose one wishes to have half of the vcpus bind to one
physical node and rest of the vcpus to second numa node, we cant say
whether second node is 1,8, or 16. and same libvirtxml on a two node
system may not be valid for another two numa node system.
[ i believe it may cause some migration problem too ].

>
>> Possible Solutions:
>> 1) Handling the memory allocations is kernel case by case: Though in some
>> cases it is easy to achieve, some cases may be intrusive/not trivial.
>> at the end it does not handle side effect (2) above.
>>
>> 2) Map the sparse chipid got from device tree to a serial nid at kernel
>> level (The idea proposed in this series).
>> Pro: It is more natural to handle at kernel level than at lower (OPAL) layer.
>> con: The chipid is in device tree no longer the same as nid in kernel
>>
>> 3) Let the lower layer (OPAL) give the serial node ids after parsing the
>> chipid and the associativity etc [ either as a separate item in device tree
>> or by compacting the chipid numbers ]
>> Pros: kernel, device tree are on same page and less change in kernel
>> Con: is it the functionality expected in lower layer
>
> ...
>
>> 3) Numactl tests from
>> ftp://oss.sgi.com/www/projects/libnuma/download/numactl-2.0.10.tar.gz
>>
>> (infact there were more breakage before the patch because of sparse nid
>> and memoryless node cases of powerpc)
>
> This is probably the best argument for your series. ie. userspace is dumb and
> fixing every broken app that assumes linear node numbering is not feasible.
>
>
> So on the whole I think the concept is good. This series though is a bit
> confusing because of all the renaming etc. etc. Nish made lots of good comments
> so I'll wait for a v2 based on those.
>

Yes, will be sending V2 soon extending my patch to fix powervm case too.

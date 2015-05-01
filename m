Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B915E1A0E0B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:05:33 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so82388053pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 23:05:32 -0700 (PDT)
Message-ID: <554317A4.3090300@ozlabs.ru>
Date: Fri, 01 May 2015 16:05:24 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com> <5541F6D5.9040809@ozlabs.ru>
 <20150501043354.GN24886@voom.redhat.com>
In-Reply-To: <20150501043354.GN24886@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 02:33 PM, David Gibson wrote:
> On Thu, Apr 30, 2015 at 07:33:09PM +1000, Alexey Kardashevskiy wrote:
>> On 04/30/2015 05:22 PM, David Gibson wrote:
>>> On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
>>>> At the moment only one group per container is supported.
>>>> POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
>>>> IOMMU group so we can relax this limitation and support multiple groups
>>>> per container.
>>>
>>> It's not obvious why allowing multiple TCE tables per PE has any
>>> pearing on allowing multiple groups per container.
>>
>>
>> This patchset is a global TCE tables rework (patches 1..30, roughly) with 2
>> outcomes:
>> 1. reusing the same IOMMU table for multiple groups - patch 31;
>> 2. allowing dynamic create/remove of IOMMU tables - patch 32.
>>
>> I can remove this one from the patchset and post it separately later but
>> since 1..30 aim to support both 1) and 2), I'd think I better keep them all
>> together (might explain some of changes I do in 1..30).
>
> The combined patchset is fine.  My comment is because your commit
> message says that multiple groups are possible *because* 2 TCE tables
> per group are allowed, and it's not at all clear why one follows from
> the other.


Ah. That's wrong indeed, I'll fix it.


>>>> This adds TCE table descriptors to a container and uses iommu_table_group_ops
>>>> to create/set DMA windows on IOMMU groups so the same TCE tables will be
>>>> shared between several IOMMU groups.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> [aw: for the vfio related changes]
>>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>>> ---
>>>> Changes:
>>>> v7:
>>>> * updated doc
>>>> ---
>>>>   Documentation/vfio.txt              |   8 +-
>>>>   drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++----------
>>>>   2 files changed, 199 insertions(+), 77 deletions(-)
>>>>
>>>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>>>> index 94328c8..7dcf2b5 100644
>>>> --- a/Documentation/vfio.txt
>>>> +++ b/Documentation/vfio.txt
>>>> @@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
>>>>
>>>>   This implementation has some specifics:
>>>>
>>>> -1) Only one IOMMU group per container is supported as an IOMMU group
>>>> -represents the minimal entity which isolation can be guaranteed for and
>>>> -groups are allocated statically, one per a Partitionable Endpoint (PE)
>>>> +1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
>>>> +container is supported as an IOMMU table is allocated at the boot time,
>>>> +one table per a IOMMU group which is a Partitionable Endpoint (PE)
>>>>   (PE is often a PCI domain but not always).
>>>
>>> I thought the more fundamental problem was that different PEs tended
>>> to use disjoint bus address ranges, so even by duplicating put_tce
>>> across PEs you couldn't have a common address space.
>>
>>
>> Sorry, I am not following you here.
>>
>> By duplicating put_tce, I can have multiple IOMMU groups on the same virtual
>> PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable multiple groups
>> per container" does this, the address ranges will the same.
>
> Oh, ok.  For some reason I thought that (at least on the older
> machines) the different PEs used different and not easily changeable
> DMA windows in bus addresses space.


They do use different tables (which VFIO does not get to remove/create and 
uses these old helpers - iommu_take/release_ownership), correct. But all 
these windows are mapped at zero on a PE's PCI bus and nothing prevents me 
from updating all these tables with the same TCE values when handling 
H_PUT_TCE. Yes it is slow but it works (bit more details below).



>> What I cannot do on p5ioc2 is programming the same table to multiple
>> physical PHBs (or I could but it is very different than IODA2 and pretty
>> ugly and might not always be possible because I would have to allocate these
>> pages from some common pool and face problems like fragmentation).
>
> So allowing multiple groups per container should be possible (at the
> kernel rather than qemu level) by writing the same value to multiple
> TCE tables.  I guess its not worth doing for just the almost-obsolete
> IOMMUs though.


It is done at QEMU level though. As it works now, QEMU opens a group, walks 
through all existing containers and tries attaching a new group there. If 
it succeeded (x86 always; POWER8 after this patch), a TCE table is shared. 
If it failed, QEMU creates another container, attaches it to the same 
VFIO/PHB address space and attaches a group there.

Then the only thing left is repeating ioctl() in vfio_container_ioctl() for 
every container in the VFIO address space; this is what that QEMU patch 
does (the first version of that patch called ioctl() only for the first 
container in the address space).

 From the kernel prospective there are 2 isolated containers; I'd like to 
keep it this way.

btw thanks for the detailed review :)

-- 
Alexey

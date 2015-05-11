Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB5471A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:26:26 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so97908601pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 19:26:24 -0700 (PDT)
Message-ID: <5550134A.3000208@ozlabs.ru>
Date: Mon, 11 May 2015 12:26:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com> <5541F6D5.9040809@ozlabs.ru>
 <20150501043354.GN24886@voom.redhat.com> <554317A4.3090300@ozlabs.ru>
 <20150505115025.GJ14090@voom.redhat.com>
In-Reply-To: <20150505115025.GJ14090@voom.redhat.com>
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

On 05/05/2015 09:50 PM, David Gibson wrote:
> On Fri, May 01, 2015 at 04:05:24PM +1000, Alexey Kardashevskiy wrote:
>> On 05/01/2015 02:33 PM, David Gibson wrote:
>>> On Thu, Apr 30, 2015 at 07:33:09PM +1000, Alexey Kardashevskiy wrote:
>>>> On 04/30/2015 05:22 PM, David Gibson wrote:
>>>>> On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
>>>>>> At the moment only one group per container is supported.
>>>>>> POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
>>>>>> IOMMU group so we can relax this limitation and support multiple groups
>>>>>> per container.
>>>>>
>>>>> It's not obvious why allowing multiple TCE tables per PE has any
>>>>> pearing on allowing multiple groups per container.
>>>>
>>>>
>>>> This patchset is a global TCE tables rework (patches 1..30, roughly) with 2
>>>> outcomes:
>>>> 1. reusing the same IOMMU table for multiple groups - patch 31;
>>>> 2. allowing dynamic create/remove of IOMMU tables - patch 32.
>>>>
>>>> I can remove this one from the patchset and post it separately later but
>>>> since 1..30 aim to support both 1) and 2), I'd think I better keep them all
>>>> together (might explain some of changes I do in 1..30).
>>>
>>> The combined patchset is fine.  My comment is because your commit
>>> message says that multiple groups are possible *because* 2 TCE tables
>>> per group are allowed, and it's not at all clear why one follows from
>>> the other.
>>
>>
>> Ah. That's wrong indeed, I'll fix it.
>>
>>
>>>>>> This adds TCE table descriptors to a container and uses iommu_table_group_ops
>>>>>> to create/set DMA windows on IOMMU groups so the same TCE tables will be
>>>>>> shared between several IOMMU groups.
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> [aw: for the vfio related changes]
>>>>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>>>>> ---
>>>>>> Changes:
>>>>>> v7:
>>>>>> * updated doc
>>>>>> ---
>>>>>>   Documentation/vfio.txt              |   8 +-
>>>>>>   drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++----------
>>>>>>   2 files changed, 199 insertions(+), 77 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>>>>>> index 94328c8..7dcf2b5 100644
>>>>>> --- a/Documentation/vfio.txt
>>>>>> +++ b/Documentation/vfio.txt
>>>>>> @@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
>>>>>>
>>>>>>   This implementation has some specifics:
>>>>>>
>>>>>> -1) Only one IOMMU group per container is supported as an IOMMU group
>>>>>> -represents the minimal entity which isolation can be guaranteed for and
>>>>>> -groups are allocated statically, one per a Partitionable Endpoint (PE)
>>>>>> +1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
>>>>>> +container is supported as an IOMMU table is allocated at the boot time,
>>>>>> +one table per a IOMMU group which is a Partitionable Endpoint (PE)
>>>>>>   (PE is often a PCI domain but not always).
>>>>>
>>>>> I thought the more fundamental problem was that different PEs tended
>>>>> to use disjoint bus address ranges, so even by duplicating put_tce
>>>>> across PEs you couldn't have a common address space.
>>>>
>>>>
>>>> Sorry, I am not following you here.
>>>>
>>>> By duplicating put_tce, I can have multiple IOMMU groups on the same virtual
>>>> PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable multiple groups
>>>> per container" does this, the address ranges will the same.
>>>
>>> Oh, ok.  For some reason I thought that (at least on the older
>>> machines) the different PEs used different and not easily changeable
>>> DMA windows in bus addresses space.
>>
>>
>> They do use different tables (which VFIO does not get to remove/create and
>> uses these old helpers - iommu_take/release_ownership), correct. But all
>> these windows are mapped at zero on a PE's PCI bus and nothing prevents me
>> from updating all these tables with the same TCE values when handling
>> H_PUT_TCE. Yes it is slow but it works (bit more details below).
>
> Um.. I'm pretty sure that contradicts what Ben was saying on the
> thread.


True, it does contradict, I do not know why he said what he said :)



-- 
Alexey

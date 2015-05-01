Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD92F1A0FE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 17:12:54 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so83755759pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2015 00:12:53 -0700 (PDT)
Message-ID: <5543276D.1090708@ozlabs.ru>
Date: Fri, 01 May 2015 17:12:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of
 TCE table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
 <20150429063113.GW32589@voom.redhat.com> <5542FA8D.2060400@ozlabs.ru>
 <20150501042319.GM24886@voom.redhat.com>
In-Reply-To: <20150501042319.GM24886@voom.redhat.com>
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

On 05/01/2015 02:23 PM, David Gibson wrote:
> On Fri, May 01, 2015 at 02:01:17PM +1000, Alexey Kardashevskiy wrote:
>> On 04/29/2015 04:31 PM, David Gibson wrote:
>>> On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
>>>> In order to support memory pre-registration, we need a way to track
>>>> the use of every registered memory region and only allow unregistration
>>>> if a region is not in use anymore. So we need a way to tell from what
>>>> region the just cleared TCE was from.
>>>>
>>>> This adds a userspace view of the TCE table into iommu_table struct.
>>>> It contains userspace address, one per TCE entry. The table is only
>>>> allocated when the ownership over an IOMMU group is taken which means
>>>> it is only used from outside of the powernv code (such as VFIO).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v9:
>>>> * fixed code flow in error cases added in v8
>>>>
>>>> v8:
>>>> * added ENOMEM on failed vzalloc()
>>>> ---
>>>>   arch/powerpc/include/asm/iommu.h          |  6 ++++++
>>>>   arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
>>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
>>>>   3 files changed, 44 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>>>> index 7694546..1472de3 100644
>>>> --- a/arch/powerpc/include/asm/iommu.h
>>>> +++ b/arch/powerpc/include/asm/iommu.h
>>>> @@ -111,9 +111,15 @@ struct iommu_table {
>>>>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
>>>>   	unsigned long  it_page_shift;/* table iommu page size */
>>>>   	struct iommu_table_group *it_table_group;
>>>> +	unsigned long *it_userspace; /* userspace view of the table */
>>>
>>> A single unsigned long doesn't seem like enough.
>>
>> Why single? This is an array.
>
> As in single per page.


Sorry, I am not following you here.
It is per IOMMU page. MAP/UNMAP work with IOMMU pages which are fully 
backed with either system page or a huge page.


>
>>> How do you know
>>> which process's address space this address refers to?
>>
>> It is a current task. Multiple userspaces cannot use the same container/tables.
>
> Where is that enforced?


It is accessed from VFIO DMA map/unmap which are ioctls() to a container's 
fd which is per a process. Same for KVM - when it registers IOMMU groups in 
KVM, fd's of opened IOMMU groups are passed there. Or I did not understand 
the question...


> More to the point, that's a VFIO constraint, but it's here affecting
> the design of a structure owned by the platform code.

Right. But keeping in mind KVM, I cannot think of any better design here.


> [snip]
>>>>   static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
>>>> @@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>>>>   	int nid = pe->phb->hose->node;
>>>>   	__u64 bus_offset = num ? pe->tce_bypass_base : 0;
>>>>   	long ret;
>>>> +	unsigned long *uas, uas_cb = sizeof(*uas) * (window_size >> page_shift);
>>>> +
>>>> +	uas = vzalloc(uas_cb);
>>>> +	if (!uas)
>>>> +		return -ENOMEM;
>>>
>>> I don't see why this is allocated both here as well as in
>>> take_ownership.
>>
>> Where else? The only alternative is vfio_iommu_spapr_tce but I really do not
>> want to touch iommu_table fields there.
>
> Well to put it another way, why isn't take_ownership calling create
> itself (or at least a common helper).

I am trying to keep DDW stuff away from platform-oriented 
arch/powerpc/kernel/iommu.c which main purpose is to implement 
iommu_alloc()&co. It already has

I'd rather move it_userspace allocation completely to vfio_iommu_spapr_tce 
(should have done earlier, actually), would this be ok?


> Clearly the it_userspace table needs to have lifetime which matches
> the TCE table itself, so there should be a single function that marks
> the beginning of that joint lifetime.


No. it_userspace lives as long as the platform code does not control the 
table. For IODA2 it is equal for the lifetime of the table, for 
IODA1/P5IOC2 it is not.



>>> Isn't this function used for core-kernel users of the
>>> iommu as well, in which case it shouldn't need the it_userspace.
>>
>>
>> No. This is an iommu_table_group_ops callback which calls what the platform
>> code calls (pnv_pci_create_table()) plus allocates this it_userspace thing.
>> The callback is only called from VFIO.
>
> Ok.
>
> As touched on above it seems more like this should be owned by VFIO
> code than the platform code.

Agree now :) I'll move the allocation to VFIO. Thanks!


-- 
Alexey

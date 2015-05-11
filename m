Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B2781A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:24:47 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so132383691pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 19:24:46 -0700 (PDT)
Message-ID: <555012E7.4020106@ozlabs.ru>
Date: Mon, 11 May 2015 12:24:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 27/32] powerpc/iommu/ioda2: Add get_table_size()
 to calculate the size of future table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
 <20150429064029.GX32589@voom.redhat.com> <5542FCD2.9000601@ozlabs.ru>
 <20150501051247.GP24886@voom.redhat.com> <554322D4.7070508@ozlabs.ru>
 <20150505115813.GL14090@voom.redhat.com>
In-Reply-To: <20150505115813.GL14090@voom.redhat.com>
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

On 05/05/2015 09:58 PM, David Gibson wrote:
> On Fri, May 01, 2015 at 04:53:08PM +1000, Alexey Kardashevskiy wrote:
>> On 05/01/2015 03:12 PM, David Gibson wrote:
>>> On Fri, May 01, 2015 at 02:10:58PM +1000, Alexey Kardashevskiy wrote:
>>>> On 04/29/2015 04:40 PM, David Gibson wrote:
>>>>> On Sat, Apr 25, 2015 at 10:14:51PM +1000, Alexey Kardashevskiy wrote:
>>>>>> This adds a way for the IOMMU user to know how much a new table will
>>>>>> use so it can be accounted in the locked_vm limit before allocation
>>>>>> happens.
>>>>>>
>>>>>> This stores the allocated table size in pnv_pci_create_table()
>>>>>> so the locked_vm counter can be updated correctly when a table is
>>>>>> being disposed.
>>>>>>
>>>>>> This defines an iommu_table_group_ops callback to let VFIO know
>>>>>> how much memory will be locked if a table is created.
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> ---
>>>>>> Changes:
>>>>>> v9:
>>>>>> * reimplemented the whole patch
>>>>>> ---
>>>>>>   arch/powerpc/include/asm/iommu.h          |  5 +++++
>>>>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++
>>>>>>   arch/powerpc/platforms/powernv/pci.c      | 36 +++++++++++++++++++++++++++++++
>>>>>>   arch/powerpc/platforms/powernv/pci.h      |  2 ++
>>>>>>   4 files changed, 57 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>>>>>> index 1472de3..9844c106 100644
>>>>>> --- a/arch/powerpc/include/asm/iommu.h
>>>>>> +++ b/arch/powerpc/include/asm/iommu.h
>>>>>> @@ -99,6 +99,7 @@ struct iommu_table {
>>>>>>   	unsigned long  it_size;      /* Size of iommu table in entries */
>>>>>>   	unsigned long  it_indirect_levels;
>>>>>>   	unsigned long  it_level_size;
>>>>>> +	unsigned long  it_allocated_size;
>>>>>>   	unsigned long  it_offset;    /* Offset into global table */
>>>>>>   	unsigned long  it_base;      /* mapped address of tce table */
>>>>>>   	unsigned long  it_index;     /* which iommu table this is */
>>>>>> @@ -155,6 +156,10 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>>>>>   struct iommu_table_group;
>>>>>>
>>>>>>   struct iommu_table_group_ops {
>>>>>> +	unsigned long (*get_table_size)(
>>>>>> +			__u32 page_shift,
>>>>>> +			__u64 window_size,
>>>>>> +			__u32 levels);
>>>>>>   	long (*create_table)(struct iommu_table_group *table_group,
>>>>>>   			int num,
>>>>>>   			__u32 page_shift,
>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>> index e0be556..7f548b4 100644
>>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>>> @@ -2062,6 +2062,18 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>>>>>>   }
>>>>>>
>>>>>>   #ifdef CONFIG_IOMMU_API
>>>>>> +static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>>>>>> +		__u64 window_size, __u32 levels)
>>>>>> +{
>>>>>> +	unsigned long ret = pnv_get_table_size(page_shift, window_size, levels);
>>>>>> +
>>>>>> +	if (!ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	/* Add size of it_userspace */
>>>>>> +	return ret + (window_size >> page_shift) * sizeof(unsigned long);
>>>>>
>>>>> This doesn't make much sense.  The userspace view can't possibly be a
>>>>> property of the specific low-level IOMMU model.
>>>>
>>>>
>>>> This it_userspace thing is all about memory preregistration.
>>>>
>>>> I need some way to track how many actual mappings the
>>>> mm_iommu_table_group_mem_t has in order to decide whether to allow
>>>> unregistering or not.
>>>>
>>>> When I clear TCE, I can read the old value which is host physical address
>>>> which I cannot use to find the preregistered region and adjust the mappings
>>>> counter; I can only use userspace addresses for this (not even guest
>>>> physical addresses as it is VFIO and probably no KVM).
>>>>
>>>> So I have to keep userspace addresses somewhere, one per IOMMU page, and the
>>>> iommu_table seems a natural place for this.
>>>
>>> Well.. sort of.  But as noted elsewhere this pulls VFIO specific
>>> constraints into a platform code structure.  And whether you get this
>>> table depends on the platform IOMMU type rather than on what VFIO
>>> wants to do with it, which doesn't make sense.
>>>
>>> What might make more sense is an opaque pointer io iommu_table for use
>>> by the table "owner" (in the take_ownership sense).  The pointer would
>>> be stored in iommu_table, but VFIO is responsible for populating and
>>> managing its contents.
>>>
>>> Or you could just put the userspace mappings in the container.
>>> Although you might want a different data structure in that case.
>>
>> Nope. I need this table in in-kernel acceleration to update the mappings
>> counter per mm_iommu_table_group_mem_t. In KVM's real mode handlers, I only
>> have IOMMU tables, not containers or groups. QEMU creates a guest view of
>> the table (KVM_CREATE_SPAPR_TCE) specifying a LIOBN, and then attaches TCE
>> tables to it via set of ioctls (one per IOMMU group) to VFIO KVM device.
>>
>> So if I call it it_opaque (instead of it_userspace), I will still need a
>> common place (visible to VFIO and PowerKVM) for this to put:
>> #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry)
>
> I think it should be in a VFIO header.  If I'm understanding right
> this part of the PowerKVM code is explicitly VFIO aware - that's kind
> of the point.

Well. 2 points against it are:

1. arch/powerpc/kvm/book3s_64_vio_hv.c and arch/powerpc/kvm/book3s_64_vio.c 
are not including any of vfio headers now (all required liobn<->iommu 
hooking bits are in virt/kvm/vfio.c), and I kind of like it.

2. for me it seems like a good idea to keep an accessor close to what it 
provides the access to. Since I cannot move it_userspace somewhere else, I 
should not move IOMMU_TABLE_USERSPACE_ENTRY() either.



>> So far this place was arch/powerpc/include/asm/iommu.h and the iommu_table
>> struct.
>>
>>
>>> The other thing to bear in mind is that registered regions are likely
>>> to be large contiguous blocks in user addresses, though obviously not
>>> contiguous in physical addr.  So you might be able to compaticfy this
>>> information by storing it as a list of variable length blocks in
>>> userspace address space, rather than a per-page address..
>>
>> It is 8 bytes per system page - 8/65536 = 0.00012 (or 26MB for 200GB guest)
>> - very little overhead.
>>
>>
>>> But.. isn't there a bigger problem here.  As Paulus was pointing out,
>>> there's nothing guaranteeing the page tables continue to contain the
>>> same page as was there at gup() time.
>>
>> This can happen if the userspace remaps memory which it registered/mapped
>> for DMA via VFIO, no? If so, then the userspace just should not do this, it
>> is DMA, it cannot be moved like this. What am I missing here?
>>
>>
>>> What's going to happen if you REGISTER a memory region, then mremap()
>>> over it?
>>
>> The registered pages will remain pinned and PUT_TCE will use that region for
>> translation (and this will fail as the userspace addresses changed).
>>
>> I do not see how it is different from the situation when the userspace
>> mapped a page and mremap()ed it while it is DMA-mapped.
>
> True, it's basically the same.  Hrm, so what guarantees a dma_map,
> mremap() dma_unmap will unreference the correct pages.

The original page will remain pinned, wrong one will be unpinned, access to 
it will produce EEH, the process exit will do cleanup. What is the problem 
here? Inability for the userspace to dma_map() and then remap()? I do not 
think x86 (or anything else) can and should cope with this well, it is DMA, 
you just cannot do certain things when you work with DMA...



>>> Then attempt to PUT_TCE a page in the region? Or what if you
>>> mremap() it to someplace else then try to PUT_TCE a page there?
>>
>> This will fail - a new userspace address has to be preregistered.
>>
>>> Or REGISTER it again in its new location?
>>
>> It will be pinned twice + some memory overhead to store the same host
>> physical address(es) twice.
>>
>>
>>
>


-- 
Alexey

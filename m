Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416Wwk1HfpzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 17:15:30 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id g20-v6so4904742plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 00:15:30 -0700 (PDT)
Subject: Re: [PATCH kernel 6/6] powerpc/powernv/ioda: Allocate indirect TCE
 levels on demand
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-7-aik@ozlabs.ru>
 <20180612041700.GZ2737@umbus.fritz.box>
 <360896bd-f3a9-530c-8144-c10502dc965b@ozlabs.ru>
 <20180614123525.GB19339@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <74fe4fba-3cfb-ba2c-90e2-e83eb173964f@ozlabs.ru>
Date: Fri, 15 Jun 2018 17:15:23 +1000
MIME-Version: 1.0
In-Reply-To: <20180614123525.GB19339@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/6/18 10:35 pm, David Gibson wrote:
> On Thu, Jun 14, 2018 at 04:35:18PM +1000, Alexey Kardashevskiy wrote:
>> On 12/6/18 2:17 pm, David Gibson wrote:
>>> On Fri, Jun 08, 2018 at 03:46:33PM +1000, Alexey Kardashevskiy wrote:
>>>> At the moment we allocate the entire TCE table, twice (hardware part and
>>>> userspace translation cache). This normally works as we normally have
>>>> contigous memory and the guest will map entire RAM for 64bit DMA.
>>>>
>>>> However if we have sparse RAM (one example is a memory device), then
>>>> we will allocate TCEs which will never be used as the guest only maps
>>>> actual memory for DMA. If it is a single level TCE table, there is nothing
>>>> we can really do but if it a multilevel table, we can skip allocating
>>>> TCEs we know we won't need.
>>>>
>>>> This adds ability to allocate only first level, saving memory.
>>>>
>>>> This changes iommu_table::free() to avoid allocating of an extra level;
>>>> iommu_table::set() will do this when needed.
>>>>
>>>> This adds @alloc parameter to iommu_table::exchange() to tell the callback
>>>> if it can allocate an extra level; the flag is set to "false" for
>>>> the realmode KVM handlers of H_PUT_TCE hcalls and the callback returns
>>>> H_TOO_HARD.
>>>>
>>>> This still requires the entire table to be counted in mm::locked_vm.
>>>>
>>>> To be conservative, this only does on-demand allocation when
>>>> the usespace cache table is requested which is the case of VFIO.
>>>>
>>>> The example math for a system replicating a powernv setup with NVLink2
>>>> in a guest:
>>>> 16GB RAM mapped at 0x0
>>>> 128GB GPU RAM window (16GB of actual RAM) mapped at 0x244000000000
>>>>
>>>> the table to cover that all with 64K pages takes:
>>>> (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 = 4556MB
>>>>
>>>> If we allocate only necessary TCE levels, we will only need:
>>>> (((0x400000000 + 0x400000000) >> 16)*8)>>20 = 4MB (plus some for indirect
>>>> levels).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  arch/powerpc/include/asm/iommu.h              |  7 ++-
>>>>  arch/powerpc/platforms/powernv/pci.h          |  6 ++-
>>>>  arch/powerpc/kvm/book3s_64_vio_hv.c           |  4 +-
>>>>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 69 ++++++++++++++++++++-------
>>>>  arch/powerpc/platforms/powernv/pci-ioda.c     |  8 ++--
>>>>  drivers/vfio/vfio_iommu_spapr_tce.c           |  2 +-
>>>>  6 files changed, 69 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>>>> index 4bdcf22..daa3ee5 100644
>>>> --- a/arch/powerpc/include/asm/iommu.h
>>>> +++ b/arch/powerpc/include/asm/iommu.h
>>>> @@ -70,7 +70,7 @@ struct iommu_table_ops {
>>>>  			unsigned long *hpa,
>>>>  			enum dma_data_direction *direction);
>>>>  
>>>> -	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
>>>> +	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index, bool alloc);
>>>>  #endif
>>>>  	void (*clear)(struct iommu_table *tbl,
>>>>  			long index, long npages);
>>>> @@ -122,10 +122,13 @@ struct iommu_table {
>>>>  	__be64 *it_userspace; /* userspace view of the table */
>>>>  	struct iommu_table_ops *it_ops;
>>>>  	struct kref    it_kref;
>>>> +	int it_nid;
>>>>  };
>>>>  
>>>> +#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
>>>> +		((tbl)->it_ops->useraddrptr((tbl), (entry), false))
>>>
>>> Is real mode really the only case where you want to inhibit new
>>> allocations?  I would have thought some paths would be read-only and
>>> you wouldn't want to allocate, even in virtual mode.
>>
>> There are paths when I do not want allocation but I can figure out that
>> from dma direction flag, for example, I am cleaning up the table and I do
>> not want any extra  allocation to happen there and they do happen because I
>> made a mistake so I'll repost. Other than that, this @alloc flag is for
>> real mode only.
> 
> Hm, ok.
> 
> Something just occurred to me: IIRC, going from the vmalloc() to the
> explicit table structure was to avoid allocating pages for memory
> regions that aren't there due to sparseness.  But.. won't you get that
> with vmalloc() anyway, if the pages for the gaps never get
> instantiated?


Nope, vmalloc() always allocates all the pages, these are not swapable
(checked with Paul).


-- 
Alexey

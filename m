Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 513721A38E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:27:57 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so82753743pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 23:27:55 -0700 (PDT)
Message-ID: <55431CE3.6050607@ozlabs.ru>
Date: Fri, 01 May 2015 16:27:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 29/32] vfio: powerpc/spapr: Register memory
 and define IOMMU v2
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-30-git-send-email-aik@ozlabs.ru>
 <20150430065524.GB24886@voom.redhat.com> <5543028B.300@ozlabs.ru>
 <20150501052357.GQ24886@voom.redhat.com>
In-Reply-To: <20150501052357.GQ24886@voom.redhat.com>
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

On 05/01/2015 03:23 PM, David Gibson wrote:
> On Fri, May 01, 2015 at 02:35:23PM +1000, Alexey Kardashevskiy wrote:
>> On 04/30/2015 04:55 PM, David Gibson wrote:
>>> On Sat, Apr 25, 2015 at 10:14:53PM +1000, Alexey Kardashevskiy wrote:
>>>> The existing implementation accounts the whole DMA window in
>>>> the locked_vm counter. This is going to be worse with multiple
>>>> containers and huge DMA windows. Also, real-time accounting would requite
>>>> additional tracking of accounted pages due to the page size difference -
>>>> IOMMU uses 4K pages and system uses 4K or 64K pages.
>>>>
>>>> Another issue is that actual pages pinning/unpinning happens on every
>>>> DMA map/unmap request. This does not affect the performance much now as
>>>> we spend way too much time now on switching context between
>>>> guest/userspace/host but this will start to matter when we add in-kernel
>>>> DMA map/unmap acceleration.
>>>>
>>>> This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
>>>> New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
>>>> 2 new ioctls to register/unregister DMA memory -
>>>> VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY -
>>>> which receive user space address and size of a memory region which
>>>> needs to be pinned/unpinned and counted in locked_vm.
>>>> New IOMMU splits physical pages pinning and TCE table update into 2 different
>>>> operations. It requires 1) guest pages to be registered first 2) consequent
>>>> map/unmap requests to work only with pre-registered memory.
>>>> For the default single window case this means that the entire guest
>>>> (instead of 2GB) needs to be pinned before using VFIO.
>>>> When a huge DMA window is added, no additional pinning will be
>>>> required, otherwise it would be guest RAM + 2GB.
>>>>
>>>> The new memory registration ioctls are not supported by
>>>> VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
>>>> will require memory to be preregistered in order to work.
>>>>
>>>> The accounting is done per the user process.
>>>>
>>>> This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
>>>> can do with v1 or v2 IOMMUs.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> [aw: for the vfio related changes]
>>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>>> ---
>>>> Changes:
>>>> v9:
>>>> * s/tce_get_hva_cached/tce_iommu_use_page_v2/
>>>>
>>>> v7:
>>>> * now memory is registered per mm (i.e. process)
>>>> * moved memory registration code to powerpc/mmu
>>>> * merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
>>>> * limited new ioctls to v2 IOMMU
>>>> * updated doc
>>>> * unsupported ioclts return -ENOTTY instead of -EPERM
>>>>
>>>> v6:
>>>> * tce_get_hva_cached() returns hva via a pointer
>>>>
>>>> v4:
>>>> * updated docs
>>>> * s/kzmalloc/vzalloc/
>>>> * in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
>>>> replaced offset with index
>>>> * renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_memory
>>>> and removed duplicating vfio_iommu_spapr_register_memory
>>>> ---
>>>>   Documentation/vfio.txt              |  23 ++++
>>>>   drivers/vfio/vfio_iommu_spapr_tce.c | 230 +++++++++++++++++++++++++++++++++++-
>>>>   include/uapi/linux/vfio.h           |  27 +++++
>>>>   3 files changed, 274 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>>>> index 96978ec..94328c8 100644
>>>> --- a/Documentation/vfio.txt
>>>> +++ b/Documentation/vfio.txt
>>>> @@ -427,6 +427,29 @@ The code flow from the example above should be slightly changed:
>>>>
>>>>   	....
>>>>
>>>> +5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
>>>> +VFIO_IOMMU_DISABLE and implements 2 new ioctls:
>>>> +VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
>>>> +(which are unsupported in v1 IOMMU).
>>>
>>> A summary of the semantic differeces between v1 and v2 would be nice.
>>> At this point it's not really clear to me if there's a case for
>>> creating v2, or if this could just be done by adding (optional)
>>> functionality to v1.
>>
>> v1: memory preregistration is not supported; explicit enable/disable ioctls
>> are required
>>
>> v2: memory preregistration is required; explicit enable/disable are
>> prohibited (as they are not needed).
>>
>> Mixing these in one IOMMU type caused a lot of problems like should I
>> increment locked_vm by the 32bit window size on enable() or not; what do I
>> do about pages pinning when map/map (check if it is from registered memory
>> and do not pin?).
>>
>> Having 2 IOMMU models makes everything a lot simpler.
>
> Ok.  Would it simplify it further if you made v2 only usable on IODA2
> hardware?


Very little. V2 addresses memory pinning issue which is handled the same 
way on ioda2 and older hardware, including KVM acceleration. Whether enable 
DDW or not - this is handled just fine via extra properties in the GET_INFO 
ioctl().

IODA2 and others are different in handling multiple groups per container 
but this does not require changes to userspace API.

And remember, the only machine I can use 100% of time is POWER7/P5IOC2 so 
it is really useful if at least some bits of the patchset can be tested 
there; if it was a bit less different from IODA2, I would have even 
implemented DDW there too :)


>>>> +PPC64 paravirtualized guests generate a lot of map/unmap requests,
>>>> +and the handling of those includes pinning/unpinning pages and updating
>>>> +mm::locked_vm counter to make sure we do not exceed the rlimit.
>>>> +The v2 IOMMU splits accounting and pinning into separate operations:
>>>> +
>>>> +- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
>>>> +receive a user space address and size of the block to be pinned.
>>>> +Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected to
>>>> +be called with the exact address and size used for registering
>>>> +the memory block. The userspace is not expected to call these often.
>>>> +The ranges are stored in a linked list in a VFIO container.
>>>> +
>>>> +- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
>>>> +IOMMU table and do not do pinning; instead these check that the userspace
>>>> +address is from pre-registered range.
>>>> +
>>>> +This separation helps in optimizing DMA for guests.
>>>> +
>>>>   -------------------------------------------------------------------------------
>>>>
>>>>   [1] VFIO was originally an acronym for "Virtual Function I/O" in its
>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> index 892a584..4cfc2c1 100644
>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>>>
>>> So, from things you said at other points, I thought the idea was that
>>> this registration stuff could also be used on non-Power IOMMUs.  Did I
>>> misunderstand, or is that a possibility for the future?
>>
>>
>> I never said a thing about non-PPC :) I seriously doubt any other arch has
>> this hypervisor interface with H_PUT_TCE (may be s390? :) ); for others
>> there is no profit from memory preregistration as they (at least x86) do map
>> the entire guest before it starts which essentially is that preregistration.
>>
>>
>> btw later we may want to implement simple IOMMU v3 which will do pinning +
>> locked_vm when mapping as x86 does, for http://dpdk.org/ - these things do
>> not really have to bother with preregistration (even if it just a single
>> additional ioctl).
>>
>>
>>
>>>> @@ -21,6 +21,7 @@
>>>>   #include <linux/vfio.h>
>>>>   #include <asm/iommu.h>
>>>>   #include <asm/tce.h>
>>>> +#include <asm/mmu_context.h>
>>>>
>>>>   #define DRIVER_VERSION  "0.1"
>>>>   #define DRIVER_AUTHOR   "aik@ozlabs.ru"
>>>> @@ -91,8 +92,58 @@ struct tce_container {
>>>>   	struct iommu_group *grp;
>>>>   	bool enabled;
>>>>   	unsigned long locked_pages;
>>>> +	bool v2;
>>>>   };
>>>>
>>>> +static long tce_unregister_pages(struct tce_container *container,
>>>> +		__u64 vaddr, __u64 size)
>>>> +{
>>>> +	long ret;
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +
>>>> +	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>>>> +		return -EINVAL;
>>>> +
>>>> +	mem = mm_iommu_get(vaddr, size >> PAGE_SHIFT);
>>>> +	if (!mem)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = mm_iommu_put(mem); /* undo kref_get() from mm_iommu_get() */
>>>> +	if (!ret)
>>>> +		ret = mm_iommu_put(mem);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static long tce_register_pages(struct tce_container *container,
>>>> +		__u64 vaddr, __u64 size)
>>>> +{
>>>> +	long ret = 0;
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +	unsigned long entries = size >> PAGE_SHIFT;
>>>> +
>>>> +	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
>>>> +			((vaddr + size) < vaddr))
>>>> +		return -EINVAL;
>>>> +
>>>> +	mem = mm_iommu_get(vaddr, entries);
>>>> +	if (!mem) {
>>>> +		ret = try_increment_locked_vm(entries);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		ret = mm_iommu_alloc(vaddr, entries, &mem);
>>>> +		if (ret) {
>>>> +			decrement_locked_vm(entries);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	container->enabled = true;
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> So requiring that registered regions get unregistered with exactly the
>>> same addr/length is reasonable.  I'm a bit less convinced that
>>> disallowing overlaps is a good idea.  What if two libraries in the
>>> same process are trying to use VFIO - they may not know if the regions
>>> they try to register are overlapping.
>>
>>
>> Sorry, I do not understand. A library allocates RAM. A library is expected
>> to do register it via additional ioctl, that's it. Another library allocates
>> another chunk of memory and it won't overlap and the registered areas won't
>> either.
>
> So the case I'm thinking is where the library does VFIO using a buffer
> passed into it from the program at large.  Another library does the
> same.
>
> The main program, unaware of the VFIO shenanigans passes different
> parts of the same page to the 2 libraries.
>
> This is somewhat similar to the case of the horribly, horribly broken
> semantics of POSIX file range locks (it's both hard to implement and
> dangerous in the multi-library case similar to above).


Ok. I'll implement x86-alike V3 SPAPR TCE IOMMU for these people, later :)

V2 addresses issues caused by H_PUT_TCE + DDW RTAS interfaces.



>>>>   static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>>>>   {
>>>>   	/*
>>>> @@ -205,7 +256,7 @@ static void *tce_iommu_open(unsigned long arg)
>>>>   {
>>>>   	struct tce_container *container;
>>>>
>>>> -	if (arg != VFIO_SPAPR_TCE_IOMMU) {
>>>> +	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
>>>>   		pr_err("tce_vfio: Wrong IOMMU type\n");
>>>>   		return ERR_PTR(-EINVAL);
>>>>   	}
>>>> @@ -215,6 +266,7 @@ static void *tce_iommu_open(unsigned long arg)
>>>>   		return ERR_PTR(-ENOMEM);
>>>>
>>>>   	mutex_init(&container->lock);
>>>> +	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
>>>>
>>>>   	return container;
>>>>   }
>>>> @@ -243,6 +295,47 @@ static void tce_iommu_unuse_page(struct tce_container *container,
>>>>   	put_page(page);
>>>>   }
>>>>
>>>> +static int tce_iommu_use_page_v2(unsigned long tce, unsigned long size,
>>>> +		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
>>
>>
>> You suggested s/tce_get_hpa/tce_iommu_use_page/ but in this particular patch
>> it is confusing as tce_iommu_unuse_page_v2() calls it to find corresponding
>> mm_iommu_table_group_mem_t by the userspace address address of a page being
>> stopped used.
>>
>> tce_iommu_use_page (without v2) does use the page but this one I'll rename
>> back to tce_iommu_ua_to_hpa_v2(), is that ok?
>
> Sorry, I couldn't follow this comment.


For V1 IOMMU, I used to have:
tce_get_hpa() - this converted UA to linear address and did gup();
tce_iommu_unuse_page() - this did put_page().

You suggested (*) to rename the first one to tce_use_page() which makes sense.

V2 introduces its own versions of use/unuse but these use preregistered 
memory and do not do gup()/put_page(). I named them:
tce_get_hpa_cached()
tce_iommu_unuse_page_v2()

then, replaying your comment (*) on V2 IOMMU, I renamed 
tce_get_hpa_cached() to tce_iommu_use_page_v2(). And I do not like the 
result now (in the chunk below). I'll rename it to 
tce_iommu_ua_to_hpa_v2(), will it be ok?



>
>>
>>
>>>> +{
>>>> +	long ret = 0;
>>>> +	struct mm_iommu_table_group_mem_t *mem;
>>>> +
>>>> +	mem = mm_iommu_lookup(tce, size);
>>>> +	if (!mem)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = mm_iommu_ua_to_hpa(mem, tce, phpa);
>>>> +	if (ret)
>>>> +		return -EINVAL;
>>>> +
>>>> +	*pmem = mem;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
>>>> +		unsigned long entry)
>>>> +{
>>>> +	struct mm_iommu_table_group_mem_t *mem = NULL;
>>>> +	int ret;
>>>> +	unsigned long hpa = 0;
>>>> +	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>>>> +
>>>> +	if (!pua || !current || !current->mm)
>>>> +		return;
>>>> +
>>>> +	ret = tce_iommu_use_page_v2(*pua, IOMMU_PAGE_SIZE(tbl),
>>>> +			&hpa, &mem);
>>>> +	if (ret)
>>>> +		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
>>>> +				__func__, *pua, entry, ret);
>>>> +	if (mem)
>>>> +		mm_iommu_mapped_update(mem, false);
>>>> +
>>>> +	*pua = 0;
>>>> +}
>>>> +


-- 
Alexey

Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD43E1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 16:09:09 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so75046949pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 23:09:07 -0700 (PDT)
Message-ID: <55543BFA.9030606@ozlabs.ru>
Date: Thu, 14 May 2015 16:08:58 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v10 33/34] vfio: powerpc/spapr: Register memory
 and define IOMMU v2
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>	
 <1431358763-24371-34-git-send-email-aik@ozlabs.ru>
 <1431552637.3625.78.camel@redhat.com>
In-Reply-To: <1431552637.3625.78.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 07:30 AM, Alex Williamson wrote:
> On Tue, 2015-05-12 at 01:39 +1000, Alexey Kardashevskiy wrote:
>> The existing implementation accounts the whole DMA window in
>> the locked_vm counter. This is going to be worse with multiple
>> containers and huge DMA windows. Also, real-time accounting would requite
>> additional tracking of accounted pages due to the page size difference -
>> IOMMU uses 4K pages and system uses 4K or 64K pages.
>>
>> Another issue is that actual pages pinning/unpinning happens on every
>> DMA map/unmap request. This does not affect the performance much now as
>> we spend way too much time now on switching context between
>> guest/userspace/host but this will start to matter when we add in-kernel
>> DMA map/unmap acceleration.
>>
>> This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
>> New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
>> 2 new ioctls to register/unregister DMA memory -
>> VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY -
>> which receive user space address and size of a memory region which
>> needs to be pinned/unpinned and counted in locked_vm.
>> New IOMMU splits physical pages pinning and TCE table update
>> into 2 different operations. It requires:
>> 1) guest pages to be registered first
>> 2) consequent map/unmap requests to work only with pre-registered memory.
>> For the default single window case this means that the entire guest
>> (instead of 2GB) needs to be pinned before using VFIO.
>> When a huge DMA window is added, no additional pinning will be
>> required, otherwise it would be guest RAM + 2GB.
>>
>> The new memory registration ioctls are not supported by
>> VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
>> will require memory to be preregistered in order to work.
>>
>> The accounting is done per the user process.
>>
>> This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
>> can do with v1 or v2 IOMMUs.
>>
>> In order to support memory pre-registration, we need a way to track
>> the use of every registered memory region and only allow unregistration
>> if a region is not in use anymore. So we need a way to tell from what
>> region the just cleared TCE was from.
>>
>> This adds a userspace view of the TCE table into iommu_table struct.
>> It contains userspace address, one per TCE entry. The table is only
>> allocated when the ownership over an IOMMU group is taken which means
>> it is only used from outside of the powernv code (such as VFIO).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>
>> Alex, should I remove your "acked-by" in the cases like this and
>> get another one?
>
>
> Generally if it's more than a trivial change, you'll want fresh acks.
>
>> ---
>> Changes:
>> v10:
>> * moved it_userspace allocation to vfio_iommu_spapr_tce as it VFIO
>> specific thing
>> * squashed "powerpc/iommu: Add userspace view of TCE table" into this as
>> it is
>> a part of IOMMU v2
>> * s/tce_iommu_use_page_v2/tce_iommu_prereg_ua_to_hpa/
>> * fixed some function names to have "tce_iommu_" in the beginning rather
>> just "tce_"
>> * as mm_iommu_mapped_inc() can now fail, check for the return code
>>
>> v9:
>> * s/tce_get_hva_cached/tce_iommu_use_page_v2/
>>
>> v7:
>> * now memory is registered per mm (i.e. process)
>> * moved memory registration code to powerpc/mmu
>> * merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
>> * limited new ioctls to v2 IOMMU
>> * updated doc
>> * unsupported ioclts return -ENOTTY instead of -EPERM
>>
>> v6:
>> * tce_get_hva_cached() returns hva via a pointer
>>
>> v4:
>> * updated docs
>> * s/kzmalloc/vzalloc/
>> * in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
>> replaced offset with index
>> * renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_memory
>> and removed duplicating vfio_iommu_spapr_register_memory
>> ---
>>   Documentation/vfio.txt              |  31 ++-
>>   arch/powerpc/include/asm/iommu.h    |   6 +
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 516 ++++++++++++++++++++++++++++++------
>>   include/uapi/linux/vfio.h           |  27 ++
>>   4 files changed, 494 insertions(+), 86 deletions(-)
>>
>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> index 96978ec..7dcf2b5 100644
>> --- a/Documentation/vfio.txt
>> +++ b/Documentation/vfio.txt
>> @@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
>>
>>   This implementation has some specifics:
>>
>> -1) Only one IOMMU group per container is supported as an IOMMU group
>> -represents the minimal entity which isolation can be guaranteed for and
>> -groups are allocated statically, one per a Partitionable Endpoint (PE)
>> +1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
>> +container is supported as an IOMMU table is allocated at the boot time,
>> +one table per a IOMMU group which is a Partitionable Endpoint (PE)
>>   (PE is often a PCI domain but not always).
>> +Newer systems (POWER8 with IODA2) have improved hardware design which allows
>> +to remove this limitation and have multiple IOMMU groups per a VFIO container.
>>
>>   2) The hardware supports so called DMA windows - the PCI address range
>>   within which DMA transfer is allowed, any attempt to access address space
>> @@ -427,6 +429,29 @@ The code flow from the example above should be slightly changed:
>>
>>   	....
>>
>> +5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
>> +VFIO_IOMMU_DISABLE and implements 2 new ioctls:
>> +VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
>> +(which are unsupported in v1 IOMMU).
>> +
>> +PPC64 paravirtualized guests generate a lot of map/unmap requests,
>> +and the handling of those includes pinning/unpinning pages and updating
>> +mm::locked_vm counter to make sure we do not exceed the rlimit.
>> +The v2 IOMMU splits accounting and pinning into separate operations:
>> +
>> +- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
>> +receive a user space address and size of the block to be pinned.
>> +Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected to
>> +be called with the exact address and size used for registering
>> +the memory block. The userspace is not expected to call these often.
>> +The ranges are stored in a linked list in a VFIO container.
>> +
>> +- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
>> +IOMMU table and do not do pinning; instead these check that the userspace
>> +address is from pre-registered range.
>> +
>> +This separation helps in optimizing DMA for guests.
>> +
>>   -------------------------------------------------------------------------------
>>
>>   [1] VFIO was originally an acronym for "Virtual Function I/O" in its
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index c8bad21..763c041 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -113,10 +113,16 @@ struct iommu_table {
>>   	unsigned long  it_page_shift;/* table iommu page size */
>>   #ifdef CONFIG_IOMMU_API
>>   	struct list_head it_group_list;/* List of iommu_table_group_link */
>> +	unsigned long *it_userspace; /* userspace view of the table */
>>   #endif
>>   	struct iommu_table_ops *it_ops;
>>   };
>>
>> +#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
>> +		((tbl)->it_userspace ? \
>> +			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
>> +			NULL)
>> +
>>   /* Pure 2^n version of get_order */
>>   static inline __attribute_const__
>>   int get_iommu_order(unsigned long size, struct iommu_table *tbl)
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 8943b29..e7e8db3 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -19,8 +19,10 @@
>>   #include <linux/uaccess.h>
>>   #include <linux/err.h>
>>   #include <linux/vfio.h>
>> +#include <linux/vmalloc.h>
>>   #include <asm/iommu.h>
>>   #include <asm/tce.h>
>> +#include <asm/mmu_context.h>
>>
>>   #define DRIVER_VERSION  "0.1"
>>   #define DRIVER_AUTHOR   "aik@ozlabs.ru"
>> @@ -81,6 +83,11 @@ static void decrement_locked_vm(long npages)
>>    * into DMA'ble space using the IOMMU
>>    */
>>
>> +struct tce_iommu_group {
>> +	struct list_head next;
>> +	struct iommu_group *grp;
>> +};
>> +
>>   /*
>>    * The container descriptor supports only a single group per container.
>>    * Required by the API as the container is not supplied with the IOMMU group
>> @@ -88,11 +95,98 @@ static void decrement_locked_vm(long npages)
>>    */
>>   struct tce_container {
>>   	struct mutex lock;
>> -	struct iommu_group *grp;
>>   	bool enabled;
>>   	unsigned long locked_pages;
>> +	bool v2;
>> +	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>> +	struct list_head group_list;
>
> You're wasting space by not packing your bools next to each other.

I'll fix it :)


>>   };
>>
>> +static long tce_iommu_unregister_pages(struct tce_container *container,
>> +		__u64 vaddr, __u64 size)
>> +{
>> +	long ret;
>> +	struct mm_iommu_table_group_mem_t *mem;
>> +
>> +	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
>> +		return -EINVAL;
>> +
>> +	mem = mm_iommu_get(vaddr, size >> PAGE_SHIFT);
>> +	if (!mem)
>> +		return -EINVAL;
>> +
>> +	ret = mm_iommu_put(mem); /* undo kref_get() from mm_iommu_get() */
>> +	if (!ret)
>> +		ret = mm_iommu_put(mem);
>
> Should \put\ really be able to fail?

tce_iommu_unregister_pages() is called from ioctl so yes, the userspace 
deserves to know that the memory will remain pinned.

> I think you really need to examine
> your reference model, mm_iommu_put() looks pretty suspicious.  If
> there's an implicit reference by being mapped, it should be handled that
> way, not via an atomic that gets decremented then corrected.

One implicit reference (*) in @mapped (from atomic_set(&mem->mapped, 1)) is 
only to protect against the race between checking for active mappings and 
putting the reference a registered memory descriptor.

If tce_iommu_unregister_pages() is called when @mapped > 1, then EBUSY is 
returned.

If tce_iommu_unregister_pages() is called when @mapped == 1 or 0, then 
there is no active mapping, @mapped becomes zero (if it is not already) and 
we can safely put the descriptor. All consequent mm_iommu_mapped_inc() 
calls will fail to increment @mapped and return error.

After looking there more, there are 2 bugs though:

--- a/arch/powerpc/mm/mmu_context_hash64_iommu.c
+++ b/arch/powerpc/mm/mmu_context_hash64_iommu.c
@@ -178,9 +178,9 @@ EXPORT_SYMBOL_GPL(mm_iommu_get);

  long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
  {
-       if (1 != atomic_dec_if_positive(&mem->mapped)) {
+       if (atomic_dec_if_positive(&mem->mapped) > 1) {
                 /* There are mappings, exit */
-               atomic_inc(&mem->mapped);
+               atomic_inc_not_zero(&mem->mapped);
                 return -EBUSY;
         }

s/1!=/1</ is to allow putting second/third/... reference of mem->kref and 
atomic_inc_not_zero() is to not elevate the counter if another thread 
managed to release the very last mapping and  decrement my implicit 
reference (*).

Am I still missing something here?

> That's not only not atomic, but causes lots of fallout with references that don't
> get released.
> Notice how you don't even check the return value at the
> call location of this function?

Ouch. This is a bug. @ret needs to be returned to the userspace.

> How many references does that
> potentially leave and where do the get resolved?

Every successful "register" should be coupled with successful "unregister" 
(if it failed - just repeat). If this did not happen, memory remains pinned 
till the process exit, and then it is unpinned unconditionally.


-- 
Alexey

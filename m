Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8C8B1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 19:33:36 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so55361178pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 02:33:34 -0700 (PDT)
Message-ID: <5541F6D5.9040809@ozlabs.ru>
Date: Thu, 30 Apr 2015 19:33:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 31/32] vfio: powerpc/spapr: Support multiple
 groups in one container if possible
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-32-git-send-email-aik@ozlabs.ru>
 <20150430072221.GD24886@voom.redhat.com>
In-Reply-To: <20150430072221.GD24886@voom.redhat.com>
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

On 04/30/2015 05:22 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:55PM +1000, Alexey Kardashevskiy wrote:
>> At the moment only one group per container is supported.
>> POWER8 CPUs have more flexible design and allows naving 2 TCE tables per
>> IOMMU group so we can relax this limitation and support multiple groups
>> per container.
>
> It's not obvious why allowing multiple TCE tables per PE has any
> pearing on allowing multiple groups per container.


This patchset is a global TCE tables rework (patches 1..30, roughly) with 2 
outcomes:
1. reusing the same IOMMU table for multiple groups - patch 31;
2. allowing dynamic create/remove of IOMMU tables - patch 32.

I can remove this one from the patchset and post it separately later but 
since 1..30 aim to support both 1) and 2), I'd think I better keep them all 
together (might explain some of changes I do in 1..30).



>> This adds TCE table descriptors to a container and uses iommu_table_group_ops
>> to create/set DMA windows on IOMMU groups so the same TCE tables will be
>> shared between several IOMMU groups.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>> Changes:
>> v7:
>> * updated doc
>> ---
>>   Documentation/vfio.txt              |   8 +-
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 268 ++++++++++++++++++++++++++----------
>>   2 files changed, 199 insertions(+), 77 deletions(-)
>>
>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> index 94328c8..7dcf2b5 100644
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
>
> I thought the more fundamental problem was that different PEs tended
> to use disjoint bus address ranges, so even by duplicating put_tce
> across PEs you couldn't have a common address space.


Sorry, I am not following you here.

By duplicating put_tce, I can have multiple IOMMU groups on the same 
virtual PHB in QEMU, "[PATCH qemu v7 04/14] spapr_pci_vfio: Enable multiple 
groups per container" does this, the address ranges will the same.

What I cannot do on p5ioc2 is programming the same table to multiple 
physical PHBs (or I could but it is very different than IODA2 and pretty 
ugly and might not always be possible because I would have to allocate 
these pages from some common pool and face problems like fragmentation).



>> +Newer systems (POWER8 with IODA2) have improved hardware design which allows
>> +to remove this limitation and have multiple IOMMU groups per a VFIO container.
>>
>>   2) The hardware supports so called DMA windows - the PCI address range
>>   within which DMA transfer is allowed, any attempt to access address space
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index a7d6729..970e3a2 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -82,6 +82,11 @@ static void decrement_locked_vm(long npages)
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
>> @@ -89,10 +94,11 @@ static void decrement_locked_vm(long npages)
>>    */
>>   struct tce_container {
>>   	struct mutex lock;
>> -	struct iommu_group *grp;
>>   	bool enabled;
>>   	unsigned long locked_pages;
>>   	bool v2;
>> +	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>
> Hrm,  so here we have more copies of the full iommu_table structures,
> which again muddies the lifetime.  The table_group pointer is
> presumably meaningless in these copies, which seems dangerously
> confusing.


Ouch. This is bad. No, table_group is not pointless here as it is used to 
get to the PE number to invalidate TCE cache. I just realized although I 
need to update just a single table, I still have to invalidate TCE cache 
for every attached group/PE so I need a list of iommu_table_group's here, 
not a single pointer...



>> +	struct list_head group_list;
>>   };
>>
>>   static long tce_unregister_pages(struct tce_container *container,
>> @@ -154,20 +160,20 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>>   	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
>>   }
>>
>> +static inline bool tce_groups_attached(struct tce_container *container)
>> +{
>> +	return !list_empty(&container->group_list);
>> +}
>> +
>>   static struct iommu_table *spapr_tce_find_table(
>>   		struct tce_container *container,
>>   		phys_addr_t ioba)
>>   {
>>   	long i;
>>   	struct iommu_table *ret = NULL;
>> -	struct iommu_table_group *table_group;
>> -
>> -	table_group = iommu_group_get_iommudata(container->grp);
>> -	if (!table_group)
>> -		return NULL;
>>
>>   	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> -		struct iommu_table *tbl = &table_group->tables[i];
>> +		struct iommu_table *tbl = &container->tables[i];
>>   		unsigned long entry = ioba >> tbl->it_page_shift;
>>   		unsigned long start = tbl->it_offset;
>>   		unsigned long end = start + tbl->it_size;
>> @@ -186,9 +192,7 @@ static int tce_iommu_enable(struct tce_container *container)
>>   	int ret = 0;
>>   	unsigned long locked;
>>   	struct iommu_table_group *table_group;
>> -
>> -	if (!container->grp)
>> -		return -ENXIO;
>> +	struct tce_iommu_group *tcegrp;
>>
>>   	if (!current->mm)
>>   		return -ESRCH; /* process exited */
>> @@ -225,7 +229,12 @@ static int tce_iommu_enable(struct tce_container *container)
>>   	 * as there is no way to know how much we should increment
>>   	 * the locked_vm counter.
>>   	 */
>> -	table_group = iommu_group_get_iommudata(container->grp);
>> +	if (!tce_groups_attached(container))
>> +		return -ENODEV;
>> +
>> +	tcegrp = list_first_entry(&container->group_list,
>> +			struct tce_iommu_group, next);
>> +	table_group = iommu_group_get_iommudata(tcegrp->grp);
>>   	if (!table_group)
>>   		return -ENODEV;
>>
>> @@ -257,6 +266,48 @@ static void tce_iommu_disable(struct tce_container *container)
>>   	decrement_locked_vm(container->locked_pages);
>>   }
>>
>> +static long tce_iommu_create_table(struct iommu_table_group *table_group,
>> +			int num,
>> +			__u32 page_shift,
>> +			__u64 window_size,
>> +			__u32 levels,
>> +			struct iommu_table *tbl)
>
> With multiple groups (and therefore PEs) per container, this seems
> wrong.  There's only one table_group per PE, so what's special about
> PE whose table group is passed in here.


The created table is allocated at the same node as table_group 
(pe->phb->hose->node). This does not make much sense if we put multiple 
groups to the same container but we will recommend people to avoid putting 
groups from different NUMA nodes to the same container.

Also, the allocated table gets bus offset initialized in create_table() 
(which is IODA2-specific knowledge). It is there to emphasize the fact that 
we do not get to choose where to map the window on a bus, it is hardcoded 
and easier to deal with the tables which have offset set once - I could add 
a bus_offset parameter to set_window() but it would be converted back to 
the window number.



>> +{
>> +	long ret, table_size;
>> +
>> +	table_size = table_group->ops->get_table_size(page_shift, window_size,
>> +			levels);
>> +	if (!table_size)
>> +		return -EINVAL;
>> +
>> +	ret = try_increment_locked_vm(table_size >> PAGE_SHIFT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = table_group->ops->create_table(table_group, num,
>> +			page_shift, window_size, levels, tbl);
>> +
>> +	WARN_ON(!ret && !tbl->it_ops->free);
>> +	WARN_ON(!ret && (tbl->it_allocated_size != table_size));
>> +
>> +	if (ret)
>> +		decrement_locked_vm(table_size >> PAGE_SHIFT);
>> +
>> +	return ret;
>> +}
>> +
>> +static void tce_iommu_free_table(struct iommu_table *tbl)
>> +{
>> +	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
>> +
>> +	if (!tbl->it_size)
>> +		return;
>> +
>> +	tbl->it_ops->free(tbl);
>
> So, this is exactly the case where the lifetimes are badly confusing.
> How can you be confident here that another copy of the iommu_table
> struct isn't referencing the same TCE tables?


Create/remove window is handled by a single file driver. It is not like 
many of there tables. But yes, valid point.



>> +	decrement_locked_vm(pages);
>> +	memset(tbl, 0, sizeof(*tbl));
>> +}
>> +
>>   static void *tce_iommu_open(unsigned long arg)
>>   {
>>   	struct tce_container *container;
>> @@ -271,19 +322,41 @@ static void *tce_iommu_open(unsigned long arg)
>>   		return ERR_PTR(-ENOMEM);
>>
>>   	mutex_init(&container->lock);
>> +	INIT_LIST_HEAD_RCU(&container->group_list);
>
> I see no other mentions of rcu related to this list, which doesn't
> seem right.
>
>>   	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
>>
>>   	return container;
>>   }
>>
>> +static int tce_iommu_clear(struct tce_container *container,
>> +		struct iommu_table *tbl,
>> +		unsigned long entry, unsigned long pages);
>> +
>>   static void tce_iommu_release(void *iommu_data)
>>   {
>>   	struct tce_container *container = iommu_data;
>> +	struct iommu_table_group *table_group;
>> +	struct tce_iommu_group *tcegrp;
>> +	long i;
>>
>> -	WARN_ON(container->grp);
>> +	while (tce_groups_attached(container)) {
>> +		tcegrp = list_first_entry(&container->group_list,
>> +				struct tce_iommu_group, next);
>> +		table_group = iommu_group_get_iommudata(tcegrp->grp);
>> +		tce_iommu_detach_group(iommu_data, tcegrp->grp);
>> +	}
>>
>> -	if (container->grp)
>> -		tce_iommu_detach_group(iommu_data, container->grp);
>> +	/*
>> +	 * If VFIO created a table, it was not disposed
>> +	 * by tce_iommu_detach_group() so do it now.
>> +	 */
>> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +		struct iommu_table *tbl = &container->tables[i];
>> +
>> +		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>> +		tce_iommu_free_table(tbl);
>> +	}
>>
>>   	tce_iommu_disable(container);
>>   	mutex_destroy(&container->lock);
>> @@ -509,12 +582,15 @@ static long tce_iommu_ioctl(void *iommu_data,
>>
>>   	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>>   		struct vfio_iommu_spapr_tce_info info;
>> +		struct tce_iommu_group *tcegrp;
>>   		struct iommu_table_group *table_group;
>>
>> -		if (WARN_ON(!container->grp))
>> +		if (!tce_groups_attached(container))
>>   			return -ENXIO;
>>
>> -		table_group = iommu_group_get_iommudata(container->grp);
>> +		tcegrp = list_first_entry(&container->group_list,
>> +				struct tce_iommu_group, next);
>> +		table_group = iommu_group_get_iommudata(tcegrp->grp);
>>
>>   		if (!table_group)
>>   			return -ENXIO;
>> @@ -707,12 +783,20 @@ static long tce_iommu_ioctl(void *iommu_data,
>>   		tce_iommu_disable(container);
>>   		mutex_unlock(&container->lock);
>>   		return 0;
>> -	case VFIO_EEH_PE_OP:
>> -		if (!container->grp)
>> -			return -ENODEV;
>>
>> -		return vfio_spapr_iommu_eeh_ioctl(container->grp,
>> -						  cmd, arg);
>> +	case VFIO_EEH_PE_OP: {
>> +		struct tce_iommu_group *tcegrp;
>> +
>> +		ret = 0;
>> +		list_for_each_entry(tcegrp, &container->group_list, next) {
>> +			ret = vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
>> +					cmd, arg);
>> +			if (ret)
>> +				return ret;
>
> Hrm.  It occurs to me that EEH may need a way of referencing
> individual groups.  Even if multiple PEs are referencing the same TCE
> tables, presumably EEH will isolate them individually.


Well. I asked our EEH guy Gavin, he did not object to this change but I'll 
double check :)



-- 
Alexey

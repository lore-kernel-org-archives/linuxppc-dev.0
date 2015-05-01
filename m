Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D4D51A0024
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:11:08 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so80098599pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 21:11:06 -0700 (PDT)
Message-ID: <5542FCD2.9000601@ozlabs.ru>
Date: Fri, 01 May 2015 14:10:58 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 27/32] powerpc/iommu/ioda2: Add get_table_size()
 to calculate the size of future table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-28-git-send-email-aik@ozlabs.ru>
 <20150429064029.GX32589@voom.redhat.com>
In-Reply-To: <20150429064029.GX32589@voom.redhat.com>
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

On 04/29/2015 04:40 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:51PM +1000, Alexey Kardashevskiy wrote:
>> This adds a way for the IOMMU user to know how much a new table will
>> use so it can be accounted in the locked_vm limit before allocation
>> happens.
>>
>> This stores the allocated table size in pnv_pci_create_table()
>> so the locked_vm counter can be updated correctly when a table is
>> being disposed.
>>
>> This defines an iommu_table_group_ops callback to let VFIO know
>> how much memory will be locked if a table is created.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v9:
>> * reimplemented the whole patch
>> ---
>>   arch/powerpc/include/asm/iommu.h          |  5 +++++
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++
>>   arch/powerpc/platforms/powernv/pci.c      | 36 +++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/powernv/pci.h      |  2 ++
>>   4 files changed, 57 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 1472de3..9844c106 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -99,6 +99,7 @@ struct iommu_table {
>>   	unsigned long  it_size;      /* Size of iommu table in entries */
>>   	unsigned long  it_indirect_levels;
>>   	unsigned long  it_level_size;
>> +	unsigned long  it_allocated_size;
>>   	unsigned long  it_offset;    /* Offset into global table */
>>   	unsigned long  it_base;      /* mapped address of tce table */
>>   	unsigned long  it_index;     /* which iommu table this is */
>> @@ -155,6 +156,10 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>   struct iommu_table_group;
>>
>>   struct iommu_table_group_ops {
>> +	unsigned long (*get_table_size)(
>> +			__u32 page_shift,
>> +			__u64 window_size,
>> +			__u32 levels);
>>   	long (*create_table)(struct iommu_table_group *table_group,
>>   			int num,
>>   			__u32 page_shift,
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index e0be556..7f548b4 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2062,6 +2062,18 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>>   }
>>
>>   #ifdef CONFIG_IOMMU_API
>> +static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>> +		__u64 window_size, __u32 levels)
>> +{
>> +	unsigned long ret = pnv_get_table_size(page_shift, window_size, levels);
>> +
>> +	if (!ret)
>> +		return ret;
>> +
>> +	/* Add size of it_userspace */
>> +	return ret + (window_size >> page_shift) * sizeof(unsigned long);
>
> This doesn't make much sense.  The userspace view can't possibly be a
> property of the specific low-level IOMMU model.


This it_userspace thing is all about memory preregistration.

I need some way to track how many actual mappings the 
mm_iommu_table_group_mem_t has in order to decide whether to allow 
unregistering or not.

When I clear TCE, I can read the old value which is host physical address 
which I cannot use to find the preregistered region and adjust the mappings 
counter; I can only use userspace addresses for this (not even guest 
physical addresses as it is VFIO and probably no KVM).

So I have to keep userspace addresses somewhere, one per IOMMU page, and 
the iommu_table seems a natural place for this.





>
>> +}
>> +
>>   static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>>   		int num, __u32 page_shift, __u64 window_size, __u32 levels,
>>   		struct iommu_table *tbl)
>> @@ -2086,6 +2098,7 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>>
>>   	BUG_ON(tbl->it_userspace);
>>   	tbl->it_userspace = uas;
>> +	tbl->it_allocated_size += uas_cb;
>>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
>>   	if (pe->tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>> @@ -2160,6 +2173,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
>>   }
>>
>>   static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>> +	.get_table_size = pnv_pci_ioda2_get_table_size,
>>   	.create_table = pnv_pci_ioda2_create_table,
>>   	.set_window = pnv_pci_ioda2_set_window,
>>   	.unset_window = pnv_pci_ioda2_unset_window,
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index fc129c4..1b5b48a 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -662,6 +662,38 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>>   	tbl->it_type = TCE_PCI;
>>   }
>>
>> +unsigned long pnv_get_table_size(__u32 page_shift,
>> +		__u64 window_size, __u32 levels)
>> +{
>> +	unsigned long bytes = 0;
>> +	const unsigned window_shift = ilog2(window_size);
>> +	unsigned entries_shift = window_shift - page_shift;
>> +	unsigned table_shift = entries_shift + 3;
>> +	unsigned long tce_table_size = max(0x1000UL, 1UL << table_shift);
>> +	unsigned long direct_table_size;
>> +
>> +	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS) ||
>> +			(window_size > memory_hotplug_max()) ||
>> +			!is_power_of_2(window_size))
>> +		return 0;
>> +
>> +	/* Calculate a direct table size from window_size and levels */
>> +	entries_shift = ROUND_UP(entries_shift, levels) / levels;
>> +	table_shift = entries_shift + 3;
>> +	table_shift = max_t(unsigned, table_shift, PAGE_SHIFT);
>> +	direct_table_size =  1UL << table_shift;
>> +
>> +	for ( ; levels; --levels) {
>> +		bytes += ROUND_UP(tce_table_size, direct_table_size);
>> +
>> +		tce_table_size /= direct_table_size;
>> +		tce_table_size <<= 3;
>> +		tce_table_size = ROUND_UP(tce_table_size, direct_table_size);
>> +	}
>> +
>> +	return bytes;
>> +}
>> +
>>   static __be64 *pnv_alloc_tce_table_pages(int nid, unsigned shift,
>>   		unsigned levels, unsigned long limit,
>>   		unsigned long *tce_table_allocated)
>> @@ -741,6 +773,10 @@ long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
>>   		return -ENOMEM;
>>   	}
>>
>> +	tbl->it_allocated_size = pnv_get_table_size(page_shift, window_size,
>> +			levels);
>> +	WARN_ON(!tbl->it_allocated_size);
>> +
>>   	/* Setup linux iommu table */
>>   	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
>>   			page_shift);
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 3d1ff584..ce4bc3c 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -224,6 +224,8 @@ extern long pnv_pci_create_table(struct iommu_table_group *table_group, int nid,
>>   		__u64 bus_offset, __u32 page_shift, __u64 window_size,
>>   		__u32 levels, struct iommu_table *tbl);
>>   extern void pnv_pci_free_table(struct iommu_table *tbl);
>> +extern unsigned long pnv_get_table_size(__u32 page_shift,
>> +		__u64 window_size, __u32 levels);
>>   extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
>>   extern void pnv_pci_init_ioda_hub(struct device_node *np);
>>   extern void pnv_pci_init_ioda2_phb(struct device_node *np);
>


-- 
Alexey

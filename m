Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F5CF1A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:01:27 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so79865609pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 21:01:25 -0700 (PDT)
Message-ID: <5542FA8D.2060400@ozlabs.ru>
Date: Fri, 01 May 2015 14:01:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of
 TCE table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
 <20150429063113.GW32589@voom.redhat.com>
In-Reply-To: <20150429063113.GW32589@voom.redhat.com>
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

On 04/29/2015 04:31 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
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
>> ---
>> Changes:
>> v9:
>> * fixed code flow in error cases added in v8
>>
>> v8:
>> * added ENOMEM on failed vzalloc()
>> ---
>>   arch/powerpc/include/asm/iommu.h          |  6 ++++++
>>   arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
>>   3 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 7694546..1472de3 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -111,9 +111,15 @@ struct iommu_table {
>>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
>>   	unsigned long  it_page_shift;/* table iommu page size */
>>   	struct iommu_table_group *it_table_group;
>> +	unsigned long *it_userspace; /* userspace view of the table */
>
> A single unsigned long doesn't seem like enough.

Why single? This is an array.

>  How do you know
> which process's address space this address refers to?

It is a current task. Multiple userspaces cannot use the same container/tables.



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
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 2eaba0c..74a3f52 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -38,6 +38,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/iommu.h>
>>   #include <linux/sched.h>
>> +#include <linux/vmalloc.h>
>>   #include <asm/io.h>
>>   #include <asm/prom.h>
>>   #include <asm/iommu.h>
>> @@ -739,6 +740,8 @@ void iommu_reset_table(struct iommu_table *tbl, const char *node_name)
>>   		free_pages((unsigned long) tbl->it_map, order);
>>   	}
>>
>> +	WARN_ON(tbl->it_userspace);
>> +
>>   	memset(tbl, 0, sizeof(*tbl));
>>   }
>>
>> @@ -1016,6 +1019,7 @@ int iommu_take_ownership(struct iommu_table *tbl)
>>   {
>>   	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
>>   	int ret = 0;
>> +	unsigned long *uas;
>>
>>   	/*
>>   	 * VFIO does not control TCE entries allocation and the guest
>> @@ -1027,6 +1031,10 @@ int iommu_take_ownership(struct iommu_table *tbl)
>>   	if (!tbl->it_ops->exchange)
>>   		return -EINVAL;
>>
>> +	uas = vzalloc(sizeof(*uas) * tbl->it_size);
>> +	if (!uas)
>> +		return -ENOMEM;
>> +
>>   	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>>   	for (i = 0; i < tbl->nr_pools; i++)
>>   		spin_lock(&tbl->pools[i].lock);
>> @@ -1044,6 +1052,13 @@ int iommu_take_ownership(struct iommu_table *tbl)
>>   		memset(tbl->it_map, 0xff, sz);
>>   	}
>>
>> +	if (ret) {
>> +		vfree(uas);
>> +	} else {
>> +		BUG_ON(tbl->it_userspace);
>> +		tbl->it_userspace = uas;
>> +	}
>> +
>>   	for (i = 0; i < tbl->nr_pools; i++)
>>   		spin_unlock(&tbl->pools[i].lock);
>>   	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>> @@ -1056,6 +1071,9 @@ void iommu_release_ownership(struct iommu_table *tbl)
>>   {
>>   	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
>>
>> +	vfree(tbl->it_userspace);
>> +	tbl->it_userspace = NULL;
>> +
>>   	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>>   	for (i = 0; i < tbl->nr_pools; i++)
>>   		spin_lock(&tbl->pools[i].lock);
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 45bc131..e0be556 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/iommu.h>
>>   #include <linux/sizes.h>
>> +#include <linux/vmalloc.h>
>>
>>   #include <asm/sections.h>
>>   #include <asm/io.h>
>> @@ -1827,6 +1828,14 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>>   		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
>>   }
>>
>> +void pnv_pci_ioda2_free_table(struct iommu_table *tbl)
>> +{
>> +	vfree(tbl->it_userspace);
>> +	tbl->it_userspace = NULL;
>> +
>> +	pnv_pci_free_table(tbl);
>> +}
>> +
>>   static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>   	.set = pnv_ioda2_tce_build,
>>   #ifdef CONFIG_IOMMU_API
>> @@ -1834,7 +1843,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>   #endif
>>   	.clear = pnv_ioda2_tce_free,
>>   	.get = pnv_tce_get,
>> -	.free = pnv_pci_free_table,
>> +	.free = pnv_pci_ioda2_free_table,
>>   };
>>
>>   static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
>> @@ -2062,12 +2071,21 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
>>   	int nid = pe->phb->hose->node;
>>   	__u64 bus_offset = num ? pe->tce_bypass_base : 0;
>>   	long ret;
>> +	unsigned long *uas, uas_cb = sizeof(*uas) * (window_size >> page_shift);
>> +
>> +	uas = vzalloc(uas_cb);
>> +	if (!uas)
>> +		return -ENOMEM;
>
> I don't see why this is allocated both here as well as in
> take_ownership.

Where else? The only alternative is vfio_iommu_spapr_tce but I really do 
not want to touch iommu_table fields there.


> Isn't this function used for core-kernel users of the
> iommu as well, in which case it shouldn't need the it_userspace.


No. This is an iommu_table_group_ops callback which calls what the platform 
code calls (pnv_pci_create_table()) plus allocates this it_userspace thing. 
The callback is only called from VFIO.


>
>>   	ret = pnv_pci_create_table(table_group, nid, bus_offset, page_shift,
>>   			window_size, levels, tbl);
>> -	if (ret)
>> +	if (ret) {
>> +		vfree(uas);
>>   		return ret;
>> +	}
>>
>> +	BUG_ON(tbl->it_userspace);
>> +	tbl->it_userspace = uas;
>>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
>>   	if (pe->tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>


-- 
Alexey

Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E6611A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:19:59 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so22577928pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:19:58 -0700 (PDT)
Message-ID: <5540A237.6070007@ozlabs.ru>
Date: Wed, 29 Apr 2015 19:19:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 13/32] vfio: powerpc/spapr/iommu/powernv/ioda2:
 Rework IOMMU ownership control
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-14-git-send-email-aik@ozlabs.ru>
 <20150429030250.GJ32589@voom.redhat.com>
In-Reply-To: <20150429030250.GJ32589@voom.redhat.com>
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

On 04/29/2015 01:02 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:37PM +1000, Alexey Kardashevskiy wrote:
>> This adds tce_iommu_take_ownership() and tce_iommu_release_ownership
>> which call in a loop iommu_take_ownership()/iommu_release_ownership()
>> for every table on the group. As there is just one now, no change in
>> behaviour is expected.
>>
>> At the moment the iommu_table struct has a set_bypass() which enables/
>> disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
>> which calls this callback when external IOMMU users such as VFIO are
>> about to get over a PHB.
>>
>> The set_bypass() callback is not really an iommu_table function but
>> IOMMU/PE function. This introduces a iommu_table_group_ops struct and
>> adds take_ownership()/release_ownership() callbacks to it which are
>> called when an external user takes/releases control over the IOMMU.
>>
>> This replaces set_bypass() with ownership callbacks as it is not
>> necessarily just bypass enabling, it can be something else/more
>> so let's give it more generic name.
>>
>> The callbacks is implemented for IODA2 only. Other platforms (P5IOC2,
>> IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
>> The following patches will replace iommu_take_ownership/
>> iommu_release_ownership calls in IODA2 with full IOMMU table release/
>> create.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>> Changes:
>> v9:
>> * squashed "vfio: powerpc/spapr: powerpc/iommu: Rework IOMMU ownership control"
>> and "vfio: powerpc/spapr: powerpc/powernv/ioda2: Rework IOMMU ownership control"
>> into a single patch
>> * moved helpers with a loop through tables in a group
>> to vfio_iommu_spapr_tce.c to keep the platform code free of IOMMU table
>> groups as much as possible
>> * added missing tce_iommu_clear() to tce_iommu_release_ownership()
>> * replaced the set_ownership(enable) callback with take_ownership() and
>> release_ownership()
>> ---
>>   arch/powerpc/include/asm/iommu.h          | 13 +++++-
>>   arch/powerpc/kernel/iommu.c               | 11 ------
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 40 +++++++++++++++----
>>   drivers/vfio/vfio_iommu_spapr_tce.c       | 66 +++++++++++++++++++++++++++----
>>   4 files changed, 103 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index fa37519..e63419e 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -93,7 +93,6 @@ struct iommu_table {
>>   	unsigned long  it_page_shift;/* table iommu page size */
>>   	struct iommu_table_group *it_table_group;
>>   	struct iommu_table_ops *it_ops;
>> -	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>>   };
>>
>>   /* Pure 2^n version of get_order */
>> @@ -128,11 +127,23 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>
>>   #define IOMMU_TABLE_GROUP_MAX_TABLES	1
>>
>> +struct iommu_table_group;
>> +
>> +struct iommu_table_group_ops {
>> +	/*
>> +	 * Switches ownership from the kernel itself to an external
>> +	 * user. While onwership is taken, the kernel cannot use IOMMU itself.
>
> Typo in "onwership".  I'd also like to see this be even more explicit
> that "take" is the "core kernel -> vfio/whatever" transition and
> release is the reverse.


Will this work?

/*
  * Switches ownership from the kernel itself to an external
  * user.
  * The ownership is taken when VFIO starts using the IOMMU group
  * and released when the platform code gets the control over the group back.
  * While ownership is taken, the platform code cannot use IOMMU itself.
  */


>> +	 */
>> +	void (*take_ownership)(struct iommu_table_group *table_group);
>> +	void (*release_ownership)(struct iommu_table_group *table_group);
>> +};
>> +
>>   struct iommu_table_group {
>>   #ifdef CONFIG_IOMMU_API
>>   	struct iommu_group *group;
>>   #endif
>>   	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>> +	struct iommu_table_group_ops *ops;
>>   };
>>
>>   #ifdef CONFIG_IOMMU_API
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 005146b..2856d27 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -1057,13 +1057,6 @@ int iommu_take_ownership(struct iommu_table *tbl)
>>
>>   	memset(tbl->it_map, 0xff, sz);
>>
>> -	/*
>> -	 * Disable iommu bypass, otherwise the user can DMA to all of
>> -	 * our physical memory via the bypass window instead of just
>> -	 * the pages that has been explicitly mapped into the iommu
>> -	 */
>> -	if (tbl->set_bypass)
>> -		tbl->set_bypass(tbl, false);
>>
>>   	return 0;
>>   }
>> @@ -1078,10 +1071,6 @@ void iommu_release_ownership(struct iommu_table *tbl)
>>   	/* Restore bit#0 set by iommu_init_table() */
>>   	if (tbl->it_offset == 0)
>>   		set_bit(0, tbl->it_map);
>> -
>> -	/* The kernel owns the device now, we can restore the iommu bypass */
>> -	if (tbl->set_bypass)
>> -		tbl->set_bypass(tbl, true);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_release_ownership);
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 88472cb..718d5cc 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1870,10 +1870,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>>   }
>>
>> -static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>>   {
>> -	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
>> -			struct pnv_ioda_pe, table_group);
>>   	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>>   	int64_t rc;
>>
>> @@ -1901,7 +1899,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>>   		 * host side.
>>   		 */
>>   		if (pe->pdev)
>> -			set_iommu_table_base(&pe->pdev->dev, tbl);
>> +			set_iommu_table_base(&pe->pdev->dev,
>> +					&pe->table_group.tables[0]);
>>   		else
>>   			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>>   	}
>> @@ -1917,13 +1916,35 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>>   	/* TVE #1 is selected by PCI address bit 59 */
>>   	pe->tce_bypass_base = 1ull << 59;
>>
>> -	/* Install set_bypass callback for VFIO */
>> -	pe->table_group.tables[0].set_bypass = pnv_pci_ioda2_set_bypass;
>> -
>>   	/* Enable bypass by default */
>> -	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
>> +	pnv_pci_ioda2_set_bypass(pe, true);
>>   }
>>
>> +#ifdef CONFIG_IOMMU_API
>> +static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
>> +{
>> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>> +						table_group);
>> +
>> +	iommu_take_ownership(&table_group->tables[0]);
>> +	pnv_pci_ioda2_set_bypass(pe, false);
>> +}
>> +
>> +static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
>> +{
>> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>> +						table_group);
>> +
>> +	iommu_release_ownership(&table_group->tables[0]);
>> +	pnv_pci_ioda2_set_bypass(pe, true);
>> +}
>> +
>> +static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>> +	.take_ownership = pnv_ioda2_take_ownership,
>> +	.release_ownership = pnv_ioda2_release_ownership,
>> +};
>> +#endif
>> +
>>   static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   				       struct pnv_ioda_pe *pe)
>>   {
>> @@ -1991,6 +2012,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   	}
>>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
>>   	iommu_init_table(tbl, phb->hose->node);
>> +#ifdef CONFIG_IOMMU_API
>> +	pe->table_group.ops = &pnv_pci_ioda2_ops;
>> +#endif
>>
>>   	if (pe->flags & PNV_IODA_PE_DEV) {
>>   		iommu_register_group(&pe->table_group, phb->hose->global_number,
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 17e884a..dacc738 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -483,6 +483,43 @@ static long tce_iommu_ioctl(void *iommu_data,
>>   	return -ENOTTY;
>>   }
>>
>> +static void tce_iommu_release_ownership(struct tce_container *container,
>> +		struct iommu_table_group *table_group)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +		struct iommu_table *tbl = &table_group->tables[i];
>> +
>> +		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>> +		if (tbl->it_map)
>> +			iommu_release_ownership(tbl);
>> +	}
>> +}
>> +
>> +static int tce_iommu_take_ownership(struct iommu_table_group *table_group)
>> +{
>> +	int i, j, rc = 0;
>> +
>> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +		struct iommu_table *tbl = &table_group->tables[i];
>> +
>> +		if (!tbl->it_map)
>> +			continue;
>> +
>> +		rc = iommu_take_ownership(tbl);
>> +		if (rc) {
>> +			for (j = 0; j < i; ++j)
>> +				iommu_release_ownership(
>> +						&table_group->tables[j]);
>> +
>> +			return rc;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int tce_iommu_attach_group(void *iommu_data,
>>   		struct iommu_group *iommu_group)
>>   {
>> @@ -515,9 +552,23 @@ static int tce_iommu_attach_group(void *iommu_data,
>>   		goto unlock_exit;
>>   	}
>>
>> -	ret = iommu_take_ownership(&table_group->tables[0]);
>> -	if (!ret)
>> -		container->grp = iommu_group;
>> +	if (!table_group->ops || !table_group->ops->take_ownership ||
>> +			!table_group->ops->release_ownership) {
>> +		ret = tce_iommu_take_ownership(table_group);
>
> Haven't looked at the rest of the series.  I'm hoping that you're
> eventually planning to replace this fallback with setting the
> take_ownership call for p5ioc etc. to point to
> tce_iommu_take_ownership.


Why? I do not really want p5ioc2 or ioda1 to have 
take_ownership/release_ownership callbacks defined as they will only do 
this default stuff which is not going to change ever as this hardware is 
quite old and extremely rare so there is no real customer for it. Should I 
still convert these to callbacks?



>> +	} else {
>> +		/*
>> +		 * Disable iommu bypass, otherwise the user can DMA to all of
>> +		 * our physical memory via the bypass window instead of just
>> +		 * the pages that has been explicitly mapped into the iommu
>> +		 */
>> +		table_group->ops->take_ownership(table_group);
>> +		ret = 0;
>> +	}
>> +
>> +	if (ret)
>> +		goto unlock_exit;
>> +
>> +	container->grp = iommu_group;
>>
>>   unlock_exit:
>>   	mutex_unlock(&container->lock);
>> @@ -530,7 +581,6 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   {
>>   	struct tce_container *container = iommu_data;
>>   	struct iommu_table_group *table_group;
>> -	struct iommu_table *tbl;
>>
>>   	mutex_lock(&container->lock);
>>   	if (iommu_group != container->grp) {
>> @@ -553,9 +603,11 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   	table_group = iommu_group_get_iommudata(iommu_group);
>>   	BUG_ON(!table_group);
>>
>> -	tbl = &table_group->tables[0];
>> -	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>> -	iommu_release_ownership(tbl);
>> +	/* Kernel owns the device now, we can restore bypass */
>> +	if (!table_group->ops || !table_group->ops->release_ownership)
>> +		tce_iommu_release_ownership(container, table_group);
>> +	else
>> +		table_group->ops->release_ownership(table_group);
>>
>>   unlock_exit:
>>   	mutex_unlock(&container->lock);
>


-- 
Alexey

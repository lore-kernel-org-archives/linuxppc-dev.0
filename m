Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D5E61A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 11:29:27 +1100 (AEDT)
Received: by pdbfl12 with SMTP id fl12so6356278pdb.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 17:29:25 -0700 (PDT)
Message-ID: <54FF8C5E.60007@ozlabs.ru>
Date: Wed, 11 Mar 2015 11:29:18 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 27/29] vfio: powerpc/spapr: powerpc/powernv/ioda2:
 Rework ownership
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>	
 <1425910045-26167-28-git-send-email-aik@ozlabs.ru>
 <1426032557.25026.95.camel@redhat.com>
In-Reply-To: <1426032557.25026.95.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/2015 11:09 AM, Alex Williamson wrote:
> On Tue, 2015-03-10 at 01:07 +1100, Alexey Kardashevskiy wrote:
>> Before the IOMMU user would take control over the IOMMU table belonging to
>> a specific IOMMU group. This approach did not allow sharing tables between
>> IOMMU groups attached to the same container.
>>
>> This introduces a new IOMMU ownership flavour when the user can not
>> just control the existing IOMMU table but remove/create tables on demand.
>> If an IOMMU supports a set_ownership() callback, that lets the user have
>> full control over the IOMMU group. When the ownership is taken,
>> the platform code removes all the windows so the caller must create them.
>> Before returning the ownership back to the platform code, the user
>> has to unprogram and remove all the tables it created.
>
> We have no ability to enforce that requirement on the user.  VFIO needs
> to do the cleanup if the user fails to.

Ah. Wrong commit log, VFIO always does cleanup (as I end my guests by c-a-x 
most of the time :) ), will fix it.


>
>> Old-style ownership is still supported allowing VFIO to run on older
>> P5IOC2 and IODA IO controllers.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++---
>>   drivers/vfio/vfio_iommu_spapr_tce.c       | 51 ++++++++++++++++++++++++-------
>>   2 files changed, 66 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 07857c4..afb6906 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1620,11 +1620,33 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
>>   {
>>   	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>>   						table_group);
>> -	if (enable)
>> -		iommu_take_ownership(table_group);
>> -	else
>> -		iommu_release_ownership(table_group);
>> +	if (enable) {
>> +		pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>> +		pnv_pci_free_table(&pe->table_group.tables[0]);
>> +	} else {
>> +		struct iommu_table *tbl = &pe->table_group.tables[0];
>> +		int64_t rc;
>>
>> +		rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
>> +				IOMMU_PAGE_SHIFT_4K,
>> +				pe->phb->ioda.m32_pci_base,
>> +				POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
>> +		if (rc) {
>> +			pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
>> +					rc);
>> +			return;
>> +		}
>> +
>> +		iommu_init_table(tbl, pe->phb->hose->node);
>> +
>> +		rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
>> +		if (rc) {
>> +			pe_err(pe, "Failed to configure 32-bit TCE table, err %ld\n",
>> +					rc);
>> +			pnv_pci_free_table(tbl);
>> +			return;
>> +		}
>> +	}
>>   	pnv_pci_ioda2_set_bypass(pe, !enable);
>>   }
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index d665ddc..3bc0645 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -426,18 +426,11 @@ static int tce_iommu_clear(struct tce_container *container,
>>   static void tce_iommu_release(void *iommu_data)
>>   {
>>   	struct tce_container *container = iommu_data;
>> -	struct iommu_table *tbl;
>> -	struct iommu_table_group *table_group;
>>
>>   	WARN_ON(container->grp);
>>
>> -	if (container->grp) {
>> -		table_group = iommu_group_get_iommudata(container->grp);
>> -		tbl = &table_group->tables[0];
>> -		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
>> -
>> +	if (container->grp)
>>   		tce_iommu_detach_group(iommu_data, container->grp);
>> -	}
>>
>>   	tce_mem_unregister_all(container);
>>   	tce_iommu_disable(container);
>> @@ -826,14 +819,24 @@ static int tce_iommu_attach_group(void *iommu_data,
>>
>>   	if (!table_group->ops || !table_group->ops->set_ownership) {
>>   		ret = iommu_take_ownership(table_group);
>> +	} else if (!table_group->ops->create_table ||
>> +			!table_group->ops->set_window) {
>> +		WARN_ON_ONCE(1);
>> +		ret = -EFAULT;
>>   	} else {
>>   		/*
>>   		 * Disable iommu bypass, otherwise the user can DMA to all of
>>   		 * our physical memory via the bypass window instead of just
>>   		 * the pages that has been explicitly mapped into the iommu
>>   		 */
>> +		struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
>> +
>>   		table_group->ops->set_ownership(table_group, true);
>> -		ret = 0;
>> +		ret = table_group->ops->create_table(table_group, 0,
>> +				IOMMU_PAGE_SHIFT_4K,
>> +				table_group->tce32_size, 1, tbl);
>> +		if (!ret)
>> +			ret = table_group->ops->set_window(table_group, 0, tbl);
>>   	}
>>
>>   	if (ret)
>> @@ -852,6 +855,7 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   {
>>   	struct tce_container *container = iommu_data;
>>   	struct iommu_table_group *table_group;
>> +	long i;
>>
>>   	mutex_lock(&container->lock);
>>   	if (iommu_group != container->grp) {
>> @@ -875,10 +879,35 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   	BUG_ON(!table_group);
>>
>>   	/* Kernel owns the device now, we can restore bypass */
>> -	if (!table_group->ops || !table_group->ops->set_ownership)
>> +	if (!table_group->ops || !table_group->ops->set_ownership) {
>> +		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +			struct iommu_table *tbl = &table_group->tables[i];
>> +
>> +			if (!tbl->it_size)
>> +				continue;
>> +
>> +			if (!tbl->it_ops)
>> +				goto unlock_exit;
>> +			tce_iommu_clear(container, tbl,
>> +					tbl->it_offset, tbl->it_size);
>> +		}
>>   		iommu_release_ownership(table_group);
>> -	else
>> +	} else if (!table_group->ops->unset_window) {
>> +		WARN_ON_ONCE(1);
>> +	} else {
>> +		for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>> +			struct iommu_table *tbl = &table_group->tables[i];
>> +
>> +			table_group->ops->unset_window(table_group, i);
>> +			tce_iommu_clear(container, tbl,
>> +					tbl->it_offset, tbl->it_size);
>> +
>> +			if (tbl->it_ops->free)
>> +				tbl->it_ops->free(tbl);
>> +		}
>> +
>>   		table_group->ops->set_ownership(table_group, false);
>> +	}
>>
>>   unlock_exit:
>>
>
>
>


-- 
Alexey

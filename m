Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 027991A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 20:09:39 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so120643450pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:09:36 -0700 (PDT)
Message-ID: <5530DBD9.9090004@ozlabs.ru>
Date: Fri, 17 Apr 2015 20:09:29 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v8 14/31] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework IOMMU ownership control
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
 <20150416060703.GE3632@voom.redhat.com>
In-Reply-To: <20150416060703.GE3632@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2015 04:07 PM, David Gibson wrote:
> On Fri, Apr 10, 2015 at 04:30:56PM +1000, Alexey Kardashevskiy wrote:
>> At the moment the iommu_table struct has a set_bypass() which enables/
>> disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
>> which calls this callback when external IOMMU users such as VFIO are
>> about to get over a PHB.
>>
>> The set_bypass() callback is not really an iommu_table function but
>> IOMMU/PE function. This introduces a iommu_table_group_ops struct and
>> adds a set_ownership() callback to it which is called when an external
>> user takes control over the IOMMU.
>
> Do you really need separate ops structures at both the single table
> and table group level?  The different tables in a group will all
> belong to the same basic iommu won't they?


IOMMU tables exist alone in VIO. Also, the platform code uses just a table 
(or it is in bypass mode) and does not care about table groups. It looked 
more clean for myself to keep them separated. Should I still merge those?


>
>> This renames set_bypass() to set_ownership() as it is not necessarily
>> just enabling bypassing, it can be something else/more so let's give it
>> more generic name. The bool parameter is inverted.
>>
>> The callback is implemented for IODA2 only. Other platforms (P5IOC2,
>> IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/iommu.h          | 14 +++++++++++++-
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++++++--------
>>   drivers/vfio/vfio_iommu_spapr_tce.c       | 25 +++++++++++++++++++++----
>>   3 files changed, 56 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index b9e50d3..d1f8c6c 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -92,7 +92,6 @@ struct iommu_table {
>>   	unsigned long  it_page_shift;/* table iommu page size */
>>   	struct iommu_table_group *it_group;
>>   	struct iommu_table_ops *it_ops;
>> -	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>>   };
>>
>>   /* Pure 2^n version of get_order */
>> @@ -127,11 +126,24 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
>>
>>   #define IOMMU_TABLE_GROUP_MAX_TABLES	1
>>
>> +struct iommu_table_group;
>> +
>> +struct iommu_table_group_ops {
>> +	/*
>> +	 * Switches ownership from the kernel itself to an external
>> +	 * user. While onwership is enabled, the kernel cannot use IOMMU
>> +	 * for itself.
>> +	 */
>> +	void (*set_ownership)(struct iommu_table_group *table_group,
>> +			bool enable);
>
> The meaning of "enable" in a function called "set_ownership" is
> entirely obscure.

Suggest something better please :) I have nothing better...


>
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
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index a964c50..9687731 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1255,10 +1255,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>>   }
>>
>> -static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>>   {
>> -	struct pnv_ioda_pe *pe = container_of(tbl->it_group, struct pnv_ioda_pe,
>> -					      table_group);
>>   	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>>   	int64_t rc;
>>
>> @@ -1286,7 +1284,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
>>   		 * host side.
>>   		 */
>>   		if (pe->pdev)
>> -			set_iommu_table_base(&pe->pdev->dev, tbl);
>> +			set_iommu_table_base(&pe->pdev->dev,
>> +					&pe->table_group.tables[0]);
>>   		else
>>   			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>>   	}
>> @@ -1302,13 +1301,27 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
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
>> +static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
>> +				     bool enable)
>> +{
>> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>> +						table_group);
>> +	if (enable)
>> +		iommu_take_ownership(table_group);
>> +	else
>> +		iommu_release_ownership(table_group);
>> +
>> +	pnv_pci_ioda2_set_bypass(pe, !enable);
>> +}
>> +
>> +static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
>> +	.set_ownership = pnv_ioda2_set_ownership,
>> +};
>> +
>>   static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   				       struct pnv_ioda_pe *pe)
>>   {
>> @@ -1376,6 +1389,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   	}
>>   	tbl->it_ops = &pnv_iommu_ops;
>>   	iommu_init_table(tbl, phb->hose->node);
>> +	pe->table_group.ops = &pnv_pci_ioda2_ops;
>>   	iommu_register_group(&pe->table_group, phb->hose->global_number,
>>   			pe->pe_number);
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 9f38351..d5d8c50 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -535,9 +535,22 @@ static int tce_iommu_attach_group(void *iommu_data,
>>   		goto unlock_exit;
>>   	}
>>
>> -	ret = iommu_take_ownership(table_group);
>> -	if (!ret)
>> -		container->grp = iommu_group;
>> +	if (!table_group->ops || !table_group->ops->set_ownership) {
>> +		ret = iommu_take_ownership(table_group);
>> +	} else {
>> +		/*
>> +		 * Disable iommu bypass, otherwise the user can DMA to all of
>> +		 * our physical memory via the bypass window instead of just
>> +		 * the pages that has been explicitly mapped into the iommu
>> +		 */
>> +		table_group->ops->set_ownership(table_group, true);
>
> And here to disable bypass you call it with enable=true, so it doesn't
> even have the same meaning as it used to.


I do not disable bypass per se (even if it what set_ownership(true) does) 
as it is IODA business and VFIO has no idea about it. I do take control 
over the group. I am not following you here - what used to have the same 
meaning?


>
> Plus, you should fold the logic to call the callback if necessary into
> iommu_take_ownership().


I really want to keep VFIO stuff out of arch/powerpc/kernel/iommu.c as much 
as possible as it is for platform DMA/IOMMU, not VFIO (which got SPAPR 
driver for that). ops->set_ownership() is one of these things.

iommu_take_ownership()/iommu_release_ownership() are helpers for old-style 
commercially-unsupported P5IOC2/IODA1, and this is kind of a hack while 
ops->set_ownership() is an interface for VFIO to do dynamic windows thing.

If it makes sense, I could fold the previous patch into this one and move 
iommu_take_ownership()/iommu_release_ownership() to vfio_iommu_spapr_tce.c, 
should I? Or leave things are they are now.


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
>> @@ -572,7 +585,11 @@ static void tce_iommu_detach_group(void *iommu_data,
>>   	table_group = iommu_group_get_iommudata(iommu_group);
>>   	BUG_ON(!table_group);
>>
>> -	iommu_release_ownership(table_group);
>> +	/* Kernel owns the device now, we can restore bypass */
>> +	if (!table_group->ops || !table_group->ops->set_ownership)
>> +		iommu_release_ownership(table_group);
>> +	else
>> +		table_group->ops->set_ownership(table_group, false);
>
> Likewise fold this if into iommu_release_ownership().
>
>>   unlock_exit:
>>   	mutex_unlock(&container->lock);
>


-- 
Alexey

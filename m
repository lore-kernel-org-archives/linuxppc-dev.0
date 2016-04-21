Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr3ny1W1YzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 13:17:08 +1000 (AEST)
Received: by mail-pa0-x22e.google.com with SMTP id zm5so24199069pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 20:17:08 -0700 (PDT)
Subject: Re: [PATCH kernel 1/2] powerpc/iommu: Get rid of default
 group_release()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-2-git-send-email-aik@ozlabs.ru>
 <20160421000225.GA8367@gwshan>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5718462C.6070107@ozlabs.ru>
Date: Thu, 21 Apr 2016 13:17:00 +1000
MIME-Version: 1.0
In-Reply-To: <20160421000225.GA8367@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2016 10:02 AM, Gavin Shan wrote:
> On Fri, Apr 08, 2016 at 04:36:43PM +1000, Alexey Kardashevskiy wrote:
>> IBM PPC IOMMU API users always set IOMMU data and IOMMU release callback
>> to an IOMMU group. At the moment the callback clears one pointer in
>> iommu_table_group and that's it.
>>
>> The platform code calls iommu_group_put() and counts on _put() being
>> called last so they check for table_group->group being reset which
>> is conceptually wrong as there may be another user holding a reference.
>>
>> This removes the default IOMMU group release() callback and adds it
>> as a parameter to iommu_register_group(). As we are changing the prototype
>> anyway, this also changes the function name to more distinctive
>> iommu_register_table_group().
>>
>> This should cause no behavioral change as it leaves BUG_ON for IODA2
>> (where it was reported) and removes BUG_ON for pseries/IODA1 as they
>> do not support IOV anyway and this BUG_ON has never been reported for
>> these platforms.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> There is one question at end of the thread...
>
>> ---
>> arch/powerpc/include/asm/iommu.h          | 12 +++++++-----
>> arch/powerpc/kernel/iommu.c               | 14 ++++----------
>> arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++++++++++----
>> arch/powerpc/platforms/pseries/iommu.c    | 17 +++++++++--------
>> 4 files changed, 31 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 7b87bab..d7ba3b4 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -201,17 +201,19 @@ struct iommu_table_group {
>>
>> #ifdef CONFIG_IOMMU_API
>>
>> -extern void iommu_register_group(struct iommu_table_group *table_group,
>> -				 int pci_domain_number, unsigned long pe_num);
>> +extern void iommu_register_table_group(struct iommu_table_group *table_group,
>> +		int pci_domain_number, unsigned long pe_num,
>> +		void (*release)(void *iommu_data));
>> extern int iommu_add_device(struct device *dev);
>> extern void iommu_del_device(struct device *dev);
>> extern int __init tce_iommu_bus_notifier_init(void);
>> extern long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
>> 		unsigned long *hpa, enum dma_data_direction *direction);
>> #else
>> -static inline void iommu_register_group(struct iommu_table_group *table_group,
>> -					int pci_domain_number,
>> -					unsigned long pe_num)
>> +static inline void iommu_register_table_group(
>> +		struct iommu_table_group *table_group,
>> +		int pci_domain_number, unsigned long pe_num,
>> +		void (*release)(void *iommu_data))
>> {
>> }
>>
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index a8e3490..8eed2fa 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -887,15 +887,9 @@ EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
>> /*
>>   * SPAPR TCE API
>>   */
>> -static void group_release(void *iommu_data)
>> -{
>> -	struct iommu_table_group *table_group = iommu_data;
>> -
>> -	table_group->group = NULL;
>> -}
>> -
>> -void iommu_register_group(struct iommu_table_group *table_group,
>> -		int pci_domain_number, unsigned long pe_num)
>> +void iommu_register_table_group(struct iommu_table_group *table_group,
>> +		int pci_domain_number, unsigned long pe_num,
>> +		void (*release)(void *iommu_data))
>> {
>> 	struct iommu_group *grp;
>> 	char *name;
>> @@ -907,7 +901,7 @@ void iommu_register_group(struct iommu_table_group *table_group,
>> 		return;
>> 	}
>> 	table_group->group = grp;
>> -	iommu_group_set_iommudata(grp, table_group, group_release);
>> +	iommu_group_set_iommudata(grp, table_group, release);
>> 	name = kasprintf(GFP_KERNEL, "domain%d-pe%lx",
>> 			pci_domain_number, pe_num);
>> 	if (!name)
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index c5baaf3..ce9f2bf 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1330,6 +1330,13 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
>> 		int num);
>> static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>>
>> +static void pnv_pci_ioda2_group_release(void *iommu_data)
>> +{
>> +	struct iommu_table_group *table_group = iommu_data;
>> +
>> +	table_group->group = NULL;
>> +}
>> +
>> static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
>> {
>> 	struct iommu_table    *tbl;
>> @@ -1965,8 +1972,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>> 		return;
>>
>> 	tbl = pnv_pci_table_alloc(phb->hose->node);
>> -	iommu_register_group(&pe->table_group, phb->hose->global_number,
>> -			pe->pe_number);
>> +	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
>> +			pe->pe_number, NULL);
>> 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>
>> 	/* Grab a 32-bit TCE table */
>> @@ -2450,8 +2457,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>> 	/* TVE #1 is selected by PCI address bit 59 */
>> 	pe->tce_bypass_base = 1ull << 59;
>>
>> -	iommu_register_group(&pe->table_group, phb->hose->global_number,
>> -			pe->pe_number);
>> +	iommu_register_table_group(&pe->table_group, phb->hose->global_number,
>> +			pe->pe_number, pnv_pci_ioda2_group_release);
>>
>> 	/* The PE will reserve all possible 32-bits space */
>> 	pe->tce32_seg = 0;
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index bd98ce2..0f6f06c 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -112,7 +112,7 @@ static void iommu_pseries_free_group(struct iommu_table_group *table_group,
>> 	}
>> 	if (table_group->group) {
>> 		iommu_group_put(table_group->group);
>> -		BUG_ON(table_group->group);
>> +		table_group->group = NULL;
>> 	}
>> #endif
>> 	iommu_free_table(tbl, node_name);
>> @@ -692,7 +692,8 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>> 	iommu_table_setparms(pci->phb, dn, tbl);
>> 	tbl->it_ops = &iommu_table_pseries_ops;
>> 	iommu_init_table(tbl, pci->phb->node);
>> -	iommu_register_group(pci->table_group, pci_domain_nr(bus), 0);
>> +	iommu_register_table_group(pci->table_group, pci_domain_nr(bus), 0,
>> +			NULL);
>>
>> 	/* Divide the rest (1.75GB) among the children */
>> 	pci->phb->dma_window_size = 0x80000000ul;
>> @@ -743,8 +744,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>> 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
>> 		tbl->it_ops = &iommu_table_lpar_multi_ops;
>> 		iommu_init_table(tbl, ppci->phb->node);
>> -		iommu_register_group(ppci->table_group,
>> -				pci_domain_nr(bus), 0);
>> +		iommu_register_table_group(ppci->table_group,
>> +				pci_domain_nr(bus), 0, NULL);
>> 		pr_debug("  created table: %p\n", ppci->table_group);
>> 	}
>> }
>> @@ -772,8 +773,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
>> 		iommu_table_setparms(phb, dn, tbl);
>> 		tbl->it_ops = &iommu_table_pseries_ops;
>> 		iommu_init_table(tbl, phb->node);
>> -		iommu_register_group(PCI_DN(dn)->table_group,
>> -				pci_domain_nr(phb->bus), 0);
>> +		iommu_register_table_group(PCI_DN(dn)->table_group,
>> +				pci_domain_nr(phb->bus), 0, NULL);
>> 		set_iommu_table_base(&dev->dev, tbl);
>> 		iommu_add_device(&dev->dev);
>> 		return;
>> @@ -1197,8 +1198,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>> 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
>> 		tbl->it_ops = &iommu_table_lpar_multi_ops;
>> 		iommu_init_table(tbl, pci->phb->node);
>> -		iommu_register_group(pci->table_group,
>> -				pci_domain_nr(pci->phb->bus), 0);
>> +		iommu_register_table_group(pci->table_group,
>> +				pci_domain_nr(pci->phb->bus), 0, NULL);
>> 		pr_debug("  created table: %p\n", pci->table_group);
>> 	} else {
>> 		pr_debug("  found DMA window, table: %p\n", pci->table_group);
>
> Here seems one issue not introduced by this patch: all PE# passed to
> iommu_register_table_group() on pSeries platform are zero. When there
> are multiple PEs under one PHB, their IOMMU groups will have same
> names. It seems not correct. Maybe we don't have two PEs under one
> PHB yet?

This is a minor issue though. I cannot recall anything depending on the 
name and at the moment VFIO does not work on pseries anyway, when/if I add 
it, I'll fix this too.



-- 
Alexey

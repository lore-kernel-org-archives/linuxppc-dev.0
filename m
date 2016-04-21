Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr3sY06XTzDqbl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 13:20:17 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id 184so25150955pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 20:20:16 -0700 (PDT)
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
 <20160421002107.GB8367@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <571846E9.80800@ozlabs.ru>
Date: Thu, 21 Apr 2016 13:20:09 +1000
MIME-Version: 1.0
In-Reply-To: <20160421002107.GB8367@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2016 10:21 AM, Gavin Shan wrote:
> On Fri, Apr 08, 2016 at 04:36:44PM +1000, Alexey Kardashevskiy wrote:
>> When SRIOV is disabled, the existing code presumes there is no
>> virtual function (VF) in use and destroys all associated PEs.
>> However it is possible to get into the situation when the user
>> activated SRIOV disabling while a VF is still in use via VFIO.
>> For example, unbinding a physical function (PF) while there is a guest
>> running with a VF passed throuhgh via VFIO will trigger the bug.
>>
>> This defines an IODA2-specific IOMMU group release() callback.
>> This moves all the disposal code from pnv_ioda_release_vf_PE() to this
>> new callback so the cleanup happens when the last user of an IOMMU
>> group released the reference.
>>
>> As pnv_pci_ioda2_release_dma_pe() was reduced to just calling
>> iommu_group_put(), this merges pnv_pci_ioda2_release_dma_pe()
>> into pnv_ioda_release_vf_PE().
>>
>
> Sorry, I don't understand how it works. When PF's driver disables
> IOV capability, the VF cannnot work. The guest is unlikely to know
> that and still continue accessing the VF's resources (e.g. config
> space and MMIO registers). It would cause EEH errors.

The host disables IOV which removes VF devices which unbinds vfio_pci 
driver and does all the cleanup, eventually we get to QEMU's 
vfio_req_notifier_handler() and PCI hot unplug is initiated and the device 
disappears from the guest.

If the guest cannot do PCI hotunplug, then EEH will make host stop it anyway.

Here we do not really care what happens to the guest (it can detect EEH or 
hotunplug or simply crash), we need to make sure that the _host_ does not 
crash in any case because the root user did something weird.


>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++------------------
>> 1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index ce9f2bf..8108c54 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>> static void pnv_pci_ioda2_group_release(void *iommu_data)
>> {
>> 	struct iommu_table_group *table_group = iommu_data;
>> +	struct pnv_ioda_pe *pe = container_of(table_group,
>> +			struct pnv_ioda_pe, table_group);
>> +	struct pci_controller *hose = pci_bus_to_host(pe->parent_dev->bus);
>
> pe->parent_dev would be NULL for non-VF-PEs and it's protected by CONFIG_PCI_IOV
> in pci.h.


Yeah, I'll fix it.

>
>> +	struct pnv_phb *phb = hose->private_data;
>> +	struct iommu_table *tbl = pe->table_group.tables[0];
>> +	int64_t rc;
>>
>> -	table_group->group = NULL;
>> -}
>> -
>> -static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
>> -{
>> -	struct iommu_table    *tbl;
>> -	int64_t               rc;
>> -
>> -	tbl = pe->table_group.tables[0];
>> 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>> 	if (rc)
>> 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>>
>> 	pnv_pci_ioda2_set_bypass(pe, false);
>> -	if (pe->table_group.group) {
>> -		iommu_group_put(pe->table_group.group);
>> -		BUG_ON(pe->table_group.group);
>> -	}
>> +
>> +	BUG_ON(!tbl);
>> 	pnv_pci_ioda2_table_free_pages(tbl);
>> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>> +	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
>> +
>> +	pnv_ioda_deconfigure_pe(phb, pe);
>> +	pnv_ioda_free_pe(phb, pe->pe_number);
>> }
>
> It's not correct enough. One PE is comprised of DMA, MMIO, mapping info etc.
> This function disposes all of them when DMA finishes its job. I don't figure
> out a better way to represent all of them and their relationship. I guess it's
> worthy to have something in long term though it's not trival work.


Sorry, I am missing your point here. I am not changing the resource 
deallocation here, I am just doing it slightly later and all I wonder at 
the moment is if there are races - like having 2 scripts - one doing unbind 
PF and another doing bind PF - will this crash the host in theory?


>
>>
>> static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>> @@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>> 		if (pe->parent_dev != pdev)
>> 			continue;
>>
>> -		pnv_pci_ioda2_release_dma_pe(pdev, pe);
>> -
>> 		/* Remove from list */
>> 		mutex_lock(&phb->ioda.pe_list_mutex);
>> 		list_del(&pe->list);
>> 		mutex_unlock(&phb->ioda.pe_list_mutex);
>>
>> -		pnv_ioda_deconfigure_pe(phb, pe);
>> -
>> -		pnv_ioda_free_pe(phb, pe->pe_number);
>> +		if (pe->table_group.group)
>> +			iommu_group_put(pe->table_group.group);
>> 	}
>> }
>>
>> --
>> 2.5.0.rc3
>>
>


-- 
Alexey

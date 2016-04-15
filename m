Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmKhh0FjJzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 11:29:40 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id e128so51307076pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 18:29:39 -0700 (PDT)
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
To: David Gibson <david@gibson.dropbear.id.au>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
 <20160414014033.GD18218@voom.redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <571043FC.8040509@ozlabs.ru>
Date: Fri, 15 Apr 2016 11:29:32 +1000
MIME-Version: 1.0
In-Reply-To: <20160414014033.GD18218@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2016 11:40 AM, David Gibson wrote:
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
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++------------------
>>   1 file changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index ce9f2bf..8108c54 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>>   static void pnv_pci_ioda2_group_release(void *iommu_data)
>>   {
>>   	struct iommu_table_group *table_group = iommu_data;
>> +	struct pnv_ioda_pe *pe = container_of(table_group,
>> +			struct pnv_ioda_pe, table_group);
>> +	struct pci_controller *hose = pci_bus_to_host(pe->parent_dev->bus);
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
>>   	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>
> Is it safe to go manipulating the PE windows, etc. after SR-IOV is
> disabled?

Manipulating windows in this case is just updating 8 bytes in the TVT. At 
this point a VF is expected to be destroyed but PE is expected to remain 
not free so pnv_ioda2_pick_m64_pe() (or pnv_ioda2_reserve_m64_pe()?) won't 
use it.

>
> When SR-IOV is disabled, you need to immediately disable the VF (I'm
> guessing that happens somewhere) and stop all access to the VF
> "hardware".

drivers/pci/iov.c
===
static void sriov_disable(struct pci_dev *dev)
{
...
for (i = 0; i < iov->num_VFs; i++)
         pci_iov_remove_virtfn(dev, i, 0);
...
pcibios_sriov_disable(dev);
===

pcibios_sriov_disable() is where pnv_pci_ioda2_release_dma_pe() is called from.

> Only the iommu group structure *has* to stick around
> until the reference count drops to zero.  I think other structures and
> hardware reconfiguration can be deferred or done immediately,
> whichever is more convenient.

I deferred everything because of convenience as iommu_table_group is 
embedded into pnv_ioda struct, not a pointer.



>>   	if (rc)
>>   		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>>
>>   	pnv_pci_ioda2_set_bypass(pe, false);
>> -	if (pe->table_group.group) {
>> -		iommu_group_put(pe->table_group.group);
>> -		BUG_ON(pe->table_group.group);
>> -	}
>> +
>> +	BUG_ON(!tbl);
>>   	pnv_pci_ioda2_table_free_pages(tbl);
>> -	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>> +	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
>> +
>> +	pnv_ioda_deconfigure_pe(phb, pe);
>> +	pnv_ioda_free_pe(phb, pe->pe_number);
>>   }
>>
>>   static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>> @@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>>   		if (pe->parent_dev != pdev)
>>   			continue;
>>
>> -		pnv_pci_ioda2_release_dma_pe(pdev, pe);
>> -
>>   		/* Remove from list */
>>   		mutex_lock(&phb->ioda.pe_list_mutex);
>>   		list_del(&pe->list);
>>   		mutex_unlock(&phb->ioda.pe_list_mutex);
>>
>> -		pnv_ioda_deconfigure_pe(phb, pe);
>> -
>> -		pnv_ioda_free_pe(phb, pe->pe_number);
>> +		if (pe->table_group.group)
>> +			iommu_group_put(pe->table_group.group);
>>   	}
>>   }
>>
>


-- 
Alexey

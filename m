Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3047C1A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 17:41:40 +1000 (AEST)
Received: by pabzx8 with SMTP id zx8so16723358pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 00:41:38 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/iommu: Set default DMA offset in
 dma_dev_setup
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1440655276-6596-1-git-send-email-aik@ozlabs.ru>
 <20150827061635.GA9648@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Wei Yang <weiyang@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55DEBF2B.3030306@ozlabs.ru>
Date: Thu, 27 Aug 2015 17:41:31 +1000
MIME-Version: 1.0
In-Reply-To: <20150827061635.GA9648@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2015 04:16 PM, Gavin Shan wrote:
> On Thu, Aug 27, 2015 at 04:01:16PM +1000, Alexey Kardashevskiy wrote:
>> "powerpc/iommu: Cleanup setting of DMA base/offset" expects that
>> the default DMA offset is set from pnv_ioda_setup_bus_dma() which
>> is correct unless it is SRIOV where the code flow is different - at
>> the moment when pnv_ioda_setup_bus_dma() is called, there is no PE for
>> the just created VF.
>>
>
> The PEs for VFs are ready at the moment. We don't have pci_dev for
> VFs actually.


Ah, you are right. Should have been:

====
"powerpc/iommu: Cleanup setting of DMA base/offset" expects that
the default DMA offset is set from pnv_ioda_setup_bus_dma() which
is correct unless it is SRIOV where the code flow is different - at
the moment when pnv_ioda_setup_bus_dma() is called, PCI devices
for VFs are not created yet.
====


>> This adds missing set_dma_offset() to pnv_pci_ioda_dma_dev_setup()
>> to cover the case of SRIOV.
>>
>> Note that we still need set_dma_offset() in pnv_ioda_setup_bus_dma()
>> as at the boot time pnv_pci_ioda_dma_dev_setup() is called when no PE
>> was created yet, this happens at the PHB fixup stage.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> Thanks,
> Gavin
>
>> ---
>>
>> Makes sense to squash it to "powerpc/iommu: Cleanup setting of DMA base/offset".
>>
>>
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 2c286b57..af875c1 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1590,6 +1590,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>>
>> 	pe = &phb->ioda.pe_array[pdn->pe_number];
>> 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
>> +	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
>> 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
>> 	/*
>> 	 * Note: iommu_add_device() will fail here as
>> --
>> 2.4.0.rc3.8.gfb3e7d5
>>
>


-- 
Alexey

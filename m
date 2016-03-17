Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQmbm5kw9zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:39:32 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 21:39:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DF4B52CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:39:17 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HBd9i254067396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:39:17 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HBcjtE007298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 22:38:45 +1100
Subject: Re: [RFC PATCH v4 7/7] powerpc/powernv/pci-ioda: Add
 IOMMU_CAP_INTR_REMAP for IODA host bridge
To: Alex Williamson <alex.williamson@redhat.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-8-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160316103207.6fffb9b5@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA9735.2010401@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 19:38:29 +0800
MIME-Version: 1.0
In-Reply-To: <20160316103207.6fffb9b5@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/17 0:32, Alex Williamson wrote:
> On Mon,  7 Mar 2016 15:48:38 +0800
> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>
>> This patch adds IOMMU_CAP_INTR_REMAP for IODA host bridge so that
>> we can mmap MSI-X table in vfio driver.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index f90dc04..f01b9ab 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1955,6 +1955,20 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>   	.free = pnv_ioda2_table_free,
>>   };
>>   
>> +static bool pnv_ioda_iommu_capable(enum iommu_cap cap)
>> +{
>> +	switch (cap) {
>> +	case IOMMU_CAP_INTR_REMAP:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static struct iommu_ops pnv_ioda_iommu_ops = {
>> +	.capable = pnv_ioda_iommu_capable,
>> +};
>> +
>>   static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   				      struct pnv_ioda_pe *pe, unsigned int base,
>>   				      unsigned int segs)
>> @@ -3078,6 +3092,9 @@ static void pnv_pci_ioda_fixup(void)
>>   
>>   	/* Link NPU IODA tables to their PCI devices. */
>>   	pnv_npu_ioda_fixup();
>> +
>> +	/* Add IOMMU_CAP_INTR_REMAP */
>> +	bus_set_iommu(&pci_bus_type, &pnv_ioda_iommu_ops);
>>   }
>>   
>>   /*
>
> Doesn't this set you up for a world of hurt?  bus_set_iommu() calls
> iommu_bus_init() which sets up notifiers, which maybe you don't care
> about, but it also means that iommu_domain_alloc(&pci_bus_type) will
> segfault because you're not providing a domain_alloc callback here.

It seems to be hard to add IOMMU_CAP_INTR_REMAP on
PPC64 platform.

And can we add a new ioctl in vfio_iommu_driver to check
if interrupt remapping is supported so that we can use our
own way to determine that on PPC64 platform?

Thanks,
Yongji Xie

Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C90491A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 17:26:13 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so42792250pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 00:26:12 -0700 (PDT)
Message-ID: <5552FC8A.5080401@ozlabs.ru>
Date: Wed, 13 May 2015 17:26:02 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 02/34] powerpc/iommu/powernv: Get rid of
 set_iommu_table_base_and_group
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-3-git-send-email-aik@ozlabs.ru>
 <20150513051831.GA18992@gwshan>
In-Reply-To: <20150513051831.GA18992@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2015 03:18 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:38:51AM +1000, Alexey Kardashevskiy wrote:
>> The set_iommu_table_base_and_group() name suggests that the function
>> sets table base and add a device to an IOMMU group. However actual
>> table base setting happens in pnv_pci_ioda_dma_dev_setup().
>>
>
> On PHB3, the DMA32 IOMMU table is created during PHB fixup time
> in ppc_md.pcibios_fixup(), which is invoked at end of PCI enumeration.
> The IOMMU table of PCI devices are initialized at same time.
> pnv_pci_ioda_dma_dev_setup() is called when adding PCI device
> or fixing up PCI bus at PCI enumeration time. So the commit logs
> here isn't accurate enough.

Right. I'll remove the second sentence.

> Basically, set_iommu_table_base_and_group() which does two things
> in one function, which is nice. I guess you don't need this function
> any more after DDW is supported and it's the reason to remove it?

Ideally iommu_add_device() should not need any iommu_table pointer at all, 
it need an iommu_table_group which is IOMMU which is one pe PE. Not a table 
(we can have more than just one or even none).

set_iommu_table_base() sets the table for later use by the platform DMA 
code (first half of arch/powerpc/kernel/iommu.c, all these 
iommu_alloc/iommu_free). If no device driver was loaded for a device in a 
group - calling set_iommu_table_base() is not needed.

KVM/VFIO do not call get_iommu_table_base() and do not use the table_base 
(except iommu_add_device()) and there is no point for VFIO-related bits of 
IOMMU code to rely on whether set_iommu_table_base() was called or not. It 
could make sense when table's life time was exactly the same as PE's 
lifetime but with DDW it is not the case anymore.

What we have now is a workaround - device-to-group assignment does not have 
to do anything with the iommu_table itself, it just needs it_table_group 
pointer. In general, I would like to use common iommu_group_get_for_dev(), 
it just won't work for us right now but we can try fixing that code. Or we 
can add root devices into groups when we configure PEs 
(pnv_pci_ioda2_setup_dma_pe()) and later when we add actual PCI functions 
(physical or SRIOV) from tce_iommu_bus_notifier - we can walk up PCI bus 
hierarchy till we find a first parent with a group set and add the child to 
this group. We can do this later.

So the function might be nice but it was confusing me (and I added it at 
the first place). It is easy to miss iommu_add_device() part while reading 
the code because it was disguised by "set_iommu_table_base" prefix.




>> The actual purpose for table base setting is to put some reference
>> into a device so later iommu_add_device() can get the IOMMU group
>> reference and the device to the group.
>>
>> At the moment a group cannot be explicitly passed to iommu_add_device()
>> as we want it to work from the bus notifier, we can fix it later and
>> remove confusing calls of set_iommu_table_base().
>>
>> This replaces set_iommu_table_base_and_group() with a couple of
>> set_iommu_table_base() + iommu_add_device() which makes reading the code
>> easier.
>>
>> This adds few comments why set_iommu_table_base() and iommu_add_device()
>> are called where they are called.
>>
>> For IODA1/2, this essentially removes iommu_add_device() call from
>> the pnv_pci_ioda_dma_dev_setup() as it will always fail at this particular
>> place:
>> - for physical PE, the device is already attached by iommu_add_device()
>> in pnv_pci_ioda_setup_dma_pe();
>> - for virtual PE, the sysfs entries are not ready to create all symlinks
>> so actual adding is happening in tce_iommu_bus_notifier.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v10:
>> * new to the series
>> ---
>> arch/powerpc/include/asm/iommu.h            |  7 -------
>> arch/powerpc/platforms/powernv/pci-ioda.c   | 27 +++++++++++++++++++++++----
>> arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 ++-
>> arch/powerpc/platforms/pseries/iommu.c      | 15 ++++++++-------
>> 4 files changed, 33 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index 1e27d63..8353c86 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -140,13 +140,6 @@ static inline int __init tce_iommu_bus_notifier_init(void)
>> }
>> #endif /* !CONFIG_IOMMU_API */
>>
>> -static inline void set_iommu_table_base_and_group(struct device *dev,
>> -						  void *base)
>> -{
>> -	set_iommu_table_base(dev, base);
>> -	iommu_add_device(dev);
>> -}
>> -
>> extern int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
>> 			    struct scatterlist *sglist, int nelems,
>> 			    unsigned long mask,
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 2f092bb..9a77f3c 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1598,7 +1598,13 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>>
>> 	pe = &phb->ioda.pe_array[pdn->pe_number];
>> 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
>> -	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
>> +	set_iommu_table_base(&pdev->dev, pe->tce32_table);
>> +	/*
>> +	 * Note: iommu_add_device() will fail here as
>> +	 * for physical PE: the device is already added by now;
>> +	 * for virtual PE: sysfs entries are not ready yet and
>> +	 * tce_iommu_bus_notifier will add the device to a group later.
>> +	 */
>
> I didn't figure out how the IOMMU table is initialized for PCI device in this
> function during bootup time. At system bootup time, the function is only called
> when applying fixup to PCI bus in pcibios_fixup_bus(). At that time, we don't
> have PE# yet, which is allocated at PHB fixup time (ppc_md.pcibios_fixup_phb).

My understanding is:
pnv_pci_ioda_dma_dev_setup() is called when
1. the device is just discovered
2. PE is configured
3. driver called set_dma_mask

The actual table gets initialized (or allocated + initialized after this 
patchset) at 2). So passing anything (NULL or a pointer to uninitialized 
iommu_table) to set_iommu_table_base() at 1) does not make any difference - 
iommu_alloc() won't be used and won't work by then anyway.

But since 1), 2), 3) all call pnv_pci_ioda_dma_dev_setup() and we do not 
know which case it is - we just call set_iommu_table_base() from there in a 
hope that iommu_alloc() happens after set_iommu_table_base() was lucky 
enough to be called with initialized iommu_table pointer.




-- 
Alexey

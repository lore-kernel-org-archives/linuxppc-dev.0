Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhC0d6R91zDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 18:14:09 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 13:44:05 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u388EJuC21692892
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 13:44:19 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u388DwHm018011
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 13:44:00 +0530
Subject: Re: [RFC v5 7/7] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: Eric Auger <eric.auger@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1459864004-2869-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459864004-2869-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160406084504.1a1cc16d@t450s.home> <570646AB.8050406@linux.vnet.ibm.com>
 <57066D76.9050303@linaro.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 will.deacon@arm.com, gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
 ruscur@russell.cc
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <5707684B.7060901@linux.vnet.ibm.com>
Date: Fri, 8 Apr 2016 16:14:03 +0800
MIME-Version: 1.0
In-Reply-To: <57066D76.9050303@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Eric,
On 2016/4/7 22:23, Eric Auger wrote:
> Hi Yongji,
> On 04/07/2016 01:38 PM, Yongji Xie wrote:
>> On 2016/4/6 22:45, Alex Williamson wrote:
>>> On Tue,  5 Apr 2016 21:46:44 +0800
>>> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
>>>
>>>> This patch enables mmapping MSI-X tables if
>>>> hardware supports interrupt remapping which
>>>> can ensure that a given pci device can only
>>>> shoot the MSIs assigned for it.
>>>>
>>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>>> ---
>>>>    drivers/vfio/pci/vfio_pci.c         |    9 +++++++--
>>>>    drivers/vfio/pci/vfio_pci_private.h |    1 +
>>>>    drivers/vfio/pci/vfio_pci_rdwr.c    |    2 +-
>>>>    3 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>>> index c60d790..ef02896 100644
>>>> --- a/drivers/vfio/pci/vfio_pci.c
>>>> +++ b/drivers/vfio/pci/vfio_pci.c
>>>> @@ -201,6 +201,10 @@ static int vfio_pci_enable(struct
>>>> vfio_pci_device *vdev)
>>>>        } else
>>>>            vdev->msix_bar = 0xFF;
>>>>    +    if (iommu_capable(pdev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>>> This doesn't address the issue I raised earlier where ARM SMMU sets
>>> this capability, but doesn't really provide per vector isolation.  ARM
>>> either needs to be fixed or we need to consider the whole capability
>>> tainted for this application and standardize around the bus flags.
>>> It's not very desirable to have two different ways to test this anyway.
>> I saw Eric posted a patchset [1] which introduce a flag
>> MSI_FLAG_IRQ_REMAPPING to indicate the capability
>> for ARM SMMU. With this patchset applied, it would
>> be  workable to use bus_flags to test the capability
>> of ARM SMMU:
> My purpose was to remove the advertising of IOMMU_CAP_INTR_REMAP from
> arm-smmu.c, "fix" mentionned by Alex (by the way I also need to do the
> same in v3 code) and to advertise the functionality on MSI controller
> instead (since the IRQ REMAPPING functionality is abstracted in GICv3
> ITS MSI controller)

Thank you for your explanation.  Now we have three
flags to test this capability with your and my patches
applied.  We need to test something like
IOMMU_CAP_INTR_REMAP || MSI_FLAG_IRQ_REMAPPING ||
PCI_BUS_FLAGS_MSI_REMAP if we want to mmap
MSI-X table. It's not very desirable if I understood
Alex correctly. So I'm thinking whether we can make
bus_flags compatible with other two flags and only
test bus_flags here.

> On top of that, on ARM we have platform (non PCI) MSI controllers so my
> understanding is the capability advertising should be possible beyond
> the PCI bus?

Actually, we just need one flag which can standardize
the capability on PCI side. With this flag set, we can
easily know hardware supports the capability of
interrupt remapping and it's safe to mmap MSI-X
tables of PCI BARs in any userspace driver.

Of course, we can also achieve that by testing all the
three flags. But I'm not sure whether it is good enough.

Regards,
Yongji

> Best Regards
>
> Eric
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index a080f44..b2d1756 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -1134,6 +1134,21 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>>   }
>>   EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
>>
>> +void pci_check_msi_remapping(struct pci_bus *bus)
>> +{
>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +        struct irq_domain *domain;
>> +        struct msi_domain_info *info;
>> +
>> +        domain = dev_get_msi_domain(&bus->dev);
>> +        if (domain) {
>> +                info = msi_get_domain_info(domain);
>> +                if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>> +                        pdev->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>> +        }
>> +#endif
>> +}
>> +
>>   #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>>   /**
>>    * pci_msi_domain_write_msg - Helper to write MSI message to PCI config
>> space
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 6d7ab9b..24e9606 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2115,6 +2115,7 @@ struct pci_bus *pci_create_root_bus(struct device
>> *parent, int bus,
>>          device_enable_async_suspend(b->bridge);
>>          pci_set_bus_of_node(b);
>>          pci_set_bus_msi_domain(b);
>> +       pci_check_msi_remapping(b);
>>
>>          if (!parent)
>>                  set_dev_node(b->bridge, pcibus_to_node(b));
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index a2a0068..fe8ce7b 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -15,6 +15,7 @@ extern int pci_msi_ignore_mask;
>>   struct irq_data;
>>   struct msi_desc;
>>   struct pci_dev;
>> +struct pci_bus;
>>   struct platform_msi_priv_data;
>>   void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>>   void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
>> @@ -155,6 +156,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
>>   void default_teardown_msi_irqs(struct pci_dev *dev);
>>   void default_restore_msi_irqs(struct pci_dev *dev);
>>
>> +void pci_check_msi_remapping(struct pci_bus *bus);
>> +
>>   struct msi_controller {
>>          struct module *owner;
>>          struct device *dev;
>>
>> Next we just need to find a proper way to make
>> bus_flags compatible with IOMMU_CAP_INTR_REMAP, right?
>>
>> I think a good place to do that is add_iommu_group().
>> But I'm not sure whether iommu drivers must be
>> initialized after PCI enumeration.  Do you have any comment?
>>
>> [1] http://www.spinics.net/lists/kvm/msg130256.html
>>
>>>> +        pdev->bus->bus_flags | PCI_BUS_FLAGS_MSI_REMAP)
>>> Perhaps some sort of wrapper for testing these flags would help avoid
>>> this kind of coding error (| vs &)
>> Thank you.  I'll try not to make the same mistake again.
>>
>> Regards,
>> Yongji
>>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

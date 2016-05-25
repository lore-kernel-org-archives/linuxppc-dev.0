Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF1Xm5Mc7zDqV2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 15:48:24 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4P5mJM9009304
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:48:23 -0400
Message-Id: <201605250548.u4P5mJM9009304@mx0a-001b2d01.pphosted.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 234qhw7y17-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:48:22 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 25 May 2016 11:18:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A3C083940060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:18:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P5m3gl14221602
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:18:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P5m1IS005768
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 11:18:14 +0530
Subject: Re: [PATCH 3/5] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
 supports IRQ remapping
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160524210434.GB16463@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 alistair@popple.id.au, ruscur@russell.cc
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 13:48:00 +0800
MIME-Version: 1.0
In-Reply-To: <20160524210434.GB16463@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/5/25 5:04, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:28PM +0800, Yongji Xie wrote:
>> On ARM HW the capability of IRQ remapping is abstracted on
>> MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
>> this [1].
>>
>> To have a universal flag to test this capability for different
>> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
>> when MSI_FLAG_IRQ_REMAPPING is set.
>>
>> [1] http://www.spinics.net/lists/kvm/msg130256.html
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/msi.c   |   12 ++++++++++++
>>   drivers/pci/probe.c |    3 +++
>>   include/linux/msi.h |    6 +++++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index a080f44..1661cdf 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -1134,6 +1134,18 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>>   }
>>   EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
>>   
>> +void pci_bus_check_msi_remapping(struct pci_bus *bus,
>> +				 struct irq_domain *domain)
>> +{
>> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>> +	struct msi_domain_info *info;
>> +
>> +	info = msi_get_domain_info(domain);
>> +	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>> +#endif
>> +}
> Functions named "check_foo" are a pet peeve of mine because the name
> doesn't tell us anything about what the function *does*.  In this
> case, we know it checks something about MSI remapping, but we don't
> know whether we're checking whether it's enabled, disabled, or some
> other property.
>
> I'd prefer something like:
>
>    int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain)
>    {
>      struct msi_domain_info *info;
>
>      if (!domain)
>        return 0;
>
>      info = msi_get_domain_info(domain);
>      if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>        return 1;
>
>      return 0;
>    }
>
>    void pci_set_bus_msi_domain(struct pci_bus *bus)
>    {
>      ...
>      if (b == bus && pci_bus_msi_isolated(bus, d))
>        bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;

Yes. This looks more reasonable. Thank you!

Regards,
Yongji

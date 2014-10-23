Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CFD51A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 17:33:30 +1100 (AEDT)
Message-ID: <5448A0F8.1040004@huawei.com>
Date: Thu, 23 Oct 2014 14:32:24 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 04/27] arm/MSI: Save MSI chip in pci_sys_data
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
 <20141023053555.GC11770@google.com>
In-Reply-To: <20141023053555.GC11770@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 22e413c..f11108c 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -35,6 +35,9 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  	struct msi_chip *chip = dev->bus->msi;
>>  	int err;
>>  
>> +	if (!chip)
>> +		chip = pci_msi_chip(dev->bus);
>> +
>>  	if (!chip || !chip->setup_irq)
>>  		return -EINVAL;
>>  
>> @@ -50,6 +53,9 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>>  	struct msi_desc *entry = irq_get_msi_desc(irq);
>>  	struct msi_chip *chip = entry->dev->bus->msi;
>>  
>> +	if (!chip)
>> +		chip = pci_msi_chip(entry->dev->bus);
>> +
>>  	if (!chip || !chip->teardown_irq)
>>  		return;
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 9cd2721..7a48b40 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1433,6 +1433,15 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>>  
>>  #include <asm/pci.h>
>>  
>> +/* Just avoid compile error, will be clean up later */
>> +#ifdef CONFIG_PCI_MSI
>> +
>> +#ifndef pci_msi_chip
>> +#define pci_msi_chip(bus)	NULL
>> +#endif
>> +#endif
> 
> I don't like the mixture of ARM changes and PCI core changes in the same
> patch.  Can you split this into a core patch that does something like this:
> 
>   struct msi_chip * __weak pcibios_msi_controller(struct pci_bus *bus)
>   {
>     return NULL;
>   }
> 
>   struct msi_chip *pci_msi_controller(struct pci_bus *bus)
>   {
>     msi_chip *controller = bus->msi;
> 
>     if (controller)
>       return controller;
>     return pcibios_msi_controller(bus);
>   }
> 
> followed by an ARM patch that puts the msi_chip pointer in struct hw_pci
> and implements pcibios_msi_controller()?

OK, I will split it in half.

> 
> I know you're trying to *remove* weak functions, and this adds one, but
> this section of the series is more about getting rid of the ARM
> pcibios_add_bus() because all it was used for was setting the bus->msi
> pointer.

Yes, agree.

> 
> Eventually we might have a way to stash an MSI controller pointer in the
> generic pci_host_bridge struct, and then the pcibios_msi_controller()
> interface could go away.

Yep, I am doing the work to make a generic pci_host_bridge, and try to rip it out from
pci_create_root_bus, that's also a large changes across many archs.

> 
>> +
>>  /* these helpers provide future and backwards compatibility
>>   * for accessing popular PCI BAR info */
>>  #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

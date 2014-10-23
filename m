Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D07941A00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 17:40:20 +1100 (AEDT)
Message-ID: <5448A2A7.9090407@huawei.com>
Date: Thu, 23 Oct 2014 14:39:35 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 09/27] arm/PCI: Clean unused pcibios_add_bus() and
 pcibios_remove_bus()
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-10-git-send-email-wangyijing@huawei.com>
 <20141023053858.GD11770@google.com>
In-Reply-To: <20141023053858.GD11770@google.com>
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

>>  /*
>>   * Swizzle the device pin each time we cross a bridge.  If a platform does
>>   * not provide a swizzle function, we perform the standard PCI swizzling.
>> @@ -478,8 +464,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>>  		sys->swizzle = hw->swizzle;
>>  		sys->map_irq = hw->map_irq;
>>  		sys->align_resource = hw->align_resource;
>> -		sys->add_bus = hw->add_bus;
>> -		sys->remove_bus = hw->remove_bus;
>>  		INIT_LIST_HEAD(&sys->resources);
>>  
>>  		if (hw->private_data)
> 
> What do the core changes below have to do with the ARM changes above?
> They should be a separate patch unless they can't be separated.

Hm, it's not the thing have to do, because the changes below is only used by arm arch, so I put it here
together. It's ok to split the core changes out to another one.

> 
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index f11108c..56e54ad 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -32,12 +32,10 @@ int pci_msi_ignore_mask;
>>  
>>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  {
>> -	struct msi_chip *chip = dev->bus->msi;
>> +	struct msi_chip *chip;
>>  	int err;
>>  
>> -	if (!chip)
>> -		chip = pci_msi_chip(dev->bus);
>> -
>> +	chip = pci_msi_chip(dev->bus);
>>  	if (!chip || !chip->setup_irq)
>>  		return -EINVAL;
>>  
>> @@ -51,10 +49,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  void __weak arch_teardown_msi_irq(unsigned int irq)
>>  {
>>  	struct msi_desc *entry = irq_get_msi_desc(irq);
>> -	struct msi_chip *chip = entry->dev->bus->msi;
>> -
>> -	if (!chip)
>> -		chip = pci_msi_chip(entry->dev->bus);
>> +	struct msi_chip *chip = pci_msi_chip(entry->dev->bus);
>>  
>>  	if (!chip || !chip->teardown_irq)
>>  		return;
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

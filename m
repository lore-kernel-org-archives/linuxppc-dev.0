Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1A791A0624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 12:09:47 +1000 (EST)
Message-ID: <54179BD1.3050608@huawei.com>
Date: Tue, 16 Sep 2014 10:09:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1 06/21] PCI/MSI: Refactor struct msi_chip to make it
 become more common
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	
 <1409911806-10519-7-git-send-email-wangyijing@huawei.com>
 <1410792261.3314.9.camel@pengutronix.de>
In-Reply-To: <1410792261.3314.9.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Xinwei Hu <huxinwei@huawei.com>,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/15 22:44, Lucas Stach wrote:
> Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
>> Now there are a lot of __weak arch functions in MSI code.
>> These functions make MSI driver complex. Thierry Reding Introduced
>> a new MSI chip framework to configure MSI/MSI-X irq in ARM. Use
>> the new MSI chip framework to refactor all other platform MSI
>> arch code to eliminate weak arch MSI functions. This patch add
>> .restore_irq() and .setup_irqs() to make it become more common.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> This change looks good to me:
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks!

> 
>> ---
>>  drivers/pci/msi.c   |   15 +++++++++++++++
>>  include/linux/msi.h |    3 +++
>>  2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 539c11d..d78d637 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -63,6 +63,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>  {
>>  	struct msi_desc *entry;
>>  	int ret;
>> +	struct msi_chip *chip;
>> +
>> +	chip = arch_find_msi_chip(dev);
>> +	if (chip && chip->setup_irqs)
>> +		return chip->setup_irqs(dev, nvec, type);
>>  
>>  	/*
>>  	 * If an architecture wants to support multiple MSI, it needs to
>> @@ -105,6 +110,11 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>>  
>>  void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
>>  {
>> +	struct msi_chip *chip = arch_find_msi_chip(dev);
>> +
>> +	if (chip && chip->teardown_irqs)
>> +		return chip->teardown_irqs(dev);
>> +
>>  	return default_teardown_msi_irqs(dev);
>>  }
>>  
>> @@ -128,6 +138,11 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>>  
>>  void __weak arch_restore_msi_irqs(struct pci_dev *dev)
>>  {
>> +	struct msi_chip *chip = arch_find_msi_chip(dev);
>> +
>> +	if (chip && chip->restore_irqs)
>> +		return chip->restore_irqs(dev);
>> +
>>  	return default_restore_msi_irqs(dev);
>>  }
>>  
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 5650848..92a51e7 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -72,7 +72,10 @@ struct msi_chip {
>>  	struct list_head list;
>>  
>>  	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
>> +	int (*setup_irqs)(struct pci_dev *dev, int nvec, int type);
>>  	void (*teardown_irq)(unsigned int irq);
>> +	void (*teardown_irqs)(struct pci_dev *dev);
>> +	void (*restore_irqs)(struct pci_dev *dev);
>>  };
>>  
>>  #endif /* LINUX_MSI_H */
> 


-- 
Thanks!
Yijing

Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBED51A003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 11:24:37 +1000 (EST)
Message-ID: <5418E2BA.4030304@huawei.com>
Date: Wed, 17 Sep 2014 09:24:10 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 16/21] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-17-git-send-email-wangyijing@huawei.com>
 <alpine.LFD.2.11.1409161325280.1618@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1409161325280.1618@denkbrett>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Xinwei Hu <huxinwei@huawei.com>,
 Tony Luck <tony.luck@intel.com>, Ralf
 Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/16 19:35, Sebastian Ott wrote:
> Hello,
> 
> On Fri, 5 Sep 2014, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/s390/pci/pci.c |   18 ++++++++++++++----
>>  1 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 2fa7b14..da5316e 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>>  	}
>>  }
>>
>> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>  {
>>  	struct zpci_dev *zdev = get_zdev(pdev);
>>  	unsigned int hwirq, msi_vecs;
>> @@ -434,7 +434,7 @@ out:
>>  	return rc;
>>  }
>>
>> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
>> +static void zpci_teardown_msi_irqs(struct pci_dev *pdev)
>>  {
>>  	struct zpci_dev *zdev = get_zdev(pdev);
>>  	struct msi_desc *msi;
>> @@ -448,9 +448,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>  	/* Release MSI interrupts */
>>  	list_for_each_entry(msi, &pdev->msi_list, list) {
>>  		if (msi->msi_attrib.is_msix)
>> -			default_msix_mask_irq(msi, 1);
>> +			__msix_mask_irq(msi, 1);
>>  		else
>> -			default_msi_mask_irq(msi, 1, 1);
>> +			__msi_mask_irq(msi, 1, 1);
> 
> The default_msi_mask_irq to __msi_mask_irq renaming is hidden in your
> patch "x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()"
> 
> This means that between that patch and this one s390 will not compile.
> Could you please move this hunk to the other patch or even make an extra
> patch with the renaming. Other than that:

Good catch. I will move this hunk into the patch "x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()".

> 
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>


Thanks!
Yijing.


> 
> Regards,
> Sebastian
> 
>>  		irq_set_msi_desc(msi->irq, NULL);
>>  		irq_free_desc(msi->irq);
>>  		msi->msg.address_lo = 0;
>> @@ -464,6 +464,16 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>  	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
>>  }
>>
>> +static struct msi_chip zpci_msi_chip = {
>> +	.setup_irqs = zpci_setup_msi_irqs,
>> +	.teardown_irqs = zpci_teardown_msi_irqs,
>> +};
>> +
>> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +	return &zpci_msi_chip;
>> +}
>> +
>>  static void zpci_map_resources(struct zpci_dev *zdev)
>>  {
>>  	struct pci_dev *pdev = zdev->pdev;
>> -- 
>> 1.7.1
>>
>>
> 
> 
> .
> 


-- 
Thanks!
Yijing

Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 911BF1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 11:31:37 +1000 (EST)
Message-ID: <541792C0.9090303@huawei.com>
Date: Tue, 16 Sep 2014 09:30:40 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	
 <1409911806-10519-4-git-send-email-wangyijing@huawei.com>
 <1410789648.3314.5.camel@pengutronix.de>
In-Reply-To: <1410789648.3314.5.camel@pengutronix.de>
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

On 2014/9/15 22:00, Lucas Stach wrote:
> Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
>> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
>> use irq chip_data to save the msi_chip pointer. They
>> already call irq_set_chip_data() in their own MSI irq map
>> functions. So irq_set_chip_data() in arch_setup_msi_irq()
>> is useless.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index f6cb317..d547f7f 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  	if (err < 0)
>>  		return err;
>>  
>> -	irq_set_chip_data(desc->irq, chip);
>> -
>>  	return 0;
>>  }
>>  
> 
> arch_teardown_msi_irq() expects to find the msi_chip in the irq
> chip_data field. As this means drivers don't have any reasonable other
> possibility to stuff things into this field, I think it would make sense
> to do the cleanup the other way around: keep the irq_set_chip_data
> arch_setup_msi_irq() and rip it out of the individual drivers.

Hi Lucas, thanks for your review and comments!
irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
And this series is mainly to use MSI chip framework in all platforms.
Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.

Thanks!
Yijing.


> 
> Regards,
> Lucas
> 


-- 
Thanks!
Yijing

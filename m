Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 017F61A01B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 20:37:56 +1000 (EST)
Message-ID: <541812EC.3000501@huawei.com>
Date: Tue, 16 Sep 2014 18:37:32 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>		
 <1409911806-10519-4-git-send-email-wangyijing@huawei.com>	
 <1410789648.3314.5.camel@pengutronix.de> <541792C0.9090303@huawei.com>
 <1410863349.2746.5.camel@pengutronix.de>
In-Reply-To: <1410863349.2746.5.camel@pengutronix.de>
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

>>> arch_teardown_msi_irq() expects to find the msi_chip in the irq
>>> chip_data field. As this means drivers don't have any reasonable other
>>> possibility to stuff things into this field, I think it would make sense
>>> to do the cleanup the other way around: keep the irq_set_chip_data
>>> arch_setup_msi_irq() and rip it out of the individual drivers.
>>
>> Hi Lucas, thanks for your review and comments!
>> irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
>> use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
>> And this series is mainly to use MSI chip framework in all platforms.
>> Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
>> irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.
>>
> Okay I see your point, so the cleanup done this way is okay.
> 
> But then this still introduces a problem: arch_teardown_msi_irq()
> expects to find the msi_chip in the chip_data field, which is okay for
> all ARM PCI host drivers, but not for other arch MSI chips.
> 
> You fix this by completely removing arch_teardown_msi_irq() at the end
> of the series, but this still has the potential to introduce issues for
> other arches than ARM within the series. So this patch should include a
> change to replace the line
> 
> struct msi_chip *chip = irq_get_chip_data(irq);
> 
> with something that doesn't rely on the msi_chip being in the irq
> chip_data field.

OK, I will update arch_teardown_msi_irq() in this patch, thanks!

Thanks!
Yijing.

> 
> Regards,
> Lucas
> 


-- 
Thanks!
Yijing

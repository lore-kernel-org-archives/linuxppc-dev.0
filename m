Return-Path: <l.stach@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA1A91A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 20:30:31 +1000 (EST)
Message-ID: <1410863349.2746.5.camel@pengutronix.de>
Subject: Re: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
From: Lucas Stach <l.stach@pengutronix.de>
To: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 16 Sep 2014 12:29:09 +0200
In-Reply-To: <541792C0.9090303@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-4-git-send-email-wangyijing@huawei.com>
 <1410789648.3314.5.camel@pengutronix.de> <541792C0.9090303@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, den 16.09.2014, 09:30 +0800 schrieb Yijing Wang:
> On 2014/9/15 22:00, Lucas Stach wrote:
> > Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
> >> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> >> use irq chip_data to save the msi_chip pointer. They
> >> already call irq_set_chip_data() in their own MSI irq map
> >> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> >> is useless.
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >> ---
> >>  drivers/pci/msi.c |    2 --
> >>  1 files changed, 0 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> >> index f6cb317..d547f7f 100644
> >> --- a/drivers/pci/msi.c
> >> +++ b/drivers/pci/msi.c
> >> @@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> >>  	if (err < 0)
> >>  		return err;
> >>  
> >> -	irq_set_chip_data(desc->irq, chip);
> >> -
> >>  	return 0;
> >>  }
> >>  
> > 
> > arch_teardown_msi_irq() expects to find the msi_chip in the irq
> > chip_data field. As this means drivers don't have any reasonable other
> > possibility to stuff things into this field, I think it would make sense
> > to do the cleanup the other way around: keep the irq_set_chip_data
> > arch_setup_msi_irq() and rip it out of the individual drivers.
> 
> Hi Lucas, thanks for your review and comments!
> irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
> use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
> And this series is mainly to use MSI chip framework in all platforms.
> Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
> irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.
> 
Okay I see your point, so the cleanup done this way is okay.

But then this still introduces a problem: arch_teardown_msi_irq()
expects to find the msi_chip in the chip_data field, which is okay for
all ARM PCI host drivers, but not for other arch MSI chips.

You fix this by completely removing arch_teardown_msi_irq() at the end
of the series, but this still has the potential to introduce issues for
other arches than ARM within the series. So this patch should include a
change to replace the line

struct msi_chip *chip = irq_get_chip_data(irq);

with something that doesn't rely on the msi_chip being in the irq
chip_data field.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

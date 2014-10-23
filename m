Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB9F41A0074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 16:39:04 +1100 (AEDT)
Received: by mail-ie0-f169.google.com with SMTP id tr6so334894ieb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 22:39:01 -0700 (PDT)
Date: Wed, 22 Oct 2014 23:38:58 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 09/27] arm/PCI: Clean unused pcibios_add_bus() and
 pcibios_remove_bus()
Message-ID: <20141023053858.GD11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-10-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413342435-7876-10-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2014 at 11:06:57AM +0800, Yijing Wang wrote:
> MSI chip will be saved in pci_sys_data, now we can
> clean up pcibios_add_bus() and pcibios_remove_bus()
> in arm, and use pci_find_msi_chip() to get msi chip
> in core MSI code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    4 ----
>  arch/arm/kernel/bios32.c        |   16 ----------------
>  drivers/pci/msi.c               |   11 +++--------
>  3 files changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 59b0d87..230b2c9 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -39,8 +39,6 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  };
>  
>  /*
> @@ -71,8 +69,6 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index a19038d..b1b872e 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -360,20 +360,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pcibios_fixup_bus);
>  
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->add_bus)
> -		sys->add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->remove_bus)
> -		sys->remove_bus(bus);
> -}
> -
>  /*
>   * Swizzle the device pin each time we cross a bridge.  If a platform does
>   * not provide a swizzle function, we perform the standard PCI swizzling.
> @@ -478,8 +464,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
>  		sys->align_resource = hw->align_resource;
> -		sys->add_bus = hw->add_bus;
> -		sys->remove_bus = hw->remove_bus;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)

What do the core changes below have to do with the ARM changes above?
They should be a separate patch unless they can't be separated.

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f11108c..56e54ad 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,12 +32,10 @@ int pci_msi_ignore_mask;
>  
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	struct msi_chip *chip = dev->bus->msi;
> +	struct msi_chip *chip;
>  	int err;
>  
> -	if (!chip)
> -		chip = pci_msi_chip(dev->bus);
> -
> +	chip = pci_msi_chip(dev->bus);
>  	if (!chip || !chip->setup_irq)
>  		return -EINVAL;
>  
> @@ -51,10 +49,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(irq);
> -	struct msi_chip *chip = entry->dev->bus->msi;
> -
> -	if (!chip)
> -		chip = pci_msi_chip(entry->dev->bus);
> +	struct msi_chip *chip = pci_msi_chip(entry->dev->bus);
>  
>  	if (!chip || !chip->teardown_irq)
>  		return;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

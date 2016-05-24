Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDnwS0CltzDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 07:04:40 +1000 (AEST)
Date: Tue, 24 May 2016 16:04:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org,
 will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [PATCH 3/5] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
 supports IRQ remapping
Message-ID: <20160524210434.GB16463@localhost>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 08:43:28PM +0800, Yongji Xie wrote:
> On ARM HW the capability of IRQ remapping is abstracted on
> MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
> this [1].
> 
> To have a universal flag to test this capability for different
> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
> when MSI_FLAG_IRQ_REMAPPING is set.
> 
> [1] http://www.spinics.net/lists/kvm/msg130256.html
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/pci/msi.c   |   12 ++++++++++++
>  drivers/pci/probe.c |    3 +++
>  include/linux/msi.h |    6 +++++-
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a080f44..1661cdf 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1134,6 +1134,18 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
>  
> +void pci_bus_check_msi_remapping(struct pci_bus *bus,
> +				 struct irq_domain *domain)
> +{
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +	struct msi_domain_info *info;
> +
> +	info = msi_get_domain_info(domain);
> +	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
> +#endif
> +}

Functions named "check_foo" are a pet peeve of mine because the name
doesn't tell us anything about what the function *does*.  In this
case, we know it checks something about MSI remapping, but we don't
know whether we're checking whether it's enabled, disabled, or some
other property.

I'd prefer something like:

  int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain)
  {
    struct msi_domain_info *info;

    if (!domain)
      return 0;

    info = msi_get_domain_info(domain);
    if (info->flags & MSI_FLAG_IRQ_REMAPPING)
      return 1;

    return 0;
  }

  void pci_set_bus_msi_domain(struct pci_bus *bus)
  {
    ...
    if (b == bus && pci_bus_msi_isolated(bus, d))
      bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;

>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  /**
>   * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..25cf1b1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -696,6 +696,9 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  	if (!d)
>  		d = pci_host_bridge_msi_domain(b);
>  
> +	if (d && b == bus)
> +		pci_bus_check_msi_remapping(bus, d);
> +
>  	dev_set_msi_domain(&bus->dev, d);
>  }
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 03eda72..b4c649e 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -15,6 +15,8 @@ extern int pci_msi_ignore_mask;
>  struct irq_data;
>  struct msi_desc;
>  struct pci_dev;
> +struct pci_bus;
> +struct irq_domain;
>  struct platform_msi_priv_data;
>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
> @@ -155,6 +157,9 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
>  void default_teardown_msi_irqs(struct pci_dev *dev);
>  void default_restore_msi_irqs(struct pci_dev *dev);
>  
> +void pci_bus_check_msi_remapping(struct pci_bus *bus,
> +				 struct irq_domain *domain);
> +
>  struct msi_controller {
>  	struct module *owner;
>  	struct device *dev;
> @@ -173,7 +178,6 @@ struct msi_controller {
>  #include <linux/irqhandler.h>
>  #include <asm/msi.h>
>  
> -struct irq_domain;
>  struct irq_domain_ops;
>  struct irq_chip;
>  struct device_node;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

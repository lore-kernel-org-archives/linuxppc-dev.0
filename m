Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE1411A0069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 10:53:51 +1100 (AEDT)
Received: by mail-ie0-f176.google.com with SMTP id rp18so4632578iec.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 16:53:48 -0700 (PDT)
Date: Wed, 22 Oct 2014 17:53:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v3 24/27] IA64/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Message-ID: <20141022235345.GE4795@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-25-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413342435-7876-25-git-send-email-wangyijing@huawei.com>
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

On Wed, Oct 15, 2014 at 11:07:12AM +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

This needs slightly more detail.  You're using the MSI chip framework
"instead of arch MSI functions".  Well, there are still arch-specific
functions, i.e., arch_ia64_setup_msi_irq() and
arch_ia64_teardown_msi_irq().

We used to have arch_setup_msi_irq() which had a weak default
implementation, and a strong arch-specific implementation here, and you're
replacing that model with the new "msi-ops" model.  I don't know how you
want to write that, but it's not that you're getting rid of the
arch-specific code; you're keeping arch-specific code but structuring it
differently.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/ia64/include/asm/pci.h |   10 ++++++++++
>  arch/ia64/kernel/msi_ia64.c |   14 ++++++++++----
>  arch/ia64/pci/pci.c         |    1 +
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
> index 52af5ed..907dcba 100644
> --- a/arch/ia64/include/asm/pci.h
> +++ b/arch/ia64/include/asm/pci.h
> @@ -94,6 +94,7 @@ struct pci_controller {
>  	int segment;
>  	int node;		/* nearest node with memory or NUMA_NO_NODE for global allocation */
>  
> +	struct msi_chip *msi_chip;
>  	void *platform_data;
>  };
>  
> @@ -101,6 +102,15 @@ struct pci_controller {
>  #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
>  #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
>  
> +extern struct msi_chip chip;

Please make this name more descriptive.  "chip" is way too generic for a
global name.

> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct pci_controller *ctrl = bus->sysdata;
> +
> +	return ctrl->msi_chip;
> +}
> +
>  extern struct pci_ops pci_root_ops;
>  
>  static inline int pci_proc_domain(struct pci_bus *bus)
> diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
> index 8c3730c..401fc98 100644
> --- a/arch/ia64/kernel/msi_ia64.c
> +++ b/arch/ia64/kernel/msi_ia64.c
> @@ -112,15 +112,16 @@ static struct irq_chip ia64_msi_chip = {
>  };
>  
>  
> -int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
> +static int arch_ia64_setup_msi_irq(struct msi_chip *chip,
> +		struct pci_dev *dev, struct msi_desc *desc)
>  {
>  	if (platform_setup_msi_irq)
> -		return platform_setup_msi_irq(pdev, desc);
> +		return platform_setup_msi_irq(dev, desc);
>  
> -	return ia64_setup_msi_irq(pdev, desc);
> +	return ia64_setup_msi_irq(dev, desc);

Please don't make gratuitous changes ("pdev" -> "dev") at the same time,
especially since the rest of the file still uses "pdev".

>  }
>  
> -void arch_teardown_msi_irq(unsigned int irq)
> +static void arch_ia64_teardown_msi_irq(struct msi_chip *chip, unsigned int irq)
>  {
>  	if (platform_teardown_msi_irq)
>  		return platform_teardown_msi_irq(irq);
> @@ -128,6 +129,11 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	return ia64_teardown_msi_irq(irq);
>  }
>  
> +struct msi_chip chip = {
> +	.setup_irq = arch_ia64_setup_msi_irq,
> +	.teardown_irq = arch_ia64_teardown_msi_irq,
> +};
> +
>  #ifdef CONFIG_INTEL_IOMMU
>  #ifdef CONFIG_SMP
>  static int dmar_msi_set_affinity(struct irq_data *data,
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index 291a582..299b67d 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -437,6 +437,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  
>  	controller->companion = device;
>  	controller->node = acpi_get_node(device->handle);
> +	controller->msi_chip = &chip;
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

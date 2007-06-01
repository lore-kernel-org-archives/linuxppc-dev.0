Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC4F0DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:23:55 +1000 (EST)
Subject: Re: [patch] powerpc: Remove redundant pci_read_irq_line() function
	for 85xx platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1180685138.17196.55.camel@localhost.localdomain>
References: <1180685138.17196.55.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 09:23:44 +1000
Message-Id: <1180740225.19517.470.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 16:05 +0800, Zang Roy-r61911 wrote:
> From: Roy Zang <tie-fei.zang@freescale.com>
> 
> Remove redundant pci_read_irq_line() function for 
> 85xx CDS board.
> This function has been realized in common pci_32.c.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c |   76 +++++++++++++----------------
>  1 files changed, 34 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 1490eb3..27b81ff 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -78,52 +78,44 @@ static int mpc85xx_exclude_device(u_char bus, u_char devfn)
>  		return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static void __init mpc85xx_cds_pcibios_fixup(void)
> +static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
>  {
> -	struct pci_dev *dev;
> -	u_char		c;
> -
> -	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> -					PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
> +	u_char c;
> +	if (dev->vendor == PCI_VENDOR_ID_VIA) {
> +		switch (dev->device) {
> +		case PCI_DEVICE_ID_VIA_82C586_1:
> +			/*
> +			 * U-Boot does not set the enable bits
> +			 * for the IDE device. Force them on here.
> +			 */
> +			pci_read_config_byte(dev, 0x40, &c);
> +			c |= 0x03; /* IDE: Chip Enable Bits */
> +			pci_write_config_byte(dev, 0x40, c);
> +
> +			/*
> +			 * Since only primary interface works, force the
> +			 * IDE function to standard primary IDE interrupt
> +			 * w/ 8259 offset
> +			 */
> +			dev->irq = 14;
> +			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> +			break;
>  		/*
> -		 * U-Boot does not set the enable bits
> -		 * for the IDE device. Force them on here.
> +		 * Force legacy USB interrupt routing
>  		 */
> -		pci_read_config_byte(dev, 0x40, &c);
> -		c |= 0x03; /* IDE: Chip Enable Bits */
> -		pci_write_config_byte(dev, 0x40, c);
> -
> -		/*
> -		 * Since only primary interface works, force the
> -		 * IDE function to standard primary IDE interrupt
> -		 * w/ 8259 offset
> +		case PCI_DEVICE_ID_VIA_82C586_2:
> +		/* There are two USB controllers.
> +		 * Identify them by functon number
>  		 */
> -		dev->irq = 14;
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> -		pci_dev_put(dev);
> -	}
> -
> -	/*
> -	 * Force legacy USB interrupt routing
> -	 */
> -	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> -					PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
> -		dev->irq = 10;
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
> -		pci_dev_put(dev);
> -	}
> -
> -	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> -					PCI_DEVICE_ID_VIA_82C586_2, dev))) {
> -		dev->irq = 11;
> -		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
> -		pci_dev_put(dev);
> +			if (PCI_FUNC(dev->devfn))
> +				dev->irq = 11;
> +			else
> +				dev->irq = 10;
> +			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
> +		default:
> +			break;
> +		}
>  	}
> -
> -	/* Now map all the PCI irqs */
> -	dev = NULL;
> -	for_each_pci_dev(dev)
> -		pci_read_irq_line(dev);
>  }
>  
>  #ifdef CONFIG_PPC_I8259
> @@ -259,7 +251,7 @@ static void __init mpc85xx_cds_setup_arch(void)
>  	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
>  		add_bridge(np);
>  
> -	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
> +	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
>  	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
>  #endif
>  }

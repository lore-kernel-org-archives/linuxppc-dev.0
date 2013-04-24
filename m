Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F2382C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 06:49:53 +1000 (EST)
Message-ID: <1366836580.2869.16.camel@pasglop>
Subject: Re: [PATCH 4/7] powerpc/powernv: Patch MSI EOI handler on P8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 06:49:40 +1000
In-Reply-To: <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366796259-29412-5-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-24 at 17:37 +0800, Gavin Shan wrote:
> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
> steps to handle the P/Q bits in IVE before EOIing the corresponding
> interrupt. The patch changes the EOI handler to cover that.

 .../...

>  static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>  {
>  	unsigned int count;
> @@ -667,6 +681,8 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>  	}
>  
>  	phb->msi_setup = pnv_pci_ioda_msi_setup;
> +	if (phb->type == PNV_PHB_IODA2)
> +		phb->msi_eoi = pnv_pci_ioda_msi_eoi;

Ouch, another function pointer call in a hot path...

>  	phb->msi32_support = 1;
>  	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
>  		count, phb->msi_base);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index a11b5a6..ea6a93d 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -115,6 +115,25 @@ static void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>  		irq_dispose_mapping(entry->irq);
>  	}
>  }
> +
> +int pnv_pci_msi_eoi(unsigned int hw_irq)
> +{
> +	struct pci_controller *hose, *tmp;
> +	struct pnv_phb *phb = NULL;
> +
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +		phb = hose->private_data;
> +		if (hw_irq >= phb->msi_base &&
> +		    hw_irq < phb->msi_base + phb->msi_bmp.irq_count) {
> +			if (!phb->msi_eoi)
> +				return -EEXIST;
> +			return phb->msi_eoi(phb, hw_irq);
> +		}
> +	}
> +
> +	/* For LSI interrupts, we needn't do it */
> +	return 0;
> +}

And a list walk ... that's not right.

Also, you do it for all XICS interrupts, including the non-PCI ones, the
LSIs, etc... only to figure out that some might not be MSIs later in
the loop.

Why not instead look at changing the irq_chip for the MSIs ?

IE. When setting up the MSIs for IODA2, use a different irq_chip which
is a copy of the original one with a different ->eoi callback, which
does the original xics eoi and then the OPAL stuff ?

You might even be able to use something like container_of to get back
to the struct phb, no need to iterate them all.

Cheers,
Ben.

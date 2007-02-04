Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66067DDE45
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 10:53:57 +1100 (EST)
Subject: Re: [PATCH] [7/9] pasemi: Configure DMA controller interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070202045509.170129000@lixom.net>>
References: <20070202045448.145851000@lixom.net> >
	<20070202045509.170129000@lixom.net>>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:53:49 +1100
Message-Id: <1170633229.2620.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-01 at 22:54 -0600, Olof Johansson wrote:
> plain text document attachment (pasemi-dma-irqs)
> The DMA controller on PWRficient is somewhat special -- has a PCI header
> so it looks like it's on the root PCI (-Express) root bus, but it uses
> more than the default number of interrupts (and they are hardwired).
> 
> We need to wire up all interrupts for the DMA controller. The generic
> IRQ code will only map the primary interrupt from the PCI header (128),
> so add 129->211 by hand.

Or you can have them in the device-tree ... the generic code only maps
PCI IRQ index 0 but nothing prevents your fixup code to map the other
ones.

However, I do wonder what is the point of creating a mapping and nor
storing the resulting virq anywhere ? When are those IRQs actually
used ?

That is the place where the mapping should happen... There is no
guarantee that the resulting virq from irq_create_mapping() will be the
same as the HW irq you passed in (it will in -most- cases with the
current code, but it's a bug to rely on that behaviour). Thus you should
store the result of irq_create_mapping() and use that. I see no
advantage in "pre-mapping" things that way.

Ben.
 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Index: merge/arch/powerpc/platforms/pasemi/pci.c
> ===================================================================
> --- merge.orig/arch/powerpc/platforms/pasemi/pci.c
> +++ merge/arch/powerpc/platforms/pasemi/pci.c
> @@ -163,6 +163,19 @@ static void __init pas_fixup_phb_resourc
>  }
>  
> 
> +void __devinit pas_pci_irq_fixup(struct pci_dev *dev)
> +{
> +	/* DMA is special, 84 interrupts (128 -> 211), all but 128
> +	 * need to be mapped by hand here.
> +	 */
> +	if (dev->vendor == 0x1959 && dev->device == 0xa007) {
> +		int i;
> +		for (i = 129; i < 212; i++)
> +			irq_create_mapping(NULL, i);
> +	}
> +}
> +
> +
>  void __init pas_pci_init(void)
>  {
>  	struct device_node *np, *root;
> Index: merge/arch/powerpc/platforms/pasemi/setup.c
> ===================================================================
> --- merge.orig/arch/powerpc/platforms/pasemi/setup.c
> +++ merge/arch/powerpc/platforms/pasemi/setup.c
> @@ -242,4 +242,5 @@ define_machine(pas) {
>  	.check_legacy_ioport    = pas_check_legacy_ioport,
>  	.progress		= pas_progress,
>  	.machine_check_exception = pas_machine_check_handler,
> +	.pci_irq_fixup		= pas_pci_irq_fixup,
>  };
> Index: merge/arch/powerpc/platforms/pasemi/pasemi.h
> ===================================================================
> --- merge.orig/arch/powerpc/platforms/pasemi/pasemi.h
> +++ merge/arch/powerpc/platforms/pasemi/pasemi.h
> @@ -3,6 +3,7 @@
>  
>  extern unsigned long pas_get_boot_time(void);
>  extern void pas_pci_init(void);
> +extern void __devinit pas_pci_irq_fixup(struct pci_dev *dev);
>  
>  extern void __init pasemi_idle_init(void);
>  
> 
> --
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

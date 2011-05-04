Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14348B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 16:07:45 +1000 (EST)
Subject: Re: [PATCH 1/3]  [PATCH 1/3]powerpc/eeh: Propagate needs_freset
	flag to device at PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
In-Reply-To: <4DB1DE33.5030206@linux.vnet.ibm.com>
References: <4DB1DE33.5030206@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 16:07:34 +1000
Message-ID: <1304489254.2513.356.camel@pasglop>
Mime-Version: 1.0
Cc: antonb@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-04-22 at 12:59 -0700, Richard A Lary wrote:
> From: Richard A Lary <rlary@linux.vnet.ibm.com>
> 
>   For multifunction adapters with a PCI bridge or switch as the device
>   at the Partitionable Endpoint(PE), if one or more devices below PE
>   sets dev->needs_freset, that value will be set for the PE device.
> 
>   In other words, if any device below PE requires a fundamental reset
>   the PE will request a fundamental reset.
> 
> Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
> ---

This patch and the next one didn't apply cleanly for some reason.

I've hand applied both and will push to -next in a few minutes, please
let me know if it's all correct.

The third one, I gave up as I was running out of time, please re-post a
version that applies on top of powerpc-next.

Cheers,
Ben.

>   arch/powerpc/platforms/pseries/eeh.c |   48 	42 +	6 -	0 !
>   1 file changed, 42 insertions(+), 6 deletions(-)
> 
> Index: b/arch/powerpc/platforms/pseries/eeh.c
> ===================================================================
> --- a/arch/powerpc/platforms/pseries/eeh.c
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -448,6 +448,39 @@ void eeh_clear_slot (struct device_node
>   	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
>   }
> 
> +void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
> +{
> +	struct device_node *dn;
> +
> +	for_each_child_of_node(parent, dn) {
> +		if (PCI_DN(dn)) {
> +
> +			struct pci_dev *dev = PCI_DN(dn)->pcidev;
> +
> +			if (dev && dev->driver)
> +				*freset |= dev->needs_freset;
> +
> +			__eeh_set_pe_freset(dn, freset);
> +		}
> +	}
> +}
> +
> +void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
> +{
> +	struct pci_dev *dev;
> +	dn = find_device_pe(dn);
> +
> +	/* Back up one, since config addrs might be shared */
> +	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
> +		dn = dn->parent;
> +
> +	dev = PCI_DN(dn)->pcidev;
> +	if (dev)
> +		*freset |= dev->needs_freset;
> +
> +	__eeh_set_pe_freset(dn, freset);
> +}
> +
>   /**
>    * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
>    * @dn device node
> @@ -736,18 +769,21 @@ int pcibios_set_pcie_reset_state(struct
>   /**
>    * rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
>    * @pdn: pci device node to be reset.
> - *
> - *  Return 0 if success, else a non-zero value.
>    */
> 
>   static void __rtas_set_slot_reset(struct pci_dn *pdn)
>   {
> -	struct pci_dev *dev = pdn->pcidev;
> +	unsigned int freset = 0;
> 
> -	/* Determine type of EEH reset required by device,
> -	 * default hot reset or fundamental reset
> +	/* Determine type of EEH reset required for
> +	 * Partitionable Endpoint, a hot-reset (1)
> +	 * or a fundamental reset (3).
> +	 * A fundamental reset required by any device under
> +	 * Partitionable Endpoint trumps hot-reset.
>   	 */
> -	if (dev && dev->needs_freset)
> +	eeh_set_pe_freset(pdn->node, &freset);
> +
> +	if (freset)
>   		rtas_pci_slot_reset(pdn, 3);
>   	else
>   		rtas_pci_slot_reset(pdn, 1);

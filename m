Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EED36DE0E1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 07:37:45 +1100 (EST)
Subject: Re: [PATCH] Restore PCI IO space behind Freescale pseudo-bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
In-Reply-To: <200901141948.n0EJmXH3002897@pogo.cesa.opbu.xerox.com>
References: <200901141948.n0EJmXH3002897@pogo.cesa.opbu.xerox.com>
Content-Type: text/plain
Date: Thu, 15 Jan 2009 07:37:34 +1100
Message-Id: <1231965454.22571.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-14 at 11:48 -0800, Andrew Klossner wrote:
> When I moved from 2.6.27 to 2.6.28, one of my devices didn't work
> until I devised the attached patch.  The kernel disallowed PCI I/O
> space resources behind the pseudo-bridge in the Freescale MPC8545
> because that bridge's config-space registers incorrectly report that
> it doesn't forward I/O space transactions.
> 
> Checking for a specific vendor ID is hacky, but it got my system going
> again with only a few perturbed lines.  Is there a more correct way to
> achieve this?

A few things yes.

First, can't you just set the PCI_COMMAND_IO bit from a quirk or at init
time rather than adding to code to cope with it being cleared later on ?

Also, the fact that it's detected as uninitialized shouldn't have broken
access to your device. If there is need for some IO space, for example
because a device requests some, the kernel should have re-opened that
window of the bridge.

Thus if that failed, it would be useful to track it down a bit more. You
can try enabling DEBUG in pci-common.c and pci-64.c, boot with "debug"
on the kernel command line and and send the resulting dmesg log

Ben.

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index f36936d..f9f0048 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -985,6 +985,7 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
>  	struct pci_dev *dev = bus->self;
>  	resource_size_t offset;
>  	u16 command;
> +	u16 vendor;
>  	int i;
>  
>  	/* We don't do anything if PCI_PROBE_ONLY is set */
> @@ -1030,7 +1031,16 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
>  		 * starting at low addresses -is- valid. What we do instead if that
>  		 * we consider as unassigned anything that doesn't have IO enabled
>  		 * in the PCI command register, and that's it.
> +		 * However, we don't do that if the bridge is internal to a Freescale
> +		 * CPU, as such bridges break the rules by, for example, not populating
> +		 * the PCI_COMMAND_IO bit.
>  		 */
> +		pci_read_config_word(dev, PCI_VENDOR_ID, &vendor);
> +		if (vendor == PCI_VENDOR_ID_MOTOROLA ||
> +		    vendor == PCI_VENDOR_ID_FREESCALE) {
> +			return 0;
> +		}
> +
>  		pci_read_config_word(dev, PCI_COMMAND, &command);
>  		if (command & PCI_COMMAND_IO)
>  			return 0;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

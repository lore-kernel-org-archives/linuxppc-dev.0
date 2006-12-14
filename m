Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A088767BC8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 15:54:20 +1100 (EST)
Subject: Re: [PATCH 11/19] powerpc: Supporting PCI bus and base of I/O for
	Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612140238.kBE2cFeU021258@toshiba.co.jp>
References: <200612140238.kBE2cFeU021258@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 15:54:13 +1100
Message-Id: <1166072053.11914.278.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-12-14 at 11:38 +0900, Ishizaki Kou wrote:
> This patch includes support for pci buses, base of Celleb specific
> devices, and etc. It works on of_platform bus.

There is still a few serious issues unfortunately with that PCI code...

> +static int celleb_epci_subordinate_read_config(struct pci_controller *hose,
> +					       int bus, unsigned int devfn,
> +					       int where, int size, u32 *val)
> +{
> +	unsigned long addr;
> +
> +	if (!hose->cfg_data)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (where == PCI_INTERRUPT_LINE) {
> +		struct celleb_epci_private *private = hose->private_data;
> +		if (private == NULL)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		*val = irq_create_mapping(NULL, private->epci_ext_irq);
> +		return PCIBIOS_SUCCESSFUL;
> +	} else if (where == PCI_INTERRUPT_PIN) {
> +		*val = 1;
> +		return PCIBIOS_SUCCESSFUL;
> +	}

Why the above ? You have 3 copies of the code here that does the IRQ
mapping inside of read_config, and I don't see this making any sense.

The IRQ mapping should be in the device-tree, in the form of an
interrupt-map property, or at -worse- as a fixup pass to setup
pci_dev->irq in ppc_md, not some weird code in the config space. Nobody
actually cares what is in PCI_INTERRUPT_LINE of a PCI device in fact.
 
> +	clear_and_disable_master_abort_interrupt(hose);
> +
> +	/* address for PCI configuration access */
> +	addr = (unsigned long)hose->cfg_data +
> +		(((bus & 0xff) << 16)
> +		 | ((devfn & 0xff) << 8)
> +		 | (where & 0xff)
> +		 | 0x01000000);
> +
> +	switch (size) {
> +	case 1:
> +		*val = in_8((u8 *)addr);
> +		break;
> +	case 2:
> +		*val = in_le16((u16 *)addr);
> +		break;
> +	case 4:
> +		*val = in_le32((u32 *)addr);
> +		break;
> +	default:
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return celleb_epci_check_abort(hose, 0);
> +}

The above code is duplicated several times (+/- endian) and I don't see
why. You definitely do not need special functions that are 90% duplicate
to handle wether you are doing a type 0 or type 1 config access :-) Best
is you look at how other platforms do it, it's mostly a single if in the
first few lines of the function to calculate the cfg address.

The host bridge case must stay separate due to different endian, though
it should still shrink the size of the code significantly by moving the
IRQ bits elsewhere.

> +int __devinit celleb_setup_epci(struct device_node *node,
> +				struct pci_controller *hose)
> +{
> +	const unsigned long *li, *li2;
> +	unsigned int rlen;
> +	struct celleb_epci_private *private;
> +
> +
> +	pr_debug("PCI: celleb_setup_epci()\n");
> +
> +	li = get_property(node, "toshiba,reg", &rlen);

Why that ? Why not use a normal "reg" property with proper ranges etc...
in the device tree, and then here, use the standard
of_address_to_resource() or similar ?

We are getting critical short on time for the 2.6.20 merge window
unfortunately. I hope we might still be able to get in, though I can't
guarantee it at this point.

Cheers,
Ben.

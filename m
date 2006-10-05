Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0422767E40
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 04:45:18 +1000 (EST)
In-Reply-To: <1160024098.22232.13.camel@localhost.localdomain>
References: <1160024098.22232.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B8F6C29-A29A-4084-B9AB-9BCC9A1A4038@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: make U4 PCIe work
Date: Thu, 5 Oct 2006 20:45:00 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

> +        if (bus == hose->first_busno) {
> +                caddr = U4_PCIE_CFA0(dev_fn, offset);
> +        } else
> +                caddr = U4_PCIE_CFA1(bus, dev_fn, offset);

Please fold CFA0 and CFA1 into one inline function, much
cleaner.

You also should check (at init time) whether indirect config
access mode is actually enabled -- or just enable it yourself.

> +        /* Uninorth will return garbage if we don't read back the  
> value ! */
> +        do {
> +                out_le32(hose->cfg_addr, caddr);
> +        } while (in_le32(hose->cfg_addr) != caddr);

Not an issue on U4, kill this.

> +static int u4_pcie_read_config(struct pci_bus *bus, unsigned int  
> devfn,
> +                               int offset, int len, u32 *val)
> +{
> +        struct pci_controller *hose;
> +        volatile void __iomem *addr;
> +
> +        hose = pci_bus_to_host(bus);
> +        if (hose == NULL)
> +                return PCIBIOS_DEVICE_NOT_FOUND;

Is this check needed?  Can this code ever be called if hose would
be 0?  The variable isn't actually used anywhere else in this
function either.

> +        struct pci_controller *hose;
> +        volatile void __iomem *addr;

No need for the volatile, the inXX()/outXX() things should handle
this just fine.

> +        /* The bus contains a bridge from root -> device, we need to
> +         * make it visible on bus 0 so that we pick the right type
> +         * of config cycles. If we didn't, we would have to force all
> +         * config cycles to be type 1. So we override the "bus-range"
> +         * property here
> +         */
> +        hose->first_busno = 0x00;
> +        hose->last_busno = 0xff;

I don't understand the comment, nor the need for this code.  Is this
just old garbage ported over from PowerMac?

> +	for_each_pci_dev(dev) {
> +		/* Fixup IRQ for PCIe host */
> +		if (u4_pcie != NULL && dev->bus->number == 0 &&
> +		    pci_bus_to_host(dev->bus) == u4_pcie) {
> +			printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
> +			dev->irq = irq_create_mapping(NULL, 1);
> +			if (dev->irq != NO_IRQ)
> +				set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);

Please do this in the platform code for boards that actually need
it, by fixing up the interrupt tree in the device tree.  MPIC IRQ1
is the PCIe error interrupt only btw, I wonder if this code does
the right thing at all?

> +        /*
> +         * We need to call pci_setup_phb_io for the HT bridge first
> +         * so it gets the I/O port numbers starting at 0, and we
> +         * need to call it for the AGP bridge after that so it gets
> +         * small positive I/O port numbers.
> +         */

Comment out of date (doesn't mention PCIe).  Oh and when do we
finally get real PCI domain support ;-)

> +	if (!machine_is(maple))
> +		return;

So the IDE wart fixup is now only executed on "real" Maples?  Or
all 970-based non-Apple boxes?  The naming starts to be confusing,
maybe the maple platform should be en-masse renamed to "ppc970" or
such.


Segher

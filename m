Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92FE167E40
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 08:27:06 +1000 (EST)
Subject: Re: [PATCH] powerpc: make U4 PCIe work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <0B8F6C29-A29A-4084-B9AB-9BCC9A1A4038@kernel.crashing.org>
References: <1160024098.22232.13.camel@localhost.localdomain>
	<0B8F6C29-A29A-4084-B9AB-9BCC9A1A4038@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 08:26:53 +1000
Message-Id: <1160087213.22232.76.camel@localhost.localdomain>
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

On Thu, 2006-10-05 at 20:45 +0200, Segher Boessenkool wrote:
> > +        if (bus == hose->first_busno) {
> > +                caddr = U4_PCIE_CFA0(dev_fn, offset);
> > +        } else
> > +                caddr = U4_PCIE_CFA1(bus, dev_fn, offset);
> 
> Please fold CFA0 and CFA1 into one inline function, much
> cleaner.

I like it this way. That's how PowerMac does it too btw.

> You also should check (at init time) whether indirect config
> access mode is actually enabled -- or just enable it yourself.

Care to send a patch ?

> > +        /* Uninorth will return garbage if we don't read back the  
> > value ! */
> > +        do {
> > +                out_le32(hose->cfg_addr, caddr);
> > +        } while (in_le32(hose->cfg_addr) != caddr);
> 
> Not an issue on U4, kill this.

I'd rather keep it for now. A matter of testing. It's harmless anyway.
Not like config space accesses had to be fast...

> > +static int u4_pcie_read_config(struct pci_bus *bus, unsigned int  
> > devfn,
> > +                               int offset, int len, u32 *val)
> > +{
> > +        struct pci_controller *hose;
> > +        volatile void __iomem *addr;
> > +
> > +        hose = pci_bus_to_host(bus);
> > +        if (hose == NULL)
> > +                return PCIBIOS_DEVICE_NOT_FOUND;
> 
> Is this check needed?  Can this code ever be called if hose would
> be 0?  The variable isn't actually used anywhere else in this
> function either.

What are you talking about ? Of course hose is used.

> > +        struct pci_controller *hose;
> > +        volatile void __iomem *addr;
> 
> No need for the volatile, the inXX()/outXX() things should handle
> this just fine.

They can. Are you commenting just for the sake of it or what ? Feel free
to send a patch removing it in all them in all the pci accessors, we'd
hade those for ages.

> > +        /* The bus contains a bridge from root -> device, we need to
> > +         * make it visible on bus 0 so that we pick the right type
> > +         * of config cycles. If we didn't, we would have to force all
> > +         * config cycles to be type 1. So we override the "bus-range"
> > +         * property here
> > +         */
> > +        hose->first_busno = 0x00;
> > +        hose->last_busno = 0xff;
> 
> I don't understand the comment, nor the need for this code.  Is this
> just old garbage ported over from PowerMac?

It comes over from PowerMac indeed, wrong bus-range property there. It
doesn't harm to have it here, I'm not sure what PIBS puts in there.

> > +	for_each_pci_dev(dev) {
> > +		/* Fixup IRQ for PCIe host */
> > +		if (u4_pcie != NULL && dev->bus->number == 0 &&
> > +		    pci_bus_to_host(dev->bus) == u4_pcie) {
> > +			printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
> > +			dev->irq = irq_create_mapping(NULL, 1);
> > +			if (dev->irq != NO_IRQ)
> > +				set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
> 
> Please do this in the platform code for boards that actually need
> it, by fixing up the interrupt tree in the device tree.  MPIC IRQ1
> is the PCIe error interrupt only btw, I wonder if this code does
> the right thing at all?

Well, this is the platform code for boards based on U3/U4, so what ? No
OF tree I've seen so far can provide the irq for the host bridge because
none has a node for it (or rather for the p2p bridge that is visible
below attu). If yours is different, then feel free to send me a
device-tree (that I've asked from you how many monthes ago ?). This is
Maple board support, I'm adding code for Maple/Tigerwood.

It's the right interrupt to use with the PCIe port driver.

> > +        /*
> > +         * We need to call pci_setup_phb_io for the HT bridge first
> > +         * so it gets the I/O port numbers starting at 0, and we
> > +         * need to call it for the AGP bridge after that so it gets
> > +         * small positive I/O port numbers.
> > +         */
> 
> Comment out of date (doesn't mention PCIe).  Oh and when do we
> finally get real PCI domain support ;-)

Comment a bit out of date but the principle is still there, I want PCIe
to get the same non-overlapping bus numbers as AGP did for various
resaons (one is to have X work).
 
> > +	if (!machine_is(maple))
> > +		return;
> 
> So the IDE wart fixup is now only executed on "real" Maples?  Or
> all 970-based non-Apple boxes?  The naming starts to be confusing,
> maybe the maple platform should be en-masse renamed to "ppc970" or
> such.

The whole platform is called maple so what ? We just make sure we don't
call the code below when booting on pseries or whatever else.

At this point, the patch should go in as it is.

Ben.

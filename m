Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BF01567B57
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 08:10:58 +1000 (EST)
Date: Tue, 5 Sep 2006 17:10:13 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Message-ID: <20060905171013.734fa390@localhost.localdomain>
In-Reply-To: <1157491909.22705.143.camel@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122853.4da8d0fe@localhost.localdomain>
	<1157491909.22705.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 06 Sep 2006 07:31:49 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Overall, looks good, some bits  tho:

Thanks! See below.


> 
> > +static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
> > +			      int offset, int len, u32 *val)
> > +{
> > +	struct pci_controller *hose;
> > +	unsigned long addr;
> 
>  .../...
> 
> You don't seem to encode support for extended config space (offsets >
> 256). If it's PCIe, you should have it (flush the 4 top bits of the
> offste in the 4 top bits of the cfg address in general). In any case,
> you should check the passed-in offset and error out if it is above your
> max offset (256 or 4096 depending if you implement extended config space
> support) or the kernel might get confused.

I'll take a look at this, thanks for pointing it out.

> > +	of_prop = alloc_bootmem(sizeof(struct property) +
> > +				sizeof(hose->global_number));
> > +	if (of_prop) {
> > +		memset(of_prop, 0, sizeof(struct property));
> > +		of_prop->name = "linux,pci-domain";
> > +		of_prop->length = sizeof(hose->global_number);
> > +		of_prop->value = (unsigned char *)&of_prop[1];
> > +		memcpy(of_prop->value, &hose->global_number, sizeof(hose->global_number));
> > +		prom_add_property(dev, of_prop);
> > +	}
> 
> Just kill that... nobody cares about that property.

Done

> > +	if (device_is_compatible(dev, "pa-pxp"))
> > +		setup_pa_pxp(hose);
> 
> And if not ? You have a non-initialized hose without config space access
> methods ? Hrm... 

True. Just a leftover from forking off the maple setup code.

> > +	printk(KERN_INFO "Found PA-PXP PCI host bridge. Firmware bus number: %d->%d\n",
> > +		hose->first_busno, hose->last_busno);
> > +
> > +	/* Interpret the "ranges" property */
> > +	/* This also maps the I/O region and sets isa_io/mem_base */
> > +	pci_process_bridge_OF_ranges(hose, dev, 1);
> > +	pci_setup_phb_io(hose, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +void __init pas_pcibios_fixup(void)
> > +{
> > +	struct pci_dev *dev = NULL;
> > +
> > +	for_each_pci_dev(dev)
> > +		pci_read_irq_line(dev);
> > +}
> > +
> > +static void __init pas_fixup_phb_resources(void)
> > +{
> > +	struct pci_controller *hose, *tmp;
> > +
> > +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> > +		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
> > +		hose->io_resource.start += offset;
> > +		hose->io_resource.end += offset;
> > +		printk(KERN_INFO "PCI Host %d, io start: %lx; io end: %lx\n",
> > +		       hose->global_number,
> > +		       hose->io_resource.start, hose->io_resource.end);
> > +	}
> > +}
> 
> There is no generic code for the above ? (I have to double check). If
> not, we shall fix that ;)

Didn't see anything, but then I didn't look that long. I'll follow up with a 
separate patch if it doesn't exist, since other platforms can use it too.

>
> > +#ifdef CONFIG_SMP
> > +struct smp_ops_t pas_smp_ops = {
> > +	.probe		= smp_mpic_probe,
> > +	.message_pass	= smp_mpic_message_pass,
> > +	.kick_cpu	= smp_generic_kick_cpu,
> > +	.setup_cpu	= smp_mpic_setup_cpu,
> > +	.give_timebase	= smp_generic_give_timebase,
> > +	.take_timebase	= smp_generic_take_timebase,
> > +};
> 
> You don't have a HW timebase sync facility ? Is this the board or the
> processor doesn't have a pin to freeze the timebase ? Either way, that
> is bad ! Time to use the cluebat !

See comment to Arnd in another email: We have hardware support for it, just 
not including it at this time.

> 
> > +#endif /* CONFIG_SMP */
> > +
> > +void __init pas_setup_arch(void)
> > +{
> > +	/* init to some ~sane value until calibrate_delay() runs */
> > +	loops_per_jiffy = 50000000;
> 
> That value still makes any sense with the new tb based delays ? I know
> we still have it here or there, I'm wondering tho...

I haven't tried doing without it, I'll take a look.


-Olof

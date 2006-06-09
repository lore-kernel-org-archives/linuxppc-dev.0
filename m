Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE2C967B23
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 08:07:40 +1000 (EST)
Subject: Re: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FojK9-0004AD-DN@jdl.com>
References: <1149803821.23938.278.camel@cashmere.sps.mot.com>
	<1149826559.12687.41.camel@localhost.localdomain>
	<E1FojK9-0004AD-DN@jdl.com>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 08:07:22 +1000
Message-Id: <1149890843.12687.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Cascade handling is changing with my genirq port. It will be easy to
> > adapt though. Same comments howveer, you should have a device-tree node
> > for the 8259 (under an ISA bridge, those shall really be in the
> > device-tree). In general, on-board bridges should be in the device-tree,
> > only slots or standardly routed child PCI devices need not.
> 
> Can you send me an example?

I'll try to dig something. Power3 at least has MPIC<->8259 cascade, as
do some IBM blades when running bare metal kernels.

> > The above looks dodgy... powerpc uses the timebase frequency for delays
> > anyway, lpj will be initialized by the bogomips code, and should but
> > unused mostly nowadays anyway.
> 
> Uh, you want I should rip it out, boss? :-)

Well, in any case it's bogus... your loops_per_jiffies is generally not
your processor frequency... I might be close on some CPUs and not on
others (it was double of it on early G4s for example), it may also
depend if things like BTIC are enabled.

I think you may just rip that out. Just check it doesn't break
anything :)

> > > +#ifdef CONFIG_PEX
> > > +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> > > +		add_bridge(np);
> > > +
> > > +	ppc_md.pci_swizzle = common_swizzle;
> > > +	ppc_md.pci_map_irq = mpc86xx_map_irq;
> > > +	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
> > > +#endif
> > 
> > I'm not sure I like this CONFIG_PEX (in general). Just use CONFIG_PCI
> > for now all over the place. PCI-E has it's own binding that we don't
> > quite respect yet but will do and all of that will be in the
> > device-tree. However, as far as the kernel is concerned, this is all
> > under CONFIG_PCI.
> 
> But I think we are looking for independent PCI/PCI-E options
> to be independently configurable still...?

Well, if you want to separately configure a given PCI-E bridge, then do
a CONFIG_MPC86xx_PCIE or something like that, but in general, PCI-E
support _is_ the same as PCI support as far as the kernel is concerned.
 
> > > +#ifdef CONFIG_SMP
> > > +  	/* Release Core 1 in boot holdoff */
> > > +	mcm_paddr = get_immrbase() + MPC86xx_MCM_OFFSET;
> > > +	mcm_vaddr = ioremap(mcm_paddr, MPC86xx_MCM_SIZE);
> > > +
> > > +	vaddr = (unsigned long)mcm_vaddr +  MCM_PORT_CONFIG_OFFSET;
> > > +	out_be32((volatile unsigned *)vaddr, CPU_ALL_RELEASED);
> > > +	smp_ops = &smp_8641_ops;
> > > +#endif
> > > +}
> > 
> > Instead of ifdef's, just do a mpc86xx_smp_init() and put it somewhere
> > with the other SMP things in the file that contains them (and remove the
> > #ifdef's there too, just only build the file if CONFIG_SMP is set).
> 
> OK, I catch your drift, but if the file is missing and
> there is a hard call to  mpc86xx_smp_init() here, how is
> that resolved?  Is mpc86xx_smp_init #defined empty when
> compiled non-SMP then?  Like in the header file:
> 
>     #ifndef CONFIG_SMP
>         #define mpc86xx_smp_init()
>     #endif

Well, you could keep a #ifdef around the call, or you can define it as a
weak empty function

> > > +void
> > > +mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
> > > +{
> > > +	uint pvid, svid, phid1;
> > > +	uint memsize = total_memory;
> > > +
> > > +	pvid = mfspr(SPRN_PVR);
> > > +	svid = mfspr(SPRN_SVR);
> > >
> > > +	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> > > +	seq_printf(m, "Machine\t\t: MPC86xx HPCN Board\n");
> > > +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> > > +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> > 
> > The PVR is probably a duplicate and the SVR should be added to per-cpu
> > info instead.
> 
> I confess, I am not sure what you mean here.  Could you
> clarify this a bit for me, or point to an example perhaps?

Well, the generic cpuinfo code already displays the PVR for each CPU and
you have a per-cpu hook you can use to display the SVR.

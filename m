Return-Path: <jdl@jdl.com>
Received: from jdl.com (mail.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED0AA67C03
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 01:55:08 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files. 
In-Reply-To: Your message of "Fri, 09 Jun 2006 14:15:58 +1000."
	<1149826559.12687.41.camel@localhost.localdomain>
References: <1149803821.23938.278.camel@cashmere.sps.mot.com>
	<1149826559.12687.41.camel@localhost.localdomain>
Date: Fri, 09 Jun 2006 10:55:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FojK9-0004AD-DN@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> On Thu, 2006-06-08 at 16:57 -0500, Jon Loeliger wrote:
> 
> > +void
> > +mpc86xx_restart(char *cmd)
> > +{
> > +	void __iomem *rstcr;
> > +
> > +	local_irq_disable();
> > +
> > +	/* Assert reset request to Reset Control Register */
> > +	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
> > +	out_be32(rstcr, 0x2);
> > +
> > +	/* not reached */
> > +}
> 
> ioremap with irq disabled isn't great....  You should do the ioremap
> once at boot.

OK.  Would this be acceptable instead:

    mpc86xx_restart(char *cmd)
    {
	void __iomem *rstcr;

	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);

	local_irq_disable();

	/* Assert reset request to Reset Control Register */
	out_be32(rstcr, 0x2);
	/* not reached */
    }


> Overall, that file is too small :) Move those into your setup.c and make
> those static...

Will do.

> [SMP code snipped]
>
> This file could/should be called *_smp.c and not need #ifdef's :)

OK.


> Most of the values above should probably be retreived from the
> device-tree.

I'll see what I can remove.  Some of the PCI/PCI-e bits
_will_ be device tree derived, but just not quite there yet...
It's just not going to be a perfect first patch;  there
will have to be incremental development in that direction.

> As I suggested before, the 2 above should be static in your setup file.

Right.

> > +extern int __init add_bridge(struct device_node *dev);
> 
> Aren't we exposing that already via some header ?

Perhaps.  I'll look around for it.

> > +extern void __init setup_indirect_pex_nomap(struct pci_controller* hose,
> > +					    void __iomem * cfg_addr,
> > +					    void __iomem * cfg_data);
> > +
> > +extern struct smp_ops_t smp_8641_ops;
> 
> See my comments about the PCI stuff with the PCI patch.

and...

> All of the above should of course come from the device-tree. 2.6.18 will
> have the support for having interrupt routing from it without having
> nodes for all devices. I'll post it to the list in a week or so, I'm
> coding right now :)

Right.  We're not quite entirely able to convert it
all to device tree yet.  Working on it still...

> > +	phys_addr_t OpenPIC_PAddr;
> > +
> > +	/* Determine the Physical Address of the OpenPIC regs */
> > +	OpenPIC_PAddr = get_immrbase() + MPC86xx_OPENPIC_OFFSET;
> 
> Do you really _need_ studly caps ? I know we did that before but you
> don't have to copy ugly stuff :)

Uh, sorry.  No problem.

> In general, you -need- a device node for the interrupt controller. It
> will be made mandatory by the new code.

I know.  There is a fully defined node for that in my
device tree already.

> You'll have to provide proper
> interrupt informations in your device-tree (it's easy, really).

It's there.

> If you get that right, it will be very easy to "just work" with my new
> code.

I'll send that to the list too for reference
just to make sure we are in sync here.

> > +	/* Alloc mpic structure and per isu has 16 INT entries. */
> > +	mpic1 = mpic_alloc(OpenPIC_PAddr,
> > +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> > +			16, MPC86xx_OPENPIC_IRQ_OFFSET, 0, 250,
> > +			mpc86xx_hpcn_openpic_initsenses,
> > +			sizeof(mpc86xx_hpcn_openpic_initsenses),
> > +			" MPIC     ");
> > +	BUG_ON(mpic1 == NULL);
> > +
> > +	/* 48 Internal Interrupts */
> > +	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
> > +	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10400);
> > +	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10600);
> 
> I haven't looked in detail at your memory map, but do you need separate
> ISUs ? They seem to be quite close together to me... Also, you should
> invent properties in the mpic node for some of those things, like
> big-endian (like apple does) indicating it's a big endian openpic,
> etc... If you manage to get close enough to spec & common usage, you
> might not even need your own init function at all in the future.

OK.  We'll work in that direction, but incrementally.

> > +	/* 16 External interrupts */
> > +	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10000);
> 
> That looks like you used ISUs in order to "re-order" them... why ?

Heck if I know.  We'll have to ask around some here... :-)

> > +#ifdef CONFIG_PEX
> > +	mpic_setup_cascade(MPC86xx_IRQ_EXT9, i8259_irq_cascade, NULL);
> > +	i8259_init(0, I8259_OFFSET);
> > +#endif
> > +}
> 
> Cascade handling is changing with my genirq port. It will be easy to
> adapt though. Same comments howveer, you should have a device-tree node
> for the 8259 (under an ISA bridge, those shall really be in the
> device-tree). In general, on-board bridges should be in the device-tree,
> only slots or standardly routed child PCI devices need not.

Can you send me an example?

> 
> All of the above shall be in the device-tree.

Yes, eventually.  But not yet...  We're working on
this with other folks like Kumar, and Monta Vista,
and other folks.

> > +static void __init
> > +mpc86xx_hpcn_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +
> > +#ifdef CONFIG_SMP
> > +	phys_addr_t mcm_paddr;
> > +	void *mcm_vaddr = NULL;
> > +	unsigned long vaddr;
> > +#endif
> > +
> > +	if (ppc_md.progress)
> > +		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
> > +
> > +	np = of_find_node_by_type(NULL, "cpu");
> > +	if (np != 0) {
> > +		unsigned int *fp;
> > +
> > +		fp = (int *)get_property(np, "clock-frequency", NULL);
> > +		if (fp != 0)
> > +			loops_per_jiffy = *fp / HZ;
> > +		else
> > +			loops_per_jiffy = 50000000 / HZ;
> > +		of_node_put(np);
> > +	}
> 
> The above looks dodgy... powerpc uses the timebase frequency for delays
> anyway, lpj will be initialized by the bogomips code, and should but
> unused mostly nowadays anyway.

Uh, you want I should rip it out, boss? :-)

> > +#ifdef CONFIG_PEX
> > +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> > +		add_bridge(np);
> > +
> > +	ppc_md.pci_swizzle = common_swizzle;
> > +	ppc_md.pci_map_irq = mpc86xx_map_irq;
> > +	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
> > +#endif
> 
> I'm not sure I like this CONFIG_PEX (in general). Just use CONFIG_PCI
> for now all over the place. PCI-E has it's own binding that we don't
> quite respect yet but will do and all of that will be in the
> device-tree. However, as far as the kernel is concerned, this is all
> under CONFIG_PCI.

But I think we are looking for independent PCI/PCI-E options
to be independently configurable still...?

> > +#ifdef CONFIG_SMP
> > +  	/* Release Core 1 in boot holdoff */
> > +	mcm_paddr = get_immrbase() + MPC86xx_MCM_OFFSET;
> > +	mcm_vaddr = ioremap(mcm_paddr, MPC86xx_MCM_SIZE);
> > +
> > +	vaddr = (unsigned long)mcm_vaddr +  MCM_PORT_CONFIG_OFFSET;
> > +	out_be32((volatile unsigned *)vaddr, CPU_ALL_RELEASED);
> > +	smp_ops = &smp_8641_ops;
> > +#endif
> > +}
> 
> Instead of ifdef's, just do a mpc86xx_smp_init() and put it somewhere
> with the other SMP things in the file that contains them (and remove the
> #ifdef's there too, just only build the file if CONFIG_SMP is set).

OK, I catch your drift, but if the file is missing and
there is a hard call to  mpc86xx_smp_init() here, how is
that resolved?  Is mpc86xx_smp_init #defined empty when
compiled non-SMP then?  Like in the header file:

    #ifndef CONFIG_SMP
        #define mpc86xx_smp_init()
    #endif

> > +void
> > +mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
> > +{
> > +	uint pvid, svid, phid1;
> > +	uint memsize = total_memory;
> > +
> > +	pvid = mfspr(SPRN_PVR);
> > +	svid = mfspr(SPRN_SVR);
> >
> > +	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> > +	seq_printf(m, "Machine\t\t: MPC86xx HPCN Board\n");
> > +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> > +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> 
> The PVR is probably a duplicate and the SVR should be added to per-cpu
> info instead.

I confess, I am not sure what you mean here.  Could you
clarify this a bit for me, or point to an example perhaps?

Thanks for you feedback!

jdl

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2FDADDECD
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 05:23:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44JNK6D019828
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 15:23:20 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44JNKJO178384
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:23:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44JNKXD013880
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:23:20 -0600
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070504190140.GA13067@lixom.net>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<20070504190140.GA13067@lixom.net>
Content-Type: text/plain
Date: Fri, 04 May 2007 14:18:24 -0500
Message-Id: <1178306304.3026.231.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-04 at 14:01 -0500, Olof Johansson wrote:
> > +#undef DEBUG
> > +#ifdef DEBUG
> > +#define DBG(fmt...) do { printk(fmt); } while(0)
> > +#else
> > +#define DBG(fmt...) do { } while(0)
> > +#endif
> 
> Please use pr_debug() instead.

/me hides head in shame.  I'm guilt of the copy/paste crime.  Will fix.


> > +#ifndef CONFIG_PCI
> > +pci_dram_offset = PPC750GXCL_TSI_PCI_MEM_OFFSET;
> > +#endif
> 
> What's this about?

To be honest, I'm not sure.  I haven't tried compiling without PCI.
Just following the Taiga board's example again.

> > +static void holly_remap_bridge(void)
> > +{
> > +	u32 lut_val, lut_addr = 0x900, misc_cfg;
> 
> Please initialize lut_addr right before using it instead of here, especially
> since you re-assign it later on.

Ok.

> 
> > +	int i;
> > +
> > +	printk(KERN_ERR "Remapping PCI bridge\n");
> > +
> > +	/* Re-init the PCI bridge and LUT registers to have mappings that don't
> > +	 * rely on PIBS */
> 
> Comment style

Yep.

> > +
> > +	/* We don't need MEM32 and PRM remapping so disable them */
> > +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x214, 0x0);
> > +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x220, 0x0);
> > +	tsi108_write_reg(TSI108_PCI_OFFSET + 0x230, 0x0);
> 
> It would be nice to get these constants defined up, but I know it's not always
> practical. I'll bring it up anyway. :-)

This is part of the on-going PCI fixup stuff.  It'll get cleaned up in
the final version.

> > +	/* setup PCI host bridge */
> > +	holly_remap_bridge();
> > +#ifdef CONFIG_PCI
> > +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> > +		tsi108_setup_pci(np);
> 
> On an environment without PCI, wouldn't it make more sense to leave it
> out of the device tree, and thus not have a match in the above, instead
> of taking out CONFIG_PCI?

Yes, actually.  Good catch.

> > +static int __init holly_probe(void)
> > +{
> > +	unsigned long root = of_get_flat_dt_root();
> > +
> > +	if (!of_flat_dt_is_compatible(root, "ppc750"))
> > +		return 0;
> 
> That's a pretty broad compatible check?

Yeah, will fix.

> > +define_machine(holly){
> > +	.name 						= "PPC750 GX/CL TSI",
> > +	.probe 						= holly_probe,
> > +	.setup_arch 				= holly_setup_arch,
> > +	.init_IRQ 					= holly_init_IRQ,
> > +	.show_cpuinfo 				= holly_show_cpuinfo,
> > +	.get_irq 					= mpic_get_irq,
> > +	.restart 					= holly_restart,
> > +	.calibrate_decr 			= generic_calibrate_decr,
> > +	.machine_check_exception	= ppc750_machine_check_exception,
> > +	.progress 					= udbg_progress,
> 
> These look all unaligned for me.

Erg.

> > --- linux-2.6.orig/drivers/net/tsi108_eth.h
> > +++ linux-2.6/drivers/net/tsi108_eth.h
> > @@ -49,7 +49,11 @@
> >   */
> >  #define PHY_MV88E	1	/* Marvel 88Exxxx PHY */
> >  #define PHY_BCM54XX	2	/* Broardcom BCM54xx PHY */
> > +#if defined(CONFIG_HOLLY)
> > +#define TSI108_PHY_TYPE PHY_BCM54XX
> > +#else
> >  #define TSI108_PHY_TYPE	PHY_MV88E
> > +#endif
> 
> This won't work well if you ever want to build a multiplatform kernel.

I know.  What do you suggest?  TSI doesn't use phylib, and adding a
property to specify PHY type in the DT seems like a hack too...

> >   * TSI108 GIGE port registers
> > --- linux-2.6.orig/include/asm-powerpc/tsi108.h
> > +++ linux-2.6/include/asm-powerpc/tsi108.h
> > @@ -68,7 +68,11 @@
> >  #define TSI108_PB_ERRCS_ES		(1 << 1)
> >  #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
> >  
> > +#ifdef CONFIG_HOLLY
> > +#define TSI108_PCI_CFG_BASE_PHYS	(0x7c000000)
> > +#else
> >  #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
> > +#endif
> >  #define TSI108_PCI_CFG_SIZE		(0x01000000)
> 
> Same here. Shouldn't this come out of the devicetree?

As a "reg" property perhaps?  I'm not a DT guru, so I was a bit lost as
to how to fix that up.

josh

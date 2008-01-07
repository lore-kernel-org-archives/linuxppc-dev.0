Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08CE2DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 08:10:16 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 2/3] Add initial iomega StorCenter board port. 
In-Reply-To: Your message of "Mon, 07 Jan 2008 14:42:50 CST."
	<47828ECA.9000507@freescale.com>
References: <E1JBwBn-0006JC-Nn@jdl.com>  <47828ECA.9000507@freescale.com> 
Date: Mon, 07 Jan 2008 15:10:11 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JBzEZ-0007mL-Iy@jdl.com>
Cc: linuxppc-dev@ozlabs.org, andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Scott Wood mumbled:

> > --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> > +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> > @@ -16,6 +16,17 @@ config LINKSTATION
> >  	  Linkstation-I HD-HLAN and HD-HGLAN versions, and PPC-based
> >  	  Terastation systems should be supported too.
> >  
> > +config STORCENTER
> > +	bool "IOMEGA StorCenter"
> > +	depends on EMBEDDED6xx
> > +	select MPIC
> > +	select FSL_SOC
> > +	select PPC_UDBG_16550 if SERIAL_8250
> > +	select WANT_DEVICE_TREE
> > +	help
> > +	  Select STORCENTER if configuring for the iomega StorCenter
> > +	  with an 8241 CPU in it.
> > +
> >  config MPC7448HPC2
> >  	bool "Freescale MPC7448HPC2(Taiga)"
> >  	depends on EMBEDDED6xx
> > @@ -56,7 +67,7 @@ config TSI108_BRIDGE
> >  
> >  config MPC10X_BRIDGE
> >  	bool
> > -	depends on LINKSTATION
> > +	depends on LINKSTATION || STORCENTER
> >  	select PPC_INDIRECT_PCI
> >  	default y
> >  
> > @@ -67,7 +78,7 @@ config MV64X60
> >  
> >  config MPC10X_OPENPIC
> >  	bool
> > -	depends on LINKSTATION
> > +	depends on LINKSTATION || STORCENTER
> >  	default y
> 
> There are many boards out there with mpc10x chips; we really don't want 
> to maintain a huge list of them in the dependency list of these options.
> 
> Can we take out the dependencies and the default y, and just select them 
> in the individual board configs?

Yeah.  That and, shouldn't those choices be mutually
exclusive in a "choice" arrangement instead too?

> > +#ifdef CONFIG_PCI
> > +	int len;
> > +	struct pci_controller *hose;
> > +	const int *bus_range;
> > +
> > +	printk("Adding PCI host bridge %s\n", dev->full_name);
> > +
> > +	bus_range = of_get_property(dev, "bus-range", &len);
> > +	if (bus_range == NULL || len < 2 * sizeof(int))
> > +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> > +				" bus 0\n", dev->full_name);
> 
> This warning should probably go away.  Does this board even have 
> multiple PCI host buses?

Hmmm...  Yeah all likely true.

>  Why is this done from board-specific code, anyway?

History.

> > +static void storcenter_restart(char *cmd)
> > +{
> > +	/* Insert restart-stuff */
> > +}
> > +
> > +static void storcenter_power_off(void)
> > +{
> > +	/* Insert powerdown-stuff */
> > +}
> 
> Shouldn't these be omitted until they actually do something, so that the 
> generic infinite loop implementations can be used?

OK.

> > +static void storcenter_show_cpuinfo(struct seq_file *m)
> > +{
> > +	seq_printf(m, "vendor\t\t: IOMEGA\n");
> > +	seq_printf(m, "machine\t\t: StorCenter\n");
> > +}
> 
> ppc_md.name is printed by the generic cpuinfo handler; this is redundant.

Ah, right.

Thanks for your review time.

jdl

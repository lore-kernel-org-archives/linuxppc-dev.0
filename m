Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81263DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 05:16:23 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l44JD7D2002025
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 15:13:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44JGKV3175174
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:16:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44JGKgg029967
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 13:16:20 -0600
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7BB5A3C3-DBE6-475A-A826-1A95E7B69A4F@kernel.crashing.org>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<7BB5A3C3-DBE6-475A-A826-1A95E7B69A4F@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 04 May 2007 14:11:24 -0500
Message-Id: <1178305884.3026.222.camel@zod.rchland.ibm.com>
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

On Fri, 2007-05-04 at 13:35 -0500, Kumar Gala wrote:
> On May 4, 2007, at 1:14 PM, Josh Boyer wrote:
> > +
> > +config HOLLY
> > +	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
> > +	select TSI108_BRIDGE
> > +	select PPC_UDBG_16550
> > +	select MPIC
> > +	select MPIC_WEIRD
> > +	help
> > +	  Select HOLLY if configuring for an IBM 750GX/CL Eval
> > +	  Board with TSI108/9 bridge (Hickory/Holly)
> >  endchoice
> >
> >  config TSI108_BRIDGE
> >  	bool
> 
> I wondering if we should have select MPIC and MPIC_WEIRD here instead  
> of on the board config.

Could be done, yes.  I don't have an mpc7448hpc2 to test with, but I can
make that change.

> > +	printk(KERN_INFO "PPC750GX/CL Platform\n");
> 
> Should this be something like "Holly PPC750GX/CL Platform"

Well... no.  It should really be "Hickory/Holly PPC750GX/CL Platform" to
be correct.  But that sucks.  Suppose I could match off of the cpu node
in the DT and just print one or the other... except they share a DT too
at the moment.

I'll think about what to do.

> > +void holly_show_cpuinfo(struct seq_file *m)
> > +{
> > +	seq_printf(m, "vendor\t\t: IBM\n");
> > +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> 
> Should 'Holly' be in the machine name?

Again, the whole "Hickory/Holly" thing.

> 
> > +}
> > +
> > +void holly_restart(char *cmd)
> > +{
> > +	unsigned long *ocn_bar1 = NULL;
> 
> This should probably be __be32 __iomem

Good catch.  I need to run this through sparse.

> > +/*
> > + * Called very early, device-tree isn't unflattened
> > + */
> > +static int __init holly_probe(void)
> > +{
> > +	unsigned long root = of_get_flat_dt_root();
> > +
> > +	if (!of_flat_dt_is_compatible(root, "ppc750"))
> > +		return 0;
> 
> This seems like to generic of a match.

Likely is, yes.

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
> This seems pretty bad.  Can we at least make this some type of kernel  
> config since I'm guessing the tsi108 isn't using the phylib.

Yep.

Thanks for the comments.  I'll fix it up in the next round.

josh

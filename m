Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5548ADDEE9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 06:06:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44K6nIW024139
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 16:06:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44K6nS0171526
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 14:06:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44K6nnZ012028
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 14:06:49 -0600
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705042144.31194.arnd@arndb.de>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 04 May 2007 15:01:53 -0500
Message-Id: <1178308913.3026.238.camel@zod.rchland.ibm.com>
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

On Fri, 2007-05-04 at 21:44 +0200, Arnd Bergmann wrote:
> On Friday 04 May 2007, Josh Boyer wrote:
> > +
> > +#undef DEBUG
> > +#ifdef DEBUG
> > +#define DBG(fmt...) do { printk(fmt); } while(0)
> > +#else
> > +#define DBG(fmt...) do { } while(0)
> > +#endif
> 
> Please replace this with the generic pr_debug()

Already noted, but yes.

> > +extern int tsi108_setup_pci(struct device_node *dev);
> > +extern void tsi108_pci_int_init(struct device_node *node);
> > +extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
> 
> please move any extern declarations into a header file that
> is included by both the file that defines and uses them

Ok.

> 
> > +static void holly_remap_bridge(void)
> > +{
> > +	u32 lut_val, lut_addr = 0x900, misc_cfg;
> > +	int i;
> > +
> > +	printk(KERN_ERR "Remapping PCI bridge\n");
> 
> Is it an error to remap the bridge? If not, KERN_INFO would be more
> appropriate ;-)

This whole function is under work at the moment, so it'll get cleaned
up.

> 
> > +void holly_show_cpuinfo(struct seq_file *m)
> > +{
> > +	seq_printf(m, "vendor\t\t: IBM\n");
> > +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> > +}
> 
> If it's an IBM product, it should come with a product code like 123-4567,
> which fits in here, instead of just listing the CPU.

Erm... why?  There are other boards that don't do this as well...

> 
> > +static int ppc750_machine_check_exception(struct pt_regs *regs)
> > +{
> > +	extern void tsi108_clear_pci_cfg_error(void);
> 
> move declaration to header file.

Ok.

> 
> > +	const struct exception_table_entry *entry;
> > +
> > +	/* Are we prepared to handle this fault */
> > +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> > +		tsi108_clear_pci_cfg_error();
> > +		regs->msr |= MSR_RI;
> > +		regs->nip = entry->fixup;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> Are you sure that you can use the generic exception table mechanism
> like this? I can't see why it doesn't work, but it's something I haven't
> seen anyone do like this.

Yes, this works and is actually required.  See tsi108_pci.c for where
the fixup/exception table information is generated.

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
> >  
> 
> this breaks multiplatform setups.

I know.  Looking for a better suggestions.  Kumar suggested a Kconfig
option at least, which is what I'm going to go with unless someone has a
better idea...

josh

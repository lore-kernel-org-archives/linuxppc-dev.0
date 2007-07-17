Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 24BCCDDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 15:32:26 +1000 (EST)
Subject: Re: [PATCH 1/3] 82xx: some 82xx platform hook functions can be
	shared by different boards
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707170259.47098.arnd@arndb.de>
References: <469B33F2.9040306@windriver.com> <200707170259.47098.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 13:31:12 +0800
Message-Id: <1184650272.18501.0.camel@mark>
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

On Tue, 2007-07-17 at 02:59 +0200, Arnd Bergmann wrote:
> On Monday 16 July 2007, Mark Zhan wrote:
> 
> > @@ -96,7 +94,7 @@
> >   	pvid = mfspr(SPRN_PVR);
> >   	svid = mfspr(SPRN_SVR);
> > 
> > -	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> > +	seq_printf(m, "Vendor\t\t: %s\n", CPUINFO_VENDOR);
> >   	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
> >   	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> >   	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> 
> This is a step in the wrong direction. CPUINFO_{VENDOR,MACHINE}
> comes from a platform specific header file, so you can not
> use these definitions in platform independent code without
> breaking multiplatform kernels.
> 
> One possible solution would be a platform specific show_cpuinfo()
> function that calls a generic 82xx version and passes in the
> two values. Even better would be to just dump whatever string
> you find in the /model property in the device tree.
> 

OK, Got what you said. I will fix it.


> > +
> > +#define RMR_CSRE 0x00000001
> > +
> > +void mpc82xx_restart(char *cmd)
> > +{
> > +	__volatile__ unsigned char dummy;
> > +
> > +	local_irq_disable();
> > +	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
> > +
> > +	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> > +	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> > +	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
> > +	printk("Restart failed\n");
> > +	while (1) ;
> > +}
> 
> I know you're just moving that code, but it looks horribly wrong
> nonetheless. cpm2_immr is an __iomem variable, so you must not
> dereference it but instead should use the in_8() macro to
> access it.
> 
> Once you get that right, you don't need the volatile variable
> any more.

OK. will fix it.

> 
> > +void mpc82xx_halt(void)
> > +{
> > +	local_irq_disable();
> > +	while (1) ;
> > +}
> 
> Here, as in the function above, there should at least be a cpu_relax()
> in the final loop. If the CPU has a nap functionality or something
> similar, that would be even better.

Not sure if mpc82xx has such kind of functionality. Based on the current
definition of cpu_relax(), it is only meaningful for ppc64.

> 
> 	Arnd <><

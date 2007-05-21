Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id F0A75DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 06:50:22 +1000 (EST)
Date: Mon, 21 May 2007 22:50:20 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] power-management elements for 603e/fsl (version 2)
In-Reply-To: <20070521155712.GA16235@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.60.0705212225470.7562@poirot.grange>
References: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
	<20070521155712.GA16235@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 May 2007, Scott Wood wrote:

> On Sat, May 19, 2007 at 09:22:10PM +0200, Guennadi Liakhovetski wrote:
> > +	local_irq_disable();
> 
> IRQs are already disabled when this function is called.

ok

> > +	/* go zzzzz... (re-enabling interrupts) */
> > +	fsl_low_sleep();
> 
> IRQs really shouldn't be enabled here without something like the "Handle
> HID0_SLEEP in the TLF_NAPPING hack" patch I posted recently.

Ok, I'd be happy to rely on those your patches... as long as they make it 
into the kernel. Paulus, what's the plan? I'll try to apply them locally 
for now and adjust my code accordingly. A recent powerpc.git should be 
fine, I guess - the arch_suspend_{disable,enable}_irqs hooks are already 
there, or are there any further dependencies?

> > +	/* Re-enable local CPU interrupts */
> > +	local_irq_enable();
> 
> Just leave them off.

ok

> > @@ -112,10 +155,15 @@ static int __init ls_uarts_init(void)
> >  
> >  	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
> >  	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
> > + 	irq = ((u32*)get_property(avr, "interrupts", &len))[0];
> 
> Oopsing if a property is missing isn't nice.

Hm, it is in .dts in the kernel tree, do I still have to care a possible 
non-compliant version? Probably, you're right, will fix.

> > +	local_irq_save(flags);
> > +	/* Apparently, MacOS uses NAP mode for Grackle ??? */
> > +	pmcr1 &= ~(MPC10X_DOZE | MPC10X_NAP);
> > +	pmcr1 |= MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
> > +	pci_write_config_word(bridge, 0x70, pmcr1);
> > +	local_irq_restore(flags);
> 
> This should probably be something like mpc10x_suspend.  Also, IRQs should
> already be disabled when this is called.

well, I'd also prefer a more specific namespace than "fsl." Would it be ok 
to call them with mpc10x (has been discussed on irc, I remember there have 
been objections against this as mpc10x are just some host-pci bridges from 
older Apple (not only?) machines)? And if we use mpc10x, is it ok to leave 
them in fsl_soc.c?

> > +	/* Make sure the decrementer won't interrupt us */
> > +	asm volatile("mtdec %0" : : "r" (0x7fffffff));
> > +	/* Make sure any pending DEC interrupt occurring while we did
> > +	 * the above didn't re-enable the DEC */
> > +	mb();
> > +	asm volatile("mtdec %0" : : "r" (0x7fffffff)); /* 8 seconds */
> 
> IRQs are already disabled here, so if it was pending it still will be (at
> least with some cores).  It needs to be done with the arch suspend hook.

as above, will test with your patches.

Thanks for comments!
Guennadi
---
Guennadi Liakhovetski

Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <4540F659.9070409@246tNt.com>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<528646bc0610260909x10c3b242i64387f576e625048@mail.gmail.com>
	<4540EB0E.2090000@bplan-gmbh.de>  <4540F659.9070409@246tNt.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:08:25 +1000
Message-Id: <1161918505.25682.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-26 at 19:54 +0200, Sylvain Munaut wrote:
> Hi Nicolas,
> 
> 
> I don't have much to add to what's already been posted, so here's a
> couple of details,
> mainly compatibility concerns with the legacy arch/ppc tree.

I'd rather not clobber the code to be compatible with arch/ppc... once
52xx is ported over, I'm happy to completely drop support for arch/ppc
52xx. If we want to keep dual support for a while and we are changing
APIs too much, we can just fork the drivers for a kernel version of two
until we are confident enough to drop the arch/ppc version.
  
> > diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> > --- a/include/asm-ppc/mpc52xx.h	2006-10-25 19:07:48.000000000 +0200
> > +++ b/include/asm-ppc/mpc52xx.h	2006-10-25 19:11:55.000000000 +0200
> > @@ -119,7 +119,7 @@ enum ppc_sys_devices {
> >  #define MPC52xx_SDMA_IRQ_NUM	17
> >  #define MPC52xx_PERP_IRQ_NUM	23
> >  
> > -#define MPC52xx_CRIT_IRQ_BASE	1
> > +#define MPC52xx_CRIT_IRQ_BASE	0

> As explained in IRC, I'm not sure about this.
> I was previously talked into applying this to avoid using interrupt
> number 0. In the LITE5200 IRQ0 is used for PCI. It's interrupt number
> is equal to MPC52xx_CRIT_IRQ_BASE and if it's 0 some drivers just don't
> work.

arch/powerpc has completely virtualized interrupt numbering. The
"hardware" numbers supported by a given interrupt controller are
generally not visible to a driver and can have any value including 0.
The system will assign virtual numbers when interrupts are "mapped" and
those will never be 0.

> That's when using the arch/ppc code. Apparently this is no longer an
> issue in arch/powerpc (someone to confirm and explain me why ? I would guess
> the irq_linear_revmap thingie ), but can a "standard" lite5200 be booted
> in a arch/powerpc kernel ?

Once the code has been ported over :-)

> So if no critical, I would postpone that change until it's confirmed
> a lite5200 can boot ...

It's not been ported yet I presume. Anyway, as I said, we shouldn't
bother too much about what is in arch/ppc. If we think we are changing
things in a conflicting way, then we should fork the drivers and
includes (you can have the same include in both asm-ppc and asm-powerpc,
the one matching you building ARCH will be used and they can have
different definitions).

> > -extern int mpc52xx_get_irq(void);
> > +extern unsigned int mpc52xx_get_irq(void);

> Mmmh, the one in arch/ppc is not unsigned but I guess the warning is fine.

We should instead create a new mpc52xx.h in include/asm-powerpc and
leave arch/ppc alone

> Finally, some triviality : The patch adds some space on empty lines. Also,
> the indentation is sometimes done with space and sometimes with space ...

Yeah, I've noticed that the patch is fairly whitespace damaged. It's
also incorrect in many ways concerning the hooking to genirq, I'm
surprised it works at all in fact.

It might be useful if somebody got me one of those boards (either efika
or lite5200b) so I can do some proper rework of that stuff.

Ben.

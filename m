Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 3614BDDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 00:53:47 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so635965rvf
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:53:46 -0700 (PDT)
Message-ID: <fa686aa40709140753sb3e0e9cv28fa5215f4db3a@mail.gmail.com>
Date: Fri, 14 Sep 2007 08:53:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <46EA8CD7.2050304@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
	<46EA8CD7.2050304@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/14/07, Matt Sealey <matt@genesi-usa.com> wrote:
> Grant!
>
> I have a newbie question which I never had properly answered. On the
> MPC52xx and specifically regarding the device tree, how are interrupt
> numbers assigned?
>
> On Efika (and in the DT docs) it's basically the X Y Z where X is the
> type (critical, main, peripheral, sdma), Y is the number of the
> interrupt, and Z is it's sense level.
>
> However while X and Z are easy to derive, how do you work out what Y
> is meant to be given a device? Is it a bit number in the interrupt
> register, or the value of the encoded interrupt register or something
> else algorithmically determined?
>
> I am just finding the code in Linux that derives this number fairly
> elusive (the irq setup function for the mpc52xx platform is truly
> sparse, irq_of_find_and_map isn't much help). Maybe I am just not
> looking in the right place but not being an MPC52xx PIC Expert I
> wouldn't even know where to start...

The l2 irq numbers map directly to the interrupt numbers listed in the
5200b user guide.  For example, on p7-11, the masks are listed for
main interrupts 0 through 16.  and on p7-17,18, the peripherial
interrupts are listed as numbered from 0 to 23 (but notice that it
does *not* line up with bit positions).

However, it is interesting to note that other than in the register
definitions, I don't think there is anywhere in the 5200b user manual
that simple lists the interrupt numbers for each interrupt type.

Cheers,
g.
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>
> Grant Likely wrote:
> > On 9/11/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> >> Hello,
> >>
> >>>> [...]
> >>>>     intr = mpc52xx_find_and_map("mpc52xx-pic");
> >>>>     if(!intr) {
> >>>>         panic(__FILE__ ": mpc52xx-pic - MAP failed");
> >>>>     }
> >>>>
> >>>>     set_irq_chip(MPC52xx_IRQ2, &my_irq_chip);
> >>> You probably don't want to do this (unless you are cascading IRQs to
> >>> custom external hardware).  All you should need is the call to
> >>> request_irq() to register your irq handler, and code in your ISR
> >>> handler to clear the interrupt condition.
> >>>
> >>> You do *NOT* want to program the interrupt controller directly.  The
> >>> mpc5200 interrupt controller already has a driver.  Don't go twiddling
> >>> the registers manually.
> >> OK!
> >>
> >> I have tried it before and i get a "-ENOSYS" returned.
> >>
> >> My code was/is now:
> >> --==>
> >> request_irq(MPC52xx_IRQ2, intmod_isr, IRQF_DISABLED , "intmod",
> >>             INTMOD_IRQ_BOARD);
> >> <==--
> >>
> >> I have looked up "kernel/irq/manage.c". "-ENOSYS" is returned on function
> >> "setup_irq" because the used irq(MPC52xx_IRQ2) is the same as no_irq_chip.
> >>
> >> THE MPC52xx_IRQ2 is a excerpt from "include/ppc/mpc52xx.h" (per copy
> >> paste), but mpc52xx is (now) a powerpc-arch. What is the desired value for
> >> IRQ-2 on a mpc5200b?
> >
> > The irq number you pass into request_irq is a system-wide irq number;
> > it doesn't necessarily map directly onto the MPC52xx irq number.
> > Typically, you'd have a node for your device in the device tree which
> > has a phandle back to the interrupt node and you would use
> > irq_of_parse_and_map() to map it back to a system-wide irq number.
> >
> > Otherwise, you need to call of_irq_map_raw with the pointer to the
> > 52xx interrupt controller node and the interrupt number in the form
> > expected by the device tree.  (But adding a device tree node for your
> > device is far easier).
> >
> > Cheers,
> > g.
> >
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

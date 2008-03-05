Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 394BADDFB7
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 07:14:57 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080305161509.GA7596@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<20080305161509.GA7596@netgate.macqel>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 07:14:28 +1100
Message-Id: <1204748068.21545.209.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-05 at 17:15 +0100, Philippe De Muyter wrote:
> 
> I asked the guy who designed the hardware, and if I understand
> correctly :
> 
> - the i/o and memory resources of the pci device are connected to the
> pci bus
> - the interrupts are directly connected to the MPIC
> 
> Can I describe that in the dts file ?

Sure, you can describe pretty much any interrupt routing, provided that
we know -how- (ie. where) they are connected. We also need to know the
idsel of the devices. (The later we can deduce from lspci done in
arch/ppc).

Ben.

> Philippe
> 
> > 
> > Or are you doing some swizzling ?
> > 
> > Also, I would need to know how those external IRQs are connected to
> the MPIC,
> > I don't have the spec of that chip here. Hrm. Somebody from
> freescale can
> > help him here ?
> > 
> > It's also not clear to me what your interrupts 9 10 and 11 are since
> you
> > seem to only talk about PIRQA...D which is only 4 lines ..
> > 
> > So at this stage, that's not enough information. We need to know
> exactly how
> > you have wired things on your board, and somebody from fsl needs to
> tell
> > me how the ExtIrq are routed to the MPIC on that guy.
> > 
> > Once that's done, you seem to have grasped the interrupt map... for
> any
> > device or slot, you provide the mapping between idsel/pirq line on
> one side,
> > and mpic interrupt & sense on the other. For PCI, sense is always 1
> for an
> > mpic so you mostly have to check your actual MPIC source numbers.
> > 
> > >From your .dts, I see you've been doing some swizzling of slots
> using
> > interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?
> > 
> > Ben.
> > 
> > >  
> > >  /*
> ************************************************************************ */
> > >
> --- ./arch/ppc/platforms/85xx/mpc85xx_ads_common.hbk        2008-01-24
> 22:58:37.000000000 +0000
> > > +++ ./arch/ppc/platforms/85xx/mpc85xx_ads_common.h  2008-02-20
> 16:36:07.000000000 +0000
> > > @@ -29,10 +29,17 @@
> > >  extern void mpc85xx_ads_map_io(void) __init;
> > >  
> > >  /* PCI interrupt controller */
> > > +#ifdef CONFIG_MEIP_8540
> > > +#define PIRQA              MPC85xx_IRQ_EXT5
> > > +#define PIRQB              MPC85xx_IRQ_EXT6
> > > +#define PIRQC              MPC85xx_IRQ_EXT7
> > > +#define PIRQD              MPC85xx_IRQ_EXT8
> > > +#else
> > >  #define PIRQA              MPC85xx_IRQ_EXT1
> > >  #define PIRQB              MPC85xx_IRQ_EXT2
> > >  #define PIRQC              MPC85xx_IRQ_EXT3
> > >  #define PIRQD              MPC85xx_IRQ_EXT4
> > > +#endif
> > >  
> > >  #define MPC85XX_PCI1_LOWER_IO      0x00000000
> > >  #define MPC85XX_PCI1_UPPER_IO      0x00ffffff
> 

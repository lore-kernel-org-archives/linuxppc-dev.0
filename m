Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 0312DDDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 10:34:33 +1100 (EST)
Date: Thu, 6 Mar 2008 00:34:30 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080305233430.GA12707@netgate.macqel>
References: <20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<20080305161509.GA7596@netgate.macqel>
	<1204748068.21545.209.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204748068.21545.209.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Thu, Mar 06, 2008 at 07:14:28AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-03-05 at 17:15 +0100, Philippe De Muyter wrote:
> > 
> > I asked the guy who designed the hardware, and if I understand
> > correctly :
> > 
> > - the i/o and memory resources of the pci device are connected to the
> > pci bus
> > - the interrupts are directly connected to the MPIC
> > 
> > Can I describe that in the dts file ?
> 
> Sure, you can describe pretty much any interrupt routing, provided that
> we know -how- (ie. where) they are connected. We also need to know the

They are connected directly to the pic-part of the mpc8540 just as 
described in the .c file in the other mail.

> idsel of the devices. (The later we can deduce from lspci done in
> arch/ppc).

Does this (boot error messages in the not-working arch/powerpc kernel) :
	PCI: Cannot allocate resource region 0 of device 0000:00:12.0
	PCI: Cannot allocate resource region 0 of device 0000:00:12.1
	PCI: Cannot allocate resource region 0 of device 0000:00:12.2
	PCI: Cannot allocate resource region 1 of device 0000:00:12.2

or this (/proc/bus/pci in the working arch/pcc kernel)
	Sorry, I am at home now and cannot access my board :)
or this (boot info messages from working arch/pcc kernel) :
	ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[55]  MMIO=[9f7fd800-9f7fdfff]  Max Packet=[2048]  IR/IT contexts=[4/8]
	...
	Yenta: CardBus bridge found at 0000:00:12.0 [0000:0000]
	...
	Yenta TI: socket 0000:00:12.0, mfunc 0x00001b00, devctl 0x66
	Yenta TI: socket 0000:00:12.0 probing PCI interrupt failed, trying to fix
	Yenta TI: socket 0000:00:12.0 falling back to parallel PCI interrupts
	Yenta TI: socket 0000:00:12.0 parallel PCI interrupts ok
	Yenta: ISA IRQ mask 0x0000, PCI irq 53
	...
	pccard: PCMCIA card inserted into slot 0
	cs: memory probe 0x80000000-0x9fffffff: excluding 0x80000000-0x807fffff 0x9f000000-0x9fffffff
	pcmcia: registering new device pcmcia0.0
	Yenta TI: socket 0000:00:12.1 parallel PCI interrupts ok
	Yenta: ISA IRQ mask 0x0000, PCI irq 54
	Socket status: 30000086

or this (U-boot info message) :
	PCI Scan: Found Bus 0, Device 18, Function 0
		00  12  104c  ac46  0607  ff
	PCI Scan: Found Bus 0, Device 18, Function 1
		00  12  104c  ac46  0607  ff
	PCI Scan: Found Bus 0, Device 18, Function 2
		00  12  104c  802a  0c00  00
and this (/proc/interrupts on a working system)
		   CPU0
	 25:          0   OpenPIC   Level     gfar_interrupt
	 26:        245   OpenPIC   Level     serial
	 27:          0   OpenPIC   Level     i2c-mpc
	 53:      18797   OpenPIC   Level     yenta, ide0
	 54:          1   OpenPIC   Level     yenta
	 55:         79   OpenPIC   Level     ohci1394
	BAD:          0

help ?

Philippe

> > > 
> > > Or are you doing some swizzling ?
> > > 
> > > Also, I would need to know how those external IRQs are connected to
> > the MPIC,
> > > I don't have the spec of that chip here. Hrm. Somebody from
> > freescale can
> > > help him here ?
> > > 
> > > It's also not clear to me what your interrupts 9 10 and 11 are since
> > you
> > > seem to only talk about PIRQA...D which is only 4 lines ..
> > > 
> > > So at this stage, that's not enough information. We need to know
> > exactly how
> > > you have wired things on your board, and somebody from fsl needs to
> > tell
> > > me how the ExtIrq are routed to the MPIC on that guy.
> > > 
> > > Once that's done, you seem to have grasped the interrupt map... for
> > any
> > > device or slot, you provide the mapping between idsel/pirq line on
> > one side,
> > > and mpic interrupt & sense on the other. For PCI, sense is always 1
> > for an
> > > mpic so you mostly have to check your actual MPIC source numbers.
> > > 
> > > >From your .dts, I see you've been doing some swizzling of slots
> > using
> > > interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?
> > > 
> > > Ben.
> > > 
> > > >  
> > > >  /*
> > ************************************************************************ */
> > > >
> > --- ./arch/ppc/platforms/85xx/mpc85xx_ads_common.hbk        2008-01-24
> > 22:58:37.000000000 +0000
> > > > +++ ./arch/ppc/platforms/85xx/mpc85xx_ads_common.h  2008-02-20
> > 16:36:07.000000000 +0000
> > > > @@ -29,10 +29,17 @@
> > > >  extern void mpc85xx_ads_map_io(void) __init;
> > > >  
> > > >  /* PCI interrupt controller */
> > > > +#ifdef CONFIG_MEIP_8540
> > > > +#define PIRQA              MPC85xx_IRQ_EXT5
> > > > +#define PIRQB              MPC85xx_IRQ_EXT6
> > > > +#define PIRQC              MPC85xx_IRQ_EXT7
> > > > +#define PIRQD              MPC85xx_IRQ_EXT8
> > > > +#else
> > > >  #define PIRQA              MPC85xx_IRQ_EXT1
> > > >  #define PIRQB              MPC85xx_IRQ_EXT2
> > > >  #define PIRQC              MPC85xx_IRQ_EXT3
> > > >  #define PIRQD              MPC85xx_IRQ_EXT4
> > > > +#endif
> > > >  
> > > >  #define MPC85XX_PCI1_LOWER_IO      0x00000000
> > > >  #define MPC85XX_PCI1_UPPER_IO      0x00ffffff
> > 

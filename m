Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06CD767B72
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 18:53:39 +1000 (EST)
Subject: Re: [PATCH] powerpc: update mpc7448hpc2 board irq
	supportusingdevice tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1156408565.6591.2.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E531@zch01exm23.fsl.freescale.net>
	<1156304338.8433.21.camel@localhost.localdomain>
	<1156397344.5913.34.camel@localhost.localdomain>
	<1156398659.8433.193.camel@localhost.localdomain>
	<1156408565.6591.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:53:28 +1000
Message-Id: <1156409608.8433.242.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 16:36 +0800, Zang Roy-r61911 wrote:
> On Thu, 2006-08-24 at 13:50, Benjamin Herrenschmidt wrote:
> > > -struct hw_interrupt_type tsi108_pci_irq = {
> > > +static struct irq_chip tsi108_pci_irq = {
> > >       .typename = "tsi108_PCI_int",
> > > -     .enable = tsi108_pci_irq_enable,
> > > -     .disable = tsi108_pci_irq_disable,
> > > +     .mask = tsi108_pci_irq_disable,
> > >       .ack = tsi108_pci_irq_ack,
> > >       .end = tsi108_pci_irq_end,
> > > +     .unmask = tsi108_pci_irq_enable,
> > >  };
> > >  
> > >  /*
> > 
> > While the patch as-is looks ok, it also looks like you could take
> > advantage of the new genirq code to clean up your TSI irq handling a
> > bit. You probably don't need a end() handler anymore provided that you
> > properly set your main handler to be either level, edge or fasteoi (in
> > which case, you need an eoi handler).

> I need the end() handler. The main handler can not proper process the
> case.

None of the 3 main handlers in kernel/irq/chip.c (You can set them at
host_map time with set_irq_chip_and_handler, if you don't do it, you end
up with the old-style main handler, but one of the 3 new ones might be
more suitable to your flow) ? Strange... I would need to look in more
details, but it's not urgent, the current stuff should work.

Ben

Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DDBE667BA8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 18:36:27 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7O8mbP3010967
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 01:48:37 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7O8aOwN005482
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 03:36:25 -0500 (CDT)
Subject: Re: [PATCH] powerpc: update mpc7448hpc2 board irq
	supportusingdevice tree
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156398659.8433.193.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E531@zch01exm23.fsl.freescale.net>
	<1156304338.8433.21.camel@localhost.localdomain>
	<1156397344.5913.34.camel@localhost.localdomain>
	<1156398659.8433.193.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156408565.6591.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Aug 2006 16:36:06 +0800
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

On Thu, 2006-08-24 at 13:50, Benjamin Herrenschmidt wrote:
> > -struct hw_interrupt_type tsi108_pci_irq = {
> > +static struct irq_chip tsi108_pci_irq = {
> >       .typename = "tsi108_PCI_int",
> > -     .enable = tsi108_pci_irq_enable,
> > -     .disable = tsi108_pci_irq_disable,
> > +     .mask = tsi108_pci_irq_disable,
> >       .ack = tsi108_pci_irq_ack,
> >       .end = tsi108_pci_irq_end,
> > +     .unmask = tsi108_pci_irq_enable,
> >  };
> >  
> >  /*
> 
> While the patch as-is looks ok, it also looks like you could take
> advantage of the new genirq code to clean up your TSI irq handling a
> bit. You probably don't need a end() handler anymore provided that you
> properly set your main handler to be either level, edge or fasteoi (in
> which case, you need an eoi handler).
I need the end() handler. The main handler can not proper process the
case.
Roy

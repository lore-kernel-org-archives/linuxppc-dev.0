Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8094267BB2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 19:03:52 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBC83aav010848
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Dec 2006 09:03:37 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272: Edge triggered IRQ
Date: Tue, 12 Dec 2006 09:02:47 +0100
References: <457E0D11.1010802@rftechnology.com.au>
	<457E1884.6050501@rftechnology.com.au>
In-Reply-To: <457E1884.6050501@rftechnology.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612120902.47823.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Found solution:
>
> immap->im_intctl.ic_siexr |= (1 << (14 - (irq - SIU_INT_IRQ1)));
>
> Makes it trigger on falling edge

Don't forget to set

        irq_desc[SIU_INT_IRQ1].status &= ~IRQ_LEVEL;

That should be done in the IRQ initialization function referenced by 
ppc_md.init_IRQ.

> > I have pretty simple code that I did a long time ago
> >
> > irqreturn_t irq_handler(int irq, void *dev_id, struct pt_regs *regs)
> > {
> >   ..
> >  return IRQ_HANDLED;
> > }
> >
> >
> > request_irq(irq,
> >             &irq_handler,
> >             SA_INTERRUPT,
> >             "irq handler",
> >              NULL);
> >
> > That code runs on MPC8272 and 2.6.18 kernel.
> > It triggers IRQ on low level (I thought it was falling edge by default).
> > So, as long as I have input low level I have hundreds of calls. Pretty
> > much it keeps calling IRQ handling routine.
> > How do I make it to trigger on falling edge?

Laurent Pinchart

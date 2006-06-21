Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx025.isp.belgacom.be (outmx025.isp.belgacom.be
	[195.238.4.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EDEB67B15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 23:54:23 +1000 (EST)
Received: from outmx025.isp.belgacom.be (localhost [127.0.0.1])
	by outmx025.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5LDs4rM032042
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Jun 2006 15:54:06 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: Re: Adding an external interrupt controller
Date: Wed, 21 Jun 2006 15:55:58 +0200
References: <9FCDBA58F226D911B202000BDBAD4673026FD958@zch01exm40.ap.freescale.net>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673026FD958@zch01exm40.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606211555.58621.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> > I'm trying to write a driver for a custom extension bus
> > mapped in my MPC8248
> > memory space.
> >
> > The bus has 32 interrupt lines which are handled by an
> > interrupt controller
> > connected to a single external interrupt on the MPC8248.
> >
> > I've had a look at the Linux interrupt management code, but
> > haven't found any
> > easy API to add an external interrupt controller. Could
>
> No, the linux kernel has this feature.
>
> > someone give me a few
> > pointers regarding how to proceed ? I would like to
> > "register" the interrupt
> > controller with the interrupt management core, so that
> > request_irq()/free_irq() could be used with the extra interrupts.
>
> Need define the struct hw_interrupt_type <your_interrupt_controller>
> and the struct irqaction <your_irqaction>, and
> implement member function and hook your interrupt controller to
> The interrupt controller of MPC8248 with setup_irq.

I've had a deeper look at that approach and things are, if not entirely clear, 
at least clear enough to try coding a simple interrupt controller.

There is, though, something that bothers me. My interrupt controller has 32 
IRQ lines. If I hook up my interrupt controller using the ppc_md.init_IRQ and 
ppc_md.get_irq callbacks, only one interrupt will be processed at a time. The 
interrupt handler acks the interrupt at source, but other interrupts which 
are already flagged will reinterrupt the CPU as soon as the interrupt handler 
returns. This is clearly sub-optimal. I noticed that some people call 
__do_IRQ reintrantly (in arch/ppc/syslib/m82xx_pic.c for instance). Could I 
do that as well, or is that discouraged ? Any problem regarding the stack 
size ?

Thanks for your help.

Best regards,

Laurent Pinchart

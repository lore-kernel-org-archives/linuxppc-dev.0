Message-ID: <B164B53F5BD6D511888D009027732E1A024973@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Dan Malek'" <dan@embeddededge.com>,
	Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: request_irq () kills kernel
Date: Thu, 22 Nov 2001 14:47:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, Dan,

This was mu suspicion too about request_irq().
I could not get to the request_8xxirq() from driver. I found that file
/arch/ppc/kernel/ppc_ksyms.c did not export it for 8260 processor, only for
8xx processor. After I changed that file I am able to use request_8xxirq()
and it does not crash anymore.

Rudolf

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Thursday, November 22, 2001 2:39 PM
> To: Rudolf Ladyzhenskii
> Cc: Linuxppc-Embedded (E-mail)
> Subject: Re: request_irq () kills kernel
>
>
>
> Rudolf Ladyzhenskii wrote:
>
>
> > I was looking through the kernel code and I discovered that
> other drivers
> > use request_8xxirq() instead of request_irq().
>
> Hmmm.....I didn't think request_irq() should exist.  The
> reason for the
> name change is to ensure people writing the drivers know a different
> integrated interrupt controller is in use and to catch any
> legacy drivers
> that would call request_irq() and mess up the interrupt controller.
> We are discussing other options, but I'm holding out for a
> more generic
> solution to all of the interrupt controller variants.
>
> > ..... Now, those things have been
> > defined to be same in /arch/ppc/kernel/irq.c, but both
> appear in System.map.
> > Which one should I use?
>
> You should only be using request_8xxirq() for all integrated
> peripherals.
>
> > Also, anyone have any ideas why kernel would die?
> > I am trying to hook to interrupt 0x0c (Timer0) and I
> checked SIMR_L register
> > to make sure Timer interrupts are masked.
>
> Installing an interrupt handler will automatically unmask
> that interrupt.
> If the hardware isn't properly initialized, like the timer is
> constantly
> generating interrupts, you will get stuck in an infinite
> interrupt loop.
>
>
> 	-- Dan
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3BFC7352.6020204@embeddededge.com>
Date: Wed, 21 Nov 2001 22:38:58 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: request_irq () kills kernel
References: <B164B53F5BD6D511888D009027732E1A024972@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:


> I was looking through the kernel code and I discovered that other drivers
> use request_8xxirq() instead of request_irq().

Hmmm.....I didn't think request_irq() should exist.  The reason for the
name change is to ensure people writing the drivers know a different
integrated interrupt controller is in use and to catch any legacy drivers
that would call request_irq() and mess up the interrupt controller.
We are discussing other options, but I'm holding out for a more generic
solution to all of the interrupt controller variants.

> ..... Now, those things have been
> defined to be same in /arch/ppc/kernel/irq.c, but both appear in System.map.
> Which one should I use?

You should only be using request_8xxirq() for all integrated peripherals.

> Also, anyone have any ideas why kernel would die?
> I am trying to hook to interrupt 0x0c (Timer0) and I checked SIMR_L register
> to make sure Timer interrupts are masked.

Installing an interrupt handler will automatically unmask that interrupt.
If the hardware isn't properly initialized, like the timer is constantly
generating interrupts, you will get stuck in an infinite interrupt loop.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

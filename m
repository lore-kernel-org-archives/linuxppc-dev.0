Date: Mon, 26 Nov 2001 10:35:57 -0500
Message-Id: <200111261535.fAQFZvd20352@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: rudolf.ladyzhenskii@act-aus.net
Cc: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <B164B53F5BD6D511888D009027732E1A024972@ntserver.act.domain>
	(message from Rudolf Ladyzhenskii on Thu, 22 Nov 2001 11:32:58 +1100)
Subject: Re: request_irq () kills kernel
References: <B164B53F5BD6D511888D009027732E1A024972@ntserver.act.domain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I am writing a driver to support MPC8260 hardware timers.
>The very moment I call request_irq(), kernel dies without a warning (I
>use 2.4.4 kernel).
>
>I was looking through the kernel code and I discovered that other
>drivers use request_8xxirq() instead of request_irq(). Now, those
>things have been defined to be same in /arch/ppc/kernel/irq.c, but
>both appear in System.map. Which one should I use?
>Also, anyone have any ideas why kernel would die?

I'm don't know which call to use, but this reminds me of a slightly
different problem I had bringing up the ppc kernel.  I accidently set
the frequency to 200 instead of 200Mhz, so the system timer was
programmed to interrupt one every 200 clocks instead of once every 200
*million* clocks, and the timer ISR takes longer than 200 clocks to
execute, so by the time the kernel was done servicing the timer, it
expired again!  This caused the processor to appear like it stopped
executing since it spent *all* of its time in the interrupt service
routine.

You may want to look at how you are setting up the timers and making
sure that the interrupt frequency is not so high as to prevent any
other processing.

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <003e01bf1a9e$59f44980$0201a8c0@home>
From: "Jeff Millar" <jeff@wa1hco.mv.com>
To: "Dan Malek" <dan@netx4.com>,
        "Graham Stoney" <greyham@research.canon.com.au>
Cc: "Dan Malek" <dan@penguin.netx4.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <19991019085603.D1026B23A@elph.research.canon.com.au> <380CCBAC.7C0DB544@netx4.com>
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
Date: Tue, 19 Oct 1999 21:56:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've also been thinking about this...

If the boot process goes bad, then the interrupt driven watchdog will
keep getting reset and prevent the watchdog from firing...leading to a
unrecoverable hang.  So, what's the likely hood of the boot process
going bad?

Our application requires downloading new kernels and applications and this
may
increase the likely hood that a kernel fails to complete the boot process.

This idea has a window of vunerability but how much and how likely???

Maybe the timer can be set longer than the longest bootup time or at least
until the first daemon gets going?

jeff

----- Original Message -----
From: Dan Malek <dan@netx4.com>
To: Graham Stoney <greyham@research.canon.com.au>
Cc: Dan Malek <dan@penguin.netx4.com>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, October 19, 1999 3:51 PM
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?


>
> Graham Stoney wrote:
>
>
> > .... The watchdog can't
> > be disabled/reenabled, and its maximum period is only a couple of
seconds;
> > there's no guarantee that the kernel will have booted and loaded the
> > application by then, so the watchdog is likely to go off during the boot
> > process. I think this probably puts my plans to use it on hold for
now...
>
> Maybe not.  I was thinking about this (when I should have been doing
> other things :-) earlier today.  What we could do when the internal
> watchdog is configured is to service it during the Linux timer
> interrupt when an application doesn't have it "enabled".  This
> doesn't provide a watchdog service, just ensures it doesn't
> unexpectedly expire.  When an application decides it wants the
> watchdog, we don't service it in the timer ISR.
>
> We would have to litter the boot code with some service calls,
> like when you wait at the Linux boot prompt, and make sure
> you can uncompress and enable timer interrupts before the next
> expiration.  Beyond that, we wouldn't have to look for any
> watchdog service points in the kernel.
>
> I may play with it later tonight........
>
>
> -- Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3898C00E.C3636738@mvista.com>
Date: Wed, 02 Feb 2000 15:38:54 -0800
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: the ppc_n_lost_interrupts thing...
References: <20000128112126.007819@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> >However,
> >what I don't understand is - how could this possibly detect an
> >interrupt that happens while the CPU is blocking external
> >interrupt?
> >In this case, ppc_n_lost_interrupts won't be incremented and when
> >the external interrupt is re-enabled, we won't be able to get
> >into interrupt mode.
>
> The interrupt will be lost only when it's masked in the controller while
> beeing issued by the device. It's a PIC bug.
>

Hmm, I assume that not every power pc board would have this problem.
Which PIC is having this problem?  The one used in Mac?

If this is the case, it would be nice that the workaround code can be
put in the #ifdef scope.  Just a thought.

> So, we need to check it out only when unmasking the interrupt -in the
> controller-. That's what we do in pmac-pic.c. If interrupts are masked on
> the CPU but not on the controller, they are not lost. If they are masked
> in both, it's not a problem neither, at least until someone tries to
> umask one in the controller.
>
> Note that our implementation if restore_flags() will check
> lost_interrupts since the unmask call can be done while MSR_EE is 0.
>

Thanks a lot.  I got it.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

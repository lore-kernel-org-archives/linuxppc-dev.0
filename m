In-Reply-To: <3891008C.A83C47B4@mvista.com>
Date: Fri, 28 Jan 2000 11:21:26 +0100
To: Jun Sun <jsun@mvista.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: the ppc_n_lost_interrupts thing...
Message-Id: <20000128112126.007819@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 27, 2000, Jun Sun <jsun@mvista.com> wrote:

>I am a newbie to PowerPC-linux.  Hopefully this question is
>not too dumb.

Definitely not ;) Here's my understanding:

>From this, I can infer that ppc_n_lost_interrupts is used to
>"fake" a new interrupt at the end of an interrupt handling.

That's it.

>However,
>what I don't understand is - how could this possibly detect an
>interrupt that happens while the CPU is blocking external
>interrupt?
>In this case, ppc_n_lost_interrupts won't be incremented and when
>the external interrupt is re-enabled, we won't be able to get
>into interrupt mode.

The interrupt will be lost only when it's masked in the controller while
beeing issued by the device. It's a PIC bug.

So, we need to check it out only when unmasking the interrupt -in the
controller-. That's what we do in pmac-pic.c. If interrupts are masked on
the CPU but not on the controller, they are not lost. If they are masked
in both, it's not a problem neither, at least until someone tries to
umask one in the controller.

Note that our implementation if restore_flags() will check
lost_interrupts since the unmask call can be done while MSR_EE is 0.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

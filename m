Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <432E39D0-E2AA-11D6-8132-0003931C2BFA@control.lth.se>
References: <432E39D0-E2AA-11D6-8132-0003931C2BFA@control.lth.se>
Date: 18 Oct 2002 10:15:35 -0500
Message-Id: <1034954142.8169.91.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-10-18 at 09:59, Anders Blomdell wrote:
>
> > 2. When the interrupts gets enabled, the system gets an interrupt and
> > eventually
> >    calls i8259_irq, which reads 0xff from pci_intack, which it will
> > continue to
> >    do	forever in this loop (do_IRQ, arch/kernel/irq.c):
>
> A quick (and working, but probably unclean) solution is call
> 'i8259_init(intack_addr)' with intack_addr set to zero (instead of the
> 0xbffffff0 from prep_setup.c), thus forcing the interrupt to be polled from
> the 8259 controller. Could somebody who understands open_pic (is this a
> relative to MPIC?), give me a hint of suitable further reading before I to
> try to clean this up?

Seems to me that either:
a) the pci_intack value is incorrect for your board, in which case you
should correct it
b) your board's int-ack feature is broken and you'll need to poll

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

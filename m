Date: Thu, 4 Nov 1999 15:32:11 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Gabriel Paubert <paubert@iram.es>
cc: Cort Dougan <cort@ppc.kernel.org>,
        David Monro <davidm@amberdata.demon.co.uk>,
        linuxppc-workstation@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <Pine.HPX.4.10.9911041206100.2724-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96L.991104145520.4298C-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Nov 1999, Gabriel Paubert wrote:
> 
> It might not solve your problem, but anyway playing with cached_A1 and
> cached_21 while an interrupt may be coming is not healthy, to say the
> least. 
> 
> --- irq.c.orig	Thu Nov  4 12:51:20 1999
> +++ irq.c	Thu Nov  4 14:10:41 1999

[snip patch]

> > My /proc/interrupts reads:
> > 1:      576     i8259   keyboard
> > 2:        0     i8259   82c59 secondary cascade
> > 5:        1     i8259   Crystal audio controller
> > 13:  287499     i8259   ide0
> > 15:   16720     i8259   PCnet/PCI II 79C970A
> > BAD:      1
> 
> Now mine reads: 
>            CPU0       
>   1:          2   i8259         keyboard
>   2:          0   i8259         82c59 secondary cascade
>   4:          5   i8259         serial
>  16:          0   OpenPIC       82c59 cascade
>  18:       2754   OpenPIC       DC21140 (eth0)
>  19:       1930   OpenPIC       ncr53c8xx
> BAD:          1
> 8259 IMR/ISR/IRR = ffe9/0000/0040
> 
> BTW: if you apply only the part which modifies the /proc output you might
> be able to know the state of the interrupt controller when the system
> locks up. This would be interesting and probably better in a first step,
> since the rest of the patch migt clash with your source.  In my case the
> floppy interrupt is requested, but as long as it's masked...

[...]

> The 8259 is a fragile beast, plus the fact that the current
> enable/disable_irq code is completely unprotected. My patch is not
> sufficient but might be a step in the right direction (hopefully enough
> on UP). 

The spinlock patch doesn't appear to have any affect on the situation. Still
lots of "hda - lost interrupt"'s.

A normal (no disk activity) /proc/interrupts:
1:     1321     i8259   keyboard
2:        0     i8259   82c59 secondary cascade
5:        1     i8259   Crystal audio controller
13:   82733     i8259   ide0
15:   30749     i8259   PCnet/PCI II 79C970A
BAD:      1
8259 IMR/ISR/IRR = 5f99/0000/0001

When "lost interrupts" are occuring (the keyboard does still function Gabriel,
my mistake), the last line consistantly looks like:

8259 IMR/ISR/IRR = 5f99/0000/a001

The 'a' indicates that interrupts have come in on irq's 13 & 15, which would
be ide0 and the ethernet controller. So it seems Cort's memory is correct. (In
your output, is irq 6 '0x0040' the floppy drive you mention?)

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

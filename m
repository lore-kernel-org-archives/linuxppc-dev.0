Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sat, 6 Apr 2002 21:53:44 -0700
From: Matt Porter <mporter@mvista.com>
To: Greg Griffes <ggg@ieee.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 7400 mmu_init problem
Message-ID: <20020407045344.GB13833@beef.az.mvista.com>
References: <00e101c1dc8e$f4f8d720$6401a8c0@attbi.com> <20020405102854.A15453@home.com> <000d01c1ddcd$c71a2c60$6401a8c0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000d01c1ddcd$c71a2c60$6401a8c0@attbi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Apr 06, 2002 at 07:47:11PM -0500, Greg Griffes wrote:
> Matt,
>
> Thanks a ton for the advice.  Looking at log_buf did the trick.
> The Oops logs helped me to track down each access violation
> and troubleshoot the rest of my bugs.  I'm getting text from
> printk now!  I am sooo excited :-))

Ahh yes, I call it "bringup euphoria". :)  Quite fun.

> The BDI2000 wouldn't work with my hardware for some reason.
> It complained that it could not break on the boot vector.
> Tried it with both hard and soft breaks.  Booting from flash, so,
> maybe that has something to do with it.

Hrm.  Have you talked to Abatron's support?  They are quite good
and can probably give you some hints or debug enabled firmware to
see what signals may be causing the problem on your hardware.

> Question.  How do you recommend mapping in hardware that is
> common to mach_dep code and drivers?
> Specifically, the ASIC is mapped using ioremap in setup_arch so
> that functions like get_irq will work.  The ASIC also has the serial
> ports.  So, for the tty driver, it seems wasteful to map the ASIC
> again in the driver init code.  What I did, was to put serial_in
> and serial_out into myboard_setup.c where the pre-initialized
> virtual address is stored.  Is there a better approach?

Well, if you ioremap both (and each set of regs is confined to a
single 4KB page...I hope for a simple PIC and UART) then you
end up with two TLB entries in constant use.  You *could* use
an io block mapping to cover it with a BAT, if you are concerned
about TLB starvation but I suspect you won't see a recognizable
difference in performance.

Look at the use of <board>_progress and early_serial_setup() to
configure UARTs in some other ports (mcpn765, gt64260, ebony).
A useful hack is to cover your UART with a BAT in head.S.  In
<board>_setup_arch you then use early_serial_setup() with
ioremap (or the address from the optional block mapped method)
to do the real mapping of your UARTs.

> To answer your questions...
>
> > 7400 (subject line) or 750? :)
>
> The board actually supports either as you hinted.  Right now, I have a 750
> version.

Aha! :)

> > and most likely got to start_kernel:setup_arch.  I can only guess
> > that you access an unmapped area in your <board>_setup_arch.
>
> BINGO!  I had some ppc_md.progress calls after mmu_init() and before the ioremap
> calls.

Cool.  Sounds like you are moving right along.

Good luck,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

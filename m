Message-ID: <000d01c1ddcd$c71a2c60$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Matt Porter" <mporter@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <00e101c1dc8e$f4f8d720$6401a8c0@attbi.com> <20020405102854.A15453@home.com>
Subject: Re: 7400 mmu_init problem
Date: Sat, 6 Apr 2002 19:47:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Thanks a ton for the advice.  Looking at log_buf did the trick.
The Oops logs helped me to track down each access violation
and troubleshoot the rest of my bugs.  I'm getting text from
printk now!  I am sooo excited :-))

The BDI2000 wouldn't work with my hardware for some reason.
It complained that it could not break on the boot vector.
Tried it with both hard and soft breaks.  Booting from flash, so,
maybe that has something to do with it.

Question.  How do you recommend mapping in hardware that is
common to mach_dep code and drivers?
Specifically, the ASIC is mapped using ioremap in setup_arch so
that functions like get_irq will work.  The ASIC also has the serial
ports.  So, for the tty driver, it seems wasteful to map the ASIC
again in the driver init code.  What I did, was to put serial_in
and serial_out into myboard_setup.c where the pre-initialized
virtual address is stored.  Is there a better approach?

Greg

To answer your questions...

> 7400 (subject line) or 750? :)

The board actually supports either as you hinted.  Right now, I have a 750
version.

> and most likely got to start_kernel:setup_arch.  I can only guess
> that you access an unmapped area in your <board>_setup_arch.

BINGO!  I had some ppc_md.progress calls after mmu_init() and before the ioremap
calls.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

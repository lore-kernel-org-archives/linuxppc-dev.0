In-Reply-To: <00012019473900.07177@localhost.localdomain>
Date: Fri, 21 Jan 2000 12:54:42 +0100
To: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000121125442.015889@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 20, 2000, Kevin Hendricks <khendricks@ivey.uwo.ca> wrote:

>From the various posts (given the operand ordering done in the original
post),
>here is what I have tried to piece together.
>
>asm volatile ("stwbrx %1,%2,%3; eieio" : "=m" (*(volatile unsigned
>*)(base_addr+regindex))       : "r" (regdata), "b" (regindex), "r"
>(base_addr));
>
>asm volatile ("lwbrx %0,%1,%2; eieio" : "=r"(val) : "b"(regindex),
>"r"(base_addr), "m" (*(volatile unsigned *)(base_addr+regindex)));

Hi Kevin !

A good rule is to use eieio() when accessing a register (that means doing
an access that actually performs an action and whose ordering is
important relative to other accesses of the same type) and not use it
when filling the framebuffer. There are usually few enough register
accesses for this to work. it may be optimal to skip eieio's when writing
to a bunch "parameters" registers where ordering is not important, in
this case you just need to put an eieio() between those, and the register
write that triggers the engine operation that will use those parameters.
However, when doing that, the PCI bridge is allowed to combine your
register writes in a burst, and I know some cards who don't handle burst
access to MMIO registers very well.

Basically, eieio() will make sure that all previous memory accesses will
have been finished before memory accesses after the eieio are done.

It may be important to make sure that the last bit of framebuffer has
been written before "starting" an engine operation. So one eieio between
frame buffer filling and engine register access may be useful in the case
where you use eieio after the write in the asm.

I personally tend to prefer doing the eieio _before_ the read/write in
the asm code, but there are some rare cases where you mix eieio and
non-eieio accesses (like with your framebuffer) where special care must
be taken and may require both eieio before and after the register access.

Another thing to take care of is PCI write posting: Basically, when you
write, let's say, a MMIO register, you are not guaranteed that this write
have actually been done unless you do a read from the same io space. For
example: If you write an interrupt mask register to disable an interrupt
followed by critical code in which this interrupt _must not_ happen, you
need absolutely to do a read (typically to re-read the mask you just
wrote to) after the write, and before the critical code.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

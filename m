Date: Fri, 21 Jan 2000 14:34:03 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <20000121125442.015889@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10001211317100.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 21 Jan 2000, Benjamin Herrenschmidt wrote:

> Hi Kevin !
>
> A good rule is to use eieio() when accessing a register (that means doing
> an access that actually performs an action and whose ordering is
> important relative to other accesses of the same type) and not use it
> when filling the framebuffer. There are usually few enough register
> accesses for this to work. it may be optimal to skip eieio's when writing
> to a bunch "parameters" registers where ordering is not important, in
> this case you just need to put an eieio() between those, and the register
> write that triggers the engine operation that will use those parameters.

Indeed, that's what I do in my VME driver. I did not like the fact that
readl/writel always insert an eieio. This is safe but almost doubles the
number of bus cycles. Very often it translates into:

- a bunch or register accesses,
- eieio,
- the access which triggers the operation (which was a read in some cases
  for the VME driver).
- eieio again, so you don't have problems with setting up the next
operation...

> However, when doing that, the PCI bridge is allowed to combine your
> register writes in a burst, and I know some cards who don't handle burst
> access to MMIO registers very well.

Broken HW exists but in a device specific driver, you should know whether
it is necessary or not from the errata...

> Basically, eieio() will make sure that all previous memory accesses will
> have been finished before memory accesses after the eieio are done.
>
> It may be important to make sure that the last bit of framebuffer has
> been written before "starting" an engine operation. So one eieio between
> frame buffer filling and engine register access may be useful in the case
> where you use eieio after the write in the asm.

If there is one before the register access that triggers the engine
operation, it should be enough.

>
> I personally tend to prefer doing the eieio _before_ the read/write in
> the asm code, but there are some rare cases where you mix eieio and
> non-eieio accesses (like with your framebuffer) where special care must
> be taken and may require both eieio before and after the register access.

That's a good quetion, does anybody have any final conclusion about
whether it is better to ensure ordering before or after the access ?

> Another thing to take care of is PCI write posting: Basically, when you
> write, let's say, a MMIO register, you are not guaranteed that this write
> have actually been done unless you do a read from the same io space. For
> example: If you write an interrupt mask register to disable an interrupt
> followed by critical code in which this interrupt _must not_ happen, you
> need absolutely to do a read (typically to re-read the mask you just
> wrote to) after the write, and before the critical code.

In this case, I think that you need the following:

- write,
- eieio,
- read,
- isync to make sure that the read has reached the registers and is not in
a load pending queue or whatever which can be quite deep especially if the
processor does never need the result of the read...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

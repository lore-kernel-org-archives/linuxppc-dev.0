Date: Fri, 21 Jan 2000 02:53:10 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012019473900.07177@localhost.localdomain>
Message-ID: <Pine.HPX.4.10.10001210151470.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	Hi,

> I don't want to be dense here but why two macros (one with eieio and one without
> eieio).  Can two processors in an SMP setting be trying to drive the same
> video card at the same time?   I didn't think that was possible.  I saw the
> eieio usage in the kernel versions and in aty128fb.c but thought that multiple
> processors might use those macros at the same time and multiple processors
> might have different fbdev drivers running in multi-head applications.  But I
> thought only one processor could drive a video hardware card.  Is this a bad
> assumption?

Multiple processors attempting to access the video hardware should be
serialized one way or anoter (semaphores or whatever).

> So exactly what is the best way to write these macros for Xpmac?  Using
> the output constraints approach with eieio following it or is all of this
> overkill.

eieio may be useful and even necessary when accessing the registers, but
in the frame buffer section it prevents the processor from performing
store merging to non guarded memory and other optimizations (like the
bridge to merge the writes and transforming them into bursts to the
framebuffer).

eieio is also necessary to avoid load from being moved before stores when
accessing IO registers: if your intent is to write to register A and then
read register B and that the first write actually changes the contents of
register B (for example your trigger an operation with the write and wait
for it to finish by reading register B which contains a busy bit), then
the eieio is necessary (it is not necessary if the registers are the
same).


> >From the various posts (given the operand ordering done in the original post),
> here is what I have tried to piece together.
>
> asm volatile ("stwbrx %1,%2,%3; eieio" : "=m" (*(volatile unsigned
> *)(base_addr+regindex))       : "r" (regdata), "b" (regindex), "r" (base_addr));
>
> asm volatile ("lwbrx %0,%1,%2; eieio" : "=r"(val) : "b"(regindex),
> "r"(base_addr), "m" (*(volatile unsigned *)(base_addr+regindex)));

I actually doubt that the eieio are necessary but then I'm not a
specialist on this kind of hardware. Every eieio is a bus broadcast
operation (except on 603, on G3 it is IIRC an option controlled by a bit
in HID0) and actually has a cost comparable to a write posted I/O access
but the other consequences (preventing bursts on the I/O bus) may actually
cause a significant performance hit.  So it should be used only when
necessary...

> Please let me know how to change the above so that I get it right this time.

Try to determine first whether the eieio are necessary; for access to the
frame buffer I'm almost sure that they are superfluous and potentially
very costly in terms of performance. For the MMIO I suspect that they may
be necessary at some places, but adding them systematically will have less
impact.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

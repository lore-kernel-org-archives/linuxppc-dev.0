Date: Fri, 21 Jan 2000 20:08:30 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <4.2.2.20000121163838.05255ad0@mail.munich.netsurf.de>
Message-ID: <Pine.HPX.4.10.10001211811030.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 21 Jan 2000, Franz Sirl wrote:

> >    "You can prevent an `asm' instruction from being deleted, moved
> >significantly, or combined, by writing the keyword `volatile' after the
> >`asm'."
> >
> >You might disagree, but I consider that moving across a volatile memory
> >reference is a _significant_ move, a very significant one.
>
> asm volatile doesn't declare any volatile memory references! What makes you
> think it does?

No it does not declare any volatile memory reference, but it is
"guaranteed not to be moved significantly". What does this exactly mean ?

Anyway asm volatile statements are guranteed not to reordered wrt each
other. So let us illustrate it with examples; if you write:

asm volatile("stwbrx...", ...);

asm volatile("eieio");

asm volatile("lwbrx...", ...);

the compiler should respect the order even without nasty memory clobbers.
The funny thing is that if the accesses are big endian or byte, then you
don't need the asm and a reordering might perhaps take place. In this
case:

*(volatile unsigned *)output_reg = data;

asm volatile("eieio");

result = *(volatile unsigned *) input_reg;

then the eieio might move become the first or last statement according to
what you say. I consider that this does not reflect the documentation
since moving across a volatile memory reference is a significant move
in my book.

Note that the documentation also states clearly that such an asm without
any parameters is considered as having undeterminate side effects so it
might actually not be moved, but it might be as bad as a memory clobber.

> There was a lengthy discussion about this with Richard Henderson on the
> gcc/egcs lists a while ago. The result was a rewrite of
> linux/include/asm-ppc/io.h in the kernel to it's current state.

I remember, but my goal is a memory-clobber-free kernel, although there
are many other efficiency issues right now in Linux/PPC...

	Gabriel
	(desperately trying to build gcc_latest_snapshot)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 21 Jan 2000 01:05:26 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012023473100.01038@enzo.bigblue.local>
Message-ID: <Pine.HPX.4.10.10001202357570.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 20 Jan 2000, Franz Sirl wrote:

> It depends a little bit on the usage of the asm's if the memory (either
> global or local) clobber is needed or not. If you use them for read/writes to HW
> registers needing ordering (which is very likely here since we talk about
> graphics HW), the compiler can only decide on the memory usage defined by the
> clobbers/memory inputs on how to order the inlines (volatile has no effect on
> this).

Do you mean that a volatile memory reference can be reordered wit an asm
volatile statement ? I thought theat this was not possible.

>From GCC's documentation:

   "You can prevent an `asm' instruction from being deleted, moved
significantly, or combined, by writing the keyword `volatile' after the
`asm'."

You might disagree, but I consider that moving across a volatile memory
reference is a _significant_ move, a very significant one.

> Actually the load instructions need a memory input too:
>
> asm volatile ("lwbrx %0,%1,%2" : "=r"(val) : "b"(regindex), "r"(base_addr),
> "m" (*(volatile unsigned *)(base_addr+regindex)));

Indeed, perhaps even more than the store since asm without output operands
are actually assumed to have side effects.

>
> And to insure ordering on processor level you still need the eieio (with a
> memory clobber) as usual.


The best thing to do is probably to put the eieio inside the asm
statement, perhaps with 2 macros, one that includes the eieio and one that
does not include it.

Memory clobbers should be used extremely sparingly, I view them as the
last resort when _nothing_ else would work. They are used far too often
for my taste in the kernel, probably because they don't affect
significantly machines with very few registers like Intel which have to
permanently spill registers to memory or stack.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 11 May 2001 12:09:11 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: frowand@mvista.com
Cc: Brian Kuschak <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <3AFAE7A0.AE936C64@mvista.com>
Message-ID: <Pine.HPX.4.10.10105111148150.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 May 2001, Frank Rowand wrote:

> Gabriel Paubert wrote:
> >
> > Why not ? I'd like to find an explanation of a possible failure mode.
> > All PPC systems have always used a simple store for atomic_set. If it does
> > not work, there is something seriously wrong, perhaps even a hardware bug.
> >
> > This is especially true on a UP system. Whatever value is stored by a stw
> > should be seen by any following lwarx/stwcx., on SMP you may need an
> > eieio. But on UP I can't see how it can affect anything.
>
> >From the "PowerPC 405GP Embedded Processor User's Manual", in the "Instruction
> Set" chapter (which describes each instruction), the Programming Note for lwarx
> says:
>
>   lwarx and the stwcx. instruction should be paired in a loop, as shown in the
>   following example, to create the effect of an atomic operation to a memory
>   area used as a semaphore between asynchronous processes.  Only lwarx can set
>   the reservation bit to 1.  stwcx. sets the reservation bit to 0 upon its
>   completion, whether or not stwcx. sent (RS) to memory.  CR[CR0]EQ must be
>   examined to determine whether (RS) was sent to memory.
>
>     loop: lwarx  # read the semaphore from memory; set reservation
>     "alter"      # change the semaphore bits in register as required
>     stwcx.       # attempt to store semaphore; reset reservation
>     bne loop     # an asynchronous process has intervened; try again
>
>   If the asynchronous process in the code example had paired lwarx with a
>   store other than stwcx., the reservation bit would not have been cleared
>   in the asynchronous process, and the code example would have overwritten
>   the semaphore.
>
>
>
> So if the lwarx occurs,
>
> then an interrupt alters the flow of execution,
> and the interrupt handler uses a stw to implement atomic_set(),
>
> then the interrupt handler returns to the original flow of execution,
>
> then the stwcx. succeeds, even though the value of the semaphore was
> altered by the atomic_set().

The solution to this is to guarantee that the reservation is always lost
on return from interrupt. This is exactly what my patch does, but it does
it just before the rfi, guaranteeing that the reservation is lost in all
cases, even if you have a down_trylock on another path which could return
with a stale reservation.

> > Did it actually have any effect on Brian's system ?
>
> Changing atomic_set() to use lwarx / stwcx. instead of stw had an
> effect on my 405GP systems here (including the Walnut and also
> the same custom board that Brian is using).

Please try the last patch I sent to the list instead and report. It should
have the same effect and protect against other (actually all AFAICT) cases
of stale reservations.

I might still have missed some cases, but it won't bloat the atomic_set()
macros and handle correctly the case of an interrupt that ends with
a failing down_trylock or spin_trylock just before returning.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3C17E3B4.9E73B22E@labs.mot.com>
Date: Wed, 12 Dec 2001 17:09:40 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled - problem found
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com> <3C14F91F.F382ABE3@labs.mot.com> <3C177748.1A1342C2@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here's another update for anyone interested:

Steve Rossi wrote:

> ...Is there a mechanism by which
> all lower priority interrupts are disabled when a higher priority one is running?

This is exactly the problem. I was able to run with data show-cycles enabled so
I could trace exactly what was happening with the SIVEC, SIMASK & SIPEND. Here's the
situation that causes the problem I described in earlier posts:
The hard disk interrupt (IRQ6) does data transfer in the ISR itself - as a result
the ISRs are very long, and furthermore, the interrupt signal is asserted again
before the service routine is exited and IRQ6 is unmasked - so as a result, as soon
as its unmasked, it causes a new interrupt to the core and IRQ6 is entered again.

Take the situation where IRQ2 becomes active between the time when IRQ6 is unmasked,
but before the next pending IRQ6 is entered. SIVEC is read, and indicates IRQ2, IRQ2
is masked & acked, then since IRQ2 is NOT flagged with SA_INTERRUPT, the interrupts
to the core are enabled. Immediately, the core recognizes that IRQ6 is pending and
unmasked so it begins to service it. Essentially IRQ6 pre-empted IRQ2, IRQ2 is
masked out. IRQ6 will run, unmask, interrupt again, mask, run, unmask, interrupt
again ... etc until the complete transfer to the disk is done. Only when there is no
longer any other interrupts pending will the IRQ2 which was preempted earlier finish
running - many milliseconds after IRQ2 was triggered.

So the problem is that mask & ack only masks the pending interrupts when I believe
it should mask the pending interrupts and all interrupts that are lower priority
than it. Conversely unmask should unmask the given interrupt and all interrupts of
lower priority that were previously unmasked when mask&ack was called. Is that right
or am I missing something here?


Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

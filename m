From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Need for persistent CPU data
Date: Mon, 26 Aug 2002 18:17:35 +0200
Message-Id: <20020826161735.7727@192.168.4.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul !

I managed to get a hand on some more recent Darwin kernel sources,
and found out a few interesting things that we probably need to
implement as well, though that leads to a couple of problems:

 - Some CPUs need L2 prefetch to be disabled during NAP mode
(notably 745x). That would eventually explain some issues I
got reported here where L2 would prefetch crap and/or would
cause L3 activity causing the CPU to miss a request for snoop
cycle (see CPU erratas)

 - The 750FX (with it's dual PLL) really wants to idle in low
speed mode. (May that explain what we got reported of a 750FX
dying on NAP mode ?)

There may be others coming in the future where we want some
CPU state to be changed for the duration of the NAP. The problem
is that it means we want to restore those when getting out of
NAP mode. Typically, that means we want to restore those in
transfer_to_handler (DEC & EE are typically what cause us to
get out of NAP).

I also spotted in their code that it seems the CPU may actually
miss the NAP transition (setting of MSR:POW). If that happens,
it also means the CPU will get out of the power_save function
without having taken an interrupt, thus without restoring it's
state.

So what I'm looking for is a way to quickly, from transfer_to
_handler, know that I'm coming from NAP mode. Though that may
make sense for a couple of other cases as well, that means we
really want some quick way to get to some "CPU status" bit mask
that I'd rather have in a CPU register than in memory.

Possible candidates I found are:

 - Reserve one more GPR (ugh !)
 - Use bits in PIR (looks like most CPUs actually implement
at least 4 low bits on this one, though I'd rather use it for
what it's meant for, that is a fast smp_processor_id())
 - Use a pair of bits of SPRG2/3 as those are pointers as the
exception stack pointer shouldn't take the whole 32 bits address
space, can it ? Well... that is nasty
 - Manage to free SPRG0 or SPRG1 by working out the exception
entry differently
 - Really put those in memory, but in order to make things
quicker, use PIR to store a CPU number, and have the N words
of memory starting at 0 physical contain the attributes for
each CPU, so we just need to mfspr PIR, rx, then lwz 0(rx) to
get to the flags.

Whatever way we choose, that would allow transfer_to_handler
to know it's getting out of NAP mode and proceed to whatever is
needed to undo what we may have done there. That includes restoring
HID1 and MSSCR0 in the 2 cases I've spotted above (wow, I also
need to put some per-CPU storage for the backup values).

Any comments ? suggestions ? I'm about to do the later (use PIR
and an array in low memory) in my tree, all this controlled by
a CPU feature so i don't try to do this on things like 601 ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

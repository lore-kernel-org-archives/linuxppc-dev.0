Date: Mon, 7 Aug 2000 14:33:00 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <20000804155023.5420@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008071358050.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Benjamin Herrenschmidt wrote:

> On recent Core99 machines, Apple has a HW timer in the KeyLargo ASIC that
> can be used to sync timebases. (It looks like a 64 bits bus-cycle timer,
> but I'm not completely sure yet). There's also, I beleive, the OpenPIC timer.

OpenPIC timers are not that easy to use since they are not guaranteed to
ultimately run off the same oscillator as the processor time base, so you
can't guarantee a stable mathematical relationship between the timebase
and an OpenPIC timer count register.

Of course it will work in many machines (you would have to sacrifice one
of the 4 timers to do this but that's not a big deal). You would also have
to keep the most significant timebase bits and some other data in some
other places (the OpenPIC timer has only 31 bits and runs at 1/8 the bus
clock on integrated Motorola OpenPICs but 1/8 the PCI clock if you have an
IBM MPIC2 chip). I'm looking for a solution for SMP which does not depend
on the exact underlying hardware (it may require IPI but these are quite
well encapsulated), like a few interlocked memory accesses to transmit the
timebase and check that they are close enough.

Oh, BTW, in the OpenPIC timer specification the following is so laughable:

- integral number of clock ticks per second

Knowing that this number is required to be >= 4 million and the stability
of typical computer oscillators, I can guarantee that the fractional part
can be used as a fairly good random number generator (provided you don't
measure it too often).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

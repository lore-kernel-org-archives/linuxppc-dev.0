Date: Tue, 8 May 2001 03:37:36 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
Cc: Eli Chen <eli@routefree.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <3AF73161.26986237@mvista.com>
Message-ID: <Pine.HPX.4.10.10105080200190.22253-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 May 2001, Dan Malek wrote:

> Eli Chen wrote:
>
> > >From the PPC manual:
> > "Because the hardware doesn't compare reservation address when executing the
> > stwcx.
>
> F**K...that's what I was looking for.  What manual is that in?
> Everything I have handy (older UISA books), state the granularity
> is implementation dependent.  I couldn't find any 4xx manual that
> stated the granularity of the reservation.  I thought 6xx/7xx at
> least checked cache line granularity in addition to a single
> reservation bit.

Nope. The reservation address register sits on the bus side for snoops,
and is at least on 601 and 603/603e only used to clear the reservation bit
in case of snoop hit. The pem makes it clear that adress chcking is
implementation dependent.

Anyway on SMP the following scenario:

1) processor 1:  sem=1, down(sem) interrupted between lwarx and stwcx.
   reservation set, sem=1 in RAM, value to store 0
2) processor 2: down(sem), sem = 0, clears reservation on processor 1
3) processor 1: interrupt handler ends in down_trylock(sem) which fails
   but sets reservation, sem = -1
4) processor 1: down(sem) finishes succesfully and stores 0 since it
   misses the modification of step 2.
5) Now two processors access the data protected by the same semaphore,
   causing interferences, generally of the destructive kind. The value of
   the semaphore when nobody has acquired it is 2, it has become useless as
   an interlock mechanism.

does screw up with only using a single variable. I've not been able to
find such a scenario on UP, this does not mean it can't be built, however.

Fix: stwcx. at the return from interrupt, again.

> Gabriel is right................

I'm myself more and more convinced myself that this is really a bug, and
a rather serious one. Now the question is whether the patch
I suggested is correct or not. It does not fix Eli's problems, so
either my patch is wrong or something else is going on.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

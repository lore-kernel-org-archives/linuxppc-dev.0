Date: Fri, 11 May 2001 12:57:58 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
Cc: frowand@mvista.com, Brian Kuschak <brian.kuschak@skystream.com>,
	Eli Chen <eli@routefree.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <3AFB009A.6B1C8F76@mvista.com>
Message-ID: <Pine.HPX.4.10.10105111119110.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 May 2001, Dan Malek wrote:

> Gabriel Paubert wrote:
>
> > Why not ? I'd like to find an explanation of a possible failure mode.
>
> Because the 4xx sucks........unlike other PowerPC processors, it
> doesn't appear to use any of the reservation address to break or
> match a lwarx.

Nother do 601, 603, and a lot of others...

>
> > All PPC systems have always used a simple store for atomic_set. If it does
> > not work, there is something seriously wrong, perhaps even a hardware bug.
>
> Yeah, it does sound kind of broken, but then the 4xx isn't any
> shining example of something that follows the PowerPC architecture.
> Other PowerPCs have a reservation granularity, so _any_ store operation
> within this will cause the reservation to be broken.  The 4xx seems
> to have no granularity, and further has inverted the logic.  Without
> granularity _any_ store operation anywhere should break the reservation,
> but in this case no store operation will break it.....very bad.

I am confused, but stores from the local processor _never_ clear the
reservation (at least on all processors I have testes) and this very
clearly documented. The only two operations which are guaranteed to clear
the reservation are:

a) stwcx.

b) snoops for writes to an address within the reservation granule

The reservation address is monitored on the external bus, not on the
internal side.

For a proof I just tested the sequence lwarx + stw + sync (just in
case) + stwcx. to the same address as well as stwcx. at a different
address from the lwarx on 7400, 750 and 603e. They are all succesful.
I have appended the test code so you can check it.

> What can happen is a lwarx to an address, in some other context a
> simple store to that address (no reservation broken) then a subsequent
> stwcx. to the address will appear successful.  Hmmmm.....several
> ways to fix it, I wonder what will work best.....

Not even "in some other contexts". I think that moving the stwcx. from
transfer_to_handler to interrupt returns solves this, since it guarantees
that you never let a stale reservation mess up with an interrupted atomic
sequence.  Unless of course you have a hardware bug and stwcx. does not
clear the reservation in some cases, which would be serious enough to
say that this part is not supported.

If I miss something, I'd like a scenario like the ones I posted on this
thread to be enlightened. Especially a scenario which would fail with my
patch applied.


	Regards,
	Gabriel.


Code to verify:
a) that local stores do not clear the reservation.
b) that stwcx. does not check the address

#include <stdio.h>

static volatile int atom[1024];

int main(int argc, char**argv)
{
    	int tmp;
	atom[0] = 0;
	/* Check for stw between lwarx and stwcx. */
    	asm("\n\
	lwarx %0,0,%2\n\
	stw %3,0(%2)\n\
	sync\n\
	addi %0,%0,2
	stwcx. %0,0,%2\n
	mfcr %0\n
	rlwinm %0,%0,3,1"
	: "=&b" (tmp), "=m" (atom[0])
	    : "r" (atom+0), "r" (4), "m" (atom[0])
	: "cr0");
	printf("Last stored value is %d, stwcx. flag=%d\n", atom[0], tmp);
	/* Check for stwcx. at a different address from lwarx */
	atom[0] = -1;
	atom[512] = 0;
    	asm("\n\
	lwarx %0,0,%2\n\
	stwcx. %0,0,%3\n
	mfcr %0\n
	rlwinm %0,%0,3,1"
	: "=&r" (tmp), "=m" (atom[512])
	: "r" (atom+0), "r" (atom+512), "m" (atom[0])
	: "cr0");
	printf("Last stored value is %d, stwcx. flag=%d\n", atom[512], tmp);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

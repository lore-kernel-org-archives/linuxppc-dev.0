Message-ID: <3BE19161.8060402@mvista.com>
Date: Thu, 01 Nov 2001 13:16:01 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Wolfgang Grandegger <wg@denx.de>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Multi-level CPM Interrupts
References: <20011031211949.C52D411269@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:


> It seems you did not real until the end of Wolfgang's message; he wrote:
>
> | it easily allows RTAI users to use CPM interrupts.

Well, I know that other people are running RTLinux without the same
modification, so "easy" must be a relative :-).

> We need this for RTAI, and I don't see any problems with it.

The problem I have is that it is a reasonable argument for exactly
the _one_ board you have.  We have tried to do what you are asking
in the past, and it resulted in a big mess.  A multiple level interrupt
controller has interrupts numbered from zero to the extent of their
implemetation, few are the same.  Further, on processors with flexible
integrated peripherals, the _real_ interrupt number for that particular
service controller has to be programmed into the peripheral.  On one hand,
you "simplify" the programming interface, and on the other you make it
a confusing implementation of arithmetic/shift/macros and configuration
unique to nearly every board.  With the current implementation all of
the 8xx boards are generally supported (or generally broken, if you choose
the "half-empty" outlook on life :-).

In all cases, moving everything under a virtual, single programming
interface doesn't remove the underlying interrupt management you have
to perform in a RTLinux environment.  There is still _only one_ CPM
interrupt vector from the perspective of the exception handler.  IMHO,
you still have to design the software to work with that, so why not
just admit it's different under all circumstances instead of just one?

We had a multilevel interrupt structure for a short time back in the
late 2.1.xxx development days.  Because we couldn't find a way to make
it support the legacy PeeCee AT cards without changing the API in the
drivers, it was dropped.  I don't want to promote the kind of change
you are requesting because it will simply propagate and become the
same mess we have seen in the past.  The proper solution is to design
a multlevel interrupt structure and acknowledge the hooks necessary
for something like an RTLinux insertion.  This design goal isn't unique
to 8xx.  There are many PowerPC boards with a variety of interrupt
controller designs that would benefit from this.  Let's do something
to make forward progress that benefits everyone instead of a modification
unique to one board.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3A2EB9A5.65311F2E@mvista.com>
Date: Wed, 06 Dec 2000 17:11:49 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.4.0-test11 - MPC860T FEC question.
References: <200012040859.eB48wj301431@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> I was wrong here. The _interrupt_ comes  just  when  it  should.  The
> problem is that the function which actually sets the "fep->link" flag
> (mii_relink)  is  not  run  immediately,  but  from a queue_task(...,

I don't like the queue_task stuff (this wasn't my doing).  The MII/link
interrupt should be handled as part of the interrupt handler like it
used to be (until the late 2.3.99 code when this was changed).

> &tq_scheduler) call - and it's scheduled much too late for  BOOTP  to
> work.

Well, BOOTP in the kernel is going away soon, so it won't matter
much longer.


> How should we handle this? I've tried to  compare  against  the  82xx
> code  in "fcc_enet.c", but this seems to be kind of incomplete; there
> is no mii_link code at all, and the mii_relink()  function  is  never
> used.

The 8260 is very incomplete.  The problem is the MII control/status
is disconnected from the ethernet controller.  The 860T FEC would
generate an interrupt when the bit shifting was done, but the 8260
requires software to do this.  The 8260 is going to get one of two
equally ugly solutions, either a tasklet that runs for the purpose of
managing the MII, or to simply to software shift and poll the MII in
line with other functions.  I stared with the FEC driver on the 8260,
hoping I could find a way to utilize the better multiple PHY support,
but I ended up just hacking it out and leaving a few functions around
as a reminder to try and find some common MII functions with the FEC.
It's not happening very fast.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

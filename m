Message-ID: <3AD5E66D.5CA8199C@mvista.com>
Date: Thu, 12 Apr 2001 13:31:25 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Scott Rogerson <sar@pt.com>
Cc: hea23587@bigwig.net, linuxppc-embedded@lists.linuxppc.org,
	jtm@smoothsmoothie.com
Subject: Re: Ethernet Bridging on 8260
References: <3AD5B240.49C8A846@pt.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scott Rogerson wrote:
>
> I encountered the same problem with the FCC driver for the 8260.  For
> the most part I agree with your analysis of the problem.  I think
> however that you may have an unintended consequence with your solution.

I think "problem" and "solution" are a little out of context here.
I certainly don't have any emotional attachment to this code and
actually hope for improvements, but I also have experience with
developing software for bridges and routers.  Based on that
experience I would have used a completely different design than
Linux provides if you are trying to build such equipment (or better,
use Linux on something like MMC network processors).

As stated in a previous message, Linux does have the ability to
relieve some of the memory pressure when the CPU core can't keep
up with the incoming packet rate.  If the CPU can't keep up,
what else is there to do?  The current driver will process Ethernet
frames as fast as they come in.  I would like to make a few changes
to handle smaller BD fragments, which would be a little more memory
efficient, but wouldn't do anything to solve the situation where
the CPU core is too slow to handle the IP processing.  Making changes
in the Ethernet driver for resource scheduling the IP stack just
doesn't seem like the right thing to do.

Adding a tasklet for the actual processing of incoming frames,
so it can be scheduled against (or assist with) user tasks would
be OK.  Just remember that what this does is cause the FCC to
discard incoming frames as the resource management.  This may not
be acceptable because it will increase the IP processing load
by requesting retransmissions, and this really hurts for large
UDP buffer sizes (because any missing fragment causes the entire
UDP to be resent).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3A2693B6.B79E95FD@mvista.com>
Date: Thu, 30 Nov 2000 12:51:50 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org,
        dan_malek@mvista.com
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <m141Uzk-001SzWC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

> ....  When I run with FEC2 active,
> I get a type of 0x00437412.  I would expect this to look something
> like 0x0180????.

Probably an MII timing problem.


> When Dan Malek runs with the National Semi PHY DP83840A, how fast
> is the MPC8260 running?

I run a variety of clock speed combinations depending upon
performance data customers request.

> ....  I think that Dan is running at 166Mhz,
> if so we might have a timing problem on I2C bus.

You mean MII control/status lines, I assume.  I have had lots of
trouble with this and am constantly changing the MII function in the
driver.  I have used about six different PHYs on a variety of boards,
none of them will respond the same.  Some seem very sensitive to the
clock duty cycle, and I may just have to write some function that
carefully provides the clock using the timebase registers and interrupts
disabled.  I don't want to do this because of the interrupt latencies
it could cause.  You can tune this function to work with one or two
PHYs, and when you try something else it just doesn't work.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

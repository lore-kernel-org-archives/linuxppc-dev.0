Message-ID: <366D8CF9.55DF77F9@jlc.net>
Date: Tue, 08 Dec 1998 15:32:57 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981207215711.7923A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> Right, the rtc is probably more accurate over a long period of time...

Nope, not even close.  If you convert rtc drift specifications and
processor oscillator drift specifications to a common reference (like
PPM) you will see processor oscillators are significantly better
than any rtc.  Of course, running PLLs with high multipliers, like
32kHz up to 50 Mhz will cause wide variations, but over a long
period of time they will they will be more accurate time keepers.


> .......  The drift should be corrected by
> a time daemon.

Yes, but sometimes they are the cause of the problem, so
check that too.

If the PPC decrementer does not appear to be keeping time correctly,
first ask how often the system is restarted.  Since the time is
initially set from the rtc, if that is out of whack (and many are)
and you reboot frequently, the system time will drift from a
wall clock in a hurry.   The decrementer should keep time
very accurately from system start up to shut down.  If it
isn't we have some fixing to do.  I believe the design to
be correct, but the implementation may be a little flawed.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

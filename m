From: benh@kernel.crashing.org
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: roger blofeld <blofeldus@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sungem bug or something else?
Date: Thu, 6 Jun 2002 22:25:23 +0200
Message-Id: <20020606202523.13690@mailhost.mipsys.com>
In-Reply-To: <D1467143-798D-11D6-8CF5-0003938E434C@ivey.uwo.ca>
References: <D1467143-798D-11D6-8CF5-0003938E434C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi,
>
>Does sungem use autonegotiate to determine its interface type and speed
>(like some  of the more advanced interface drivers) or does it look at
>the rom or use a table?
>
>If it autonegotiates, does the driver actually wait long enough for the
>autonegotiation to fully complete before returning the first time?

It autonegociates first, then tries fixed speeds, etc..

>Under some tulip drivers, I noticed something very similar (but no oops,
>just a inability to use the driver until I rmmod and then insmod it
>once).  I think it happens because the the autonegotiation results where
>handled asynchronously and the main driver routine simply started it and
>returned before the auonegotiation actually completed and the interface
>and speed were properly determined.  The problem was right after
>bringing up the network in the boot sequence things tried to use it (the
>appletalk drivers, etc).  So if I waited to insert the module for the
>driver until after everything else was started (at the end of the
>bootsequence) all was well.
>
>This is all just a wag, but it is something to look at.

Nah, it's clearly the chip beeing powered down. I know I have a bug
in the driver that doesn't prevent HW access to the PHY via the
ethtool ioctl's when the chip is down, and that will cause a Machine
Check. I just didn't yet take the time to fix it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

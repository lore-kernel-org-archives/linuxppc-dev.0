Date: Sat, 29 Dec 2001 11:49:15 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112291949.fBTJnFc00222@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Recommendations for LXT971A PHY MII interrupt connection
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We had a problem where suddenly the ethernet would stop working, once
there was a lot of outgoing traffic from the box. It turned out it only
happened when plugging the ethernet into a full duplex switch instead of
a half duplex hub. In full duplex there are now two interrupt indicators,
on TX and RX. In half duplex the interrupt bits are shared. So the driver
has to know what duplex the PHY is in. How does it find out? The best way
is to allow the PHY to interrupt the cpu when the status changes.

The 10/100 rate seems irrelevant, the driver appears to get the information
then do nothing with it. But the duplex really matters.

I had the PHY interrupting on completion of the auto-negotiation. In that
case you don't get an interrupt if a line is unplugged, just when a line is
plugged in. The only problem seems to be what register to examine in the
PHY to find out the line status, there doesn't appear to be a standard.

An alternative is to program the PHY to only negotiate half duplex mode.
Then nothing really can change that you care about.

I think an important lesson here is do testing under various conditions. It
turned out in all our testing in the lab we had always plugged the box into
hubs, which were half duplex. It took some time for us to figure out why
the box was failing, first we were worried about the cabling, then the
switch itself, then the hardware on that box possibly being bad. It was only
after ruling all out that we figure out it was the full/half duplex.

We still haven't tried doing any testing with 10 base T though :^(.

-Dave

>Being lazy, the preferred (by me) method is not to use a PHY
>interrupt at all :-) You need the PHY interrupt only in cases when
>you need to get informed about link status changes. Few applications
>really need this type of information (although it's "interesting",
>especially during board bring-up).
>
>Hope this helps,
>
>Wolfgang Denk

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

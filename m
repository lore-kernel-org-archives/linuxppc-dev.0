Date: Wed, 2 Jan 2002 21:54:42 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201030554.g035sgW00250@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: fcc_enet.c phy mii communication broken
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I switched from HHL 2.4.2 to the standard 2.4.17 kernel (surprisingly
easy, actually). One thing I found was the mii communication was broken in
arch/ppc/8260_io/fcc_enet.c

It was working in 2.4.2 but someone made changes that couldn't
possibly have worked. There is a loop where in the old version only
14 bits are clocked out, but in the new version 16 are. Then in both
versions 2 more bits are clocked either in or out depending on whether
it is a read or write operation. Then in the new version, on a read,
one more bit is clocked and lost before bits begin to get saved. The
net result is the 3 most significant bits are lost, and the data ends up
getting shifted 3 bits to the left, whereas on the original version it
worked fine.

What's more, this code isn't even getting called. Someone broke the
code, then disabled calling of it. They also removed the phy_speed from
the fcc_enet_private structure. True, it wasn't getting used but it
might eventually be. The system was locking the port in half duplex
mode.

I changed the way the system operates. I added fields in the fcc_info_t
structures which tell the interrupt number and the phy number, so if they
are specified those are taken to determine line settings. That is required
if there is more than one PHY. Then I install an interrupt handler for
the PHY interrupt, that will set the duplex/speed after auto-negotiation.
Also the mii_discover_phy_poll has to be called before the init_fcc_startup,
otherwise the duplex is set wrong. On and on and on...

Also someone removed the MII #defines and replaced them with magic numbers.
Why would anyone do that? It makes the code more cryptic and less useful.

Anyway just be warned that the mii_send_receive function is broken. You'd
be better off going back to the 2.4.2 version, if you find you're having
no luck with mii communication.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

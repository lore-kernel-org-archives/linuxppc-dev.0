Subject: Re: cpm_enet_down and MAC address change.
To: dnevil@snmc.com (Daris A Nevil)
Date: Mon, 4 Sep 2000 12:03:45 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39AFAD3C.C849E398@snmc.com> from "Daris A Nevil" at Sep 01, 2000 08:21:00 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000904010345.E061E251@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris A Nevil writes:
> I have been promising myself that I would re-work the ethernet driver ...

If you do, I think it would be good to integrate similar changes to those I
made to the FEC driver, in the patch at:
    http://members.xoom.com/greyhams/linux/patches/2.2/fecdmaskb.patch

In particular, DMA directly into the skbuf avoids a copy, and received
packets that get dropped should only be counted in rx_dropped -- not counted
again in rx_packets.  Also, it's good to avoid reading the buffer descriptor
status bits multiple times, especially since they're uncached.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

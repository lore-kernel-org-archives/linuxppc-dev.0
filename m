Subject: Re: Tiny fix to fec.c for RPX boards using only fast ethernet
To: dan@netx4.com (Dan Malek)
Date: Thu, 30 Mar 2000 12:47:03 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <38E2B00D.E65880E7@embeddededge.com> from "Dan Malek" at Mar 29, 2000 08:38:21 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000330024703.3E3C0355E8@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Why don't you want this?  Ethernet addresses are supposed to be assigned
> to MACs.  It's not a good idea to have a MAC appear at different addresses.
> This is why it always assigns the same address.

Sure, but there's only provision for a single MAC address in the bd_t
struct, and since we're not using the SCC ethernet port, we'd like the FEC to
assume this address un-munged. Otherwise the MAC address the ROM monitor tells
you about is different to the one the FEC uses. That's excusable as a
workaround for the ROM monitor only knowing about a single MAC address when
you need to use two ports, but it's unfriendly if you're only using one port.

> > ..... It also makes the decision non-board-specific, so other boards
> > with dual FEC & SCC ports benefit too:
>
> That's not good either.  I know how EP assigns Ethernet addresses, so
> I can do this.  Manufacturers are supposed to supply Ethernet addresses
> for every MAC they support.  The "right" way is to have multiple, known
> unique addresses assigned to boards that have multiple MACs.  Other
> boards may (should) require different assignment methods.

True, it just seemed to me to be a better default for other vendors who
support both interfaces than the current situation, where both interfaces get
the same MAC address. The munged address is still in their OUI block, whereas
using the same address on two interfaces is definitely illegal.

Perhaps a better board-independent solution to supporting dual interfaces is
to have fec.c read the MAC address from "bd->bi_fenetaddr" rather than both
fec.c and enet.c reading "bd->bi_enetaddr".

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

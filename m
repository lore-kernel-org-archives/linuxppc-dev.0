Mime-Version: 1.0
Message-Id: <p05100300b7c6188b0203@[10.0.0.42]>
In-Reply-To: <20010906171002.26712d35.armando@nycap.rr.com>
References: <3B97DA58.6894B342@acm.org>
 <20010906171002.26712d35.armando@nycap.rr.com>
Date: Thu, 13 Sep 2001 01:19:04 -0700
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: PCMCIA issues
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Do PCMCIA cards work with the current linuxppc_2_4 or linuxppc_2_4_devel trees?

I have a PowerBook 2400, a Tulip based 10/100 CardBus ethernet card,
and a 3Com 3c589 10Base-T PCMCIA card.  Using a recently updated
linuxppc_2_4 tree, kernel version string 2.4.10-pre8.  The Tulip card
works fine (*), but the 3c589 does not:

Sep 13 01:08:38 localhost cardmgr[259]: socket 1: Anonymous Memory
Sep 13 01:08:38 localhost kernel: cs: unable to map card memory!
Sep 13 01:08:38 localhost kernel: cs: unable to map card memory!
Sep 13 01:08:39 localhost cardmgr[259]: executing: 'modprobe memory_cs'
Sep 13 01:08:39 localhost cardmgr[259]: + modprobe: Can't locate
module memory_cs
Sep 13 01:08:39 localhost cardmgr[259]: modprobe exited with status 255
Sep 13 01:08:39 localhost cardmgr[259]: module
/lib/modules/2.4.10-pre8/pcmcia/memory_cs.o not available
Sep 13 01:08:40 localhost cardmgr[259]: get dev info on socket 1
failed: Resource temporarily unavailable

For some reason the card is detected as a generic memory card rather
than an Ethernet card.

Yes, I did edit /etc/pcmcia/config.opts to set up the resources the
way they should be for PowerBooks.

I have had this 3c589 card working in the past, so I know it's
possible.  I'm guessing this is related to the in-kernel
PCMCIA/CardBus drivers not being totally mature yet.


(*) Those familiar with the 2400 may be wondering how a CardBus tulip
card can possibly work, given that the 2400 doesn't support CardBus.
Well, it turns out the 2400 has a CardBus capable PCMCIA controller,
the TI 1130.  The hardware hack necessary to allow insertion of
CardBus cards without locking the machine or other unpleasant side
effects turns out to be surprisingly simple.  You just have to reduce
the time constant of a RC circuit attached to one of the card present
/ type detect signals!


P.S.  Does anybody know the current whereabouts of that old patch
which allows the PCMCIA utilities to physically eject a card on
PowerBooks with that capability?
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

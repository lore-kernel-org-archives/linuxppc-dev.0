Message-Id: <v01530501b7acbaac823e@[199.170.89.71]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 24 Aug 2001 21:28:40 -0500
To: linuxppc-dev@lists.linuxppc.org
From: trag@io.com (Jeff Walther)
Subject: Re: Hacking the Apple x500, x600 ROMs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:59 8/24/2001, Michael R. Zucca wrote:

>At 2:15 AM -0400 8/23/01, Jeff Walther wrote:
>
>>Also interesting is that some PM7200 boards use the same ROMs as the x500
>>machines.  The Power Computing Catalyst based clones were based on the 7200
>>and had their ROMs on a DIMM.  If that DIMM is compatible with the ROM slot
>>in the x500 machines, it may be possible to install modified ROM chips on
>>one of the Power Computing DIMMs and then install the ROM DIMM in the ROM
>>slot of the target x500/x600 machine.  One would still need to solder the
>>chips to the DIMM, but one would avoid soldering on the actual motherboard.
>
>That would be neat for Catalyst board owners. Particularly PowerCenter
>folks since the new DIMM could do the "PCI Timing Update" in ROM and also
>identify the PowerCenter differently from the 7200.
>
>It would also be nice to have a real, working version of OF rather than the
>half-done Apple version. Maybe an internal video driver node so that one
>could boot up like those with the chaos are able to?

The x500 machines (7500, 8500, 9500) all use the Apple 341S0168 - 341S0171
(four chips) ROMs.  I have about ten 7200 boards here (scavenging Bandits
and Cudas) and about half of them use the same set of ROMs, which is
strange.  That would seem to imply that the Platinum memory controller must
control the CPU bus in a very similar fashion to the Hammerhead.  I guess
it's the same ARBus.  It would kind of need to be for the Bandit to work in
the 7200.  But I would also think that the Platinum would need similar
registers to the Hammerhead for that to work.   Curious.

The other half of the 7200s have 341S0106 - 341S0109 (or maybe 105 to 108)
numbered ROMs.  However, there doesn't seem to be any relationship between
the model of 7200 and which ROM ended up soldered to the board.  It looks
as if Apple just used whatever they had handy.

I don't know if the PCC Catalyst machines use the 168 - 171 ROMs or the 106
-109 ROMs or both, but I doubt it would matter, since it doesn't seem to on
the 7200.  Though if there is some kind of anomaly in 7200s where some of
them have certain characteristic and others don't, the difference in ROMs
would be a possible explanation.

Anyway, if someone wants to take a hack at the code I'll be happy to
provide advice and what assistance I can to get it into Flash chips and
onto the board.  There are several challenges there.  The ROM code is
interleaved across the four ROM chips.  Each chip delivers 8 bits at a time
so reading the four chips simultaneously delivers 32 bit words.  One would
need to break up any intended replacement code into the same interleaved
pattern for delivery to the individual chips.

Desoldering existing ROMs and soldering Flash chips in their place is easy
for me, so I'm happy to do that for anyone on the list as time permits.  I
just don't have anything like the software skills or familiarity to try
modifying the ROM code myself.

Oh and an addendum to my first message.  While the Atmel AT49F8192
definitely doesn't work in this application, it is possible that the newer
AT49F8192A would, since the 8192A does support the dual mode 8b/16b that
the Apple ROMs support.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 25 Aug 1999 21:38:46 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Tony Mantler <eek@escape.ca>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <v04003a01b3ea69c1f8eb@[216.81.21.14]>
Message-ID: <Pine.LNX.3.96.990825211846.30523H-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Tony Mantler wrote:

> >Not quite.  It moves from 0 to something like 0x10000, but there may be
> >more zeroes than that.  That's the PDM's.  If you're asking about the
> >52/53/62/6300's, though, they use a Valkyrie just like the 5400.  They
> >have nothing in common with the 6100.  They don't even have DMA support.
> 
> Actually the ESP SCSI and SONIC ethernet (comslot) should do DMA on the
> performas. Anything else stuck in the Comslot or PDS can do DMA too. (iirc)

It's based on the Q630 (I believe), not the AV Quadras.  In other words,
it has no DMA controller chip, which rules out real DMA.  The SONIC card
should have its own memory on the card that it uses for buffers, AFAIK. 
Optimally, you'd to pseudo-DMA on the "ESP" (53C94).


> I think seperating based on how the interrupts are handled is a good idea.
> The Video, DMA bits and IDE are just a matter of different drivers, not
> really worth splitting the machine class on it's own.

Maybe.  You're still dividing it the same way, though.  There are three
primary setups:

PDM       Has master ICR/IFR
PowerBook similar to PDM with DMA stripped, IDE added, some other changes
Performa  Not similar to anything -- no master ICR, etc.  Interrupt
          regs do not match more recent machines.
Legacy    similar to Performa, with different secondary interrupt control
          hardware at different locations, I think.


> >Note that the last two are not quite working yet.  We were close on the
> >performas, and the 68k PowerMacs aren't quite as close, but at least some
> >of them start booting now with the right config.
> 
> I'm curious why you separated the Performa's from the PPC upgraded 68k's.

We have to do some weird twiddling to make the ppc-upgraded 68k's get past
the booter.  That and I don't think the ppc<- ->68k bus bridge is the same
in the two machines, though I'm not sure about that.  The most annoying
thing is that the 68k machines had no main interrupt controller, and I
think some of the interrupt hardware is in different places on the
Performas, which makes it obnoxious.  It's workable to keep them together,
and I seriously considered it before deciding to go with a separate class.
I think there may have been other reasons, but I can't remember what.


> >From what I understand, the logical layout of the hardware is very similar
> (PPC chip bridged onto the 68k bus), and Linux/Mac68k has no troubles
> supporting all 68k machines under one machine class. Are there differences
> in the way the PPC->68k bridging is done?

I _think_ it's a different bridge chip, but I haven't actually dismantled
a PPC upgrade card to find out for sure.  :-)


> Anyways, I really must get myself a dead-tree version of the PPC
> Programming Environment Manual. Does Motorolla still give those books away
> for free?

Heheh.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

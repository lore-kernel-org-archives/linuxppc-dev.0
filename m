Message-Id: <v04003a02b3ea789770f8@[216.81.21.14]>
In-Reply-To: <Pine.LNX.3.96.990825211846.30523H-100000@mvista.com>
References: <v04003a01b3ea69c1f8eb@[216.81.21.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 26 Aug 1999 01:41:29 -0500
To: "David A. Gatwood" <dgatwood@mvista.com>
From: Tony Mantler <eek@escape.ca>
Subject: Re: Performa 5200
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:38 PM -0500 8/25/99, David A. Gatwood wrote:
>On Wed, 25 Aug 1999, Tony Mantler wrote:
>> Actually the ESP SCSI and SONIC ethernet (comslot) should do DMA on the
>> performas. Anything else stuck in the Comslot or PDS can do DMA too. (iirc)
>
>It's based on the Q630 (I believe), not the AV Quadras.  In other words,
>it has no DMA controller chip, which rules out real DMA.  The SONIC card
>should have its own memory on the card that it uses for buffers, AFAIK.
>Optimally, you'd to pseudo-DMA on the "ESP" (53C94).

Well, the macsonic.c driver has plenty of DMA type code in it, so I'd be
inclined to belive that there is indeed some form of DMA (especially
considering the driver works). :)

http://maclinux.plcom.on.ca/cvsweb/linux-mac68k/drivers/net/macsonic.c?rev=1.24

I recall the Apple docs specifically say in regards to the 5200 that both
the Comslot and PDS can bus-master for the sake of DMA (or other nasty
bus-mastering deeds), and the PDS can also use the slot $E shared memory
region and interrupt.

I'm pretty sure the ESP does DMA too if you ask it nicely enough, though
the Mac68k code (which, iirc, sucks royally) just uses the standard mode
access.

However, that's all just driver issues to be dealt with *after* I get the
machine booting and the interrupts working. :)


>> I think seperating based on how the interrupts are handled is a good idea.
>> The Video, DMA bits and IDE are just a matter of different drivers, not
>> really worth splitting the machine class on it's own.
>
>Maybe.  You're still dividing it the same way, though.  There are three
>primary setups:
>
>PDM       Has master ICR/IFR
>PowerBook similar to PDM with DMA stripped, IDE added, some other changes
>Performa  Not similar to anything -- no master ICR, etc.  Interrupt
>          regs do not match more recent machines.
>Legacy    similar to Performa, with different secondary interrupt control
>          hardware at different locations, I think.

The interrupt structure up to the point of the 68k bus should (in theory,
atleast) be almost identical across the Performas and Legacy machines,
atleast as much as the 68k machines they're based on.


>> >Note that the last two are not quite working yet.  We were close on the
>> >performas, and the 68k PowerMacs aren't quite as close, but at least some
>> >of them start booting now with the right config.
>>
>> I'm curious why you separated the Performa's from the PPC upgraded 68k's.
>
>We have to do some weird twiddling to make the ppc-upgraded 68k's get past
>the booter.  That and I don't think the ppc<- ->68k bus bridge is the same
>in the two machines, though I'm not sure about that.  The most annoying
>thing is that the 68k machines had no main interrupt controller, and I
>think some of the interrupt hardware is in different places on the
>Performas, which makes it obnoxious.

I'm not really familiar with how the 68k autovector interrupts are
presented to the PPC, so I wouldn't be able to comment on that.

Speaking of which, is there any documentation on the subject? (code,
commented code, dead trees, whatever)


>It's workable to keep them together,
>and I seriously considered it before deciding to go with a separate class.
>I think there may have been other reasons, but I can't remember what.

I'm inclined to keep them together, though it's not like I have a PPC
upgraded legacy machine laying around here for me to write support for.
(donations welcome) :)


>> >From what I understand, the logical layout of the hardware is very similar
>> (PPC chip bridged onto the 68k bus), and Linux/Mac68k has no troubles
>> supporting all 68k machines under one machine class. Are there differences
>> in the way the PPC->68k bridging is done?
>
>I _think_ it's a different bridge chip, but I haven't actually dismantled
>a PPC upgrade card to find out for sure.  :-)

I know the 5200 uses the Capella chip, but I haven't been able to find any
documentation whatsoever about the PPC upgrade cards.

I would be surprised if Apple did bother to make 2 different 68k <-> PPC
bridge chips, as in both cases they perform the exact same function. But
then, Apple does do that sort of thing.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

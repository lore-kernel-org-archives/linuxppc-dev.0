Message-Id: <v04003a01b3ea69c1f8eb@[216.81.21.14]>
In-Reply-To: <Pine.LNX.3.96.990825202634.30523A-100000@mvista.com>
References: <v04003a00b3e9f623e46f@[216.81.27.143]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 25 Aug 1999 23:15:01 -0500
To: "David A. Gatwood" <dgatwood@mvista.com>
From: Tony Mantler <eek@escape.ca>
Subject: Re: Performa 5200
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:43 PM -0500 8/25/99, David A. Gatwood wrote:
>On Wed, 25 Aug 1999, Tony Mantler wrote:
>
[...]
>> Yeek. Sounds like a messed up version of RBV (IIsi). On that particular
>> machine (iirc), the start of real useable ram, where the kernel is located,
>> is remapped down to 0x0, and the framebuffer is mapped way up into (I
>> think) slot $9 regular space to mimic the configuration of the slightly
>> more sane macs.
>
>Not quite.  It moves from 0 to something like 0x10000, but there may be
>more zeroes than that.  That's the PDM's.  If you're asking about the
>52/53/62/6300's, though, they use a Valkyrie just like the 5400.  They
>have nothing in common with the 6100.  They don't even have DMA support.

Actually the ESP SCSI and SONIC ethernet (comslot) should do DMA on the
performas. Anything else stuck in the Comslot or PDS can do DMA too. (iirc)

It's not very *good* DMA support, but, you know...


[...]
>> >Or simply CONFIG_NUBUS_PMAC... BootX will tell you if you are running on
>> >one of those and will tell you if it's a PDM based (x100), performa or
>> >powerbook (5300/1400). It will also give you the gestalt machineID and
>> >the phys. memory map table. If you need more infos, tell me, but I
>> >beleive most of the other infos will have to be hard coded.
>
>It's a bad idea to have any of these three in the same class.  They don't
>act a thing alike.  The NuBus PowerBooks and Performas are KIND of close,
>in that neither has DMA, but their IDE works with different offsets
>between registers, their interrupt handling is almost completely
>different, the video is different... it's substantial enough to make it
>far better to define them as separate classes.  Otherwise, all those
>pieces of code will be riddled with switch statements for a huge list of
>gestalts (16 different numbers for the PDMs alone).

I think seperating based on how the interrupts are handled is a good idea.
The Video, DMA bits and IDE are just a matter of different drivers, not
really worth splitting the machine class on it's own.


>If you want to maintain some sense of naming consistency with MkLinux
>(which is a good idea), we use:
>
>POWERMAC_CLASS_PCI       - almost everything
>POWERMAC_CLASS_PDM       - 6/7/81xx, AWS 6/7/81xx
>POWERMAC_CLASS_POWERBOOK - NuBus PowerBooks
>POWERMAC_CLASS_PERFORMA  - NuBus Performas
>POWERMAC_CLASS_LEGACY    - 68k PowerMacs w/ upgrade cards
>
>Note that the last two are not quite working yet.  We were close on the
>performas, and the 68k PowerMacs aren't quite as close, but at least some
>of them start booting now with the right config.

I'm curious why you separated the Performa's from the PPC upgraded 68k's.
>From what I understand, the logical layout of the hardware is very similar
(PPC chip bridged onto the 68k bus), and Linux/Mac68k has no troubles
supporting all 68k machines under one machine class. Are there differences
in the way the PPC->68k bridging is done?


Anyways, I really must get myself a dead-tree version of the PPC
Programming Environment Manual. Does Motorolla still give those books away
for free?

Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

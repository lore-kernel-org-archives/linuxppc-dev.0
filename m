Message-Id: <200003240804.IAA15674@hyperion.valhalla.net>
Date: Fri, 24 Mar 2000 08:04:34 +0000
Subject: Re: State of sound support in 2.3.x
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: jingai@floatingpenguins.com
CC: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >I have the 2.3.52 kernel from Paul's tree, with PowerMac DMA
>> > sound support compiled in.  I guess my question is:  what is the
>> current
>> > state of sound support in Paul's 2.3.52 kernel?
>>
>> My primary distribution source is also LimuxPPC.
>>
>> Geert Uytterhoeven posted a patch to split the DMA sound support between
>> Pmac, Atari etc. a while ago (look for dmasound split).
>
> Okay, I applied the patch (and the patch to the patch) that I found in the
> list archives.  It built fine, but upon reboot, sound doesn't work at all
> (no beep even).  I tried building both Sound Support and PowerMac AWACS
> support as modules, and it produced one module called soundcore.c.  I
> rebooted with this kernel and insmod'ed it, and it still doesn't work,
> although /dev/dsp and /dev/mixer existed this time.  Any clues?  I've got a
> UMAX S900, which, IIRC is a 9500 clone.

Yes (I think) - I should have posted a patch for this.

in drivers/char/mem.c there are two areas in which calls (and its
declaration) to init_dmasound() are conditional on CONFIG_DMASOUND - but
CONFIG_DMASOUND has been removed.

You need to change those lines to something like...

#if defined(CONFIG_DMASOUND_AWACS) || defined(CONFIG_DMASOUND_ATARI....

or whatever (the various CONFIG_DMASOUND_XXXXX are visible in the Makefiles)

Sorry about this - I was very new to the list and carried out some of the
discussion without doing cc's ;-)

I think that is it - basically you have everything complied in - but it
isn't being called at init time.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 13 Nov 2002 22:11:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE on LongTrail
In-Reply-To: <3DC7AC62.6040409@iram.es>
Message-ID: <Pine.GSO.4.21.0211132202190.7985-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Nov 2002, Gabriel Paubert wrote:
> Geert Uytterhoeven wrote:
> > According to the IBM LongTrail schematics, PINT[CD] on the W83C553 are
> > connected to EXT_INT[56] on the Apple Hydra, which are OpenPIC inputs.
> > The connections are called `IDE_NM_INT_P/S' and 'IDE_NM_INT_S'. So it should be
> > possible, unless Tatung changed that.
>
> Ok, in this case. look at page 125. You have to set bit 11 (LEGIRQ) to
> route the interrupts to IRQC for both channels. You can only separately
> route each channel (IRQC for channel 0, IRQD for channel1) if you channel
> 1 in legacy mode it seems. That's at least what I understand.
>
> > Will do some more W83C553 doc parsing soon :-)
>
> Parsing is nothing; you also have to interpret the oracle ;-)

Well, after exactly following the instructions at page 125 I made it work
(using setpci for manual register poking):
  1. Disable ISA interrupts by writing 0x00 to the IDE interrupt routing
     register on the PCI/ISA bridge (used to be 0xef, i.e. IRQs 14 and 15)
  2. Enable native mode for both channels by writing 0x33 to the IDE mode
     register
  3. Set LEGIRQ to route the interrupts for both channels to IRQC.

And `modprobe ide-probe-mod' gave me a working primary IDE channel! Haven't
tested the second channel yet.

The confusing part is that for (2) you need `native mode' (PCI native mode, I
think), while for (3) you need `legacy mode'...

Will cook a patch later...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 21 Mar 2000 18:52:05 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: anthony tong <atong@uiuc.edu>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Kevin Hendricks <khendricks@ivey.uwo.ca>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128
 and Rage128Pros
In-Reply-To: <20000321112355.A5368@rogue.genunix.net>
Message-ID: <Pine.LNX.4.05.10003211849030.994-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, anthony tong wrote:
> Kostas Gewrgiou (Tue, Mar 21, 2000 at 06:56:25PM +0200):
> > #ifdef __powerpc__ for this it should be better to see if the card has
> > an OF or BIOS rom first since that will allow people to keep using cards
> > with bios roms under ppc (i wonder if anyone is doing this)
> > Any ideas on how we can check if a card has OF or BIOS roms ?
>
> this is from memory (probably from the mach64 days): Bit 0 of the
> PCI configuration register 0x30 is 0 if a PC style BIOS doesn't
> exist. So we could do a check for that instead if this is verified
> to still be true.

Not true. Register 0x30 is 0 for both my S3 (with PC BIOS) and ATI (with OF
BIOS). I think you refer to the indiator for the enabled ROM?

    #define  PCI_ROM_ADDRESS_ENABLE 0x01

So you have to enable the ROM and check for the PC BIOS signature (don't know
what it is, but it should exist).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

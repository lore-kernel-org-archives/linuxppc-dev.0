Date: Tue, 21 Mar 2000 11:23:55 -0600
From: anthony tong <atong@uiuc.edu>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128 and Rage128Pros
Message-ID: <20000321112355.A5368@rogue.genunix.net>
References: <00032021464800.00801@localhost.localdomain> <Pine.LNX.4.21.0003211716210.18439-100000@idd-01.imbc.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0003211716210.18439-100000@idd-01.imbc.gr>; from gewrgiou@imbc.gr on Tue, Mar 21, 2000 at 06:56:25PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou (Tue, Mar 21, 2000 at 06:56:25PM +0200):
>  From the patches i see that the reference freq is still assumed to be
> 29.50Mhz
>      /* Assume REF clock is 2950 (in units of 10khz) */
>      /* and that all pllclk must be between 125 Mhz and 250Mhz */
>      pll->reference_freq = 2950;
>      pll->min_pll_freq   = 12500;
>      pll->max_pll_freq   = 25000;
>
>  From the comments in the xfree driver (and the ati docs) this isn't always
> true:
>      /* These probably aren't going to work for
>         the card you are using.  Specifically,
>         reference freq can be 29.50MHz,
>         28.63MHz, or 14.32MHz.  YMMV. */

I think that we can assume a 29.50 clock *for now*; lower clocks are
probably for future low powered/mobile versions of the chip.

> #ifdef __powerpc__ for this it should be better to see if the card has
> an OF or BIOS rom first since that will allow people to keep using cards
> with bios roms under ppc (i wonder if anyone is doing this)
> Any ideas on how we can check if a card has OF or BIOS roms ?

this is from memory (probably from the mach64 days): Bit 0 of the
PCI configuration register 0x30 is 0 if a PC style BIOS doesn't
exist. So we could do a check for that instead if this is verified
to still be true.

-at

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 21 Mar 2000 21:00:34 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: anthony tong <atong@uiuc.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128
  and Rage128Pros
In-Reply-To: <v03110701b4fd5f523b24@[129.100.29.243]>
Message-ID: <Pine.LNX.4.21.0003212046350.1173-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Kevin B. Hendricks wrote:

> Hi,
>
> > From the patches i see that the reference freq is still assumed to be
> >29.50Mhz
> >     /* Assume REF clock is 2950 (in units of 10khz) */
> >     /* and that all pllclk must be between 125 Mhz and 250Mhz */
> >     pll->reference_freq = 2950;
> >     pll->min_pll_freq   = 12500;
> >     pll->max_pll_freq   = 25000;
>
>
> Yes, that's true.  Luckily, all of the Mac's use Rage128 cards with 2950 AFAIK.
> I will keep looking through the manual to see if I can figure out a way to
> determine this without a bios.
>

  If most Mac's use cards with 2950 then we should be fine for now, but for
the future we need to find a way to get this right.

> > From the comments in the xfree driver (and the ati docs) this isn't always
> >true:
> >     /* These probably aren't going to work for
> >        the card you are using.  Specifically,
> >        reference freq can be 29.50MHz,
> >        28.63MHz, or 14.32MHz.  YMMV. */
>
> Yes I know.
>
> >  I'll be more than happy to get the patches in the xfree tree, even with
> >the reference_freq hardcoded its still an improvement.
>
> Jacl Howarth just report a 30% performance increase in some x11perf tests
> on XF 4.0 with the new patch versus the old values!  That makes me feel
> better.
>

 Wow thats something :)

> >#ifdef __powerpc__ for this it should be better to see if the card has
> >an OF or BIOS rom first since that will allow people to keep using cards
> >with bios roms under ppc (i wonder if anyone is doing this)
> >Any ideas on how we can check if a card has OF or BIOS roms ?
>
> Unforntunately, the current xf4 bios check does not work on some G3s and
> G4's.  Literally tmp[] comes back with the right values that leads you to
> believe that the Bios is there but the values for ref, the max and min pll,
> read from the "Bios" etc are truly garbage (i.e. xlck reads as 0).  The
> only reason it still worked was that none of the builtin modes fit the max
> and min pll values so no modes were found so the r128_driver.c just
> defaulted to the current fb mode which works.
>
> I think a better check for a bios being present would detect the issue and
> we code default to of values set in the pll registers next.
>

  The current code always assume that the ROM is a BIOS one, the 2 bytes
that it checks in the beggining are probably present in OF ati cards as
well so it thinks that everything is ok, we need to know if the card has
an OF rom or not (this is needed for other places in xfree as well the
int10 module will try to softboot OF cards also), i am sure there is a way
to find this i'll check the OF docs and see if i can find something.

> Thanks!
>
> Kevin
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 21 Mar 2000 18:56:25 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: anthony tong <atong@uiuc.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128
 and Rage128Pros
In-Reply-To: <00032021464800.00801@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0003211716210.18439-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 2000, Kevin Hendricks wrote:

> Hi Kostas,
>
> With lots of help from Ben, we were able to figure out that the OF values used
> to initialize the Rage128 and Rage128Pro cards are the same ones used by the
> MacOS and that we can actually read the X_MPLL_REF_FB_DIV value, the XCLK_CNTL,
> and PLL_REF_DIV values and calculate the proper XCLK.  In a similar way you can
> calculate the MCLK value too so you can get or calculate almost all of the same
> info as is probed from the Bios under x86 machines.
>

 From the patches i see that the reference freq is still assumed to be
29.50Mhz
     /* Assume REF clock is 2950 (in units of 10khz) */
     /* and that all pllclk must be between 125 Mhz and 250Mhz */
     pll->reference_freq = 2950;
     pll->min_pll_freq   = 12500;
     pll->max_pll_freq   = 25000;

 From the comments in the xfree driver (and the ati docs) this isn't always
true:
     /* These probably aren't going to work for
        the card you are using.  Specifically,
        reference freq can be 29.50MHz,
        28.63MHz, or 14.32MHz.  YMMV. */

So we need to find a way to calculate the reference freq, without it
xfree/aty128fb still won't do the right thing :(


> This allows both machines with G3s, and G4 (even with the Rage 128 cards) to
> work with the same aty128fb.c kernel driver without any table lookups.
>
> The patch to add this to the aty128fb.c is attached.  I have also used
> similar code to replace the bios code probe for powerpc in the r128_driver.c for
> xf400. The patch to do that is also attached.
>
> These patches have been tested and work fine on my B+W G3 rev 2, my brand new
> G4 with Rage128Pro card, and on Ben's older G4 with the non-pro card.
>
> We still need to test this on a B+W G3 revision 1 just to be complete (but Ben
> will do that soon).
>
> Assuming they test out fine, Kostas would you see about getting the r128 patch
> integrated into the next xf40X release while I see about getting Paul and/or
> Anthony to integrate the aty128fb.c patch into both the stable and development
> kernels.
>

  I'll be more than happy to get the patches in the xfree tree, even with
the reference_freq hardcoded its still an improvement.

#ifdef __powerpc__ for this it should be better to see if the card has
an OF or BIOS rom first since that will allow people to keep using cards
with bios roms under ppc (i wonder if anyone is doing this)
Any ideas on how we can check if a card has OF or BIOS roms ?

> Hopefully with these in place, new G4s will work as well as older G4s
> and G3s.
>
> Thanks!!!
>
> Kevin


  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

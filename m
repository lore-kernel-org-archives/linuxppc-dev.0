Message-Id: <200010121430.JAA21005@lists.linuxppc.org>
From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
Reply-To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber
	 <huber@mclx.com>,
        Linux/PowerPC Devel List
	 <linuxppc-dev@lists.linuxppc.org>
Date: Thu, 12 Oct 2000 10:30:17 -0400
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: dual head r128
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

> If the main clock rate is different, as long as
> > you can find out what it is, reading and calculating the  timings from
> > those register settings really should work generically, shouldn't it?

> The reference frequency isn't the same in all cards, your patch assumes that
>   /* Assume REF clock is 2950 (in units of 10khz) */
>   /* and that all pllclk must be between 125 Mhz and 250Mhz */

Yes, that is what I was referring to above.  That info is generally available in the card docs.  Ben has a whole set of ref clock rates for all the ati cards shipped under mac or clones.  I also have that info and could easily look up the card id to set it for macs in general.

>   /* These probably aren't going to work for
>      the card you are using.  Specifically,
>      reference freq can be 29.50MHz,
>      28.63MHz, or 14.32MHz.  YMMV. */

You can actually use info on the pllclk constraints to rule out the 14.32Mhz cases from the other two cases and then you are left with only 2 to try.

A lookup table would certainly do the trick if the user did not want to simply  use trial and error.  Anything would be better than the complete hard coded values set in the XF 4.0 source.

Perhaps a better idea is allow the REF clock rate to be passed as a parameter in the XF86Config file (much like the video memory parameter and bus ids passed now) for people to have control over if need be.   This value would then only be used if the bios test failed and then in place of the hardcoded values so that my pll register probing routine would be actually work.  A desperate user could then try each of the 3 values until he/she saw something they liked on the screen.

> Most of the ppc r128 cards have a reference frequency of 29.50MHz so the
> code works but i heard that some of the new ones have different reference
> freq.

Yes, there is one new card (of the r128 variety) on Ben's list that does not use the 2950 ref clock value.

Since he has a bios on a ppc card it would be interesting to see the results of some "bios present?" tests to help determine if a bios is really there or not.  The current test sometimes passes on macs without a bios (possibly OF rom?) and garbage values are returned.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 12 Oct 2000 17:10:44 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
cc: Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <200010121341.IAA20116@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.21.0010121655001.1144-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Hendricks, Kevin wrote:

>
> Hi,
>
> > the patch breaks the calculations for the x86 cards
> > (thats the reason why its not in the xfree cvs), so don't expect to get
> > sane values for the x86 card. (aty128fb has the same problem as well btw)
>
> Why?  This should not be unless the bios on the x86 card never initializes
> the card in any way.  If the bios does do some basic initialization, the
> patch should work just as well for an x86 card as a ppc one if the main
> clock rate is the same.  If the main clock rate is different, as long as
> you can find out what it is, reading and calculating the  timings from
> those register settings really should work generically, shouldn't it?

The reference frequency isn't the same in all cards, your patch assumes that
  /* Assume REF clock is 2950 (in units of 10khz) */
  /* and that all pllclk must be between 125 Mhz and 250Mhz */

>From the comment in r128_driver.c you can see that the possible values are
29.50MHz, 28.63MHz, or 14.32MHz.

  /* These probably aren't going to work for
     the card you are using.  Specifically,
     reference freq can be 29.50MHz,
     28.63MHz, or 14.32MHz.  YMMV. */

Most of the ppc r128 cards have a reference frequency of 29.50MHz so the
code works but i heard that some of the new ones have different reference
freq.

  Kostas.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39DB51E3.1352F009@charter.net>
Date: Wed, 04 Oct 2000 10:50:59 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ethernet on fads850sar board?
References: <39D7F8FB.9C508CF1@charter.net> <39D816D8.35ED965E@mvista.com> <39D87006.979C210@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
> Dan Malek wrote:
> >
> > "Dan A. Dickey" wrote:
> >
> > > Any ideas?
> >
> > Make sure the GP I/O pins are configured properly to be SCC2 Ethernet
> > control/status lines.  Make sure the BCSR bits enable and properly
> > configure the PHY (half/full duplex, loopback, etc.).
>
> I've been over them about three times already.  But I can certainly
> check again.
>
> > > (And why do the baud rate generators that feed the ethernet
> > >  clocks need to run at 2Mhz?)
> >
> > Ummm, no.....The PHY provides the clocks, they are inputs to port.
> > I don't know why an external clock would be set to that value.

Dan, Thank You!
This cyptic comment (for me anyways) was the key to getting
ethernet going on my fads850 board.  I now understand the ethernet
clocks, and the parallel I/O ports much better than I did a few
days ago.

And yes indeed, the baud rate generators are not needed at all;
so now I'm leaving them alone all together.

> The only way that I could get a packet to go (otherwise I got a
> TX Timeout) was by clocking SCC2 to one or two of the Baud Rate
> Generators.  I've tried CLK4, and CLK1+CLK3.  It didn't work.
> By this, I mean that right now I'm doing a:
>     immr->im_cpm.cp_sicr |= SICR_ENET_CLKRT;
> Where SICR_ENET_CLKRT is:
> #define SICR_ENET_CLKRT ((uint)0x00001300)  /* RCLK-BRG3, TCLK-BRG4 */

What I needed to do and ended up doing was using CLK2 for the RCLK, and
CLK4 for the TCLK; thusly:
#define SICR_ENET_CLKRT    ((uint)0x00002f00)      /* RCLK-CLK2,
TCLK-CLK4 */

Thanks again for everyones help.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

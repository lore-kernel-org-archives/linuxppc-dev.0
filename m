Message-ID: <39D87006.979C210@charter.net>
Date: Mon, 02 Oct 2000 06:22:46 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ethernet on fads850sar board?
References: <39D7F8FB.9C508CF1@charter.net> <39D816D8.35ED965E@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> "Dan A. Dickey" wrote:
>
> > Any ideas?
>
> Make sure the GP I/O pins are configured properly to be SCC2 Ethernet
> control/status lines.  Make sure the BCSR bits enable and properly
> configure the PHY (half/full duplex, loopback, etc.).

I've been over them about three times already.  But I can certainly
check again.

> > (And why do the baud rate generators that feed the ethernet
> >  clocks need to run at 2Mhz?)
>
> Ummm, no.....The PHY provides the clocks, they are inputs to port.
> I don't know why an external clock would be set to that value.

The only way that I could get a packet to go (otherwise I got a
TX Timeout) was by clocking SCC2 to one or two of the Baud Rate
Generators.  I've tried CLK4, and CLK1+CLK3.  It didn't work.
By this, I mean that right now I'm doing a:
    immr->im_cpm.cp_sicr |= SICR_ENET_CLKRT;
Where SICR_ENET_CLKRT is:
#define SICR_ENET_CLKRT ((uint)0x00001300)  /* RCLK-BRG3, TCLK-BRG4 */

Otherwise, where does the RCLK and TCLK come from or go to?
(And what speed *should* they be running at?)
Is there something more that I can read to get an understanding
of what is going on here?

Thank you for your help.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

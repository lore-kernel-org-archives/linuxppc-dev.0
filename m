Subject: Re: [PATCH][RFC]Updated MPC I2C driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	kumar.gala@freescale.com, mcclintock@freescale.com
In-Reply-To: <40E463E5.1060401@246tNt.com>
References: <1088705955.28598.168.camel@localhost>
	 <40E463E5.1060401@246tNt.com>
Content-Type: text/plain
Message-Id: <1088715248.28598.192.camel@localhost>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 21:54:08 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-01 at 20:20, Sylvain Munaut wrote:

> Interesting, it really looks like the MPC5200 I2C controller.
> Unfortunatly :
>  - On the MPC5200, all the status/controls bits are in the MSBs ( so
> the consts would need to be << 24 )

Are you sure about that? The MPC107 registers are little-endian PCI
registers, accessed with readl/writel, but it looks to me that the
MPC5200 registers are big-endian.

>  - And there is a interrupt control register I don't see in your code.
> It's shared by the two I2C controllers onboard.

That could easily be added as a special case.

> I'll try to see if I can make it work on the lite5200 board.

Please do try. It would be good if one driver covered all these chips.

I'm going to try byte reads and writes on the MPC107 as my next
experiment. I think that may avoid the need for separate access
functions.

- Adrian Cox


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

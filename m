Message-Id: <4.3.2.20001130110218.00bd23b0@falcon.si.com>
Date: Thu, 30 Nov 2000 11:03:53 -0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: EST SBC8260 and Canary CTX-1170
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[oops, forgot to send it to the list.  Sorry for the duplicate Jon,
Brian, Dan]

...and the other Canary dongle had a chip in it labeled:

Enable
(c) 1998
5v Simple
3001AD1E2MJ1C
3440903 9934P

I have not tried to track down the manufacturer.

The primary point is that PHYs have different chip sets, even ones from
a single company and labeled with the same part number (maybe Canary is
the only company to do this, but somehow I doubt that :-).

The secondary point is that you should stick to standard MII registers
if at all possible.  According to 802.3 (1998) Section 22.2.4,
registers 0-1 are "Basic", 2-10 are "Extended", 11-14 are reserved, 15
("Extended Status") is "Basic", and 16-31 are vendor specific.

gvb


At 09:47 AM 11/30/00 -0500, diekema_jon wrote:

> > I cracked open my CTX-1170 gizmo and it has a Lucent LU3X51FT-JE80
> PHY in
> > it.  I manually set the phy_duplex to 1 and the phy_speed to 100, still
> > no dice.
>
>We have several of the CTX-1170 MII, and we have at least two
>different PHY's in them.  One of the types is the Lucent
>LU3X51FT-JE80.  I was unable to find a data sheet for the LU3X51FT
>from http://www.lucent.com/micro, however I was able to find one on
>the LU3X54FT.  The LU3X54-FT is a quad version of the LU3X51-FT.
>
>The cep->phy_type variable in arch/ppc/8260_io/fec_enet.c gets derived
>from the PHY identifer registers 1 / 2.  When I run with FEC2 active,
>I get a type of 0x00437412.  I would expect this to look something
>like 0x0180????.
>
>#
># MPC8260 Communication Options
>#
># CONFIG_SCC_ENET is not set
>CONFIG_FEC_ENET=y
># CONFIG_FCC1_ENET is not set
>CONFIG_FCC2_ENET=y
># CONFIG_FCC3_ENET is not set
>
>MPC8260 CPU/CPM/BUS: 200/133/33 Mhz
>
>fec: Phy @ 0x0, type 0x00437412
>
>
>When Dan Malek runs with the National Semi PHY DP83840A, how fast
>is the MPC8260 running?  I think that Dan is running at 166Mhz,
>if so we might have a timing problem on I2C bus.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

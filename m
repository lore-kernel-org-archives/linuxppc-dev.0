Message-ID: <00a401c451bb$7b65a650$5200a8c0@transengfb16d1>
From: "LarrZheng" <larryzheng@transengines.com>
To: "Matt Porter" <mporter@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <20040419115634.A19863@home.com>
Subject: Re: PPC440GX GigE support
Date: Mon, 14 Jun 2004 10:58:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt
    I have test GigE driver,  EMAC2/3 can be initialized but con't work on
my 440gx board,  i guess that CIS8201 phy driver need support 1000FULL ange
mode .  but current driver only support 100FULL ange mode in routine
genmii_setup_aneg(), do we need update  cis8201_setup_aneg() to support
1000FULL ange?

    another question is that performance test for EMAC0/1, here is test
result using SmartBit 6000.

linux-2.5-ocp 440gx test result:
    package size(byte)      single-direction(Mbps)      bi-direction(Mbps)
    1518                            99
99
    64                                35
8

linux-2.4-26  440gx test result:
     package size(byte)      single-direction(Mbps)      bi-direction(Mbps)
    1518                            95
N/A
    64                                44
N/A


    It seems that small(64byte) package performance is not good as our
image. do you have any suggestion?
    BTW, when the TAH driver for 440gx will released?

Larry





----- Original Message -----
From: "Matt Porter" <mporter@kernel.crashing.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, April 20, 2004 2:56 AM
Subject: PPC440GX GigE support


>
> I've pushed a bunch of code for this to the linux-2.5-ocp tree. It
> overhauls the EMAC driver a bit and adds a number of fields to the
> new OCP EMAC .additions field that are set per SoC or by the board
> specific code.  There's support for GigE on EMAC2/3, the TAH,
> zerocopy, and jumbo frames.
>
> There's still work to be done on jumbo frames > 4062 MTU since
> the RX side requires a copy. If we get some assumptions about
> linear skbs in various protocol implementations removed, this can
> be fixed. TSO support is the only major thing unimplemented.
>
> Performance is right on par with an e1000 in the same platform,
> showing anywhere from 700-850Mbps TX throughput depending on
> MTU size and sendfile usage. RX range is slightly less.
>
> Pull from bk://source.mvista.com/linux-2.5-ocp
>
> Once the new OCP stuff goes into linux-2.5, I'll send some
> version of this (plus previous EMAC driver work for 2.6) to
> jgarzik.
>
> -Matt
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

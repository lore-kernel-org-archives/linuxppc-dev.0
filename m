Message-ID: <3F86A52B.1070803@siemens.com>
Date: Fri, 10 Oct 2003 14:25:15 +0200
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 FCC enet driver problem
References: <000001c38766$68b14d90$5201a8c0@GEG2400>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Gérard,

> I use a 2.4.18 Linux kernel on my custom 8260 board with 3 FCC ports.
> These 3 ports work fine at 100Mbs half or full duplex.
>
> I connect 2 boards on the first port via a 10Mbs hub.
> The ports auto-negotiate and fall into 10Mbs half duplex mode.

Does it mean the eth0 port has been switched from full duplex (100Mbs Switch)
to half duplex (10 Mbs Hub) by changing the Hub/Switch ?

In this case, the new duplex mode will be negotiated by the two PHYs.
But, also the MAC Controller (FCC, FPSMR(FDE) bit) must be switched to half
duplex. Otherwise, the MAC Controller continues with full duplex.
This results in late collisions. In this case, the CPCR command RESTART TRANSMIT
is necessary.

I have not seen this kind of synchronization (PHY -- MAC) in fcc_enet.c.
I don't know why.


--


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 7
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

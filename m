Message-ID: <3D05B542.8F17F0D2@icn.siemens.de>
Date: Tue, 11 Jun 2002 10:30:58 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: Gerhard TAEUBL <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2 Ethernet ports on a MPC860T
References: <sd05c43a.096@mail.frequentis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We have to redesign our customer board next year, and there is a requirement to use two ethernet
> ports. At the moment we use of course the FEC with 10/100 MBit. So we want to add a SCC (SCC3 fits
> for us ...) for a second ethernet. Is that configuration supported by linux, or easy to adapt? (to
> switch from another SCC to SCC3 or similar).

I think this should be easy possible. The arch/ppc/8xx_io provides
both drivers: enet.c: for SCC
              fec.c:  for FEC

Via the CONFIG_SCC[1-3]_ENET switches you can configure the kernel,
which SCC is used (see enet.c).

You must also associate e.g. the 'eth0' network interface
to the SCC and the 'eth1' network interface to the FEC as desired.

In order to do this I think you can pass your own net_device structure
to init_etherdev() (not NULL) inside the driver init entry points
(e.g.; scc_enet_init()).
Before calling init_etherdev() you can initialize the name member
of the net_device structure as you want ("eth0", "eth1", ...).
I hope this works.

>
> What kind of external devices are necessary? And how do you store the MAC Address? (We do it at the
> moment via a one wire chip, they garant for the right MAC Address).
>
We are storing the MAC addresses inside the FLASH memory part of our
system.

Steffen
--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

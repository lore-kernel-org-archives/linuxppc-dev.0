Message-Id: <m141Uzk-001SzWC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: EST SBC8260 and Canary CTX-1170
To: ford@vss.fsi.com (Brian Ford)
Date: Thu, 30 Nov 2000 09:47:32 -0500 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
In-Reply-To: <Pine.GSO.4.21.0011291213330.493-100000@eos> from "Brian Ford" at Nov 29, 2000 12:18:44 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I cracked open my CTX-1170 gizmo and it has a Lucent LU3X51FT-JE80 PHY in
> it.  I manually set the phy_duplex to 1 and the phy_speed to 100, still
> no dice.

We have several of the CTX-1170 MII, and we have at least two
different PHY's in them.  One of the types is the Lucent
LU3X51FT-JE80.  I was unable to find a data sheet for the LU3X51FT
from http://www.lucent.com/micro, however I was able to find one on
the LU3X54FT.  The LU3X54-FT is a quad version of the LU3X51-FT.

The cep->phy_type variable in arch/ppc/8260_io/fec_enet.c gets derived
from the PHY identifer registers 1 / 2.  When I run with FEC2 active,
I get a type of 0x00437412.  I would expect this to look something
like 0x0180????.

#
# MPC8260 Communication Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_FCC1_ENET is not set
CONFIG_FCC2_ENET=y
# CONFIG_FCC3_ENET is not set

MPC8260 CPU/CPM/BUS: 200/133/33 Mhz

fec: Phy @ 0x0, type 0x00437412


When Dan Malek runs with the National Semi PHY DP83840A, how fast
is the MPC8260 running?  I think that Dan is running at 166Mhz,
if so we might have a timing problem on I2C bus.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

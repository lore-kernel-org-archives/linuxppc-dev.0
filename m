From: David Hopcroft <dhopcroft@aminocom.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem implementing pcmcia_cs on ppc 823 hardware
Date: Fri, 9 Mar 2001 17:11:37 +0000
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01030917160500.00652@dhopcroft>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I wonder if any one can shed some light on a problem I am having? I am trying
to implement PCMCIA services on a custom PPC based board.

I am using;
	Processor - PPC 823 @ 64MHz
	Kernel - 2.2.14
	Card Services - 3.1.10
	PCMCIA card - Xircom CreditCard Ethernet (CE3B-100BTX)

I "insmod" the required modules (pcmcia_core, m8xx_pcmcia, ds and xirc2ps_cs)
and run cardmgr.

The problem arises when I insert a pcmcia card, into it's slot. At which
point I get a "Kernel panic: machine check".  This seems to be around the area,
in the code, where the card services are starting to read it's CIS/attribute
area.

I have iormap'd _IO_BASE to 0x80000000 in init.c

My BMT is enabled but set to 255(Max value).

The bus frequency of the board is 32Mhz I have tried setting this in the code
to values of 32 & 32000000 with the same results. looking at file m8xx_pcmcia.c
it should be set to the latter.

Can any one suggest any thing obvious I have missed, or misunderstood?

I can post a debug log if required, but it's quite long.

---
David Hopcroft


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

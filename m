Subject: Tiny fix to fec.c for RPX boards using only fast ethernet
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Thu, 30 Mar 2000 10:11:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000330001115.4B3FF5067E@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi y'all,

There's an elegant engineering solution in fec.c to the problem of RPX boards
with both FEC and SCC ethernet ports. Unfortunately, it isn't desirable if the
SCC port isn't being used, because it still renumbers the FEC MAC address from
the one in the board info structure.

Here's a simple patch that only enables the renumbering if SCC ethernet is
also being used. It also makes the decision non-board-specific, so other boards
with dual FEC & SCC ports benefit too:


*** fec.c.old	Thu Mar 30 10:05:58 2000
--- fec.c	Thu Mar 30 10:06:30 2000
***************
*** 994,1000 ****
  	eap = (unsigned char *)my_enet_addr;
  	iap = bd->bi_enetaddr;

! #ifdef CONFIG_RPXCLASSIC
  	/* The Embedded Planet boards have only one MAC address in
  	 * the EEPROM, but can have two Ethernet ports.  For the
  	 * FEC port, we create another address by setting one of
--- 994,1000 ----
  	eap = (unsigned char *)my_enet_addr;
  	iap = bd->bi_enetaddr;

! #ifdef CONFIG_SCC_ENET
  	/* The Embedded Planet boards have only one MAC address in
  	 * the EEPROM, but can have two Ethernet ports.  For the
  	 * FEC port, we create another address by setting one of

--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

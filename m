Date: Tue, 19 Mar 02 16:43:34 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203200043.AA08228@ivan.Harhan.ORG>
To: mgreer@mvista.com
Subject: Re: EV-64260-BP & GT64260 bi_recs
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> I like what Michael has done but want to add more and change the
> BI_GT64260_ETH_CFG to a more generic BI_ETH_CFG.

I disagree. I don't see how a generic BI_ETH_CFG is possible. See how I've
implemented BI_GT64260_ETH_CFG in arch/ppc/kernel/setup.c:parse_bootinfo: it
injects the information from this record directly into the gt64260_eth driver,
which is where this information is needed.

Next when someone wants to do the same for, say, 8260 Ethernet, they'll have to
add BI_8260_ETH_CFG or whatever. I don't see any other way: what if I built a
board with an 8260 CPU and a GT-64260 attached to the 60x bus coming out of the
8260 (such a board was in the works at SBS before I left) and both 8260 and GT
Ethernets are used? What will parse_bootinfo() do with a BI_ETH_CFG then? Is it
going to inject the MAC address into the 8260 Ethernet driver, into the GT
Ethernet driver, or where? How do you make sure that each Ethernet interface
gets the MAC address that belongs to it?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

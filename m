Message-ID: <37D0F88E70D96C428C19EEB865701A38016C25F2@buda902a.siemens.hu>
From: Meszaros Lajos <ludwigm@siemens.com>
To: Kamalesh B <kamal@tataelxsi.co.in>,
	Coray Tate <ctate@metrowerks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem porting 2.4.17 linux to MPC8260ADS
Date: Tue, 4 Mar 2003 10:20:45 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You have to initialize memory controller to certain
addresses BEFORE any use of BATs, ioremap etc.
For example
  -BR1/OR1 for BCSR
  -BR5/OR5 for ATM
  -IMMR
  all of them anywhere above 0xf0000000.

So You can use these addresses with or without MMU
at same address. ( phys = virtual !!!)

Best Regards
  Ludwig


> -----Eredeti uzenet-----
> Felado: Kamalesh B [mailto:kamal@tataelxsi.co.in]
> Kuldve: Friday, February 21, 2003 5:16 PM
> Cimzett: Coray Tate; linuxppc-embedded@lists.linuxppc.org
> Targy: Problem porting 2.4.17 linux to MPC8260ADS
[snip]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

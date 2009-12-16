Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3E7D1B6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 22:37:17 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
References: <200912091529.13913.roman.fietze@telemotive.de>
	<20091209145748.GB3112@pengutronix.de>
In-Reply-To: <20091209145748.GB3112@pengutronix.de>
MIME-Version: 1.0
Message-ID: <200912161237.09796.roman.fietze@telemotive.de>
Date: Wed, 16 Dec 2009 12:37:09 +0100
Content-Type: Text/Plain;
  charset="iso-8859-15"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

On Wednesday 09 December 2009 15:57:48 Wolfram Sang wrote:

> Do you have a way to measure performance penalties?

As I said, I do.

And here they are. They won't win a price for the most impartial
benchmarks ever seen, but thet'll be a good starting point to get a
feeling what stability might cost.

The board is using the MPC5200B on a board derived from the old
lite5200, but with the fixes for the MPC5200B. All tests are run using
an ST940813AM hard drive with an ext2 and an ext3 of 10GB each,
default mkfs options. The OS is Debian 4.0. The network connection is
between a fast Athlon XP2 6400 and the target, using 100MBit/s wiring
and a 100MBit/s switch.

The F always stands for fast settings, coherent cache, XLB features
like snooping, etc. turned on, XLB config 0x0000a006 or 0x0001a006
(makes no or no big difference).

The S always stands for slow settings, non coherent cache, XLB
features like snooping, etc. turned on, XLB config 0x80012006.


Bonnie++ V1.03:

              ------Sequential Output------ --Sequential Input- --Random-
              -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine  Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
=46 ext2:  256M  2676  99 14759  47  5502  24  2792  98 16201  26 136.2   4
               ------Sequential Create------ --------Random Create--------
               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
         files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
            64    85  99 84712  99 14517 100    86  99 114078 100   309  99


              ------Sequential Output------ --Sequential Input- --Random-
              -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine  Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
S ext2:  256M  2647  99 14462  56  5468  29  2778  99 15856  32 134.2   4
               ------Sequential Create------ --------Random Create--------
               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
         files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
            64    87  99 85872 100 15919  99    88  99 114094  99   317  99


              ------Sequential Output------ --Sequential Input- --Random-
              -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine  Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
=46 ext3:  256M  2461  96 13327  73  5792  29  2798  98 16213  27 133.9   3
               ------Sequential Create------ --------Random Create--------
               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
         files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
            64  2826  92 59290  99  3803  71  2778  90 114706 100  3872  74


              ------Sequential Output------ --Sequential Input- --Random-
              -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine  Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
S ext3:  256M  2455  97 13340  85  5533  33  2759  98 15855  32 136.7   4
               ------Sequential Create------ --------Random Create--------
               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
         files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
            64  2774  92 59474 100  3810  74  2726  91 113937 100  3905  77


Netcat tests to or from my MPC5200B target. All times are the netcat
time -p output real/user/sys and the network data rate in MB/s. The
source data itself is either a dd from /dev/zero with bs=3D10M
count=3D1024 or a file of equal size either on an ext2 or ext3
filesystem. The destination is either /dev/null or a file on an ext2
or ext3.


Server:/dev/zero -> Target:/dev/null
  F: 1594/15.3/1031	6.8
  S: 1864/8.8/921	5.8

Target:/dev/zero -> Server:/dev/null
  F: 1396/35.8/1361	7.7
  S: 1578/51.5/1526	6.8

Server:/dev/zero -> Target:ext2
  F: 1799/37.0/1721	6.0
  S: 2093/42.6/2009	5.1

Target:ext2 -> Server:/dev/null
  F: 2423/31.3/1030	4.4
  S: 2820/15.2/1186	3.8

Server:/dev/zero -> Target:ext3
  F: 2110/33.4/1912.88	5.1
  S: 2397/47.5/2208.63	4.5

Target:ext3 -> Server:/dev/null
  F: 2407/17.9/1016	4.5
  S: 2676/15.4/1160	4.0

I repeated one or the other test and got comparable results.

And please keep in mind, that adding some more or less high load on
the SCLPC/LPC the F system crashed either right away or at least once
every few hours, depending on what we did (TX/RX, FLASH/FPGA,
SCLPC+DMA/SCLPC/CPU, ...), and depending on the concurrent load on the
=46EC and ATA. If you only need one or the other peripheral with your
system you might get away with alls the XLB fetures turned on.

Additionally to that, I got wrong data reading from FLASH or the FPGA
using SCLPC+DMA in the first few bytes with the fast settings, when I
did not manually flush or invalidate the cache prior to the DMA
submission as dma_map_single would do it in non cache coherent setups.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

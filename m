Message-Id: <m12zJwA-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: "eth0: transmit timed out" / "nfs: task can't get a request slot" msgs
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 6 Jun 2000 10:02:34 -0400 (EDT)
Cc: all@cideas.com
In-Reply-To: <m12uJGo-001SyaC@bucks> from "diekema_jon" at May 23, 2000 02:19:10 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> To: linuxppc-embedded@lists.linuxppc.org

> Platform: EST SBC8260 w/ MPC8260 Rev A.1 running at 166 Mhz

  Initial conditions: CPU/CPM/BUS 167/133/33 Mhz

> Ethernet: 10 Mbs (SCC)
> Root file system: Hard Hat Linux 1.1 from MontaVista
> Linux: 2.3.99-pre9

  Linux: 2.4.0-test1-ac7

> Problem:

> We are experiencing "eth0: transmit timed out" and "nfs: task XXXX
> can't get a request slot" messages during high NFS activity.  When
> this happens, the system performance is significantly degraded.  The
> Ethernet Tx LED only flashes infrequently.  I have experienced this
> problem under two cases:

> 1. A -mhard-float floating point application writing its results to a
>    NFS mounted log file.

> 2. Using cp to copy a 100 MB file to/from a NFS mounted partition.

> In either case, the task never runs to completion in a reasonable
> amount of time.

I can reduce/eliminate the "eth0: transmit timed out" problem by increasing
the bus clock and the cpu clock.

CPU/CPM/BUS

167/133/33  Initial problem discovered

167/133/66  Problem is less severe

	    I am able to copy more data via NFS before the problem hits

200/133/66  Problem has disappeared

	    I was able to read/write > 100 MB of data without any
	    strange messages appearing.  The data written compares
	    byte-for-byte with the data read.


Linux version 2.4.0-test1-ac7 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #6 Tue Jun 6 06:43:36 EDT 2000

CPU freq: 000000A5 Mhz
CPM freq: 00000084 Mhz
BUS freq: 00000042 Mhz

> cp z.in z.out &
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root      2195456 Jun  6  2000 z.out
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root     10424320 Jun  6  2000 z.out
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f8 cur_rx f00001a0.
1c04 05ea 005f2802
1c04 05ea 005f3802
1c04 0512 005f3002
1c04 05ea 008e5802
1c04 05ea 008e5002
1c1c 05ea 0088d802
1c00 05ea 005f2002
3c00 0512 006ed802
9c00 0100 001f6000
SCC ENET: BSY can't happen.
SCC ENET: BSY can't happen.
9c00 0040 001f6800
9c00 00ae 001eb000
SCC ENET: BSY can't happen.
9c00 0040 001eb800
9c00 0040 001ea000
9c00 0040 001ea800
9c00 0040 001e9000
bc00 0040 001e9800
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f8 cur_rx f00001b8.
1c00 0512 00527002
1c00 05ea 00526802
1c0c 05ea 00526002
1c00 0512 00561802
1c04 05ea 00561002
1c00 0512 006ec802
1c00 05ea 008e4802
3c00 05ea 008e4002
9c00 0060 001f6000
9c00 0075 001f6800
9c00 0076 001eb000
9c00 0076 001eb800
9c00 006a 001ea000
9c00 0075 001ea800
9c00 0075 001e9000
bc00 0040 001e9800
nfs: server 126.28.1.117 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx f00001f8 cur_rx f00001b8.
1c04 05ea 00577002
1c08 0512 00576802
5c04 002a 001e6842
5c00 002a 0045af02
5c00 002a 0045adc2
1c00 05ea 00560802
1c00 0512 00560002
3c00 05ea 00577802
9c00 00ae 001f6000
9c00 0046 001f6800
9c00 0076 001eb000
9c00 0075 001eb800
9c00 0072 001ea000
9c00 0075 001ea800
9c00 00ae 001e9000
bc00 0076 001e9800


Linux version 2.4.0-test1-ac7 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #6 Tue Jun 6 06:43:36 EDT 2000

CPU freq: 000000C6 Mhz
CPM freq: 00000084 Mhz
BUS freq: 00000042 Mhz

> cp z.in z.out &
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root     40599552 Jun  6  2000 z.out
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root     105480192 Jun  6  2000 z.out
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root     117575680 Jun  6  2000 z.out
> ls -al z*
-rw-rw-r--   1 root     root     117575680 May 23  2000 z.in
-rw-------   1 root     root     117575680 Jun  6  2000 z.out

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <200004130939.LAA10861@denx.local.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 Apr 2000 10:03:56 +0200."
             <Pine.LNX.4.10.10004130948140.10131-100000@opal.biophys.uni-duesseldorf.de>
Date: Thu, 13 Apr 2000 11:39:05 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.10.10004130948140.10131-100000@opal.biophys.uni-duesseldorf.de> you wrote:
>
> That might be a result of the interface init - if there are no real
> collisions otherwise. What number of collisions does the other machine
> log?

Seems normal to me for a usually lightly loaded network; for instance:

          RX packets:15315134 errors:1699 dropped:210 overruns:1691 frame:16
          TX packets:1427615 errors:7 dropped:0 overruns:3 carrier:4
          collisions:27791 txqueuelen:100

          RX packets:11453931 errors:10 dropped:0 overruns:0 frame:20
          TX packets:5286558 errors:3 dropped:0 overruns:2 carrier:1
          collisions:1157 txqueuelen:100

          RX packets:2011658 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1477258 errors:0 dropped:0 overruns:0 carrier:0
          collisions:8579 txqueuelen:100

> This, together with your info that the missing bytes happen on packet
> boundaries, strongly supports BenH's idea that we may be running into the
> txdma bug quoted above. The chipset apparently needs to be tweaked some
> way to reset the transmitter before starting the next DMA frame.

Yepp.

> What machine is on the receiving end? The file size being conserved may be

The other machines are either PC's running Linux (2.2.12 on a AMD-K6,
2.2.13 on a dual P-II, 2.3.51 on a dual P-III)  or  embedded  systems
(2.2.13 on MPX8xx, with xx=23, 50 and 60).

> due to Linux only looking at the packet size from the header (not cross
> checking with the size actually received), the sending machine padding the
> packet, or the BMAC on the receiving end placing packet size and status at
> the end of the frame.
>
> No idea why the bug correlates with disk activity - is the disk interrupt
> priority higher than ethernet DMA?

Well, I have no absolute evidence that there is a strict correlation.
It's more a certain feeling, and the observation that usually a  'tar
-zcf  - . | rsh ..." is almost certain to fail, while a plain FTP has
at least a 50...70% chance to be ok.

Regarding the interrupts:

# cat /proc/interrupts
           CPU0
  4:          0   PMAC-PIC      SCC-txdma
  5:          0   PMAC-PIC      SCC-rxdma
  6:          0   PMAC-PIC      SCC-txdma
  7:          0   PMAC-PIC      SCC-rxdma
  8:          1   PMAC-PIC      AWACS out
 12:         15   PMAC-PIC      MESH
 13:      20987   PMAC-PIC      ide0
 14:          5   PMAC-PIC      ide1
 15:          0   PMAC-PIC      SCC
 16:          0   PMAC-PIC      SCC
 17:          0   PMAC-PIC      AWACS
 18:       6587   PMAC-PIC      VIA-PMU
 19:          0   PMAC-PIC      SWIM3
 27:          1   PMAC-PIC      interrupt cascade
 32:      92922   PMAC-PIC      BMAC-txdma
 33:      70818   PMAC-PIC      BMAC-rxdma
 42:     163755   PMAC-PIC      BMAC-misc
 68:          0   PMAC-PI2      SCC-txdma
 69:          0   PMAC-PI2      SCC-rxdma
 79:          0   PMAC-PI2      SCC
 83:          0   PMAC-PI2      SWIM3

Hm... I have no idea if this relates to interrupt priorities on  this
box.

Also, after a failing FTP transfer:

# cat /proc/net/bmac
BMAC counters & registers
MEMADD: 0x000000
MEMDATAHI: 0x000000
MEMDATALO: 0x000000
TXPNTR: 0x000214
RXPNTR: 0x0002ce
IPG1: 0x000008
IPG2: 0x000004
ALIMIT: 0x000010
SLOT: 0x000040
PALEN: 0x000007
PAPAT: 0x0000aa
TXSFD: 0x0000ab
JAM: 0x000004
TXCFG: 0x000001
TXMAX: 0x0005ee
TXMIN: 0x000040
PAREG: 0x00000b
DCNT: 0x00b861
NCCNT: 0x0092cf
NTCNT: 0x003635
EXCNT: 0x000000
LTCNT: 0x000000
TXSM: 0x000010
RXCFG: 0x000b01
RXMAX: 0x0005ee
RXMIN: 0x000040
FRCNT: 0x0014d2
AECNT: 0x000000
FECNT: 0x000000
RXSM: 0x000002
RXCV: 0x000000

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:05:02:07:39:97
          inet addr:10.0.0.3  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:70896 errors:1 dropped:0 overruns:0 frame:0
          TX packets:92979 errors:2 dropped:0 overruns:0 carrier:0
          collisions:0


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It is better to have tried and failed than to have  failed  to  try,
but the result's the same."                           - Mike Dennison

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

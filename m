Message-ID: <20030506023727.28965.qmail@kunk.qbjnet.com>
Subject: SCC interrupts
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 5 May 2003 21:37:27 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm runing 2.4.20-ben10 on a 7200/75. The SCC in about 2 hours is
showing approx 60 interrupts/sec. This SEEMS to be making the
machine kind of sluggish. It is running an ax25 interface using
the kernel based ax25 drivers:

# dpkg -l | grep ax
ii  ax25-apps      0.0.6-1        Applications for AX25
ii  ax25-tools     0.0.8-2        AX-25 Tools
ii  libax25        0.0.10-1       ax25 libraries for hamradio applications

If I look at the ax25 interface it seems pretty quiet:

# ifconfig ax0
ax0       Link encap:AMPR AX.25  HWaddr N0QBJ-6
          inet addr:44.94.9.14  Bcast:44.255.255.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1024  Metric:1
          RX packets:5776 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5093 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:985720 (962.6 KiB)  TX bytes:457017 (446.3 KiB)

Also, from /proc/meminfo about 11 megs of the 48 megs of ram in the
machine is free.
If I look at /proc/interrupts though:

# cat /proc/interrupts
           CPU0
  4:          0   PMAC-PIC  Edge      SCC-txdma
  5:       3897   PMAC-PIC  Edge      SCC-rxdma
  6:          0   PMAC-PIC  Edge      SCC-txdma
  7:          0   PMAC-PIC  Edge      SCC-rxdma
 12:        195   PMAC-PIC  Edge      53C94
 15:     459070   PMAC-PIC  Edge      SCC
 16:          0   PMAC-PIC  Edge      SCC
 18:      11728   PMAC-PIC  Edge      ADB
 19:          0   PMAC-PIC  Edge      SWIM3
 23:       8555   PMAC-PIC  Level     aic7xxx
 24:      64369   PMAC-PIC  Level     eth0
BAD:          1

Lots of business on SCC. About 50 times as many interrupts as
received and transmitted packets. One the eth interface the
number of packets is roughly equivalent to the number of interrupts.

Would I be correct in assuming that something is up with the
ax25 driver or the kissattach command??

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b2b76717bf6b@[209.86.156.101]>
Date: Tue, 5 Jan 1999 00:52:41 -0800
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Strange PMAC IDE performance problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I discovered hdparm today, and ran its -Tt test to show sustained DTR from
the drive on several configurations:

1) PowerMac G3,    2.1.130,    BootX, IBM DGHS-09U on Adaptec 2940UW
   buffered disk reads 14.55 MB/s

2) PowerMac G3,    2.1.130,    BootX, IBM DHEA-38451 IDE
   buffered disk reads 1.89 MB/s

3) PowerBook 2400, 2.1.115,    OF,    IBM DTCA-24090 IDE 2.5"
   buffered disk reads 1.90 MB/s

4) PowerBook 2400, 2.2.0-pre4, BootX, IBM DTCA-24090 IDE 2.5"
   buffered disk reads 1.74 MB/s

5) PowerBook 2400, 2.2.0-pre4, OF,    IBM DTCA-24090 IDE 2.5"
   buffered disk reads 0.93 MB/s


I provided the Ultra SCSI case for comparison's sake, to show that hdparm
hasn't totally lost its mind.  14.55 MB/s is pretty much what IBM claims
for the DGHS-09U (UltraStar 9LP).

Needless to say, the IDE performance figures are far less than those drives
are capable of!  Under MacOS they benchmark much higher (for example, the
38451 scores 7780 to 9472 KB/s (8819 avg) sustained read on the FWB
BenchTest).  I think it's particularly interesting that the 2400 did better
when booted from BootX than Open Firmware.  It would also appear from (3)
that things have gotten worse over time, not better.

All the IDE figures above are with DMA on (except 2.1.115, which doesn't
support IDE DMA on the PowerMac unless I am mistaken).  I tried turning IDE
DMA off on 2.2.0-pre4 (hdparm -d0 /dev/hda).  Doing so increased the
throughput by .02 MB/s (BootX, didn't try OF case).

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

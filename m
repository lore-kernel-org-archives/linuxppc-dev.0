Message-ID: <A60FFE6CA339C742BE11C311EA8BFF5401637E@mdsms2.inside.mdsroc.com>
From: "Ruhland, Paul" <PRuhland@microwavedata.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Ethernet, kernel bug/weakness
Date: Thu, 7 Mar 2002 15:50:04 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've recently discovered what appears to be a bug or weakness in the kernel
that some may be interested in.

Hardware:
--
MPC850 @ 55Mhz
Bootloader:  PPCBOOT 1.1.4
Kernel:  linux-2.4.4-2001-07-23 from denx.de
Ethernet: LevelOne (LXT905) on SCC2

Conditions:
--
DOS type of attack on the ethernet port.

I originally discovered this when our QA department hooked a unit up to a
SmartBits Network Analyzer.  One test slams the UUTs ethernet port with
large amounts of IP packets...starting at the full bandwidth supported by
the network ( ie. 10Mbps/100Mbps ), or at configurable percentages of the
full bandwidth.  For our unit(s), the critical point is ~7-10% of 10Mpbs (
700Kbps - 1Mbps ).  The actual IP packets have valid ethernet/ip headers but
bogus data and a directed at the UUT's ethernet address.

I have since written a C program which can recreate the problem ( replacing
the SmartBits with a workstation, as not many people dont have them ).
Basically open a raw socket, providing the ip header and data yourself, loop
sending as fast as your machine permits to UUT.

Effect:
--
Once the ethernet traffic goes above the critical point described above, all
cpu cycles are spent servicing the ethernet traffic.  If the watchdog is
enabled, the unit will reboot since no other process is able to run (
including the one that kicks the dog ).  Even a kernel driver that kicks the
dog via timer interrupt will not be run.  Without watchdog enabled the unit
does...well, nothing...for all practical purposes it is dead.


Current Status
--
I've tried various things attempting to narrow the problem down.  Even
resetting the watchdog immediately upon entry to ethernet interrupt handler
doesn't stop the reboot ( in case where watchdog is enabled of course )...so
the problem appears to be at a higher level.  Some type of throttling of the
network load on system seems to be required but is not currently present in
the kernel.

Although this type of traffic doesn't occur under normal conditions,
sometimes bad things happen ( intentionally or accidentally ) and the
current behavior of the kernel is less than acceptable.

I currently don't have time to spend on this issue but thought folks should
be made aware to either verify, refute, or investigate and fix.       I will
be returning to this when time permits, but I will provide any other info (
if possible ) to anyone who inquires.

--
Paul Ruhland


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

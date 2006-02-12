Return-Path: <linuxppcdev@lists.qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id C0C2F679EA
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2006 08:08:04 +1100 (EST)
Date: 12 Feb 2006 21:01:23 -0000
Message-ID: <20060212210123.24360.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@lists.qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: PReP PCI resource allocations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a 7248-133 43p. I had a lot of trouble with the early 2.6
kernels on this prep machine however 2.6.14.7 runs well (the
vga console driver even works now). There is one thing I noticed
different from 2.4.32 involving PCI resources. On 2.6.14.7 I get...

Total memory = 192MB; using 512kB for hash table (at c0300000)
Linux version 2.6.14.7 (root@oldbb) (gcc version 4.0.3 20051201 (prerelease)
(Debian 4.0.2-5)) #4 Fri Feb 10 13:27:45 CST 2006
PReP architecture
IBM planar ID: f7
...
PCI: Probing PCI hardware
Setting PCI interrupts for a "IBM 7248, PowerSeries 830/850 (Carolina)"
PCI: Cannot allocate resource region 0 of device 0000:00:0c.0
PCI: Cannot allocate resource region 1 of device 0000:00:0c.0
PCI: Cannot allocate resource region 0 of device 0000:00:10.0

The regions correspond to:
Region 0: I/O ports at 80001020 [size=32] of the builtin pcnet32 ethernet.
Region 1: Memory at c0800100 (32-bit, non-prefetchable) [size=32] pcnet32..
Region 0: I/O ports at 80001400 [size=256] of the Symbios Logic 53c810 scsi.

Both the ethernet and scsi work fine though..

2.4.32 remaps these...
Linux version 2.4.32 (root@oldbb) (gcc version 2.95.4 20011002
(Debian prerelease)) #2 Tue Feb 7 12:30:21 CST 2006
PReP architecture
IBM planar ID: 000000f7
...
PCI: Cannot allocate resource region 0 of device 00:0c.0
PCI: Cannot allocate resource region 0 of device 00:10.0
PCI: moved device 00:0c.0 resource 0 (101) to 1020
PCI: moved device 00:0c.0 resource 1 (200) to 0
PCI: moved device 00:10.0 resource 0 (101) to 1400

Is this important??

2.6.15 BTW doesn't work at all. I need to hook up a serial console to
see if I can figure out what is going on...

Bob

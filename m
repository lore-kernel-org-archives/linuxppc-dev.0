Date: Wed, 12 Jan 2000 19:10:28 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Help Sought: 8390-Ethernet Troubles on PowerPC 4xx Port
Message-ID: <Pine.SGI.4.10.10001121900080.250408-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The latest road bump I've encountered on the path to a Linux port for the
PowerPC 403GCX running on IBM's "Oak" evaluation board is getting the
National Semiconductor DP83902AV chip to behave.

The chip on the board works with both the IBM PROM and with TiVo's
2.1.24-based kernel, so I know that the hardware is OK.

Thinking that maybe I had a problem with the Linux 2.3.3x sources, I
overlaid the port onto 2.2.14 and get the same problem. So, it's
definitely something in the 4xx-code or something in my 'oaknet.c' driver.

My driver is pretty much a verbatim copy of all the other 8390-based
drivers. TiVo's 2.1.24 driver doesn't seem much different either.

I DO know for a fact that I can probe and see the device and I know for a
fact that the driver is getting and handling interrupts.

Anyone out there with any experience with 8390-based controllers or
drivers have any insight on where I might start looking to tackle the
below problem? 

The "oaknet.c" code is in the latest 2.3.39 sources; otherwise, I can send
the similar code for 2.2.14 if it'd help. Both rely on the stock 8390.o
module.

I get the following sorts of errors on both 2.2.14 and 2.3.3x:

Linux version 2.2.14 (grant@brule) (gcc version 2.95.2 19991024 (release)) #97 Wed Jan 12 16:52:16 CST 2000
Calibrating delay loop... 9.73 BogoMIPS
Memory: 7124k available (660k kernel code, 372k data, 36k init) [c0000000,c0800000]
Dentry hash table entries: 1024 (order 1, 8k)
Buffer cache hash table entries: 8192 (order 3, 32k)
Page cache hash table entries: 2048 (order 1, 8k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 8192 bhash 8192)
Starting kswapd v 1.5 
Shoulda called rs_init...
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: National DP83902AV at 08:00:5a:c8:02:b4, found at 0xf4000000, using IRQ 27.
Looking up port of RPC 100003/2 on 192.168.68.90
eth0: timeout waiting for Tx RDC, stat = 0x0
	start address 0x2000, current address 0x2018, count 42
Resetting eth0...
eth0: timeout waiting for Tx RDC, stat = 0x3
	start address 0x2600, current address 0x2612, count 42
Resetting eth0...
eth0: timeout waiting for Tx RDC, stat = 0x3
	start address 0x2000, current address 0x2014, count 42
Resetting eth0...
neighbour table overflow
eth0: timeout waiting for Tx RDC, stat = 0x3
	start address 0x2600, current address 0x2613, count 42
Resetting eth0...
eth0: timeout waiting for Tx RDC, stat = 0x3
	start address 0x2000, current address 0x2012, count 42
Resetting eth0...
eth0: timeout waiting for Tx RDC, stat = 0x3
	start address 0x2600, current address 0x2613, count 42
Resetting eth0...
neighbour table overflow

Stymied,

Grant Erickson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-Id: <200012040043.eB40h5028102@denx.local.net>
cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: 2.4.0-test11 - MPC860T FEC question.
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 03 Dec 2000 21:11:23 +0100."
Date: Mon, 04 Dec 2000 01:43:05 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

I just found another problem with the FEC / MII code. It happens when
I try to use BOOTP in the LInux kernel (I haven't been doing this for
a long time, since _if_ we use BOOTP, we do so in PPCBoot,  and  pass
all information to the kernel instead of running BOOTP twice).

Here is what I see:

Linux version 2.4.0-test11 (wd@denx.local.net) (gcc version 2.95.2 19991024 (release)) #1 Mon Dec 4 00:19:12 MET 2000
Boot arguments: root=/dev/nfs rw ip=bootp
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw ip=bootp
Decrementer Frequency: 3125000
Calibrating delay loop... 49.87 BogoMIPS
Memory: 14664k available (980k kernel code, 388k data, 44k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: IBM-DCXA-210000, ATA DISK drive
ide0 at 0xc2000000-0xc2000007,0xc2000106 on irq 10
hda: 19640880 sectors (10056 MB) w/420KiB Cache, CHS=19485/16/63
Partition check:
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6
eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 12, addr 00:d0:93:00:01:cb
eth0: Phy @ 0x0, type LXT971 (0x001378e1)
eth1: FEC ENET Version 0.2, FEC irq 9, MII irq 12, addr 00:d0:93:00:01:cb
eth0: Phy @ 0x0, type LXT971 (0x001378e1)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100HDX, 10HDX.
IP-Config: Failed to open eth1
Sending BOOTP requests............. timed out!
IP-Config: Auto-configuration of network failed.
eth0: status: link up, 100 Mbps Half Duplex, auto-negotiation complete.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
Root-NFS: No NFS server available, giving up.
...


It seems the "link up" interrupt comes much too late for the
"IP-Config" part; shouldn't we wait in fec_enet_open() for
"fep->link" to come up?

And do you have an idea why there is a "eth1" detected?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Confound these ancestors.... They've stolen our best ideas!"
- Ben Jonson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

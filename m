Message-ID: <619D608DD3F0D311882C009027732E1A353222@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Matt Porter'" <mmporter@home.com>
Cc: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.4.6 kernel on MCP750 board
Date: Mon, 23 Jul 2001 11:03:12 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, Matt

Your patch did make things a bit better. Now it tries to initialize the
tulip, but I do not think it is very happy.
Kernel tries to send BOOTP requests, but they never reach the server.
And tulip driver complains about missing EEPROM. Old kernel was finding the
EEPROM OK. Also, MAC address is changing between two kernels somehow. I
assume it is due to the detection of an EEPROM.

I've included updated start up dump.

<Skipped>

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/nfs
nfsroot=/usr/local
/opt/hardhat/devkit/ppc/7xx/target ip=on
Uncompressing Linux...done.
Now booting the kernel
Total memory = 32MB; using 128kB for hash table (at c01e0000)
Linux version 2.4.6 (marka@actmel042.act.domain) (gcc version 2.95.2
19991030 (2
.95.3 prerelease/franzo)) #39 Mon Jul 23 10:18:32 EST 2001
PReP architecture
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/nfs
nfsroot=/usr/
local/opt/hardhat/devkit/ppc/7xx/target ip=on
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at fc000000
OpenPIC timer frequency is 8.333848 MHz
time_init: decrementer frequency = 16.666442 MHz
Calibrating delay loop... 465.30 BogoMIPS
Memory: 30228k available (1140k kernel code, 576k data, 100k init, 0k
highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Fixup res 1 (200) of dev 00:00.0: 3c000000 -> fc000000
Fixup res 1 (200) of dev 00:0e.0: 3bffff00 -> fbffff00
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Memory resource not set for host bridge 0
Fixup res 0 (1208) of dev 01:0d.0: 3bef0000 -> fbef0000
Fixup res 1 (200) of dev 01:0d.0: 3beef000 -> fbeef000
Fixup res 2 (200) of dev 01:0d.0: 3bc00000 -> fbc00000
Fixup res 3 (200) of dev 01:0d.0: 3bb80000 -> fbb80000
PCI: Unable to handle 64-bit address space for
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
PCI:00:00.0: Resource 1: fc000000-fc03ffff (f=200)
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI:  parent is c01ce04c: c0000000-ffffffff (f=200)
PCI:00:0b.1: Resource 0: 0000fff0-0000fff7 (f=101)
PCI: Cannot allocate resource region 0 of device 00:0b.1
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 1: 0000ffec-0000ffef (f=10d)
PCI: Cannot allocate resource region 1 of device 00:0b.1
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 2: 0000ffe0-0000ffe7 (f=101)
PCI: Cannot allocate resource region 2 of device 00:0b.1
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 3: 0000ffdc-0000ffdf (f=10d)
PCI: Cannot allocate resource region 3 of device 00:0b.1
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 4: 0000ffc0-0000ffcf (f=101)
PCI: Cannot allocate resource region 4 of device 00:0b.1
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0b.2: Resource 4: 0000ffa0-0000ffbf (f=101)
PCI: Cannot allocate resource region 4 of device 00:0b.2
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0e.0: Resource 0: 0fffff00-0fffff7f (f=101)
PCI: Cannot allocate resource region 0 of device 00:0e.0
PCI:  parent is c01ce030: 00000000-ffffffff (f=100)
PCI:00:0e.0: Resource 1: fbffff00-fbffff7f (f=200)
PCI: Cannot allocate resource region 1 of device 00:0e.0
PCI:  parent is c01ce04c: c0000000-ffffffff (f=200)
PCI:01:0d.0: Resource 0: fbef0000-fbefffff (f=1208)
PCI: Cannot allocate resource region 0 of device 01:0d.0
PCI:  parent is c02ba938: fbb00000-fbefffff (f=200)
PCI:01:0d.0: Resource 1: fbeef000-fbeeffff (f=200)
PCI: Cannot allocate resource region 1 of device 01:0d.0
PCI:  parent is c02ba938: fbb00000-fbefffff (f=200)
PCI:01:0d.0: Resource 2: fbc00000-fbdfffff (f=200)
PCI: Cannot allocate resource region 2 of device 01:0d.0
PCI:  parent is c02ba938: fbb00000-fbefffff (f=200)
PCI:01:0d.0: Resource 3: fbb80000-fbbfffff (f=200)
PCI: Cannot allocate resource region 3 of device 01:0d.0
PCI:  parent is c02ba938: fbb00000-fbefffff (f=200)
PCI: Failed to allocate resource 0(1000-1007) for 00:0b.1
PCI: Failed to allocate resource 1(1000-1003) for 00:0b.1
PCI: Failed to allocate resource 2(1000-1007) for 00:0b.1
PCI: Failed to allocate resource 3(1000-1003) for 00:0b.1
PCI: Failed to allocate resource 4(1000-100f) for 00:0b.1
PCI: Failed to allocate resource 4(1000-101f) for 00:0b.2
PCI: Failed to allocate resource 0(1080-10ff) for 00:0e.0
  got res[c0000000:c000007f] for resource 1 of PCI device 1011:0009
PCI: Failed to allocate resource 0(10000000-1000ffff) for 01:0d.0
PCI: Failed to allocate resource 1(10000000-10000fff) for 01:0d.0
PCI: Failed to allocate resource 2(10000000-101fffff) for 01:0d.0
PCI: Failed to allocate resource 3(10280000-102fffff) for 01:0d.0
Activating ISA DMA hang workarounds.
PCI: Via IRQ fixup for 00:0b.2, from 16 to 0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI IS
APNP enabled
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 20002kB/6667kB, 64 slots per queue
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
tulip0:  Missing EEPROM, this interface may not work correctly!
eth0: Digital DS21140 Tulip rev 34 at 0x1080, EEPROM not present,
00:4C:69:6E:75
:79, IRQ 18.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Sending BOOTP requests .<7>eth0: Media selection tick, 100baseTx, status
fffffff
f mode ffffffff SIA ffffffff ffffffff ffffffff ffffffff.
.....<7>eth0: Media selection tick, 100baseTx, status ffffffff mode ffffffff
SIA
 ffffffff ffffffff ffffffff ffffffff.
 timed out!
IP-Config: Retrying forever (NFS root)...
..


Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: linuxppc-dev@lists.linuxppc.org
Cc: peter@cendio.se
Subject: Problem with a IBM ServerRAID and it's PCI-bridge
From: Jan Smith <smith@cendio.se>
Date: 20 Nov 2001 19:37:01 +0100
Message-ID: <vxherpthki.fsf@snoddas.lkpg.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We are trying to build the ips driver for the IBM ServerRAID 4H
card. When the kernel is booting do we get some information about some
fixup function that are moving the cards I/O-adress from fffc00 to
1fffc00. (Output from dmesg is included below.)

What is this fixup function needed for? We think that one reason to
move the card's I/O-adress is that there is another SCSI interface
that's using the adress fffc00 but as we not are using that interface
don't I see why we have to bother about that.

I have only found information about different types of Mac's that
need the fixup method to initialize it's PCI-cards in a right
way. This PCI card has a PCI bridge and maybe that's the reason
why we need to use it even here. I'd be very pleased to get
some information that anyone can have about the fixup function from
people who are writing drivers for RS/6000 machines.

dmesg output:

Total memory = 768MB; using 2048kB for hash table (at c0800000)
Linux version 2.4.14 (root@illian.lkpg.cendio.se) (gcc version 2.95.2 19991024 (release)) #1 SMP Mon Nov 12 09:49:58 CET 2001
PCI bus 0 controlled by pci at fef00000
PCI bus 64 controlled by pci at fee00000
OpenPIC addrs: ffc00000 feff7c00 feef7c00
RTAS Event Scan Rate: 1 (2999 jiffies)
On node 0 totalpages: 196608
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at f7efc000
time_init: decrementer frequency = 93.746483 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 748.74 BogoMIPS
Memory: 768080k available (1576k kernel code, 1028k data, 292k init, 0k highmem)System.map loaded at 0xc121ff38 for debugger, size: 4113 bytes
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: Probing PCI hardware
Fixup res 0 (101) of dev 40:0c.0: fffc00 -> 1fffc00
PCI: Cannot allocate resource region 3 of PCI bridge 0
PCI: resource is a0000..9ffff (200), parent c01e0e90
PCI:00:0f.0: Resource 0: c0000000-c0ffffff (f=1208)
PCI:00:0f.0: Resource 1: c2800000-c2803fff (f=200)
PCI:00:0f.0: Resource 2: c2000000-c27fffff (f=200)
PCI:00:0b.1: Resource 0: 00ffe000-00ffe007 (f=101)
PCI:00:0b.1: Resource 1: 00ffd800-00ffd803 (f=101)
PCI:00:0b.1: Resource 2: 00ffe400-00ffe407 (f=101)
PCI:00:0b.1: Resource 3: 00ffdc00-00ffdc03 (f=101)
PCI:00:0b.1: Resource 4: 00ffe800-00ffe80f (f=101)
PCI:00:0b.1: Resource 5: 00ffec00-00ffec0f (f=101)
PCI:00:0c.0: Resource 0: 00fff000-00fff01f (f=101)
PCI:00:0c.0: Resource 1: c321b000-c321b01f (f=200)
PCI:00:0d.0: Resource 0: c3210000-c3213fff (f=200)
PCI:00:10.0: Resource 0: 00fff400-00fff41f (f=101)
PCI:00:10.0: Resource 1: c321a000-c321a01f (f=200)
PCI:00:11.0: Resource 0: 00fff800-00fff8ff (f=101)
PCI:00:11.0: Resource 1: c3219000-c32193ff (f=204)
PCI:00:11.0: Resource 3: c3216000-c3217fff (f=204)
PCI:00:11.1: Resource 0: 00fffc00-00fffcff (f=101)
PCI:00:11.1: Resource 1: c3218000-c32183ff (f=204)
PCI:00:11.1: Resource 3: c3214000-c3215fff (f=204)
PCI:40:0c.0: Resource 0: 01fffc00-01fffcff (f=101)
PCI:40:0c.0: Resource 1: dff00000-dfffffff (f=200)

--
--------------------------------------------------------------------------
Jan Smith                              Email:  smith@cendio.se
Cendio Systems AB                      WWW:    www.cendio.se
Teknikringen 3,                        Voice:  +46 - (0)13 - 21 46 00
SE-583 30  LINKÖPING, SWEDEN           Fax:    +46 - (0)13 - 21 47 00

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

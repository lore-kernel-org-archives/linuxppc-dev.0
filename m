Message-Id: <4.2.2.20040519145943.04c28200@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 15:19:54 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS time out
In-Reply-To: <20040519224447.GE13351@gate.ebshome.net>
References: <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
 <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
 <4.2.2.20040519143346.04c41220@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>It's possible that after you did something with OpenBIOS, e.g. rebuilt it,
>VPD
>area moved to some other place. Or probably you have an old or new boot
>loader
>:)

We are using the one which came with the board about 3 months ago.

Using the default bootloader [ which came with the board ], and the
zImage.ebony which
is produced by:

target=powerpc-eabi-elf
PATH=/opt/rtems/bin:/home/engr/tools/linux2powerpc-eabi-elf/bin:$PATH
OUTPUT=/home/engr/users/bhawley/projects/thirdparty/kernel/ebony_def
make ARCH=ppc O=$OUTPUT mrproper
make CROSS_COMPILE=$target- ARCH=ppc O=$OUTPUT ebony_defconfig
make CROSS_COMPILE=$target- ARCH=ppc O=$OUTPUT

We get:

The IBM boot, looks the same as the uboot boot. But, the EMAC addresses
are correct.  However, it still has the same problem in that at the point where
the kernel starts trying to do bootp requests and doesn't get a
response.  The DHCP
server is configured [ and we are obviously loading the kernel from it
].  But, at
the point it starts sending BOOTP requests, there is no network
traffic.  We are sniffing
the traffic to the dhcp server for the MAC address of the ebony board...and
while we
see the tftp requests...no dhcp requests ever come.

Our dhcpd.conf for ebony looks like:

host ebony {
         hardware ethernet 00:04:ac:e3:23:b2;
         fixed-address 162.10.98.190;
         option root-path "/eldk/ppc_4xx";
         option host-name "ebony";
         filename "/zImage.ebony";
}


->0
EMAC0: Speed is 100 MBPS, FULL duplex connection
EMAC0: Ethernet Test OK.
Booting from [EMAC0] Ethernet 0 ...
Sending bootp request ...

Loading file "/zImage.ebony" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...
loaded at: 00500000 005C81DC
relocated to: 01000000 010C81DC
zimage at: 01005847 010C4136
avail ram: 00400000 00800000
Linux/PPC load: ip=on
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.5 (bnh-engr@feimer) (gcc version 3.3.3) #1 Wed May 19
15:41:31 PDT 2004
IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
On node 0 totalpages: 32768
DMA zone: 32768 pages, LIFO batch:8
Normal zone: 0 pages, LIFO batch:1
HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: ip=on
PID hash table entries: 1024 (order 10: 8192 bytes)
Memory: 127584k available (1212k kernel code, 428k data, 84k init, 0k
highmem)
Calibrating delay loop... 598.01 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing PCI hardware
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
mal0: Initialized, 4 tx channels, 2 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC 00:04:ac:e3:23:b2
eth0: Found Generic MII PHY (0x08)
zmii0: input 1 in RMII mode
eth1: IBM emac, MAC 00:04:ac:e3:23:b3
eth1: Found Generic MII PHY (0x09)
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: Link is Up
eth0: Speed: 100, Full duplex.
Sending BOOTP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
eth0: Speed: 100, Full duplex.
Sending BOOTP requests ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: okorpil@fh-landshut.de
Date: Mon, 5 Apr 2004 15:23:32 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: Interrupt problem on MVME2100
Message-ID: <Pine.LNX.4.58.0404051411250.32201@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I've spent the weekend porting Andrew Johnon's MVME2100 patch for the
HHL2.0 Linux kernel 2.4.2 to kernel.org 2.4.25.

I consider it mostly a success, since the new version - you find it here:

http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.bz2
http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.gz

- will correctly boot a zImage off ethernet, mount a NFS root (which is
verified because it starts binaries off it later), gives it output in the
debug serial console...

So, now I have ethernet working, and serial console mostly working...

Mostly because it shows the kernel boot process correctly - and fast! -
and then falls into a slow mode when putting out the messages from init.

It has been mentioned here on the mailing list, that this derives from
incorrectly setup interrupts - characters are reflected on the serial
console as if several were spit out on every timeout.

Unfortunately Andrew Johnson mentioned on the discussion

http://lists.linuxppc.org/linuxppc-embedded/200107/msg00063.html

that he simply ignored that (UART serial) interrupt (at 29) because it had
"too high" a number.

So combining that, I think the driver doesn't get to see the interrupt,
and therefore is so slow.

The problem may derive from two facts. First, there is a (too) limited set
of interrupts defined, and second, the MVME2100 has unused interrupts -
you could say holes in the interrupt map.

First 16 interrupts are left free because there is no cascaded 8259, if I
understand correctly, and then there are several unused interrupts (as
stated in the manual).

Andrew Johnson originally suggested to use something cannonicalize_irq ()
to drop the inconsistencies.

If you want to make a picture yourself, look at the definition of
__initdata  in arch/ppc/platforms/mvme2100.c, where interrupt map is
initialized.

My problem is this: How go I best about bringing my interrupts into range?
Do I need to remap something? Do I redefine a constant defining the
maximum?

The config file is in the patch as arch/ppc/configs/mvme2100_defconfig

Thanks in advance, Oliver Korpilla

My boot output:

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&801471, Bytes Loaded =&801471
Bytes/Second   =&801471, Elapsed Time =1 Second(s)

Residual-Data Located at: $01F5511C
loaded at:     00005400 000CA5BC
relocated to:  00800000 008C51BC
zimage at:     00805910 008C1F2A
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/nfs
nfsroot=192.168.1.1:/home/korpo/praktikum/mvme2100/rootfs
ip=192.168.1.3:192.168.1.1::255.255.255.0:mvme2100::off
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.25 (korpo@ppcproject1) (gcc version 2.95.3 20010315
(release)) #48 Mon Apr 5 13:40:52 CEST 2004
Platform: Motorola MVME2100
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs
nfsroot=192.168.1.1:/home/korpo/praktikum/mvme2100/rootfs
ip=192.168.1.3:192.168.1.1::255.255.255.0:mvme2100::off
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at f7fd0000
OpenPIC timer frequency is 8.333344 MHz
time_init: decrementer frequency = 16.666765 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 30388k available (1260k kernel code, 472k data, 252k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xffe10000 (irq = 29) is a 16550A
Real Time Clock Driver v1.10f
Generic RTC Driver v1.07
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3)
block.
tulip0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xbfffec00, 00:01:AF:02:93:8C, IRQ
17.
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
IP-Config: Complete:
      device=eth0, addr=192.168.1.3, mask=255.255.255.0,
gw=255.255.255.255,
     host=mvme2100, domain=, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.1, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 252k init
eth0: Setting full-duplex based on MII#8 link partner capability of 45e1.
init started:  BusyBox v1.00-pre8 (2004.03.29-15:26+0000) multi-call
binary


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

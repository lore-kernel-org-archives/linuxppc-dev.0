Date: Wed, 2 Apr 2003 14:02:15 +0200
From: Toni Van Remortel <t.vanremortel@ha.be>
To: linuxppc-embedded@lists.linuxppc.org
Subject: EP405 Kernel Panic
Message-Id: <20030402140215.47965273.t.vanremortel@ha.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've built a zImage.initrd (which should be OK, because it boots) and I
burned it into the flash of my EP405 board.

This is the boot output:

loaded at:     FF840000 FFA8C1D4
relocated to:  00400000 0064C1D4
board data at: 00649128 00649144
relocated to:  004053B4 004053D0
zimage at:     00405910 0048D141
initrd at:     0048E000 00648F81
avail ram:     0064D000 01000000

Linux/PPC load: root=/dev/ram init=/bin/bash
Uncompressing Linux...done.
Now booting the kernel
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.21-pre6 (root@toni) (gcc version 2.95.4 20010319 (prerelease/franzo/20011204)) #17 wo apr 2 12:01:21 CEST 2003
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram init=/bin/bash
Calibrating delay loop... 199.47 BogoMIPS
Memory: 13000k available (984k kernel code, 340k data, 76k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.6.2 init complete
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
OCP Reset timeout #2!
OCP Reset timeout #1!
eth0: No PHY device found.
removing net dev
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1771k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 76k init
Kernel panic: No init found.  Try passing init= option to kernel.


So as you can see, the kernel parameters are root=/dev/ram
init=/bin/bash, but why does the kernel panic on No init!?
/bin/bash does exist in the initrd.

Anybody an idea where to look?

# file bin/bash
bin/bash: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), for GNU/Linux 2.2.5, dynamically linked (uses shared libs), stripped
Needed libs are in /lib.

--
Toni Van Remortel - Scientific Researcher
D-science lab (Hogeschool Antwerpen)
Phone: +32 (0) 3 205 61 72
Fax  : +32 (0) 3 205 61 95

Current project:
LinEmb: RealTime and Embedded Linux
(http://linemb.d-sciencelab.com)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

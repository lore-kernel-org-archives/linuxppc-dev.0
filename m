Subject: Re: [U-Boot-Users] Auto-detected parameters CpuFreq and
	granularity no longer autodetected.
From: Seb James <seb@peak.uklinux.net>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org, rtai@rtai.org
In-Reply-To: <20030828120155.58923C59E4@atlas.denx.de>
References: <20030828120155.58923C59E4@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1062077667.3292.221.camel@xerxes.hypercube>
Mime-Version: 1.0
Date: 28 Aug 2003 14:34:27 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2003-08-28 at 13:01, Wolfgang Denk wrote:
>
> Which version of insmod are you using? The one builtin with  busybox?
> BusyBox  v0.60.2  might  have  some  problems  here  ... Try out what
> happens when you disable the modutils option in busybox, and use  the
> binaries from the ELDK.

The one in busybox, yes. This is the busybox from the eldk.

I'll try the modutils idea.

Here is another bit of the puzzle. If I boot using the eldk root
environment mounted over nfs, then I can't insmod rtai.o at all - the
kernel hangs. This is ELDK 2.0.2. There's a kernel message during boot
here that looks wrong, these two lines:

Oct 22 03:48:12 vmu kernel: Cannot find map file.
Oct 22 03:48:12 vmu kernel: No module symbols loaded.

What's this to do with I wonder?

-----------------console output---------------------------
=> run flash_nfs
## Booting image at 40040000 ...
   Image Name:   test kernel
   Created:      2003-07-04  15:35:53 UTC
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    1368124 Bytes =  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
OK
Linux version 2.4.4-rthal5 (seb@mst26) (gcc version 2.95.4 20010319 (prerelease/franzo/20011204)) #8 Wed Jun 25 16:28:38 BST 2003
I2C uCode patch installed
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.10.1:/eldk/ppc_8xx ip=192.168.10.99:192.168.10.1:192.168.10.1:255.255.255.0:vmu::off panic=1
Decrementer Frequency: 3125000
Calibrating delay loop... 49.86 BogoMIPS
Memory: 14568k available (1020k kernel code, 428k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS0 on SMC1 at 0x0280, BRG1
pty: 256 Unix98 ptys configured
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40000000
Registered flash device /dev/flasha (minor 0, 4 partitions)
Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40400000
Registered flash device /dev/flashb (minor 8, 2 partitions)
block: queued sectors max/low 9586kB/3195kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
No card in slot B: PIPR=ff00ff00
eth0: CPM ENET Version 0.2 on SCC2, 00:d0:93:00:c0:a4
CPM load tracking driver $Revision: 1.0 $
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.10.1
Looking up port of RPC 100005/2 on 192.168.10.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
modprobe: modprobe: Can't locate module char-major-4
INIT: version 2.78 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
Setting clock : Fri Oct 22 03:48:00 EDT 2021 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname vmu:  [  OK  ]
Finding module dependencies:  [  OK  ]
Checking filesystems
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting system logger: [  OK  ]
Starting kernel logger: Oct 22 03:48:12 vmu kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 22 03:48:12 vmu kernel: Cannot find map file.
[  OK  ]
Oct 22 03:48:12 vmu kernel: No module symbols loaded.
Oct 22 03:48:12 vmu kernel: Linux version 2.4.4-rthal5 (seb@mst26) (gcc version 2.95.4 20010319 (prerelease/franzo/20011204)) #8 Wed Jun 25 16:28:38 BST 2003
Oct 22 03:48:12 vmu kernel: I2C uCode patch installed
Oct 22 03:48:12 vmu kernel: On node 0 totalpages: 4096
Oct 22 03:48:12 vmu kernel: zone(0): 4096 pages.
Oct 22 03:48:12 vmu kernel: zone(1): 0 pages.
Oct 22 03:48:13 vmu kernel: zone(2): 0 pages.
Oct 22 03:48:13 vmu kernel: Kernel command line: root=/dev/nfs rw nfsroot=192.168.10.1:/eldk/ppc_8xx ip=192.168.10.99:192.168.10.1:192.168.10.1:255.255.255.0:vmu::off panic=1
Oct 22 03:48:13 vmu kernel: Decrementer Frequency: 3125000
Oct 22 03:48:13 vmu kernel: Calibrating delay loop... 49.86 BogoMIPS
Oct 22 03:48:13 vmu kernel: Memory: 14568k available (1020k kernel code, 428k data, 56k init, 0k highmem)
Oct 22 03:48:13 vmu kernel: Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Oct 22 03:48:13 vmu kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Oct 22 03:48:13 vmu kernel: Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Oct 22 03:48:13 vmu kernel: Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Oct 22 03:48:13 vmu kernel: POSIX conformance testing by UNIFIX
Oct 22 03:48:13 vmu kernel: Linux NET4.0 for Linux 2.4
Oct 22 03:48:13 vmu kernel: Based upon Swansea University Computer Society NET3.039
Oct 22 03:48:13 vmu kernel: Starting kswapd v1.8
Oct 22 03:48:13 vmu kernel: CPM UART driver version 0.03
Oct 22 03:48:13 vmu kernel: ttyS0 on SMC1 at 0x0280, BRG1
Oct 22 03:48:13 vmu kernel: pty: 256 Unix98 ptys configured
Oct 22 03:48:13 vmu kernel: Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40000000
Oct 22 03:48:13 vmu kernel: Registered flash device /dev/flasha (minor 0, 4 partitions)
Oct 22 03:48:13 vmu kernel: Found 2x16bit 4MByte CFI flash device of type AMD/Fujitsu standard at 40400000
Oct 22 03:48:13 vmu kernel: Registered flash device /dev/flashb (minor 8, 2 partitions)
Oct 22 03:48:13 vmu kernel: block: queued sectors max/low 9586kB/3195kB, 64 slots per queueOct 22 03:48:13 vmu kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 22 03:48:13 vmu kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Oct 22 03:48:13 vmu kernel: ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Oct 22 03:48:13 vmu kernel: PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
Oct 22 03:48:13 vmu kernel: No card in slot B: PIPR=ff00ff00
Oct 22 03:48:13 vmu kernel: eth0: CPM ENET Version 0.2 on SCC2, 00:d0:93:00:c0:a4
Oct 22 03:48:13 vmu kernel: CPM load tracking driver $Revision: 1.0 $
Oct 22 03:48:13 vmu kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct 22 03:48:13 vmu kernel: IP Protocols: ICMP, UDP, TCP
Oct 22 03:48:13 vmu kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Oct 22 03:48:13 vmu kernel: TCP: Hash tables configured (established 1024 bind 1024)
Oct 22 03:48:13 vmu kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Oct 22 03:48:13 vmu kernel: Looking up port of RPC 100003/2 on 192.168.10.1
Oct 22 03:48:13 vmu kernel: Looking up port of RPC 100005/2 on 192.168.10.1
Oct 22 03:48:13 vmu kernel: VFS: Mounted root (nfs filesystem).
Oct 22 03:48:13 vmu kernel: Freeing unused kernel memory: 56k init

vmu login:


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

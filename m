Message-ID: <35C119252057D511BB9F0003476BF8A208E5CA@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ramdisk: kernel panic...
Date: Fri, 28 Sep 2001 15:46:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to bring up Linux_2_4_Devel on a 750 custom board. Using
powerboot as the bootloader.

I was able to get until mounting the ramdisk and freeing both 'initrd' and
'unused' memory. After that when it tries to execute the below statement, I
get kernel PANIC. I commented the other 'init' execve's, to at least bring
up the system first.

	execve("/bin/sh",argv_init,envp_init);

Also looks like do_execve() in fs/exec.c returns fine with value "0". But in
the end I get kernel panic.

Actually I am using simple ramdisk (simple-ramdisk.image.gz). I don't see
the 'echo's of linuxrc getting printed on the console either. But following
kernel printk's are printed fine on the console.

Does this has anything to do with interrupts what so ever?.

I am giving the boot trace below. It would be great if any one can help me
out with this problem.

Thanks in advance
-- Siva


PowerBoot> go 400000
loaded at:     00400000 004091C4
relocated to:  00800000 008091C4
zimage at:     00406067 00488D64
relocated to:  0080A000 0088CCFD
initrd at:     00488D64 00513818
relocated to:  0088D000 00917AB4
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/ram0 rw
Uncompressing Linux...done.
Now booting the kernel
wTotal memory = 256MB; using 1024kB for hash table (at c0200000)
Linux version 2.4.10 (prasad@siva) (gcc version 2.95.3 20010315 (release))
#1 Fr
i Sep 28 11:24:33 PDT 2001
Host bridge in Agent mode
Force PCore port (C) 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram0 rw
TODC real-time-clock was stopped. Now starting...
time_init: decrementer frequency = 945.000099 MHz
Warning: real time clock seems stuck!
Calibrating delay loop... 30198.98 BogoMIPS
Memory: 254780k available (860k kernel code, 372k data, 180k init, 0k
highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Memory resource not set for host bridge 0
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Cannot allocate resource region 0 of device 00:00.0
PCI: Cannot allocate resource region 1 of device 00:0b.0
PCI: Failed to allocate resource 0(10000000-1000ffff) for 00:00.0
PCI: Failed to allocate resource 1(10000000-10000fff) for 00:00.0
PCI: I/O Region 00:0b.0/-1 too large (2048 bytes)
PCI: I/O Region 00:0b.0/-1 too large (2048 bytes)
PCI: Failed to allocate resource 1(1000-17ff) for 00:0b.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 554k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 180k init
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <006701c3bebf$fe474360$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: RAMDISK: incomplete write (ramdisk too small?)
Date: Wed, 10 Dec 2003 09:50:30 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
    I made an initrd but failed to boot.The process about making the
initrd is as follows:
    dd if=/dev/zero of=/tmp/ramdisk.image bs=1k count=8192
    mke2fs -F -m 0 -b 1024 -N 1000 /tmp/ramdisk.image
    tune2fs -c 0 /tmp/ramdisk.image
    mount -o loop /tmp/ramdisk.image /mnt/initrd
    After these, I populated the root fs by installing the busybox.
[root tmp]# e2fsck ramdisk.image
e2fsck 1.27 (8-Mar-2002)
ramdisk.image: clean, 156/1000 files, 397/8192 blocks
    umount /mnt/initrd
    gzip -vf9 /tmp/ramdisk.image
    cp /tmp/ramdisk.image.gz arch/ppc/boot/images/

The console displays,
loaded at:     00400000 004E61E4
board data at: 004E313C 004E3154
relocated to:  00405600 00405618
zimage at:     00405BBB 004BE25C
initrd at:     004BF000 004E2CE8
avail ram:     004E7000 08000000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.18_mvl30-ml300 (user@hyding-pc-linux) (gcc version 3.3.1) #30
¶þ 12ÔÂ 9 16:50:08 CST 2003
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista.com)

On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Xilinx INTC #0 at 0xD0000FC0 mapped to 0xFDFFDFC0
rtsched version <20011203.1609.50>
Console: colour dummy device 80x25
Calibrating delay loop... 299.82 BogoMIPS
Memory: 127036k available (1372k kernel code, 392k data, 64k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.2.1 init complete
Starting kswapd
Disabling the Out Of Memory Killer
Journalled Block Device driver loaded
i2c-core.o: i2c core module version 2.6.2 (20011118)
i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
i2c-proc.o version 2.6.2 (20011118)
Xilinx PS/2 #1 at 0xA9001000 mapped to 0xC900D000
Xilinx PS/2 #0 at 0xA9000000 mapped to 0xC900F000
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq = 0) is a 16450
ttyS01 at 0xfdffe003 (irq = 1) is a 16550A
xgpio #0 at 0x90000000 mapped to 0xC9011000
xilinx_ts #0 at 0xAA000000 mapped to 0xC9013000, irq=6
block: 128 slots per queue, batch=32RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Partition check:
 xsysacea: xsysacea1 xsysacea2 xsysacea3
System ACE at 0xCF000000 mapped to 0xC9015000, irq=9, 1052352KB
PPP generic driver version 2.4.1
eth0: Xilinx EMAC #0 at 0x60000000 mapped to 0xC9017000, irq=3
Console: switching to colour frame buffer device 80x30
fb0: Xilinx LCD frame buffer at 0x07E00000 mapped to 0xC901C000
Xilinx IIC adapter #0 at 0xA8000000 mapped to 0xC91FF000, irq=2
NET4: Linux TCP/I
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (ramdisk too small?) (-28 != 32768)

Thanks!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

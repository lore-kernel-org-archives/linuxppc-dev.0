Message-ID: <B25E2E5A003CD311B61E00902778AF2A02BBDAA6@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Corrupted ramdisk image
Date: Thu, 3 Jan 2002 12:28:01 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm upgrading from 2.4.3 to 2.4.17 (rsync from mvista) on a Walnut-variant
board.  The initrd seems to be getting corrupted.  The kernel crashes during
the decompress or prints "crc error" or "invalid compressed format"
messages.  I have allocated enough space by using the 'ramdisk=32000'
command line option.  The same ramdisk works fine on a 2.4.3 kernel.

I've used my BDI to dump the initrd image back onto my workstation, and
gunzip also complains about the file format.  So it really is getting
corrupted.  The beginning of the file looks ok in a hex editor.  Also the
loader addresses look ok, no overlaps.  Any ideas?

Thanks,
Brian


loaded at:     00500000 00B72890
relocated to:  00400000 00A72890
board data at: 00A6F7C0 00A6F800
relocated to:  00A6F780 00A6F7C0
zimage at:     00405200 004B16F2
initrd at:     004B2000 00A6EF0C
avail ram:     00A73000 04000000

Linux/PPC load: console=ttyS0,9600 root=/dev/ram rw ramdisk=32000
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.17-rc2 (root@special-k) (gcc version 2.95.2 19991030
(2.95.3 prerelease/franzo)) #58 Thu Jan 3 11:43:31 PST 2002
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/ram rw ramdisk=32000
Console: colour dummy device 80x25
Calibrating delay loop... 199.88 BogoMIPS
Memory: 56700k available (1160k kernel code, 460k data, 220k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Memory resource not set for host bridge 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xef600300x (irq = 0) is a 16550A
ttyS01 at 0xef600400x (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
eth0: Phy @ 0x10, type DP83843 (0x20005c10)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
ramdisk start = 0xc04b2000, end = 0xc0a6ef0c, bytes = 6016780
Oops: kernel access of bad area, sig: 11
NIP: C0095AC8 XER: 20000000 LR: C0095998 SP: C04A51A0 REGS: c04a50e0 TRAP:
0800    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c04a4000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0xef6003ff acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x0ef60303 besr0= 0x00000000 besr1= 0x00000000

GPR00: C04A56C0 C04A51A0 C04A4000 C0AF7A28 00000001 00000319 C04A56C8
0000000B
GPR08: C04A56B0 40473098 00000003 00000101 C0AF7A24 30000000 0000000C
00000030
GPR16: 00000001 C01A0000 0000031A 00000001 0000000C 00000004 00000000
00000009
GPR24: 00000008 00000319 00000004 00000009 00000101 C013329A 00000673
00000400
Call backtrace:
C0095998 C0096A6C C0096C5C C0096CE8 C00971F4 C0170EAC C0170824
C0170C1C C00025A8 C00026E8 C0004F78
Kernel panic: Attempted to kill init!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

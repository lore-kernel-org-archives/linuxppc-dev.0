From: yama@isd.mci.mei.co.jp
Message-Id: <200006290359.MAA09991@ms.tokyo.jcom.ne.jp>
Date: Thu, 29 Jun 2000 12:54:24 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel stuck when decompress initrd
In-Reply-To: <NEBBLJBIIKANNNOGGKNDGEKJCAAA.jykim@raonet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

But,this is not the answer on this problem( kernel stuck when decompress
initrd)
I also worry about the same proglem.
I'm trying to run LINUX 2.2.13 image on our custom board.
I also found the kernel stopped in flush_window() in drivers/block/rd.c after
showing following messages on console.

Does anybody advise on this problem?

Regards,
Seiji Yamazaki
yama@isd.mci.mei.co.jp

--- message start --------------------------------------------------------
loaded at:     00800000 00816E18
board data at: 0081030C 00816D18
relocated to:  0081030C 00816D18
zimage at:     0081B000 008859FF
initrd at:     008859FF 00A5C83C
relocated to:  00886000 00A5CE3D
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
PReP architecture
Total memory = 32MB; using 0kB for hash table (at 00000000)
Linux version 2.2.13 (root@pc.tokyo.jcom.ne.jp) (gcc version egcs-2.91.66
199903
14 (egcs-1.1.2 release)) #36 Wed May 10 09:23:10 JST 2000
Boot arguments:
time_init: decrementer frequency = 1080001500/60 (17MHz)
Calibrating delay loop... 215.45 BogoMIPS
Memory: 29380k available (732k kernel code, 708k data, 64k init)
[c0000000,c2000
000]
000]
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Setting PCI interrupts for a "Blackhawk (Powerstack)"
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
IP-Config: No network devices available.
RAMDISK: Compressed image found at block 0
--- message end --------------------------------------------------------

At 22:15 00/06/21 +0900, you wrote:
>
> Hello,
>
> I'm trying to run LINUX 2.3.99 image on SBC8260 boards.
>
> The kernel stopped after showing following messages on console.
> I'm really novice to LINUX, so only debugging way is printk.
> I found the kernel stopped in flush_window() in drivers/block/rd.c.
> It is in the middle of gunzip() procedure.
> Any idea?  Something wrong in the sequence?
> I'm using vWARE boot rom from EST to boot LINUX.
> I tried to boot LINUX from FLASH SIMM on the board(it is 0xe0100000),
> but worse than from RAM. it only shows first boot loader messages.
>
> Regards,
> Jin
> jykim@raonet.com
>
> ========================
> loaded at:     00400000 0040C274
> board data at: 00100000 0010002C
> relocated to:  00200100 0020012C
> zimage at:     0040D000 0047A105
> initrd at:     0047B000 00653A15
> avail ram:     00654000 01000000
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> Total memory = 16MB; using 0kB for hash table (at 00000000)
> Linux version 2.4.0-test1-ac21 (jykim@raonet.com) (gcc version 2.95.2
19991024 (release)) #176 呪 6杉 21 21:57:00 KST 2000
> PowerPC Architecture (id:0x810101)
> Boot arguments: root=/dev/ram
> On node 0 totalpages: 4096
> zone(0): 4096 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram
> Calibrating delay loop... 166.30 BogoMIPS
> Memory: 12824k available (824k kernel code, 464k data, 40k init)
[c0000000,c1000000]
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> kmem_create: Poisoning requested, but con given - bdev_cache
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> kmem_create: Poisoning requested, but con given - inode_cache
> kmem_create: Poisoning requested, but con given - file lock cache
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.3
> Based upon Swansea University Computer Society NET3.039
> kmem_create: Poisoning requested, but con given - skbuff_head_cache
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 1024 bind 1024)
> Starting kswapd v1.6
> CPM UART driver version 0.01
> ttyS00 at 0x0000 is a SMC
> ttyS01 at 0x0040 is a SMC
> ttyS02 at 0x8100 is a SCC
> ttyS03 at 0x8200 is a SCC
> pty: 256 Unix98 ptys configured
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> eth0: SCC ENET Version 0.1, 08:00:3e:26:15:59
> RAMDISK: Compressed image found at block 0
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

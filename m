Message-ID: <38FC2742.B20C4C44@csem.ch>
Date: Tue, 18 Apr 2000 11:13:38 +0200
From: Amre El-Hoiydi <amre.el-hoiydi@csem.ch>
MIME-Version: 1.0
To: ku2911@363.net
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK uncompress problem.
References: <001e01beca40$ab7ac4e0$57c809c0@nt4srv87>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Your cmd_line is possibly using the memory zone where the compressed
ramdisk is stored.
In arch/ppc/mbxboot/misc.c, cmd_line = 0x200000 if CONFIG_MBX is not
defined.

Amre

ku2911@363.net wrote:
>
> hello:
>     i got a problem like this:
>
> loaded at:     00100000 002C5AD0
> board data at: 001001C4 001001E0
> relocated to:  00200100 0020011C
> zimage at:     0010B1F0 0013A3F3
> initrd at:     0013A400 003116E2
> avail ram:     00312000 01000000
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.2.13 (root@bigeyes) (gcc version 2.95.2 19991024 (release)) #110
>  Tue Apr 18 15:35:59 EDT 2000
> Boot arguments: root=/dev/ram
> time_init: decrementer frequency = 90000000/60
> Calibrating delay loop... 23.81 BogoMIPS
> Memory: 13768k available (356k kernel code, 352k data, 20k init) [c0000000,c1000
> 000]
> DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v 1.5
> CPM UART driver version 0.02
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0100 is a SCC
> ttyS02 at 0x0200 is a SCC
> RAM disk driver initialized:  16 RAM disks of 4096K size
> RAMDISK: Compressed image found at block 0
> crc error!orig_crc=0xe211d8c1,CRC_VALUE=0x40e28495
> length error! orig_len=0x400000,bytes_out=0x4000d5
>
> i added some prink() for debug ... ;)
> my ramdisk.image.gz is broken?
> but i can mount(-o loop) it in my host(i386-linux) after gunziped.
>
> and how to creat a correct ramdisk image?
>     using following step?
>         mkfs -t ext2 /dev/loop0
>         mount /dev/loop0 /mnt/rd
>                 mkdir /mnt/rd/bin  /dev ...
>                 cp bash etc. to /mnt/rd/bin ...
>                  mknod ....
>         dd if=/dev/loop0 of=./ramdisk.image
>         gzip -9 ramdisk.image
>
> what can i do?
>
> thanks for any help.
>
> b.r.
> john zhan.
> hacking time.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <010c01c285ab$5e51dbc0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: <Philip.Lougher@zarlink.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <OF88B9DD11.7EBA6D08-ON80256C68.004CF847@zarlink.com>
Subject: EXT2-f error Some more info
Date: Wed, 6 Nov 2002 21:14:18 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Philip

I  executed fsck on the ramdisk.image and it says clean. For second
possibility , I didn't get any error there [ I gv some printk and checked].
The third step I am trying to find out. Before that I thought I will tell
about the custom board memory map. There is no much difference between the
440GP evaluation kit except the boot rom setting.

Local memory/peripherals

DDR-SDRAM                       0x0 0000 0000        0x0 0BFF FFFF
64MB
SRAM                                    0x0 8000 0000        0x0 8000 1FFF
8KB

Internal peripherals

EBCO memory banks
BOOT ROM (CS0)                0x1 FFFE 0000        0x1 FFFF FFFF       128KB
FPGA (CS1)                           0x1 FFE0 0000        0x1 FFEF FFFF
1MB
FPGA (CS2)                           0x1 FFD0 0000       0x1 FFDF FFFF
1MB

UART0 Registers                     0x1 40000 0200       0x1 4000 0207    8B
IIC0 Registers                          0x1 40000 0400       0x1 4000 041F
32B

PCI registers                            0x2 0EC0 0000        0x2 0EC8 01F8
504B.

One question regarding the booting.

loaded at:     01000000 0134A1BC
zimage at:     01005970 010829D3
initrd at:     01083000 013465FE
avail ram:     00400000 00800000

Above console output says that avail ram is from 4MB to 8MB. What this means
whether only 4MB is available. I am asking this question since I have a
ramdisk about 8MB[Without compression]. Will this cause a problem?

Thanking you in advance
Regards
Aman




----- Original Message -----
From: <Philip.Lougher@Zarlink.Com>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>;
<owner-linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, November 05, 2002 9:02 PM
Subject: Re: EXT2-f error


>
> >Hi All
> >
> >I have built a zImage.initrd.ebony image [ Kernel + Ramdisk] for my
custom
> >board which has 440GP as its processor. This board doesn't have ethernet
> >support. However the kernel image contain network and ethernet support.
> >
> >
> >If I download this image to the custom board , I get the following
errors.
> >"EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
> >directory #20: unaligned directory entry - offset=0, inode=4294967295,
> >rec_len=65535, name_len=255".
> >
> >I tried the same image with my evaluation board , it works fine.  I have
> >taken the ramdisk image from HHL. Can you help me in solving this issue.
>
> Well you've obviously got a corrupted fs, what you have to do is find out
> where it is being corrupted.  There are 3 possibilities:
>
> 1.  The initrd file (initrd.gz?) is corrupt itself.  This is probably
> unlikely because you say your evaluation board works fine. However, the
> supplied kernel output suggests the initrd file is not clean. You should
do
> an
> fsck on the initrd file.  This can be done by ungzipping the initrd file
> and attaching to a loopback device, .i.e.
>
> losetup /dev/loop0 initrd
> fsck -t ext2 /dev/loop0
> losetup -d /dev/loop0
>
> 2. If that's okay, the initrd image may be being corrupted when loaded
into
> memory by the bootloader, and before it has been de-compressed by the
> ramdisk code (drivers/block/rd.c::crd_load).  Gunzip should return an
error
> if that's the case, as it will not be able to decompress the entire
> ramdisk.  Your error may be explained because you're ending up with a
> truncated decompressed filesystem in the ramdisk.
>
> 3. If that's okay, the only other possibility is something is overwriting
> your buffer cache (where your ramdisk is sitting).
>
> Both 2 & 3 could be quite tricky to track down.  What is the differences
> between the custom and evaluation board, that may give some pointers.
>
> Phillip
>
>
>
>
>
>                       "Aman"
>                       <aman@mistralsoftware.com>             To:
"linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
>                       Sent by:                               cc:
>                       owner-linuxppc-embedded@lists.l        Subject:
EXT2-f error
>                       inuxppc.org
>
>
>                       05-Nov-2002 01:41 PM
>
>
>
>
>
>
>
> Hi All
>
> I have built a zImage.initrd.ebony image [ Kernel + Ramdisk] for my custom
> board which has 440GP as its processor. This board doesn't have ethernet
> support. However the kernel image contain network and ethernet support.
>
> If I download this image to the custom board , I get the following errors.
> "EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
> directory #20: unaligned directory entry - offset=0, inode=4294967295,
> rec_len=65535, name_len=255".
>
> I tried the same image with my evaluation board , it works fine.  I have
> taken the ramdisk image from HHL. Can you help me in solving this issue.
>
> Thanking you in advance
> Regards
> Aman
>
>
>
> Below is the console output of my custom board
>
> loaded at: 01000000 0134A1BC
> zimage at: 01005970 010829D3
> initrd at: 01083000 013465FE
> avail ram: 00400000 00800000
>
> Linux/PPC load: root=/dev/ram0 ramdisk_size=8192
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.4.17_mvl21-ebony (root@hardhat) (gcc version 2.95.3
> 20010315
> (release/MontaVista)) #146 Sun Nov 3 22:05:41 IST 2002
> IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 32768
> zone(0): 4096 pages.
> zone(1): 28672 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram0 ramdisk_size=8192
> Warning: real time clock seems stuck!
> Calibrating delay loop... 599.65 BogoMIPS
> Memory: 124584k available (908k kernel code, 352k data, 68k init, 0k
> highmem)
> Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Disabling the Out Of Memory Killer
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled
> ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
> ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
> block: 128 slots per queue, batch=32
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> eth0: Got bad Phy Read, missing MDIO pullup?
> eth0: No PHY device found.
> removing net dev
> eth0: Got bad Phy Read, missing MDIO pullup?
> eth0: No PHY device found.
> removing net dev
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 1024 buckets, 8Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> IP-Config: No network devices available.
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 2829k freed
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 68k init
> EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
> directory
> #20: unaligned directory entry - offset=0, inode=4294967295,
rec_len=65535,
> name_len=255
> Warning: unable to open an initial console.
> EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
> directory
> #104: unaligned directory entry - offset=0, inode=4294967295,
> rec_len=65535,
> name_len=255
> EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in
> directory
> #59: unaligned directory entry - offset=0, inode=620723148, rec_len=25099,
> name_len=46
> Kernel panic: No init found. Try passing init= option to kernel.
> <0>Rebooting in 180 seconds..
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

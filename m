From: Ruedi.Hofer@ascom.ch
Date: Thu, 03 Feb 2000 16:18:33 +0100 (CET)
Subject: initrd
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FPD00L6T17ENM@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_S8hVGzsuHrhe283dHtUmcg)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_S8hVGzsuHrhe283dHtUmcg)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi


I now try to add an initrd in order to generate a standalone system.

I encounter the following problem:

--------

If I generate a ramdisk.image.gz myself according to the initrd.txt kernel documentation

<
We'll describe the RAM disk method:

 1) make sure you have a RAM disk device /dev/ram (block, major 1, minor
0)
 2) create an empty file system of the appropriate size, e.g.
    # mke2fs -m0 /dev/ram 300
    (if space is critical, you may want to use the Minix FS instead of
Ext2)
 3) mount the file system on an appropriate directory, e.g.
    # mount -t ext2 /dev/ram /mnt
 5) copy all the files that are needed to properly use the initrd
    environment. Don't forget the most important file, /linuxrc
    Note that /linuxrc's permissions must include "x" (execute).
 6) unmount the RAM disk
    # umount /dev/ram
 7) copy the image to a file
    # dd if=/dev/ram bs=1k count=300 of=/boot/initrd
 8) deallocate the RAM disk
    # freeramdisk /dev/ram
<

.. then the kernel doesn't start.

entry 0x100000, phoff 0x34, shoff 0xf2864
phnum 0x1, shnum 0xa
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x532c, p_memsz 0xb1bc
Loading at 0x10c000
Starting 0x11c000
loaded at:     0011C000 001271BC
relocated to:  00100000 0010B1BC
board data at: 00FF0000 00FF001C
relocated to:  00200100 0020011C
zimage at:     00122000 00182FEC
initrd at:     00182FEC 001FE822
avail ram:     001FF000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
<hang hang hang..... forever>

--------

If I take a prebuilt ramdisk.image.gz then the kernel
starts up and crashes with the following output:

.....
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
Sending BOOTP and RARP requests.... OK
IP-Config: Got BOOTP answer from 10.1.20.2, my address is 10.1.20.1
RAMDISK: Compressed image found at block 0
crc errorEXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
attempt to access beyond end of device
01:00: rw=0, want=127205377, limit=4096
dev 01:00 blksize=1024 blocknr=127205376 sector=254410752 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127270913, limit=4096
dev 01:00 blksize=1024 blocknr=127270912 sector=254541824 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127336449, limit=4096
dev 01:00 blksize=1024 blocknr=127336448 sector=254672896 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127401985, limit=4096
dev 01:00 blksize=1024 blocknr=127401984 sector=254803968 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127467521, limit=4096
dev 01:00 blksize=1024 blocknr=127467520 sector=254935040 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127533057, limit=4096
dev 01:00 blksize=1024 blocknr=127533056 sector=255066112 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127598593, limit=4096
dev 01:00 blksize=1024 blocknr=127598592 sector=255197184 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127664129, limit=4096
dev 01:00 blksize=1024 blocknr=127664128 sector=255328256 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127729665, limit=4096
dev 01:00 blksize=1024 blocknr=127729664 sector=255459328 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127795201, limit=4096
dev 01:00 blksize=1024 blocknr=127795200 sector=255590400 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127860737, limit=4096
dev 01:00 blksize=1024 blocknr=127860736 sector=255721472 size=1024 count=1
attempt to access beyond end of device
01:00: rw=0, want=127926273, limit=4096
dev 01:00 blksize=1024 blocknr=127926272 sector=255852544 size=1024 count=1
init: error in loading shared libraries
libtermcap.so.2: invalid ELF header



Any ideas?

TIA
\Ruedi








--Boundary_(ID_S8hVGzsuHrhe283dHtUmcg)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

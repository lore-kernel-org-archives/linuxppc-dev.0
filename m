Message-ID: <3A5B06B6.536B2B02@centurysys.co.jp>
Date: Tue, 09 Jan 2001 21:40:22 +0900
From: Tania Oka <tania@centurysys.co.jp>
MIME-Version: 1.0
To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem mounting ramdisk
References: <3A54C5E5.23A76888@dspace.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had a similar problem (with the "attempt to access beyond end of device" symptom) when the size of my initrd exceeded the
kernel ramdisk_size.  I don't see the problem with your script but I used a slightly different method so I am including the
script which eventually worked for me (on an x86 host, by the way).  Might be worth a try.  You also might try increasing the
kernel's idea of the ramdisk size to see if it helps (one way is to edit ramroot_string in arch/ppc/boot/misc.c, I use
"root=/dev/ram ramdisk_size=6144").

Here's my script:

# NOTE: (bs * count) <= ramdisk_size
# the ramdisk uncompress/init code will NOT complain if you exceed ramdisk_size,
# but you may see "attempt to access beyond end of device" messages
dd if=/dev/zero of=/tmp/ramimage.tmp bs=1k count=4096
/sbin/mke2fs -m 0 -i 2000 /tmp/ramimage.tmp
mount -o loop -t ext2 /tmp/ramimage.tmp /mnt
cd file_system; tar cf - * | (cd /mnt; tar xf -)
umount /mnt
dd if=/tmp/ramimage.tmp bs=1k | gzip -v9 > ramdisk.gz
du -ch file_system > file_system.txt

The last line is just for informational purposes.

Good luck.
Tania


Andreas Schreckenberg wrote:

> hello,
>
> My linux (modified kernel 2.2.14) starts
> on my custom PPC board (PPC750/128MB)
> but when I mount the ramdisk, the kernel issues:
>
> ...
> Serial driver version 4.27 with no serial options enabled
> ttyS00 at 0x12000000 (irq = 16) is a 16550A
> RAM disk driver initialized:  16 RAM disks of 4096K size
> RAMDISK: Compressed image found at block 0
> attempt to access beyond end of device
> 01:00: rw=0, want=8196, limit=4096
> dev 01:00 blksize=1024 blocknr=8195 sector=16390 size=1024 count=1
> EXT2-fs error (device ramdisk(1,0)): read_block_bitmap: Cannot read block bitmap - block_group = 1, block_bitmap = 52428800
> attempt to access beyond end of device
> 01:00: rw=0, want=16386, limit=4096
> dev 01:00 blksize=1024 blocknr=16385 sector=32770 size=1024 count=1
> EXT2-fs error (device ramdisk(1,0)): read_block_bitmap: Cannot read block bitmap - block_group = 2, block_bitmap = 20971520
> attempt to access beyond end of device
> 01:00: rw=0, want=24580, limit=4096
> ... (and so on)
>
> ... (later)
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 40k init 28k prep 4k pmac 12k open firmware
> ...
>
> ... (last)
> EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to read inode block - inode=4001, block=16389
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 5 seconds..
> ...
>
> The fs image contains no shell at the moment, so the last kernel panic is okay.
>
> What is the Problem with EXT2-fs error ?
> I used the following script on my x86 host (<- the problem ?)
> to build the compressed image:
>
> #!/bin/sh
> dd if=/dev/zero of=/dev/ram bs=1k count=4096
> mke2fs -m0 /dev/ram
> mkdir -p /mnt/ram
> mount /dev/ram /mnt/ram
> (cd file_system; cp -a * /mnt/ram)
> umount /mnt/ram
> rmdir /mnt/ram
> dd if=/dev/ram of=fs_images/ramdisk.image bs=1k count=4096
> (cd fs_images;gzip -v9f ramdisk.image)
>
> every help would be appreciated...
>
> bye
> Andreas
> --
>           Life's not fair. But the root password helps ! :-)
>                    http://schrecky.home.pages.de
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

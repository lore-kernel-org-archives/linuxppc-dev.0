From: "Jim Lewis" <jlewis@mvista.com>
To: "Andreas Schreckenberg" <ASchreckenberg@dspace.de>,
        <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: problem mounting ramdisk
Date: Thu, 4 Jan 2001 12:16:02 -0600
Message-ID: <NDBBLNMCOLBBHLKBOLFEAEDKCJAA.jlewis@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A54C5E5.23A76888@dspace.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
It looks to me like you made your ramdisk bigger than 4MB, which is
the default ramdisk size. You can either modify drivers/block/rd.c and
change the value of rd_size, add the "ramdisk_size=" parm to the boot
command line, or create a smaller ramdisk image.
-Jim Lewis

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Andreas
> Schreckenberg
> Sent: Thursday, January 04, 2001 12:50 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: problem mounting ramdisk
>
>
>
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
> EXT2-fs error (device ramdisk(1,0)): read_block_bitmap:
> Cannot read block bitmap - block_group = 1, block_bitmap = 52428800
> attempt to access beyond end of device
> 01:00: rw=0, want=16386, limit=4096
> dev 01:00 blksize=1024 blocknr=16385 sector=32770 size=1024 count=1
> EXT2-fs error (device ramdisk(1,0)): read_block_bitmap:
> Cannot read block bitmap - block_group = 2, block_bitmap = 20971520
> attempt to access beyond end of device
> 01:00: rw=0, want=24580, limit=4096
> ... (and so on)
>
> ... (later)
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 40k init 28k prep 4k pmac 12k
> open firmware
> ...
>
> ... (last)
> EXT2-fs error (device ramdisk(1,0)): ext2_read_inode:
> unable to read inode block - inode=4001, block=16389
> Kernel panic: No init found.  Try passing init= option to kernel.
> Rebooting in 5 seconds..
> ...
>
> The fs image contains no shell at the moment, so the last
> kernel panic is okay.
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

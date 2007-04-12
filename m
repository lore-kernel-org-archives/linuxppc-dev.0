Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 762EFDDD02
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 22:55:29 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <E1AF14BEE9B355499E146B179F69E9AF152EB9@exchangesrv.cristie.co.uk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0145911017a20ddbedd13eebfb7b6bc7@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Cannot open ramdisk
Date: Thu, 12 Apr 2007 07:55:17 -0500
To: Chris West <chrisw@cristie.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sometime near Thu Apr 12 20:37:08 EST 2007 Chris West wrote:

>>> My ramdisk is a compressed 64MB ext3 filesystem in /ppc/chrp/system
>>>
>>> After the kernel has booted I get the following message:
>>>
>>> VFS: Cannot open root device "ram0" or unknown-block(1,0)
>>> Please append a correct "root=" boot option
>>>
>>> I've read that only uncompressed kernels can load a ramdisk, is
>>> this still the case?  I have tried using an uncompressed kernel
>>> with the same results.

Your boot log shows the ramdisk is being loaded.

>>>
>>> Can anyone tell me why my ramdisk isn't being loaded?
>>
>> Not sure... what is the full kernel log and the messages from
>> yaboot ?  It's possible that your ramdisk is just too big for
>> either yaboot or the kernel to cope...
>>
>> Also, the ramdisk should be compressed, is it ?

Actually, when its compressed, there kernel has to trust the parameters.
If you don't compress the ramdisk, it takes longer for the bootloader
to copy the image but it knows about ext3 and about half a dozen other
file systems, and will adjust the ramdisk blocksize and block length
to match the image.   For compressed images, it doesn't try.

>
> Thanks for your reply.
>
> Is there a yaboot limit on the size of initrd?
> Mine is about 15MB.
>
> The ramdisk is 64MB uncompressed, compressed using gzip -9.
>
> Here is the latest yaboot.conf:
>
> init-message=linux
> timeout=300
> default=linux
> image=ppc/chrp/kernel
>         label=linux
>         initrd=ppc/chrp/ramdisk.image.gz
>         append="root=/dev/ram0 console=ttyS0"
>         read-only
>
> Here are the full logs:
>
> Elapsed time since release of system processors: 2 mins 47 secs
>
> Config file read, 164 bytes
>
> linux
> Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-2.fc6)
> Enter "help" to get some basic usage information
> boot: linux
> Please wait, loading kernel...
>    Elf64 kernel loaded...
> Loading ramdisk...
> ramdisk loaded at 04300000, size: 14805 Kbytes

This shows that yaboot located the ramdisk at 04300000.
Your version of yaboot is smart enough to load in
pieces and copy them from its read buffer to
a contiguous region
above the firmware area.

> OF stdout device is: /pci at 400000000110/isa at 3/serial at i3f8
> command line: ro root=/dev/ram0 console=ttyS0
> memory layout at init:
>   alloc_bottom : 0000000005176000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000000080000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000000080000000

This shows what memory prom_init may use.

> Looking for displays
> opening PHB /pci at 400000000110... done
> opening PHB /pci at 400000000112... done
> instantiating rtas at 0x000000002fd0d000 ... done
> 0000000000000001 : starting cpu hw idx 0000000000000001... done
> WARNING: maximum CPUs (1) exceeded: ignoring extras
> copying OF device tree ...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000005377000 -> 0x00000000053782d2
> Device tree struct  0x0000000005379000 -> 0x0000000005380000

And everything from alloc_bottom through here was used.

> Calling quiesce ...
> returning from prom_init
> Using pSeries machine description
> Found initrd at 0xc000000004300000:0xc000000005175774

This shows the kernel realized that there was a ramdisk
and the addresses appear to mach yaboot.   Also, the
alloc_bottom was after the initrd, so that means we
should not have overwritten anything.

> Starting Linux PPC64 #5 Tue Apr 10 15:19:56 BST 2007
> -----------------------------------------------------
> ppc64_pft_size                = 0x0
> physicalMemorySize            = 0x80000000
> ppc64_caches.dcache_line_size = 0x80
> ppc64_caches.icache_line_size = 0x80
> htab_address                  = 0xc00000007c000000
> htab_hash_mask                = 0x3ffff
> -----------------------------------------------------
> Linux version 2.6.18-1.2798.fc6 (root at fedora6ppc64) (gcc version
> 4.1.1 20061011
> (Red Hat 4.1.1-30)) #5 Tue Apr 10 15:19:56 BST 2007
> [boot]0012 Setup Arch

Looks good so far, skipping the other drivers.

> Found initrd at 0xc000000004300000:0xc000000005175774
> Starting Linux PPC64 #5 Tue Apr 10 15:19:56 BST 2007

This is the transition from the early debug console
to the real console.

> checking if image is initramfs...it isn't (no cpio magic); looks like
> an initrd
> Freeing initrd memory: 14805k freed

This is unpack_to_rootfs saying your initrd area is not
a new cpio buffer because it doesn't find any cpio header.
It then copies it to a file in rootfs and frees the original
memory.

> RAMDISK driver initialized: 16 RAM disks of 65536K size 512 blocksize

Ok your ramdisk can hold 64MB, and the block size is 512.

> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> RAMDISK: Compressed image found at block 0

Here the prepare_namespace code split in the various
do_mounts files in init/ is being run.  rd_load_image
in init/do_mounts_rd.c found a compressed image, and
called do_crd_load to gunzip it from the file in rootfs.
Since there were no error messages, it appears it was
successful.

> VFS: Cannot open root device "ram0" or unknown-block(1,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(1,0)
>  <0>Rebooting in 180 seconds..

But the kernel did not recognize a file system

I'm guessing your problem is that your file system block
size does not match your ramdisk block size.  When the
file system tries to change the block size of the ramdisk,
the page cache is flushed.   But since /dev/ram0 lives in
the page cache, that results in all data being lost.

By default, ext2 and ext3 use a 1024 byte block, although
some tools may go to 4096 (4k) byte block to match the page
size and avoid allocating buffer heads.

Its also possible that you did not configure your file system
into the kernel, not as a module.


Try either (1) specifying the ramdisk block size to
match that of your file system using the ramdisk_blocksize=
parameter on your kernel command line  (2) set
CONFIG_BLK_DEV_RAM_BLOCKSIZE when prompted by "Default RAM
disk block size (bytes)", or (3) uncompress the ramdisk, spend
the additional time in yaboot (it looks like there is still
memory available during early boot) and see if the kernel detects
and sizes the ramdisk before copying.

milton

Message-ID: <389A7487.738ACDAA@netx4.com>
Date: Fri, 04 Feb 2000 01:41:11 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd
References: <0FPD00L6T17ENM@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:


>  2) create an empty file system of the appropriate size, e.g.
>     # mke2fs -m0 /dev/ram 300


>From experience, I know a 300 block size ramdisk can't possibly
hold enough files to get a system started.  You need at least
2 Meg (2048), and I build at least 4000 block ramdisks.  Make
sure you get all of the minimal shared libraries in there.....


>  7) copy the image to a file
>     # dd if=/dev/ram bs=1k count=300 of=/boot/initrd
>  8) deallocate the RAM disk
>     # freeramdisk /dev/ram


....I am assuming you gzip'ped the ramdisk......


> entry 0x100000, phoff 0x34, shoff 0xf2864
> phnum 0x1, shnum 0xa
> p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
> p_filesz 0x532c, p_memsz 0xb1bc


Oh oh....you are using a FADS board or something custom......


> If I take a prebuilt ramdisk.image.gz then the kernel
> starts up and crashes with the following output:

> RAMDISK: Compressed image found at block 0
> crc error

Ummm....doesn't this mean something to you?  When something is
uncompressed and you get a CRC error, the file is usually
truncated or corrputed.....

Since it appears this is a board that isn't known to be able
to download something properly that is this large, you should
probably verify the download with some kind of standard test
pattern and test software.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

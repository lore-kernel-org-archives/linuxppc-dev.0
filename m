Message-ID: <408E000A.6040303@fh-landshut.de>
Date: Tue, 27 Apr 2004 08:39:06 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1> <20040426220944.GI19246@smtp.west.cox.net>
In-Reply-To: <20040426220944.GI19246@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

>>Is this even possible with the PPCbug, or do I need a Linux-friendly
>>bootloader? I initially guessed, that if at bootup everything is
>>relocated, that would actually suffice, and no additional information from
>>the bootloader is required??
>>
>>
>
>It works from PPCBug.  At least with cramfs, I _believe_ there is, or
>has been a problem with creating an image on an LE machine for a BE
>machine, and vice versa.  What happens when you try and use an ext2
>ramdisk?
>
>
>
Tried this initially, and it didn't work - will try again, to supply you
with the exact messages later today (I'm not in work yet - lazy, lazy! :) )

The steps for my initrd image - AFAI can remember:

I made a file with

dd if=/dev/zero of=initrd.img bs=1k count=8192

(Made an ext2 on it, don't quite remember the command, but mounted ok!)

(as root)

mount --t ext2 -o loop initrd.img tmp/
cp -ar rootfs/ tmp
umount tmp/

(as me)
gzip -9 -c initrd.img > initrd.bin

(and copied it into the kernel dir)
cp initrd.bin <kernel_dir>/arch/ppc/boot/simple/images/ramdisk.image.gz
cd <kernel_dir>

make zImage.initrd


Is this correct, or is there anywhere a wrong assumption in between?

(Actually getting this ramdisk to boot seems to be getting more
important all the time, because the flash chip support in Memory
Technology Devices seems to be broken for good and so I cannot make a
flash fs like jffs2 over it, or a FTL-ext2... looks more and more I'm
running out of options :) )

Thanks and with kind regards,
Oliver Korpilla


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <jacmet@gmail.com>
Received: from mail-fx0-f161.google.com (mail-fx0-f161.google.com
	[209.85.220.161]) by ozlabs.org (Postfix) with ESMTP id B1F5DDE0B4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 04:16:39 +1100 (EST)
Received: by fxm5 with SMTP id 5so2893192fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Mar 2009 09:16:36 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: =?utf-8?Q?G=C3=BCnter?= Leonhardt <Guenter.Leonhardt@men.de>
Subject: Re: U-Boot image
References: <D0B748CCD5DF144CA5C56A9D860A31341DE5C9@men-exch1.intra.men.de>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 04 Mar 2009 17:52:15 +0100
In-Reply-To: <D0B748CCD5DF144CA5C56A9D860A31341DE5C9@men-exch1.intra.men.de>
	(=?utf-8?Q?=22G=C3=BCnter?= Leonhardt"'s message of "Tue\, 3 Mar 2009
	14\:11\:36 +0100")
Message-ID: <87fxhtgri8.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "G=C3=BCnter" =3D=3D G=C3=BCnter Leonhardt <Guenter.Leonhardt@men.de>=
 writes:

 G=C3=BCnter> Hello,

 G=C3=BCnter> I'am looking for an image to boot a embedded device with a
 G=C3=BCnter> single image.

 G=C3=BCnter> I though the generated uImage in arch/powerpc/boot should
 G=C3=BCnter> work, but u-boot cannot but this, because the addresses of
 G=C3=BCnter> initrd and dtb not found.

 G=C3=BCnter> Now I'am creating the image by hand with mkimage:
 G=C3=BCnter> mkimage -A ppc -n F302 -O linux \
 G=C3=BCnter> 		-T multi -C gzip -a 0x0 -e 0x0 \
 G=C3=BCnter>             -d vmlinux.bin.gz:initramfs_data.cpio.gz:f302.dtb=
 \
 G=C3=BCnter>             uImage

I posted a patch to add support for multi image uImages to the kernel
makefiles, E.G. uImage.<platform> some time ago. It got nack'ed by
wdenx though as he wants people to use the new fitimage stuff in
u-boot instead. Anyway, it might be useful to you:

http://peter.korsgaard.com/patches/linux/bootwrapper-uboot-multi-2.patch

To use it, add:

image-$(CONFIG_<your-platform>) + uImage.<your-platform>

to arch/powerpc/boot/Makefile.

 G=C3=BCnter> This file is bootable, but I don't understand how a standard
 G=C3=BCnter> file has to be booted.

With an external dtb / initrd.

 G=C3=BCnter> Can someone explain me the different fileforamts for booting
 G=C3=BCnter> a powerpc with u-boot?  Which is the simplest to use?

Have a look at Documentation/powerpc/bootwrapper.txt

--=20
Bye, Peter Korsgaard

Return-Path: <linnj@xilinx.com>
Received: from mail5-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4BB2DDFB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jun 2008 00:05:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Linux on Virtex board with ARCH=powerpc
Date: Tue, 24 Jun 2008 08:03:00 -0600
In-Reply-To: <4860B81F.6070205@computing.dundee.ac.uk>
References: <4860B81F.6070205@computing.dundee.ac.uk>
From: "John Linn" <linnj@xilinx.com>
To: "Peter Mendham" <petermendham@computing.dundee.ac.uk>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080624140532.E77E333006C@mail5-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

I'm not up on what can be done with the simple image you refer to in 1.
I'm sure I should be, but there's a lot to learn.

With regards to 2, the elf image, zImage (without the elf extension), is
located in arch/powerpc/boot.

You can make a SystemACE file from that elf image just as you did in
arch/ppc.  We have a default device tree file, ml405.dts, in the
arch/powerpc/boot/dts directory for our ml405 board. The kernel
configuration has a config, DEVICE_TREE, that specifies the name of the
device tree file. I normally compile the device tree into the kernel
which is the default build, make ARCH=3Dpowerpc zImage. That image does
not require a boot loader.

I inserted the text below from a document that I have about building the
arch/ppc and arch/powerpc kernels.

Hope that helps,
John


Notation

The phrase "<ppc or powerpc>" is used throughput the text and means that
one or the other, "ppc" or "powerpc" is to be typed depending on the
architecture you are building.

Commands that are used in a bash shell are preceded by ">".

Getting Ready To Build the Kernel

This assumes you installed the ELDK tools and assumes you'll be using a
bash shell.

>bash
>export CROSS_COMPILE=3Dppc_4xx-

Setting Up the Kernel Tree

If you have previously built this kernel for another architecture, ppc
or powerpc, then the tree needs to be setup correctly for the new
architecture.  Assuming you have not previously built it, this does not
need to be done.

>make ARCH=3D<ppc or powerpc> mrproper

Configuring the Kernel

The kernel should be configured to run on the ML405 or ML507 board from
Xilinx. =

	=

>make ARCH=3D<ppc or powerpc>  ml405_defconfig

or =


>make ARCH=3D<ppc or powerpc> ml507_defconfig

Building the Kernel

The following command will build the Linux kernel assuming you are in
the root directory of the kernel.  The root directory of the kernel from
the Xilinx Git tree is linux-2.6-xlnx. An elf file, zImage.elf, is
created in the arch/ppc/boot/images directory for ppc architecture. An
elf file, zImage, is created in the the arch/powerpc/boot directory for
the powerpc architecture.

>make ARCH=3D<ppc or powerpc> zImage
	=

Building the Kernel With Ramdisk

A ram disk image, a file named *.gz, must be placed into the
arch/ppc/boot/images or arch/powerpc/boot directory, depending on the
architecture, prior to building the kernel.

>make ARCH=3D<ppc or powerpc> zImage.initrd

An elf file, zImage.initrd.elf, is created in arch/ppc/boot/images
directory for the ppc architecture. An elf file file, zImage.initrd, is
created in arch/powerpc/boot directory for the powerpc architecture.

Generating An Ace File

The elf file generated for the kernel and the bit stream can be combined
to create an ACE file for compact flash.  The following assumes a bash
shell where XMD is accessible and a xilinx probe attached to the board
for which you are generating an ace file.

>xmd -tcl genace.tcl -jprog -target ppc_hw -hw <bit file name> -elf <elf
file name> -board <ml405 or ml507> -ace <desired ace file name>

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Peter Mendham
Sent: Tuesday, June 24, 2008 3:02 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linux on Virtex board with ARCH=3Dpowerpc

Dear all,

I'm trying to boot a 2.6.26-rc6 kernel on a custom Virtex 4 board.  I =

have used the Xilinx utility to generate a device tree and now want to =

generate an image for throwing onto CF for use with a SystemACE (just =

like on the the ML3/4xx boards).  I don't want to use a bootloader (I =

don't really need one).  I saw something on this list about simpleImage,

"simple" sounded good to me so I thought I'd try that (or did I =

misinterpret what this is for?).  I also don't want the image to be too =

big, I always used to use a zImage under ARCH=3Dppc. So, two questions, =

which hopefully are easy ones:
1. I did what Grant said in a post to this list about simpleImage, and =

dumped my dts into arch/powerpc/boot/dts and I called it system.dts (for

now).  I then tried to do make simpleImage.system which ran right =

through to final link then moaned about a missing simpleboot-system.  =

Where is this supposed to come from?  What am I doing wrong?  I naively =

tried copying simpleboot.o to simpleboot-system.o and the error went =

away.  Hmm.
2. I need an ELF to give to my SystemACE file generator.  This used to =

pop up in arch/ppc/boot/images and be called zImage.elf, which made =

sense to me.  What's the deal now with powerpc?  What should I be using?
Finally, can anyone give me a heads-up on any gotchas with what I'm =

trying to do.  As you can tell, I don't entirely know what I'm doing, so

any pointers would be gratefully received.

Thanks,
-- Peter


The University of Dundee is a Scottish Registered Charity, No. SC015096.


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

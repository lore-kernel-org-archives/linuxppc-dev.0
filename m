Return-Path: <jwboyer@gmail.com>
Subject: Re: Creating a wrapped zImage.initrd -- can't start the trampoline?
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paul@mad-scientist.us
In-Reply-To: <1217644827.6390.12.camel@homebase.localnet>
References: <1217644827.6390.12.camel@homebase.localnet>
Content-Type: text/plain
Date: Sat, 02 Aug 2008 08:35:50 -0400
Message-Id: <1217680550.2328.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-01 at 22:40 -0400, Paul Smith wrote:
> Hi all;
>         
> I'm working with a PPC 460EX-based board.  I have a 2.6.25.10-based
> kernel I obtained from the DENX git tree which contains a port to this
> board, under arch/powerpc.
> 
> I can build a kernel and have it downloaded and booting using u-boot,
> providing the blob and appropriate kernel parameters, after having done
> a standard "make zImage" with the appropriate configs etc.  All good so
> far.
> 
> However, my ultimate target board uses a custom bootloader, not uboot,
> which is very, very simple (please don't suggest we just switch to
> uboot--that argument has been already had, and lost :-/)  I had a
> previous version of Linux, 2.6.14, booting on a predecessor of this
> board based on the 440GX with the same bootloader, but the creation of
> that image was done under arch/ppc and it was pretty different (I'm
> discovering).  And, I didn't do that port anyway.
> 
> Anyway, I need to generate an all-in-one image containing the kernel and
> the initrd, and the trampoline code tacked onto it to turn it into an
> ELF image.  I'm worried I'll need to write a custom platform_init() but
> for now I'm just using of.c.

It needs the vmlinux, dtb, and initrd in a single image.  The dtb is
required for arch/powerpc ports.

> >From what I can tell, the wrapper script seems to be intended to have
> the ability to generate an image like this.  I've tried just running
> "make zImage.initrd" after putting the ramdisk.initrd.gz in the right
> place, and it seems to create an image OK: using file shows it to be
> "ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV),
> statically linked, not stripped", which seems correct.
> 
> But we can't get it to boot.
> 
> The bootloader downloads the image (tftp) and jumps to the start address
> in the ELF image, and immediately takes an illegal instruction.  We have
> set the bootloader to load the image at 0x00000000 and then we look
> through the ELF image for the start address, which (using objdump) I can
> see is the correct address for the _zimage_start symbol from crt0.S; in
> our case it's 0x00400204.
> 
> When we use a debugger to look at what's loaded at that location, it's
> just a whole slew of 0xa bytes... obviously not right.  Is the start
> address not the offset from the start of the ELF image?  Should we be
> loading the image somewhere else (the previous incarnation loaded it at
> 0x0, so we just did that too)?

Load it at the link address.  Which is 4MiB.  A normal bootloader would
have done that.  Then the wrapper code will uncompress your kernel to
0x0 for you.

josh

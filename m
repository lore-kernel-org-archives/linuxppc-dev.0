Return-Path: <paul@mad-scientist.us>
Subject: Re: Creating a wrapped zImage.initrd -- can't start the trampoline?
From: Paul Smith <paul@mad-scientist.us>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1217680550.2328.15.camel@localhost.localdomain>
References: <1217644827.6390.12.camel@homebase.localnet>
	<1217680550.2328.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Aug 2008 08:55:12 -0400
Message-Id: <1217681712.6390.35.camel@homebase.localnet>
Mime-Version: 1.0
Cc: Linuxppc-embedded@ozlabs.org
Reply-To: paul@mad-scientist.us
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2008-08-02 at 08:35 -0400, Josh Boyer wrote:

> It needs the vmlinux, dtb, and initrd in a single image.  The dtb is
> required for arch/powerpc ports.

We have a dtb that we were using with uboot.  We were hoping we could
continue to do that even with the trampoline: that is, get the dtb from
the bootloader, while leaving the kernel and initrd in the downloaded
image.  We have coded up the bootloader to provide this information on
the command line and I was kind of hoping the trampoline would just pass
it through when it booted the uncompressed kernel.

It just seems to make more sense to have the dtb tied to the
hardware/firmware.

Is this possible?  If not we can do it the other way around (I found the
right targets in the Linux build system for this, I think).

> > The bootloader downloads the image (tftp) and jumps to the start address
> > in the ELF image, and immediately takes an illegal instruction.  We have
> > set the bootloader to load the image at 0x00000000 and then we look
> > through the ELF image for the start address, which (using objdump) I can
> > see is the correct address for the _zimage_start symbol from crt0.S; in
> > our case it's 0x00400204.
> > 
> > When we use a debugger to look at what's loaded at that location, it's
> > just a whole slew of 0xa bytes... obviously not right.  Is the start
> > address not the offset from the start of the ELF image?  Should we be
> > loading the image somewhere else (the previous incarnation loaded it at
> > 0x0, so we just did that too)?
> 
> Load it at the link address.  Which is 4MiB.  A normal bootloader would
> have done that.  Then the wrapper code will uncompress your kernel to
> 0x0 for you.

Ah.  OK, that's good info.  We'll give that a go.

Thanks!

Message-ID: <BE1C564723B3D21191FD0000F840E39801D8154E@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Questions about 8xxrom
Date: Tue, 30 May 2000 09:35:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This thread has become interesting, but I think that my original message was
maybe not understood.  Here are the highlights:

a) I originally got 8xxrom-0.3.0 working by adding a GO command:  GO
0xFF810000 will jump to location 0xFF810000 where zImage.initrd's code
starts.  That works fine for me and I'm happy with it.  But 8xxrom was
intended to work with disk in addition to flash, so I started exploring why
ELF-loading didn't work.

b) I found several problems in 8xxrom-0.3.0 regarding loading an ELF image
from the beginning of a disk.  I was hoping some past/present/future 8xxrom
developer was lurking on this list and I could start a conversation (off of
the list probably) about this.

c) The problem with initrd decompression was that the board descriptor data
was copied explicitly to 0x200000 which happened to be in the middle of
initrd.  This happens in arch/ppc/mbxboot/misc.c:
	cmd_line = (char *)(0x200000);
For me at least, this change worked wonders:
	if ((load_addr >= 0x10000) && (load_addr <= 0x210000))
		cmd_line = (char *)(load_addr - 0x10000);
	else
		cmd_line = (char *)(0x200000);
This assumes that the 64K directly under the load address is RAM that is
unused.  That assumption may not be valid for everyone.

Regarding the questions about the load sequence, I think this has been
covered many times on this list and elsewhere.  The load sequence is
something like this:

1) The original boot loader initializes the hardware and locates the Linux
image.  If the Linux image is on a disk, the boot loader copies the Linux
image to RAM.  Otherwise, if the Linux image is in flash, the boot loader
can just jump to the flash address, probably saving a bit of time and
definitely needing less RAM.

2) Linux's loader (the code in arch/ppc/mbxboot) initializes a serial port
and the board descriptor.  It finds RAM for the command line, the board
descriptor, the zImage, and the initrd.  If necessary, it copies zImage and
initrd into RAM.

3) Linux's loader uncompresses zImage into RAM and jumps to it.

4) The actual Linux kernel boots.  It finds an initrd in RAM and
uncompresses it to create a RAMdisk.  The original initrd RAM is freed.
Here also, the arch/ppc/8xx_io/uart.c takes over the serial port handling
and many other things happen.

We shouldn't dabble with the uncompressing of initrd.. that's standard
Linux.
We don't have much room to improve the linux loader in arch/ppc/mbxboot.  It
does a good job juggling various memory requirements for an ever-growing
assortment of target boards which have different memory layouts.  The code
in arch/ppx/mbxboot shouldn't be specialized for each board.  That is the
job of the original boot loader such as 8xxrom.  In that light, I have been
looking at 8xxrom to try to improve it beyond what I require.


> -----Original Message-----
> From: Dan Malek [mailto:dan@netx4.com]
> Sent: Monday, May 29, 2000 5:48 PM
> To: Graham Stoney
> Cc: Brown, David (dbrown03); linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Questions about 8xxrom
>
>
>
> Graham Stoney wrote:
>
> > > After all that, it still fails, while decompressing initrd.
>
> I must have missed this.....what is the error?  Post the few lines
> that show the actual/relocated debug messages for the zImage portions.
>
> > I suspect Dan's comments last week explain that this
> doesn't currently work:
>
> The word "currently" is quite correct.  It was never designed to
> decompress directly from Flash.
>
> > Dan, any chance you could clarify what would need to be
> done in order to
> > decompress the initrd directly from flash?  We also want to do this
> > eventually, and would like to avoid the wasted copy to RAM.
>
> Nothing needs to be done.  The code in arch/ppc/mbxboot/misc.c will
> allocate a RAM area and copy the initrd from Flash to RAM.
> The address
> and size of this is given to the kernel when it is started.
>
> The functions for uncompressing and using initrd are part of
> the kernel
> and common to all architectures.  It assumes the initrd is in RAM,
> which is also common to all architectures.  I don't intend to change
> this, and I don't see any real reason either.  The product dependent
> boot will place a copy of initrd in RAM, which could be from
> a network,
> CDROM, Floppy, Flash ROM, PCMCIA disk, etc.  The kernel isn't
> responsible
> for placing it there, only for using it.  It is a common feature for
> all systems, and thankfully someone made it real easy for us
> to use it.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

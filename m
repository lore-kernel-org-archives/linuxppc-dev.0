Date: Sat, 17 Nov 2001 01:03:44 +0000 (GMT)
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: a general bootloader question
In-Reply-To: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
Message-ID: <Pine.LNX.4.21.0111170017120.1293-100000@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 15 Nov 2001, Shie Erlich wrote:
>
> have also tried using the
> vxWorks bootloader (since it's already on the target's rom). The vxWorks
> bootloader fails bigtime, since
> it tries to load the kernel into --physical-- address 0xc0000000 and
> crashes.

I imagine you're trying to directly boot the vmlinux ELF file on the
vxWorks bootrom (the vxWorks bootROM uses ELF format boot files)...

The vmlinux ELF header has a physical and vm load address of 0xc0000000,
the vxWorks bootrom is simply taking this information, and sticking the
file where it's been told.  As a number of others have said, you don't
want to be doing this :-)

>
> if anyone can help with the following question, i'd be really grateful:
>
> 1) what is the proper way to get the kernel to boot - do i need a
> bootloader, if so, what ?

You do need a bootloader.  You've got two options.  Either you replace the
vxWorks bootrom with one of the public bootloaders, or you write a
bootloader called by vxWorks to boot Linux.  This can be done, I wrote
a bootloader for the vxWorks bootrom a while back.

>
> 2) what is the bootloader's functionality - except downloading the kernel ?
> does it modify
>     memory in any way ? is the kernel dependent on such modifications ?

The main job of the bootloader is to take the linux image, move it to
physical address 0 (possibly uncompressing the image, if it's compressed),
copy the initrd fs (if present) to a sensible place, flush the I & D
caches, set up processor/memory, and pass the command line, location of
initrd, and other goodies to the kernel.

Depending on your kernel (I'm familiar with the 405 kernel, things
may be different) the other goodies should contain at least the physical
memory size, the clock speed, and possibly the ethernet MAC
address.  Otherwise the kernel will get a bit upset.

As far as a writing a bootloader for the vxWorks bootrom, there are a
couple of extra things you should know.

1. The vxworks bootrom uses ELF boot files.  However, it only downloads
and uses the text and data sections.  Any other sections present in the
ELF file are ignored.  This means techniques (like the treeboot loader),
which add the linux image and the initrd fs as extra sections don't
work.  Both the linux image and the initrd fs need to be contained as
part of the text section.

2. The vxWorks bootrom sets up the PIT timer, and this has to be disabled
(plus interrupts turned off), before the kernel is moved.  Otherwise,
you'll get a crash when your I & D cache flush flushes the exception
handler (which has been overwritten by the linux kernel :-).

3. With the vxworks bootrom the memory has been already setup, so
this doesn't have to be done.

> 3) how can i make a bootloader load the kernel in low memory without
> changing KERNELBASE etc ?
>

You make your bootloader (not the vxworks bootloader) have a load address
somewhere in physical RAM, somewhere where it won't be over-written by the
(possibly) decompressed kernel (i.e. at phys 0x40000).  Your bootloader
will have the linux image in it's text section (perhaps a big char array),
which it will copy down to phys 0 appropriately.

The linux image should be a pure binary image (not with the ELF header).
See objdump concerning how to string the vmlinux file.

Hope this helps.

Phillip

----
Phillip Lougher,
Zarlink Semiconductor,
Chepstow,
Wales.

>
> 		thanks in advance,
> 			Shie Erlich
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Mon, 6 Mar 2000 13:28:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bootloader ideas
In-Reply-To: <38C355B5.951735EB@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003060942140.2213-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 6 Mar 2000, David Monro wrote:

> I've been thinking about bootloaders. Particularly with respect to PReP
> machines.

Me too...

>
> The current method of making the kernel a binary loaded by the firmware
> is a bit of a kluge. It means we have to jump through hoops to change
> kernel parameters etc. It seems to me there are two or three obvious
> approaches, but first I need some information.
>
> 1) What if any services does the PReP firmware provide once it loads an
> image? I'm guessing that it isn't a lot, just the residual data to tell
> us what hardware we have. I could be wrong here though - can anybody
> tell me where to find softcopy PReP documentation?

It's somewhere on IBM sites if it's still there...

>
> 2) What does the ARC bootloader goop for NT provide in the way of
> services? I'm guessing rather more. In particular I suspect we have a
> way or reading files, by name, from a FAT16-formatted partition, and
> possibly passing them arguments, maybe stored in nvram. This is the way
> some Alpha systems do it; you set up an ARC boot entry to run a little
> executable (ldmilo.exe) which loads a file called 'milo' from the same
> directory and executes it. Milo then takes over and loads the kernel.
>
> Do all the PReP machines have ARC available for them? I would guess most
> do, but I could be wrong.

No, I've never seen a single machine with ARC myself...

> IMHO milo itself is overkill; it actually contains an awful lot of the
> kernel code (basically the SCSI drivers etc) so that once loaded it can
> load the kernel from any device that linux knows about, even if the
> machine firmware and ARC don't know about it. The current PReP boot code
> covers that eventuality even if it is a bit of a kluge - as long as the
> kernel can be loaded by the firmware (even from floppy) it will work.
> Assuming that more PReP machines have ARC images available, I'd be
> interested in creating a bootloader which, once loaded from ARC, would
> be able to load a kernel image from a device ARC could read, using ARC
> services. Anybody got any documentation?

The problem is that ARC has some services, PPCBUG used on Motorola boards
has very likely different ones...

> Oh, we could also have the bootloader do a lot of fixing up of things
> like the PCI spaces and interrupts - I note that NT and Linux on the
> IBM 850 have different ideas of where things are and what interrupts
> they use. Seems to work though.

For starting point see my prepboot bootloader which you can find at
ftp://vlab1.iram.es/linux-2.[23]

it is included in the mvme patches.

Basically:
- for now it adds a new directory (for now), arch/ppc/preepboot and a
CONFIG option to enable it.

- it reorganizes PCI I/O and memory space, actually for my machines based
on Raven/Falcon or Hawk Motorola chipsets, it remaps them completely
to something closer to CHRP

- it initializes video boards with an x86 ROM BIOS emulator if neceessary

- it still needs some work to handle the NVRAM, I want too to get rid of
most kludges in the early part of the kernel

- I have code which correctly gets the interrupt routing from residual
data

- it includes its own virtual memory management system, simple, primitive
and not resistant at all to fragmentation, but anyway it's thrown away
almost immediately,

- it is completely relocatable so that it can run whatever the memory
map of the system is ((except for interrupt vectors which are fixed by
HW). Actually it moves itself high so that it can decompress the kernel
in low memory.


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200003061229.VAA01945@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Mon, 06 Mar 2000 21:29:16 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-workstation@lists.linuxppc.org
In-Reply-To: Your message of "Mon, 06 Mar 2000 06:52:37 +0000"
 	<38C355B5.951735EB@amberdata.demon.co.uk>
References: <38C355B5.951735EB@amberdata.demon.co.uk>
Subject: Re: bootloader ideas
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Return for :
From: David Monro <davidm@amberdata.demon.co.uk>
on " bootloader ideas "
date: Mon, 06 Mar 2000 06:52:37 +0000 >>>

> Hi,
>
> I've been thinking about bootloaders. Particularly with respect to PReP
> machines.
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

I think so, too.
Some of PRePs cannot install because of ARC firmware.
They cannot rewrite itself from ARC to PRePspec firmware.
And, FireWorks PReP machines maybe needs such loader.

If there are some bootloader like MILO, copy a loader kernel
on DOS based partition, it is very useful for all PRePs.

MILO is ported on MIPS and Alpha based machines, they have some
relationship with ARC.  Maybe they have a same root, and compiled
for each machines.  (Is it true? Please correct me.)

But I am afraid it need to make with original compiler.
(I suppose this needs some cross compile method for ARC-PPC. )


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

Linux/MIPS FAQ have some information for ARC, but they say ARC is
not a right firmware, only it boots up NT.
Maybe ARC have no work for device detection.

> Ideally we would get to the point where all the platform-specific fixup
> code etc was moved into the bootloaders, and then do away with the
> CHRP/PReP/whatever compile option.

How cool it is!


Best regards.
----------------------
Kaz Aoshima = Editor of the PReP station
Material deveropment, Faculty of engineering,
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I would appreciate if you could give me suggestions
 for my impolite English expressions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <38C43234.3D1E32F8@amberdata.demon.co.uk>
Date: Mon, 06 Mar 2000 22:33:24 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bootloader ideas
References: <Pine.HPX.4.10.10003060942140.2213-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Mon, 6 Mar 2000, David Monro wrote:

> >
[..]
> > us what hardware we have. I could be wrong here though - can anybody
> > tell me where to find softcopy PReP documentation?
>
> It's somewhere on IBM sites if it's still there...

Got it (and the nvram and residual data specs). Looks like a PReP
machine with Open Firmware would possibly have enough smarts to do
something sensible, but I don't think the 850 and the like implement OF,
so that isn't very useful. Do we know what machines do implement OF,
which ones have ARC available, which ones have PPCbug, and are there any
other PReP machines with none-of-the-above?

[..]
> > Do all the PReP machines have ARC available for them? I would guess most
> > do, but I could be wrong.
>
> No, I've never seen a single machine with ARC myself...

Which machines do you deal with - did they not have an NT port? I could
be wrong, but I thought ARC was pretty much always used to boot NT on
non-intel machines...

[..]
>
> The problem is that ARC has some services, PPCBUG used on Motorola boards
> has very likely different ones...

Very true. Ugh.

>
> > Oh, we could also have the bootloader do a lot of fixing up of things
> > like the PCI spaces and interrupts - I note that NT and Linux on the
> > IBM 850 have different ideas of where things are and what interrupts
> > they use. Seems to work though.
>
> For starting point see my prepboot bootloader which you can find at
> ftp://vlab1.iram.es/linux-2.[23]
>
> it is included in the mvme patches.

I've had a look at this before - didn't work for me at the time, but
that was probably for other reasons. I'll have to give it another shot.
Ahh - I guess there probably wasn't an NT port to a VME bus system :-)
Last mvme box I played with was I think the 131 - 68020 with 68851
running sysv/68k r2v3. Long time ago :-)

It is still part of the kernel image though, isn't it? What I would like
is an interactive standalone bootloader which knows quite a bit about
the individual systems, which is then capable of loading the kernel and
booting it - like milo on the alpha.

>
> Basically:
> - for now it adds a new directory (for now), arch/ppc/preepboot and a
> CONFIG option to enable it.
>
> - it reorganizes PCI I/O and memory space, actually for my machines based
> on Raven/Falcon or Hawk Motorola chipsets, it remaps them completely
> to something closer to CHRP

Hmm. Not sure what mine in the 850 is; lspci mentions a motorola MCP105
Eagle as the host bridge.
>
> - it initializes video boards with an x86 ROM BIOS emulator if neceessary

Nice idea. It would still be kind of hard to access SMS (system
management services, basically the tools to select what device you plan
to boot off etc) if the firwmare doesn't support your video card though.
I don't think the 850 supports serial console at the firmware level
unfortunately :-)

>
> - it still needs some work to handle the NVRAM, I want too to get rid of
> most kludges in the early part of the kernel

Good..

>
> - I have code which correctly gets the interrupt routing from residual
> data
>
> - it includes its own virtual memory management system, simple, primitive
> and not resistant at all to fragmentation, but anyway it's thrown away
> almost immediately,
>
> - it is completely relocatable so that it can run whatever the memory
> map of the system is ((except for interrupt vectors which are fixed by
> HW). Actually it moves itself high so that it can decompress the kernel
> in low memory.

Yeah, I noticed that. Keep up the good work!

btw - which tree are your patches on vlab1 against - Linus', vger or
fsmlabs?

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

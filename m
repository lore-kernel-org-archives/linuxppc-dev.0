Date: Tue, 7 Mar 2000 14:34:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bootloader ideas
In-Reply-To: <38C43234.3D1E32F8@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003071141310.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 6 Mar 2000, David Monro wrote:

> Got it (and the nvram and residual data specs). Looks like a PReP
> machine with Open Firmware would possibly have enough smarts to do
> something sensible, but I don't think the 850 and the like implement OF,
> so that isn't very useful. Do we know what machines do implement OF,
> which ones have ARC available, which ones have PPCbug, and are there any
> other PReP machines with none-of-the-above?

I had OF on my early MVME2600 but then Motoroola switched back to PPCBUG.
The OF was so buggy and lacking (no interrupt routing, no RTAS, even told
me that the OpenPIC was at bus 0 device 31 when it was device 0) that it
was useless.

> Which machines do you deal with - did they not have an NT port? I could
> be wrong, but I thought ARC was pretty much always used to boot NT on
> non-intel machines...

I have seen VME boards from several manufacturers, and might see more
soon. All have different firmware, actually I liked very much the first
one which  had a decent OF but it failed after a few weeks of operation.

Right now I only have Motorola to test (26xx, 24xx, hopefully soon
51xx but I know people who use my kernels on 23xx and 27xx).

> > The problem is that ARC has some services, PPCBUG used on Motorola boards
> > has very likely different ones...
>
> Very true. Ugh.

Oh, and BTW the PPCBUG services can't be used with the cache or the MMU
enabled. Even sending a character to the console does not work. Don't
believe the documentation, it is so obviously plain wrong in this respect
that it's not even funny.

I checked on 603e boards, it seems the firmware forces the use of the high
interrupt entry points in ROM by setting MSR[IP] which do not provide
TLB reload handlers and prevents replacing MMU handlers.

In short I can't call PPCBUG services under my own memory management :-(,
it might work if I provided all possible translations that the firmware
use through BATS, but there are only 4 of them.

> > For starting point see my prepboot bootloader which you can find at
> > ftp://vlab1.iram.es/linux-2.[23]
> >
> > it is included in the mvme patches.
>
> I've had a look at this before - didn't work for me at the time, but
> that was probably for other reasons. I'll have to give it another shot.
> Ahh - I guess there probably wasn't an NT port to a VME bus system :-)
> Last mvme box I played with was I think the 131 - 68020 with 68851
> running sysv/68k r2v3. Long time ago :-)
>
> It is still part of the kernel image though, isn't it? What I would like
> is an interactive standalone bootloader which knows quite a bit about
> the individual systems, which is then capable of loading the kernel and
> booting it - like milo on the alpha.

Well it is part of the kernel image but it needs not be actually. You can
look at it as an MS-DOS like system. It would be fairly easy to add simple
drivers:it already provides simple memory management, console I/O and
basic PCI configuration services for a single task which may be anything
you want (right now it is decompressing an embedded kernel image +
setting bootinfo + moving initrd around). But it could also load another
image from disk or network, actually I wanted to do it but the PPCBUG
problems make it painful (include a simple fs which can read the kernel
image and pass it the correct parameters).

However I would not like to add interrupt management since polling should
be sufficient in a bootloader. Better clock and timing management could be
added if it simplifies the handling of timeouts however. As long as it's
mostly my code, I'll try to prevent needless bloat, however.


> Hmm. Not sure what mine in the 850 is; lspci mentions a motorola MCP105
> Eagle as the host bridge.

Fine, it's a standard PreP bridge, old but working. It can't be used for
CHRP like mappings though AFAIR (unlike the 106).

> >
> > - it initializes video boards with an x86 ROM BIOS emulator if neceessary
>
> Nice idea. It would still be kind of hard to access SMS (system
> management services, basically the tools to select what device you plan
> to boot off etc) if the firwmare doesn't support your video card though.

Indeed, unless you rewrite the firmware...

> I don't think the 850 supports serial console at the firmware level
> unfortunately :-)

PPCBUG does, actually most of my boxes are headless (don't even have a
keyboard interface or USB, which makes it somewhat awkward to plug in
a standard keyboard).

AIX firmware certainly had some support for serial console. Can't you put
a different firmware in your box (I know I'm lucky with the MVME boards,
they have 2 separate Flash ROMS and a jumper to select the one used at
reset so I can test a new firmware version and easily switch back to the
previous one if it fails).

> > - it is completely relocatable so that it can run whatever the memory
> > map of the system is ((except for interrupt vectors which are fixed by
> > HW). Actually it moves itself high so that it can decompress the kernel
> > in low memory.
>
> Yeah, I noticed that. Keep up the good work!
>
> btw - which tree are your patches on vlab1 against - Linus', vger or
> fsmlabs?

Linus', I might try fsmlabs when BK it becomes official but I was so
severely burnt the day vger was closed to the public (had to modify
something like 600 files to get my systems to boot again), that I'm going
to be very reluctant to try anything else. Besides there are mirrors of
Linus'tree everywhere, but from here a checkout of vger does not always
finish overnight :-(

	Cheers,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

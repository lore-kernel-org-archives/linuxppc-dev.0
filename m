From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 16 Jan 2004 20:54:06 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Broadcom BCM94306
Message-ID: <20040116195406.GA25566@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040115115023.GA12001@iram.es> <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 02:00:16PM +0100, Segher Boessenkool wrote:
>
> >>Also note that the 970 does not support wrong^H^H^H^H^Hlittle-endian
> >>mode
> >>at all.
> >
> >BTW, where did you find this? IBM's sites have no real documentation on
> >the 970, or I was too dumb to find them.
>
> I work for IBM.  I did not realize this information wasn't
> publicly available -- if it isn't, and it's not just you.

The fact is that the documentation for the 970 is by far the
poorest from all the processors on IBM's website. I believed
IBM would release more information about these processors. Or
doesn't IBM really want to sell them?

Anyway, since you seem to have ties inside IBM ;-), you might
know why they do not even give a list of differences of the
970 implementation. I know from another source that the 970 does
not have BATs, but supports large pages with a size of 16MB.

>
> >It's more complex than this, because it is pseudo little endian,
> >munging
> >low address bits.
>
> It's not, afaics.

It's the case for all 603/604/7xx/7xxx processors.

>
> > The memory seen as an array of bytes is not invariant
> >through this transformation for most processors. For example the
> >character
> >chain "abcdefgh" copied from a kernel buffer through a read call will
> >look as "hgfedcba" from a little endian application.
>
> Representation depends on access size.

Indeed, but I said array of bytes, implying byte size accesses even
if it was not clear. However, I forgot to mention that it should be
an 8 byte array on a 8 byte boundary. This is the rule for all the
processors I have mentioned before.

>
> > Bridges have a
> >"LE" bit to also mung addresses during DMA and PIO transfers.
>
> Well yeah, PCI swizzling is awful and complicates the hell out
> of everything.

Well, if the processors switched to little endian with byte
invariant addressing, there would be no need for mode switching
control bits in the bridges, and it would be almost easy to
support a mixture of BE and LE applications (note that I said
"almost", but the only practical interest is for emulators).

>
> >But this makes it almost impossible to support a mixture of little and
> >bug endian applications. Indeed the ROM BIOS x86 emulator I wrote a
> >few years ago runs in big-endian mode and uses {l,st}[hw]brx
> >instructions
> >to emulate x86 crapitecture.
>
> That's how to normally access PCI as well, yeah.
>
> >P.S.: there is nothing wrong with calling little-endian wrong or
> >perverted or fucked-up ;-)
>
> I don't know if I trust you here -- you wrote "bug endian" just a few
> lines up ;-)

Damned laptop keyboards! U and I keys are just too close from each
other;-) Apart from this, if you look up some archives, you'll certainly
find that I think, live and breathe big-endianly ;-) (bit 0 is the most
significant bit, period)

Now the fact that the 970 does not support backwards-endian is a very
good thing. From time to time (although it has been less frequent
recently) somebody suggest on the list that Linux/PPC switches to the
dark side of the endianness. The fact that some processors don't support
it will be a killer argument.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

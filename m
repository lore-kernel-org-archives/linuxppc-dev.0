Date: Mon, 8 Apr 2002 10:23:48 -0700
From: Matt Porter <mporter@mvista.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020408102348.A1048@home.com>
References: <20020408162412.GJ2716@opus.bloom.county> <Pine.LNX.4.33.0204081831350.20339-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0204081831350.20339-100000@gra-lx1.iram.es>; from paubert@iram.es on Mon, Apr 08, 2002 at 06:48:04PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 06:48:04PM +0200, Gabriel Paubert wrote:
>
> On Mon, 8 Apr 2002, Tom Rini wrote:
>
> > It's my understanding that since they're PReP + bits, it's cleaner to
> > support them seperatly than in the big prep mess.  It's also easier to
> > get all of the HW bits working.  But maybe Matt Porter will speak up. :)

Ok, Ok.

> Well, when the bits outside of initdata/initcode can be reduced to only
> a different iobase, it seems overkill. And even the other bits can be
> extremely tiny and mostly pushed to the bootloader. Maybe I've forgotten
> something, since I've got machines running in production for about 3 years
> and hardly touched anything since then.
>
> > > Actually, PreP residual data can be useful, if you kow how to interpret it
> > > to find interrupt routing for example.

Most of the MCG's residual data are so incorrect that you spend more time
fixing stuff up than using this "wonderful" source of board info. I had
an opportunity to examine all of them in detail at my previous employer
to realize that it's mostly useless to use it.

Couple that with the constant breakage of a numer of the boards by all
the tweaks to real legacy PReP workstations.

The CONFIG_PPLUS port made the code clean, neat, and maintainable.

Because the CONFIG_PPLUS port doesn't rely on residual data, the
ability to create a "ROMboot" image is simplified to the point that
it is generated in the kernel instead of an 18 step process involving
dumping a copy of residual data that was only being used to get
the memory size.  Retrieving memory size from the memory controller
configuration already had been done for other MCG boards with
inaccurate residual data info.

The firmware group at MCG will _never_ fix the residual data since
their AIX doesn't use it.  Even when they had some decent staff
on hand they weren't willing to fix anything related to residual
data.  Now, they've laid off just about everybody so it's guaranteed
to never happen.

CONFIG_PPLUS also made it easy to add pci_auto support since putting
it in PReP would have been a complete mess...

> > > (Who should have properly submitted his PrePboot code 3 years ago)

Yeah, you even had a sorting autoconfiguration algorithm in prepboot,
IIRC.

> > Yes.  Willing to dig it up again and try and get it going for 2.5? :)
>
> Hmm, it booted at least until 2.4.0 (early 2001), but I am very busy on
> other things right now (some software, but mostly microwave, analog
> electronics up to 18 GHz is so fun!) and I was waiting for at least the
> new kbuild to appear in the official trees: if it holds up to its
> promises, it will make life much simpler.

This makes me miss application work. :-/

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

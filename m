Date: Fri, 18 Jun 2004 08:35:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Leigh Brown <leigh@solinno.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
Message-ID: <20040618153506.GD811@smtp.west.cox.net>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk> <20040617161616.GK24479@smtp.west.cox.net> <20040617223626.GB21217@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040617223626.GB21217@iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 18, 2004 at 12:36:26AM +0200, Gabriel Paubert wrote:

> On Thu, Jun 17, 2004 at 09:16:16AM -0700, Tom Rini wrote:
> >
> > On Thu, Jun 10, 2004 at 05:55:56PM +0100, Leigh Brown wrote:
> >
> > >
> > > This patch adds a function residual_pcidev_irq() which finds out
> > > from the residual data which IRQ the given PCI device should use.
> > > The interesting part about this patch is the changes I made to
> > > prep_pcibios_fixup().  The old code was more than a little
> > > opaque so I tried to change it to make it a bit clearer.  I'd
> > > definitely be pleased if someone could cast their eyes over
> > > that bit.
> >
> > Is this jsut a "Residual Data is Good" type change, or does it fix some
> > set of IBM machines?  I ask since residual data on Motorola PRePs can be
> > incorrect, iirc.
>
> On my PreP machines (well PowerPlus since they are actually
> Raven/Falcon or Hawk based), the residual data for interrupt
> routing is correct, but some people insisted in writing code
> without having read the spec, and refused mine which correctly
> decoded this information :-(

Fixing things up to follow the spec, so long as there's not a good
reason to not follow the spec (e.g. more machines have out-of-spec data,
than do), maybe it'll get in now. :)

> BTW: I believe that we should really merge PPlus, MVME5100 and PreP,
> they are really minor variants (and on my MVME2[467]xx machine which
> boot as PreP, I reprogram the Raven/Hawk so that they look more like
> CHRP because I need a very large PCI address space, but 1GB of I/O
> space is stupid.

Actually, there's 2 directions that ideally, someday, we might go in:
- Make any subset of 'compatibile' machines configurable, e.g. a kernel
  that works on pmac, pplus, and sbs k2 (but not also an ebony or
  walnut)
- Finish ripping the pplus stuff out of prep*, since it's a bit better
  supported in pplus.c (current 2.6) and if there's not a good reason
  not to, merge mvme5100 stuff into another platform grouping (pplus if
  it fits easily, for example).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

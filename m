Date: Fri, 16 Nov 2001 10:13:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011116094210.B3473@beef.az.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 09:42:10AM -0700, Matt Porter wrote:
> On Fri, Nov 16, 2001 at 08:51:21AM -0700, Tom Rini wrote:
> > On Fri, Nov 16, 2001 at 04:57:38AM -0700, Matt Porter wrote:
> > >
> > > I've been wondering why it's architected that way as well.  It
> > > seems you are looking for it to follow the model of the well
> > > abstracted 7xx/74xx ports.  Examples are the ones that rely on
> > > mpc10x_common and pplus_common as libraries of common initialization
> > > code (MEN F1, PCore, MCPN765, MVME5100, etc.).
> >
> > But that's just it.  Someone else should probably speak up on this, but
> > in the 403/405/stb0{3,4}xxx, and possibly 440 when it exists there are
> > some things which always exist, depending on processor.  Each 750 board
>
> Leave the 440 out of this, it should never pollute the classic PPC
> tree if it's done correctly.
>
> > for example can really have almost anything attached to it.  But for a
> > 405GP, there are known things and some variable things.  I _think_ 4xx
> > boards vary more like the 8xx ones do, than 750 does.
>
> 405GP specifically is similar to an 8240 in that the "system
> controller" is fixed.  That is, there is a known PPC core,
> memory controller, PCI bridge, and a set of peripherals.
> 8240 ports are using the "7xx/74xx" approach because it fits
> well.

That and all of the 8240 'boards' are 7xx/74xx boards which can take a
processor 'card' of some sort, yes?

Not getting too off course, but what's the difference in 8240 vs 8245
(not much, yes?) vs 8260 (different I/O, yes?).

> You could make the same argument that all gt64260+7xxx
> ports belong in one file rather than a board specific file
> that calls to a common set of library initialization routines.

Well depending on how different the boards are, perhaps.

I think right now, 4xx is done in a different way intentionally.  The
7xx/74xx design does indeed work, but for every off-by-one board you end
up either doing an #ifdef or a new set of files, for small changes.  The
current 4xx design seems to be the other way around.  There's common
ground, with hooks for board-specific stuff.  This could probably use
more cleanup & slight changes, but I don't think it's time to scrap the
idea.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

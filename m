Date: Mon, 2 Jun 2003 10:40:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] A stand-alone boot loader for PReP
Message-ID: <20030602174032.GC787@ip68-0-152-218.tc.ph.cox.net>
References: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk> <20030531214950.GP32642@plato.local.lan> <63891.213.107.143.228.1054475827.squirrel@www.solinno.co.uk> <20030601221249.GQ32642@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030601221249.GQ32642@plato.local.lan>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 01, 2003 at 02:12:49PM -0800, Ethan Benson wrote:
>
> On Sun, Jun 01, 2003 at 02:57:07PM +0100, Leigh Brown wrote:
> >
> > Ethan Benson said:
> > >
> > > On Sat, May 31, 2003 at 09:36:41PM +0100, Leigh Brown wrote:
> > >>
> > >> [If you bore easily:
> > >> http://www.solinno.co.uk/leigh/pablo/pablo-0.2.tar.gz ]
> > >>
> > >> Ever since I got Linux going on my PReP box I've been unhappy about
> > >> the boot loader. There is no lilo or yaboot equivalent for PReP and
> > >> it's a pain. For the past several months I've been trying to devise
> > >> a way of making a bootloader similar to lilo or yaboot, and this is
> > >> the best I've been able to come up with.
> > >
> > > I have been working (slowly due to lack of time) on a complete
> > > rewrite of yaboot, the plan is for it to support any OF based
> > > hardware (not limited to powerpc), and to design it in a general way
> > > so it can accomidate the various ways different architectures boot.
> > >
> > > to start with im writing a prom-libc library so all the usual stdc
> > > stuff doesn't have to be reinvented crappilly like every other
> > > loader seems to do, as well as get the prom specific stuff out of
> > > bootloaders and into a common place (it also should allow for a
> > > bootloader which is designed well enough to be more easily portable
> > > to different prom types so long as prom-libc has support). it will
> > > also allow the bootloader to be written much more like ordinary unix
> > > C programs, making them more portable (don't port the loader, port
> > > prom-libc).
> > >
> > > my goal is to eliminate the need for a different bootloader for
> > > every variation of hardware, i particularly hate how there is a
> > > dozen different loaders all with different user interfaces just for
> > > powerpc, much less other architectures.
> >
> > Unfortunately I think a PReP boot loader is largely orthogonal to an
> > OF based loader. Even PReP boxes that have OF don't support enough
> > services for yaboot (in any form) to work. Most PReP boxes don't have
> > OF or even allow any firmware calls from within the boot loader. With
> > PReP everything you need to bring up the O/S has to be held on the
> > boot partition and loaded into memory at boot time.
>
> then why do you have a of1275 interface in your loader?
>
> basically prep OF is more broken then apple's oldworld? now thats
> impressive...

I suspect it's because some PReP boxes (IBM ones, _mostly_) have
OpenFirmware.  And yes, there's a few versions of OF that are as funky,
if not funkier, than the one Apple uses.  But, as the 2.5 kernel shows,
the OF code can be shared.  The problem is that not all PReP boxes
support OF, so yaboot2 won't work on them.  Unless you're up for
allowing non-OF machines. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

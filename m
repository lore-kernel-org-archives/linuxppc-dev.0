Date: Thu, 25 Jan 2001 17:27:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Ani Joshi <ajoshi@shell.unixbox.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
Message-ID: <20010125172716.F594@opus.bloom.county>
References: <Pine.LNX.4.30.0101251138590.17251-100000@idd-01.imbc.gr> <Pine.LNX.4.05.10101251235590.18764-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10101251235590.18764-100000@callisto.of.borg>; from geert@linux-m68k.org on Thu, Jan 25, 2001 at 12:38:25PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 25, 2001 at 12:38:25PM +0100, Geert Uytterhoeven wrote:
> On Thu, 25 Jan 2001, Kostas Gewrgiou wrote:
> > On Wed, 24 Jan 2001, Petr Vandrovec wrote:
> > > On 24 Jan 01 at 11:11, Ani Joshi wrote:
> > > > I recently ran into an issue with the matroxfb driver and XFree86 4.0.2's
> > > > matrox driver.  Sometime in the past someone decided to use BE
> > > > register access in matroxfb for BE machines, while this is probably The
> > > > Right Way, it produces problems in X.  I can use BE register access
> > > > macro's in X but it was causing problems with the engine, perhaps some DMA
> > > > issue although the dma BE bits are on.
> > >
> > > Using big-endian on PPC was required by PPC users for compatibility with
> > > existing XF[86][68]_FBDev servers. Are you sure that there are no problems
> > > otherwise, and that it works correctly on all PReP/CHRP/???? architectures?
> >
> > Nope it won't cause any problems, none of the XF[86][68]_FBDev servers where
> > accelerated for matrox, other libs (SDL etc) that have accel for matroxfb
> > don't work correctly for ppc either.
>
> XF68_FBDev is accelerated for matroxfb, at least on the PPC platform.

Er, it is?  I thought only Xpmac was...

> > Changing the endian to little is the *right* thing, big-endian mode doesn't
> > offer us anything beyond problems in matroxfb 8/16 bit accesses become a
> > nightmare there...

Just my thoughts on this, but the matrox+ppc camp is relativly small (Yes, I
know some chrps which now work have 'em) and since I'm guessing (Ani, can you
benchmark some of this? :)) XF4 is faster than Xpmac, putting this in now,
with a toggle bit for people that really don't wanna upgrade to X4, and removing
the toggle in 2.5..  It should be an overall win.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

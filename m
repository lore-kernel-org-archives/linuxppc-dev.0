Message-ID: <001601c28a92$e4a0d8c0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>,
	<alan@lxorguk.ukuu.org.uk>
References: <20021112162504.GI658@opus.bloom.county> <IGEFJKJNHJDCBKALBJLLAEPBFHAA.joakim.tjernlund@lumentis.se> <20021112184025.GA9033@opus.bloom.county>
Subject: Re: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
Date: Tue, 12 Nov 2002 22:30:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, Nov 12, 2002 at 05:46:49PM +0100, Joakim Tjernlund wrote:
>
> > > > Now to the trick question(s):
> > > > Where might it be suitable to add -funroll-loops or, better yet, can it be done
> > > > with a pragma or attribute attached to the function in question? It's pretty
> > > > hard to unroll inline functions otherwise (and only the inline function).
> > >
> > > Well, to lib/Makefile:
> > > ifeq ($(CONFIG_PPC32),y)
> > > CFLAGS_crc32.o += -funroll-loops
> > > endif
> > >
> > > Should work.  And it's not unheard of.
> >
> > Yes, that much I already figured, but are there OTHER places in
> > the kernel that also might benefit from unrolling. I don't know the
> > kernel as well as you do and was hoping for a lead or two.
>
> Not really.  Unfortunatly what might be better is to figure out how it
> works on i386, and then figure out how to duplicate that logic on PPC,
> maybe making it another flag and then turned on for different sizes
> based on -mtune.

well, according to Mark Hatle it's only gcc 3.3-pre that does this kind of unrolling
automatically so that will take a very long time before it's figured out and usable.

So maybe it's worth the effort  to figure out a few hot spots and apply -funroll-loops there.

-mtune is new to me, need to look that one up.

>
> > > >  Any progress on the i2c-algo-8xx.c and/or 8xx_io/enet.c patches I sent earlier?
> > >
> > > As I said privatly, Dan Malek is handling the enet patch, and I'm
> > > looking for time to do the i2c one.  Right now I'm working on making the
> > > kernel easier to tweak (in some ways) for 2.5.
> >
> > I know Dan is handling the enet stuff, but since you both work
> > for MV(don't you?) I figured you might know, being an insider and all :-)
>
> I don't follow you.  Dan doesn't work for MVista now.

Sorry, I didn't know that.

>
> > Maybe your tweak stuff could make use of forced unrolling?
>
> Eventually, it could be used for turning it on or off for the whole
> kernel, or for a specific area even, once I get Makefile tweaks working.
> First I'm trying to get dependancies right.

makes sense.

    Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Wed, 2 Aug 2000 14:05:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <39860A50.E423F099@embeddededge.com>
Message-ID: <Pine.LNX.4.10.10008021351010.427-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jul 2000, Dan Malek wrote:
> Geert Uytterhoeven wrote:
> > Given the flexibility I was used to on m68k[*], I find this a pity as well...
> Well, it looks like I opened up a big can of worms...........
>
> I guess this is something that will get discussed as part of
> "restructuring" the PowerPC source tree when we jump into 2.5.xx.

Note that there was a time when we did have separate CONFIG_PMAC, CONFIG_PREP
and CONFIG_CHRP switches. I liked it, since it allowed to customize your kernel
more precisely.

> However, I need some kind of a simple solution that will help me with
> the embedded processors that will no longer build in the 2.4.xx
> kernel.  I know there must be some embedded Linux m68k boards that
> have a similar challenge that I may be able to use for insight.

AFAIK there are no embedded m68k boards. There are embedded uClinux boards,
though, but these are still at the 2.0.38 level.

> What I would like to do in the short term, is create a CONFIG_PPCMAC
> that has the sole purpose of including the drivers/macintosh software,

Please call it CONFIG_PMAC, like it used to be.

BTW, ADB code should be in driverd/adb/, cfr. all other bus types. It should be
protected using CONFIG_ADB, which should be configurable depending on either of
CONFIG_MAC, CONFIG_PMAC, CONFIG_CHRP or CONFIG_NEXT in
arch/{m68k,ppc}/config.in. That way you can leave out ADB support if you don't
need it (e.g. for server PowerMac boxes, and for CHRP boxes that use the PS/2
port only).

> or perhaps overload the CONFIG_ALL_PPC to do this.  Perhaps I will
> look at what CONFIG_PPC really means, and not define this for embedded
> boards (although this sounds wrong).

CONFIG_PPC is always set to `y' on the PPC platform. It's a substitute for
checking the arch type. I don't really see why it was invented, since the same
thing can easily be done using `#ifdef __powerpc__' in sources and `ifeq
($(ARCH),PPC)' in makefiles. Besides, CONFIG_PPC has the unwanted side effect
of making more sources depend on config.h.

So far my opinion...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

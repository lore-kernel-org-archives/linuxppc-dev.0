Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>,
	<alan@lxorguk.ukuu.org.uk>
Subject: RE: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
Date: Tue, 12 Nov 2002 17:09:11 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCEOPFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021112152255.GF658@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, Nov 12, 2002 at 10:40:41AM +0100, Joakim Tjernlund wrote:
>
> > I optimized the crc32() in JFFS2(fs/jffs2/crc.h) by manually unrolling
> > the crc32 loop. This gave me a speed increase of 22% in mounting JFFS2 FS
> >
> > Later Alan Cox pointed out that my changes makes x86 run slower and it turns
> > out that on x86 and a fairly new gcc will automatically unroll loops 'where appropriate'
> >
> > Removed my hand coded unrolling and added -funroll-loops to the JFFS2 Makefile,
> > I got similar results as my hand coded unrolling (a little better).
> >
> > I therefore conclude that ppc_8xx-gcc 2.95.3 from Monta Vista does not do ANY unrolling
> > unless you specify -funroll-loops. Doing this for the whole kernel is NOT a good idea,
> > it will run slower due to big increase of size.
>
> I'm sort-of supprised that gcc-2.95.x (or gcc-*, for that matter) will
> unroll some loops with only -O2 since the info page on gcc-3.2 and
> gcc-2.95 both say that -funroll-loops isn't turned on my any of the -O
> levels.
>
> So I suspect someone decided that small loops can safely be unrolled on
> i386 at some optimization level, but that same decision (with possibly
> good reason) was not made for PPC32.  So it's a gcc feature, not a
> MVista-specific issue.

Newer gcc(>=3.0) may do the same for PPC32. We only know that newer gcc's(Alan Cox knows more)
will do it for x86 and 2.95.3 for ppc_8xx won't, so there is a big ? in the middle.

Now to the trick question(s):
Where might it be suitable to add -funroll-loops or, better yet, can it be done
with a pragma or attribute attached to the function in question? It's pretty
hard to unroll inline functions otherwise (and only the inline function).

>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> [ disclaimer: I work for MVista. ]
Yeah, I know :-)

    Jocke
PS.
 Any progress on the i2c-algo-8xx.c and/or 8xx_io/enet.c patches I sent earlier?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

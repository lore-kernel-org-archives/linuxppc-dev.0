Date: Mon, 21 Aug 2000 19:11:45 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michel Lanners <mlan@cpu.lu>,
        dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A12C4F.1AEFBA48@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10008211711340.17506-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > The only way to work with this is to make xres_virtual = xres+0x20. But
> > > then XFree86 will draw into the cursor region, too.
> >
> > I think it used to work without such a hack - some old m68k Macs had the
> > video scan lines start every 1024 bytes but the actual xres was smaller.
> > I'll have to look at the macfb code to see what xres_virtual was set to.
> > I'm sure the X server didn't draw to the offscreen region as that would
> > have caused a bus error (at least the earlier 3.3.x versions didn't.
> > Later X versions drawing beyond xres would in fact explain bus errors
> > some people saw ...).
>
> X 4.0 distincts 3 values:
>
> 'xres'	- physical horizontal resolution of the current mode.
>
> virtualX - horizontal resolution of the virtual screen. Never changes during a
> screen's life.
>
> displayWidth - the length in pixels of each scanline in memory.
>
>
> Unfortunately, the fbdev driver still assumes that displayWidth == virtualX,
> and most other drivers have adapted that assumption (for most of them it's
> right though :) .

The right assumption would be displayWidth == fix.line_length/bpp (using
xres_virtual would have been some horrible kludge). Now where in the pScrn
struct does the fb.fix struct hide?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

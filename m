Date: Mon, 27 Mar 2000 14:33:11 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003271147390.31775-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0003271409210.22822-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Michael Schmitz wrote:

>
> > > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> > > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
> > > aperture, and allows XFree86 4.0 to run on my Lombard.
> >
> > Great news! So how does it compare to 3.3.x for you?
>
> It feels a lot slower (15/16 bpp as fast as 32 before), 16 bpp have messed
> up color (green too bright, maybe 565 is wrong after all), 32 bpp fails to
> start (no screen found, weight 000 inconsistent with depth 32).
>
> I need to figure out what the pixel format for 16 and 32 bpp really is.
> Currently the X server refuses to start up if the RGB weights don't add up
> to the screen depth, and depth 32 isn't supported at all. 24 bpp works but
> it's really slower than 32 bpp before. Plus the X server refuses to
> cooperate with xscreensaver and consistently kicks me out after 10
> minutes.
>

Without acceleration its logical to be *alot* slower than the old server
the shadowfb helps a little there (its used by default unless you disabled
it in the config)

16bpp isn't supported by atyfb, you should use 15bpp instead (the xserver
needs to be fixed to report that 16bpp isn't supported)

32bpp should have worked fine, the (no screen found, weight 000 inconsistent
with depth 32) message probably means that you tried a startx -- -depth 32
instead of the correct -fbbpp 32

> Even with not loading the more arcane extensions the X server weighs in at
> 21 MB (I recall 17 or so before), that might explain the slowdown a bit.
> Need to work on the accelerated Mach64 driver perhaps.

  My xserver weights about 74mb (it hits 100+mb with dual head) but keep in
mind that this includes the  mmaped fb/mmio areas which in my case is 64mb
so the server is using about 10mb of memory which isn't too much.
 The shadowfb module might be the cause of the memory increase in your case
i don't think that all the extra 4mb are from there though, but as i said
the slowdown is because you use a non accelerated server non because of
memory.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

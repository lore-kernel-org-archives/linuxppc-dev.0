Date: Mon, 27 Mar 2000 11:58:25 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <38DF2D3E.2E5B19E7@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003271147390.31775-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Applying Geerts patch (minus the PCIBIOS_MIN_MEM patch) plus the following
> > one solves my PCI address conflict for the Mach64 by reallocating the MMIO
> > aperture, and allows XFree86 4.0 to run on my Lombard.
>
> Great news! So how does it compare to 3.3.x for you?

It feels a lot slower (15/16 bpp as fast as 32 before), 16 bpp have messed
up color (green too bright, maybe 565 is wrong after all), 32 bpp fails to
start (no screen found, weight 000 inconsistent with depth 32).

I need to figure out what the pixel format for 16 and 32 bpp really is.
Currently the X server refuses to start up if the RGB weights don't add up
to the screen depth, and depth 32 isn't supported at all. 24 bpp works but
it's really slower than 32 bpp before. Plus the X server refuses to
cooperate with xscreensaver and consistently kicks me out after 10
minutes.

Even with not loading the more arcane extensions the X server weighs in at
21 MB (I recall 17 or so before), that might explain the slowdown a bit.
Need to work on the accelerated Mach64 driver perhaps.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 28 Jul 2000 16:51:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000728050930.2549D-100000@ofey.inetnebr.com>
Message-ID: <Pine.LNX.4.10.10007281606400.423-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 Jul 2000, Takashi Oe wrote:
> On Wed, 26 Jul 2000, Geert Uytterhoeven wrote:
> > There's indeed a global lock on the console, to prevent multiple accesses to
> > the console at once. This solves some problems, one being that some graphics
> > hardware crashes when both the CPU and the graphics accelerator touch the video
> > RAM at the same time.
>
> Would it be difficult to make the lock per fbdev thing?  If the
> CPU/accelerator clash is the only reason for the global lock, we can
> certainly remove that for hardware which doesn't have that kind of
> problem, can't we?

There could indeed be separate locks per fbdev. But the global console lock
(console_lock) would still be there. It is needed because the console subsystem
is not re-entrant (yet). Since fbdev is called from the console subsystem, it
runs under the same lock (i.e. with interrupts disabled).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

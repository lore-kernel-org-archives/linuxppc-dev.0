Date: Tue, 8 Aug 2000 15:55:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
In-Reply-To: <20000808091311.B248@mclx.com>
Message-ID: <Pine.LNX.4.10.10008081552520.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Josh Huber wrote:
> On Tue, Aug 08, 2000 at 02:35:19PM +0200, Geert Uytterhoeven wrote:
> > Is this XF4.0.1 in `fbdev' mode? If yes, it's a bug in the X server. Setting
> > the DSP registers is part of the video mode initialization and thus is the
> > sole responsability of the frame buffer device, when running in `fbdev' mode.
>
> Yes.  The server shows the SAME behavior using the fbdev driver and
> the ati driver.  Also, as a note, the 3.3.6 XF68FB_Dev server with ati
> accel also does the same thing!   So there's some code that's getting
> used by all three that is wrong?
>
> I'm a little confused as to where the problem lies...

An X server does:

 1. video mode programming
 2. color map setting
 3. accel engine setup
 4. accel engine programming

A `hardware banging' X server does all 4 of them by banging the hardware.
An X-server in fbdev mode must use ioctl() for 1 and 2, and use hardware
banging for 3 and 4.

Playing with the DSP registers is definitely part of 1, so the X server must
not touch those registers when in fbdev mode. Probably there's some code to
change the DSP registers in the accel engine setup code in both 3.3.6 and 4.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

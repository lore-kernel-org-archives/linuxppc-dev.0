Date: Fri, 29 Sep 2000 13:05:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000928174446.666M-100000@ofey.earthlink.net>
Message-ID: <Pine.LNX.4.10.10009291253420.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Takashi Oe wrote:
> On Thu, 28 Sep 2000, Geert Uytterhoeven wrote:
> > > My understanding is this:
> > > Video console uses 16 colors, and it only initializes the cmap
> > > corresponding to those 16 colors.  The other entries in cmap are up to
> > > each individual fb driver or undefined as far as console is concerned.
> > > For software cursor, driver specific (struct display_switch *)ops->revc()
> > > is used to make the cursor blink.  For the generic fbcon_cfb{16,32}_revc,
> > > it xors each pixel with masks 0xffff (depth 16) or 0xffffffff (depth 32).
> > > For controlfb which I am very familiar with, the "correct" masks are
> > > 0x3def for 555 and 0x0f0f0f0f for 8888.  That is, only 4 LSBs or low 16
> > > for each red, green, and blue are xor'ed since cmap entries corresponding
> > > to higher bits are undefined as far as fbcon support is concerned.
> >
> > In 2.5.x, we'll have a user-defined xor mask for the cursor as the 17th entry
> > in the dispsw_data array.
>
> Can we put it for 2.4?  As far as I can see, the actual size of
> dispsw_data matters only between fb driver and fbcon-cfbxx.c, and the
> changes required for each driver seem to be rather small.  Besides,
> controlfb is not the only one which will benefit from this change.

That's true. Personally, I see no problems with it if someone's willing to
write the patch for _all_ drivers at once. The real 2.4.0 is still a long way
to go, I think, and the impact of the required changes is known quite well.

The main thing we need to be careful about is that the xor mask is different
for truecolor and directcolor visuals: truecolor needs an `all ones' mask,
while directcolor needs `15' for each color component (drivers that incorrectly
report a directcolor instead of truecolor visual will easily be identified).

  - Affected fbcon low level drivers:

      o fbcon-cfb16.c
      o fbcon-cfb24.c
      o fbcon-cfb32.c

  - Affected frame buffer device drivers:

      o acornfb.c
      o atafb.c
      o aty128fb.c
      o atyfb.c
      o chipsfb.c
      o clgenfb.c
      o controlfb.c
      o creatorfb.c
      o cyber2000fb.c
      o fm2fb.c
      o hgafb.c
      o hitfb.c
      o igafb.c
      o imsttfb.c
      o macfb.c
      o matrox/matroxfb_accel.c
      o matrox/matroxfb_crtc2.c
      o offb.c
      o platinumfb.c
      o pm2fb.c
      o q40fb.c
      o riva/fbdev.c
      o sgivwfb.c
      o sisfb.c
      o skeletonfb.c
      o tdfxfb.c
      o tgafb.c
      o valkyriefb.c
      o vesafb.c
      o vfb.c
      o virgefb.c

Not that bad, only about 1/4 of all files...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

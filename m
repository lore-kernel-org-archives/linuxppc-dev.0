Date: Sun, 1 Oct 2000 13:30:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1000929112058.7632A-100000@unlserve.unl.edu>
Message-ID: <Pine.LNX.4.10.10010011330090.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Takashi Oe wrote:
> On Fri, 29 Sep 2000, Geert Uytterhoeven wrote:
> > > > In 2.5.x, we'll have a user-defined xor mask for the cursor as the 17th entry
> > > > in the dispsw_data array.
> > >
> > > Can we put it for 2.4?  As far as I can see, the actual size of
> > > dispsw_data matters only between fb driver and fbcon-cfbxx.c, and the
> > > changes required for each driver seem to be rather small.  Besides,
> > > controlfb is not the only one which will benefit from this change.
> >
> > That's true. Personally, I see no problems with it if someone's willing to
> > write the patch for _all_ drivers at once. The real 2.4.0 is still a long way
> > to go, I think, and the impact of the required changes is known quite well.
>
> Good!  I'll work on it.  Only a few allocate memory for dispsw_data
> dynamically, the changes should be trivial for most.
>
> > The main thing we need to be careful about is that the xor mask is different
> > for truecolor and directcolor visuals: truecolor needs an `all ones' mask,
> > while directcolor needs `15' for each color component (drivers that incorrectly
> > report a directcolor instead of truecolor visual will easily be identified).
>
> I don't know how it will work out for atyfb, but we'll see...

Atyfb is directcolor. Grep fro VISUAL_ to find out :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

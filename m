Date: Mon, 3 Dec 2001 14:16:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
In-Reply-To: <3C0AA2AF.97E7FCB4@wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0112031415170.5519-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2 Dec 2001, Martin Costabel wrote:
> Paul Mackerras wrote:
> > Martin Costabel writes:
> > > For the valkyriefb driver on my Pmac 6400, I can confirm from a first
> > > short test that it still works. This is with your patch applied to
> > > today's 2.4.17-pre1-ben0 kernel.
> >
> > Do you still have macos on the 6400?  If so can you confirm whether,
>
> Yes, I still have MacOS 8.6. No 9.x, though.
>
> > if you set the screen resolution and colour depth in macos, that the
> > value you have set in macos is the default that linux will use?
>
> I did some tests with the 2 useful modes of the 6400: 1024x768x8bit at
> 72Hz (vmode 15, cmode 8) and 800x600x16bit at 60Hz (vmode 10, cmode 16).
>
> The results, with or without Tom's patch, were the same as they always
> were:
> The vmode of MacOS is used by the Linux console; the cmode 16 is not
> recognized, so instead of vmode 10 16 one always gets vmode 10 8 as
> default. The log says
>
> kernel: Monitor sense value = 0x62b, <6>using video mode 10 and color
> mode 0

<video/macmodes.h>:

| #define CMODE_8                 0       /* 8 bits/pixel */
| #define CMODE_16                1       /* 16 (actually 15) bits/pixel */
| #define CMODE_32                2       /* 32 (actually 24) bits/pixel */

So please try `cmode 1' instead of `cmode 16'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

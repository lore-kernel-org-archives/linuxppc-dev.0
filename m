Date: Fri, 19 May 2000 08:03:22 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Brad Douglas <Brad@NERUO.com>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-fbdev] Re: macmodes/modedb
In-Reply-To: <6BAD6986DF8FD211AB8300A0C931D855050F05@MAIL>
Message-ID: <Pine.GSO.4.10.10005190801530.19668-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 May 2000, Brad Douglas wrote:
> > From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> > > Another option is to not try and do everything in fb_find_mode().
> >
> > You cannot do everything in fb_find_mode() since monitor sense is
> > a per-monitor issue, not global.
>
> As of now, all drivers have a 1:1 relationship with a monitor.  Even the
> Matrox G400 driver insmods a second driver for the 2nd head.  Should we
> expect this to change?  I do not believe fbdev is capable of initializing
> two video cards from a single driver, but I could be wrong -- I have no
> ability to test.

Yes it is. There are drivers that can handle multiple cards. And you can have
different cards as well.

> > One possible thing (in each fbdev driver :-(
> >
> >     default_mode = NULL;
> > #ifdef CONFIG_PPC_ALL
> >     sense = ...;
> >     default_mode = mac_map_monitor_sense(sense);
> > #endif
> >     ... = fb_find_mode(..., default_mode, ...);
>
> I believe this would be acceptable, but we'll have to change
> mac_map_monitor_sense() to return fb_videomode instead of VMODE.
> fb_find_mode() will be unhappy to get an int when it's expecting
> fb_videomode. ;)

Of course.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

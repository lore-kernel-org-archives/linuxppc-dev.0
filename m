Date: Thu, 18 May 2000 07:59:33 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brad Douglas <Brad@NERUO.com>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: macmodes/modedb
In-Reply-To: <6BAD6986DF8FD211AB8300A0C931D855050EF3@mail.neruo.com>
Message-ID: <Pine.GSO.4.10.10005180753280.16889-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Brad,

> I was just cleaning some things up with the macmodes/modedb changes (I
> finally have a little time!) and I have just realized that if I'm to
> continue the way I am (fb_find_mode() takes care of all mode
> initialization), I need to figure out what to do with Macintosh monitor
> sensing.

I've been thinking about that one as well... It's the main remaining culprit.

> What I can think of off hand is adding fb_mac_monitor_sense to fb_ops (which
> already looks like a less than optimal idea) or possibly depreciating it.

That's not a very good idea, since it's Mac only.
>From the other side, DDC is something similar, so a generic call in fb_ops may
be the good solution?

> Another option is to not try and do everything in fb_find_mode().

You cannot do everything in fb_find_mode() since monitor sense is a per-monitor
issue, not global.

One possible thing (in each fbdev driver :-(

    default_mode = NULL;
#ifdef CONFIG_PPC_ALL
    sense = ...;
    default_mode = mac_map_monitor_sense(sense);
#endif
    ... = fb_find_mode(..., default_mode, ...);

Or: should it be considered as a real mode_option (if mode_option == NULL)
instead of a default mode?

I'm dragging this to linuxppc-dev, for input from other Mac guys, and to
linux-fbdev.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

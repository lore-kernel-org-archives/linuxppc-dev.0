Date: Sat, 14 Oct 2000 18:41:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1001013173038.60708A-100000@unlserve.unl.edu>
Message-ID: <Pine.LNX.4.10.10010141839280.570-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Oct 2000, Takashi Oe wrote:
> On Fri, 13 Oct 2000, Benjamin Herrenschmidt wrote:
>
> > >That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> > >all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> > >video mode.
> >
> > Well, my understanding is that MOL needs to be able to "probe" for all
> > supported mode. Doing so on a visible console would definitely be hell.
> > It does that in order to setup the MacOS-side driver mode list.
>
> According to Samuel's last post, MOL needs both var and fix for probing.
> If there is something like:
>
> struct fb_probe_info {
> 	struct fb_var_screeninfo var;
> 	struct fb_fix_screeninfo fix;
> };

Why does it need fix? Relying on data from fix for a mode that is not yet
really set is not wise: there's no guarantee that fix will be the same when the
mode is really set later.

Example: dual-head cards, where the resolution on one head is changed so the
card's memory management is changed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 3 Oct 2000 13:01:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <20001002224703.A15425@suse.de>
Message-ID: <Pine.LNX.4.10.10010031301130.1187-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2 Oct 2000, Olaf Hering wrote:
> On Mon, Oct 02, Geert Uytterhoeven wrote:
> > On Sun, 1 Oct 2000, Olaf Hering wrote:
> > > while we are about to improve the atyfb, is it possible to fix the color
> > > depth switching?
> > > When I boot without a kernel arg I end up with 8 bit at console. I can't
> > > increase the color depth afterwards with fbset, and mol crashes when it
> > > tries to do that. When I specify atyfb:cmode:24 everythings works fine
> > > and I can switch down to 8 and back to 24 and mol starts fine.
> >
> > Does it also crash when you increase the color depth with fbset?
>
> It was not clear enough: I can not fbset when I have only 8 bit. But XF4
> can increase the color depth, maybe it does that in a different way?
>
> plum:~ # fbset
>
> mode "1024x768-60"
>     # D: 64.666 MHz, H: 48.115 kHz, V: 59.696 Hz
>     geometry 1024 768 1024 4080 8
                             ^^^^
>     timings 15464 144 40 29 3 136 6
>     accel true
>     rgba 8/0,8/0,8/0,0/0
> endmode
>
> plum:~ # fbset -depth 24
> ioctl FBIOPUT_VSCREENINFO: Invalid argument

That's normal, you also have to decrease the virtual size, which was
initialized to the maximum possible value w.r.t. RAM size.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

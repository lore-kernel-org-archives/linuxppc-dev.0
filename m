Date: Tue, 4 Apr 2000 08:55:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steven Hanley <sjh@wibble.net>
cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problems with the frame buffer (ATV 64) on a power mac 7220 in
   newer kernels
In-Reply-To: <38E93D4B.6BDE311@wibble.net>
Message-ID: <Pine.LNX.4.05.10004040854190.15657-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Apr 2000, Steven Hanley wrote:
> Michel Lanners wrote:
> > > I tried a kernel command line of video=controlfb:vmode:5
> >                                          ^^^^^^^^^
> > I didn't know the 7220 had a control display adapter? Anyway, this
> > option will do nothing for your ATI display. You need to look at atyfb
> > for relevant options.
>
> I have no idea what the hardware actually has or doesnt, however as
> mentioned in the email I did try a plain video=vmode:6 also which if I
> read line 3279 of atyfb.c correctly (2.2.15pre14)
>
> 3278-#if defined(CONFIG_PPC)
> 3279:   else if (!strncmp(this_opt, "vmode:", 6)) {
> 3280-       unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
> 3281-       if (vmode > 0 && vmode <= VMODE_MAX)
> 3282-           default_vmode = vmode;
>
> should set the vmode correctly to whatever I pass, instead it still just
> goes with 6 seemingly due to code paulus added since 2.2.10.

Should be:

    video=atyfb:vmode:6

The default video= parser doesn't know about vmode options. In 2.3.x it does
using this syntax:

    video=mac6

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 19 Aug 2000 14:12:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
In-Reply-To: <200008190718.JAA00823@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10008191410200.525-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 19 Aug 2000, Michel Lanners wrote:
> On  18 Aug, this message from Daniel Jacobowitz echoed through cyberspace:
> >> In fact, before, the line length was exactly hpixels * bytes/pixel,
> >> whereas now there's an additional 0x20 bytes in each line. I have not
> >> been able to boot a 2.4.0 kernel with any fix applied, but you could try
> >> and build a version without those 0x20 bytes added (they are found in a
> >> few spots inside controlfb.c).
> >>
> >> As to why these 0x20 bytes were added, anybody know an explanation? And,
> >> if they do serve a purpose (I suppose so ;-), it would be better to add
> >> the exact number of bytes as a #define somewhere...
> >
> > *sigh*
> >
> > I have no idea where this came from, but 0x20 means it has something to
> > do with cursor support, I'd bet.  I seem to recall someone talking
> > about that a few months ago... that is how hardware cursor is generally
> > implemented, by a 32 pixel block at the end of the scanline.
>
> That's what I was thinking about. However, I'm not sure that XFree
> supports a display with discontiguous lines in video memory. I think I
> read that somewhere in some mailing list or X doc... Can any of the
> XFree specialists confirm?

I can speak for XFree86 3.x only, not for 4.x.

The only way to work with this is to make xres_virtual = xres+0x20. But then
XFree86 will draw into the cursor region, too.

Alternatively you can modify the XFree86 cfb code to remove the assumption
that the line_length is based on the virtual horizontal resolution.

Gr{oetje,eeting}s,

				    Geert (also underactive and out of touch)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 21 Aug 2000 12:46:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A0EF0C.EDC3D3A1@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10008211241460.371-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 21 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> That's not even needed, the fbdev driver is just broken. Line 430:
>
> 	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
>
> is indeed wrong. virtualX is obvious, but displayWidth should be the memory
> pitch of a scanline.
>
> Now you just have to find out where to get the correct value for displayWidth.

I suppose

    if (fix.line_length)
	pScrn->displayWidth = fix.line_length*8/var.bits_per_pixel;
    else
	pScrn->displayWidth = var.xres_virtual;

should work fine, except on hardware were fix.line_length*8/var.bits_per_pixel
might not be integer (e.g. if 1280x1024x24 mode requires a line_length of
4096).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

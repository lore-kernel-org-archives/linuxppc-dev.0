Date: Sat, 10 Mar 2001 09:18:51 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Console text selection bug
In-Reply-To: <3AA69A1D.F1F85B48@denise.shiny.it>
Message-ID: <Pine.LNX.4.05.10103100916270.765-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Mar 2001, Giuliano Pochini wrote:
> >> It's an endian bug in fbcon when accessing the text/attribute buffer.
>
> > Nevertheless, it's a bug. Can someone please change fbcon_invert_region() to
> > use scr_{read,write}w() to access the shadow screen buffer and see whether it
> > works? Patches are accepted at linux-fbdev-devel@lists.sourceforge.net :-)
>
> Yes, it's an endianess bug.  scr_{read,write}w() are defined as normal
> assignments in vt_buffer.h, so I wonder where is the bug. Is the shadow buffer

No, their definition in vt_buffer.h depends on VT_BUF_HAVE_RW. If that is
defined in <asm/vga.h>, vga.h must provide its own definitions.

> supposed to be native endian ?

It doesn't really matter, since all accesses must be done using
scr_{read,write}w() anyway. For performance reasons we chose native endianness.
Except when VGA (CONFIG_VGA_CONSOLE || CONFIG_MDA_CONSOLE) is defined, since on
VGA/MDA the shadow buffer _is_ the screen image and must be little endian.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 6 Mar 2001 07:52:22 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Console text selection bug
In-Reply-To: <v04220800b6ca30dbefe5@[10.0.0.42]>
Message-ID: <Pine.LNX.4.05.10103060750360.29713-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 5 Mar 2001, Timothy A. Seufert wrote:
> At 10:35 PM +0100 3/5/01, Benjamin Herrenschmidt wrote:
> >>When I select text in console it's scrambled. I looked at the
> >>aty128 sources, but I didn't find anything about it. Where is
> >>the code that manages selection/cut/paste ?
> >>
> >>The selected text is scrambled in this way: every char has
> >>the bits 1,2,3 swapped with bits 5,6,7 respectively (bits
> >>numbered left to right). I don't know what can cause this
> >>strange behaviour... I thought the console screen was a
> >>simple array of char/colour pairs.
> >
> >It's an endian bug in fbcon when accessing the text/attribute buffer.
> >
> >I think someone posted a fix for it, You may have more luck asking on
> >the fbdev mailing list to the fbdev maintainers what's up.
> >
> >I think it's related to fbcon_invert_region() not using the access
> >macros and directly tapping the buffer, causing attributes & text
> >to be messed up.
>
> I saw this problem in 2.4.x until I turned off the config option for
> VGA consoles.  Then it went away.

Nevertheless, it's a bug. Can someone please change fbcon_invert_region() to
use scr_{read,write}w() to access the shadow screen buffer and see whether it
works? Patches are accepted at linux-fbdev-devel@lists.sourceforge.net :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

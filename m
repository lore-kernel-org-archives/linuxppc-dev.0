Date: Tue, 12 Sep 2000 18:42:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huber@mclinux.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: strange console behavior in 2.4
In-Reply-To: <20000912093049.C6709@mclinux.com>
Message-ID: <Pine.LNX.4.10.10009121838560.372-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Sep 2000, Josh Huber wrote:
> I've been playing with 2.4 on my G4, and everything's working great,
> except for text selection in console mode.
>
> If I use gpm to select text in console mode it's almost as if a
> completely different (and very wrong) character map is being used.
> The characters that have been selected not only invert color, but they
> change to different ones.  Most of them look like high ascii chars,
> like smilely faces etc.

The shadow screen contains 2 bytes for each character cell, one containing the
character code and one containing the attribute.  Does it look like the
attributes and characters got exchanged?

If yes, look for changes in the various scr_{read,write}() functions and in
drivers/char/vc_screen.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

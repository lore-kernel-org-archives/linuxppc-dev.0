Date: Fri, 25 Jan 2002 17:03:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: arch/ppc/kernel/setup.c::screen_info
In-Reply-To: <20020125154448.GB745@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.GSO.4.21.0201251701280.15996-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 25 Jan 2002, Tom Rini wrote:
> Hey all.  Currently in the linuxppc_2_4 tree, we conditionally compile
> the screen_info struct on CONFIG_VGA_CONSOLE (and export the symbol
> based on that too).  In linuxppc_2_4_devel, Geert checked in vga16fb
> fixes 2 months ago or so that added tests for CONFIG_FB_VGA16{,_MODULE}.
> And just recently Hollis Blanchard posted a patch to add vesafb to this
> list as well.   So now the question is, shouldn't we just blindly
> allocate this struct and always export the screen_info symbol?  This
> makes the most sense IMHO, since the point of modules is that you can
> add things on later without having to recompile.  But if people are
> concerned about the extra space, perhaps we should do it based on
> CONFIG_FB (I don't believe VGA_CONSOLE actually needs the symbol to be
> exported, since it's a bool).   Comments?

Note that vga16fb and vgacon use screen_info, through the ORIG_* macros
(defined in <linux/tty.h>), e.g.

#define ORIG_VIDEO_ISVGA        (screen_info.orig_video_isVGA)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 25 Jan 2002 09:44:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: arch/ppc/kernel/setup.c::screen_info
Message-ID: <20020125164406.GF745@cpe-24-221-152-185.az.sprintbbd.net>
References: <20020125162139.GE745@cpe-24-221-152-185.az.sprintbbd.net> <Pine.GSO.4.21.0201251727160.15996-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0201251727160.15996-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 25, 2002 at 05:28:21PM +0100, Geert Uytterhoeven wrote:
>
> On Fri, 25 Jan 2002, Tom Rini wrote:
> > On Fri, Jan 25, 2002 at 05:03:02PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 25 Jan 2002, Tom Rini wrote:
> > > > Hey all.  Currently in the linuxppc_2_4 tree, we conditionally compile
> > > > the screen_info struct on CONFIG_VGA_CONSOLE (and export the symbol
> > > > based on that too).  In linuxppc_2_4_devel, Geert checked in vga16fb
> > > > fixes 2 months ago or so that added tests for CONFIG_FB_VGA16{,_MODULE}.
> > > > And just recently Hollis Blanchard posted a patch to add vesafb to this
> > > > list as well.   So now the question is, shouldn't we just blindly
> > > > allocate this struct and always export the screen_info symbol?  This
> > > > makes the most sense IMHO, since the point of modules is that you can
> > > > add things on later without having to recompile.  But if people are
> > > > concerned about the extra space, perhaps we should do it based on
> > > > CONFIG_FB (I don't believe VGA_CONSOLE actually needs the symbol to be
> > > > exported, since it's a bool).   Comments?
> > >
> > > Note that vga16fb and vgacon use screen_info, through the ORIG_* macros
> > > (defined in <linux/tty.h>), e.g.
> > >
> > > #define ORIG_VIDEO_ISVGA        (screen_info.orig_video_isVGA)
> >
> > Right.  The problem is that exporting a module symbol based on CONFIG_
> > option is bad taste.  I'd rather not do it based on FB_VGA16_MODULE ||
> > FB_VESA_MODULE :)
>
> I'd really like to get rid of the screen_info. It's some kind of
> `residual data', filled in with values passed by the BIOS (on ia32).

Perhaps we can in 2.5 as part of the fb rewrite that's going on.  But I
don't think it's an option for 2.4, do you?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

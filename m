Date: Thu, 19 Jun 2003 10:02:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] 2.4.21 fixes
In-Reply-To: <16113.6008.29477.779178@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0306190956560.7953-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Jun 2003, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> >   - arch/ppc/kernel/ppc_ksyms.c, arch/ppc/kernel/setup.c: Define and export
> >     screen_info unconditionally, so vga16fb can be built as a module. An
> >     alternative is to make the definition dependent on CONFIG_FB_VGA16 ||
> >     CONFIG_FB_VGA16_MODULE, and the export on CONFIG_FB_VGA16_MODULE, but this
> >     is ugly.
> >
> >     Another reason is that screen_info is referenced in
> >     arch/ppc/platforms/prep_setup.c on the following (complex) condition:
> >
> >     #if defined(CONFIG_PREP_RESIDUAL) && \
> >         (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
> > 	         defined(CONFIG_FB_VESA))
> >
> >     which causes a link failure with the current code, too. The alternative
> >     #ifdef solution would clutter this even more...
>
> I think we could make this depend on CONFIG_FB.  I don't think we want

Don't forget it's also needed for CONFIG_VGA_CONSOLE.

> to make it depend on CONFIG_FB_VGA_16_MODULE since that would mean
> that you couldn't set CONFIG_FB_VGA_16=m and make a module that would
> work with an existing kernel that had been compiled with
> CONFIG_FB_VGA_16=n.  The screen_info structure is only 52 bytes so
> it's not that big a deal to have it always included if CONFIG_FB=y.

BTW, the only reason it's needed for vga16fb is the ORIG_VIDEO_ISVGA define.
Perhaps there's some way to kill that one? It's useless on machines without a
PC BIOS anyway. If we would hardcode all ORIG_VIDEO_* defines in <linux/tty.h>,
we can get rid of screen_info for both vga16fb and vgacon.

Then all that's left is screen_info.orig_video_isVGA in vesafb.c...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

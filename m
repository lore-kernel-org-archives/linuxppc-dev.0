Date: Sat, 25 Mar 2000 14:46:23 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Ani Joshi <ajoshi@shell.unixbox.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Found bug in mode switching but who is at fault...XFree86 or
 aty128fb.c?
In-Reply-To: <00032423100100.00584@localhost.localdomain>
Message-ID: <Pine.LNX.4.05.10003251444150.11322-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Kevin Hendricks wrote:
> Okay so I found the bug.  It seems all through the r128 driver, crtc.pitch
> values are set to the virtual x resolution  (vxres) / 8.  But in aty128fb.c in
> the var_to_crtc routine the crtc.pitch is set to be just the xres / 8.

Which is wrong: aty128fb must do `vxres * bpp / 8'.

> Who is wrong?  Should xfree shrink the vxres and vyres to match xres and yres
> before calling set_var or should aty128fb.c var_to_crtc routine be fixed to use
> vxres >> 3 instead of just xres >> 3?

XFree86 cannot change the visible resolution on the fly.

> What use is it to get a nice 832x624 hole into a display that is virtually
> 1152x870?!?  I can't get to any of the kde controls, panels, etc since they are
> off the screen!  And it would be a pain to have to pan around looking for them
> (especially since the ioctl for panning is on the "to do" list!).

Hence panning needs to be fixed :-) In fact panning is very simple, just change
the offset of the first pixel. That's a `one-register' update.

> So my feeling is that both are wrong.  We should shrink the virtual resolution
> to match the physical resolution in xfree when mode switching and put the patch
> in place in aty128fb.c

XFree86 cannot change the visible resolution on the fly, so we cannot change
it. Design bug in the whole X system :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 7 Oct 2000 19:56:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Samuel Rydh <samuel@ibrium.se>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: Video driver bug
In-Reply-To: <20001007133851.A994@ibrium.se>
Message-ID: <Pine.LNX.4.10.10010071939260.398-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 7 Oct 2000, Samuel Rydh wrote:
> Certain 2.4 video drivers (aty128, aty, platinum, tdfx, iga)
> appear to be buggy. More specifically, the problem is the
> following:
>
> In the set_disp function, info->dispsw is initialized and disp->dispsw
> is given the address of info->dispsw:
>
> 	static void aty128_set_disp(..)
> 	{
> 	  switch(bpp) {
> 	    case 8:
> 	        info->dispsw = accel ? fbcon_aty128_8 : fbcon_cfb8;
> 	        disp->dispsw = &info->dispsw;
> 	        break;
> 	   ...
> 	}
>
> The problem is that the info struct is shared by all virtual consoles.
> Thus if the video mode is set on a console which is not active, the
> active console will be affected too. This typically results in a kernel
> panic (the wrong set of console output functions is used).

You're right. *_set_disp() may be called for non-active VTs, changing
info->dispsw for the active VT.

> This problem is observable if one starts MOL from the console. MOL
> changes the video mode on an inactive console in order to extract
> certain video mode parameters (like rowbytes).
>
> One way to fix the bug is changing set_disp to the following:
>
> 	static void aty128_set_disp(..)
> 	{
> 	  switch(bpp) {
> 	    case 8:
> 	        disp->dispsw = accel ? &fbcon_aty128_8 : &fbcon_cfb8;
> 	        break;
> 	   ...
> 	}
>
> This is how the code used to look like (before 2.3.43-pre5).
> Does anyone know why this was changed?

The 2.3.44 patch shows that this line was added to struct fb_info_aty128:

+    struct display_switch dispsw;       /* for cursor and font */

While that comment isn't applicable to aty128fb, it is to atyfb (where it is
no longer present, probably it was removed in 2.1.x). When using a hardware
cursor, display_switch.{cursor,set_font} needs to be overridden, cfr.

            if (info->cursor) {
                info->dispsw.cursor = atyfb_cursor;
                info->dispsw.set_font = atyfb_set_font;
            }

in atyfb_set_disp().

I remember the original version changed the cursor and set_font fields of
disp->dispsw directly. Since this affected multiple ATI cards in your machine
(fbcon_aty* is shared), or even other video cards (disp->dispsw == fbcon_cfb*
if acceleration is disabled), I added the per-card copy of struct
display_switch to struct fb_info_aty.

Well, for aty128fb (which doesn't support a hardware cursor yet), the fix is
what you propose. However, for atyfb I see no simple solution, apart from
disabling the hardware cursor :-(

Any other takers?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 10 Oct 2000 15:45:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@suse.com>
cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.05.10010101003550.32152-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10010101541220.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 10 Oct 2000, Geert Uytterhoeven wrote:
> On Mon, 9 Oct 2000, James Simmons wrote:
> > > Well, for aty128fb (which doesn't support a hardware cursor yet), the fix is
> > > what you propose. However, for atyfb I see no simple solution, apart from
> > > disabling the hardware cursor :-(
> >
> > I have some ideas but it would requires some changes to the fbcon layer.
> > Also it would move palette handling from fbdev to the console layer.

That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
video mode.

> > Would these changes be included with the 2.4.0-testX kernels?
>
> I think we must do something in 2.4.0-testX, since you can abuse the bug to
> panic the box.

Does this fix the problem on atyfb? I'm not able to test it myself.

I renamed atyfb_set_disp() to atyfb_set_dispsw() as well, since it no longer
sets up the whole display struct, but only the dispsw part.

--- linux-2.4.0-test10-pre1/drivers/video/atyfb.c.orig	Sun Sep 17 20:04:17 2000
+++ linux-2.4.0-test10-pre1/drivers/video/atyfb.c	Tue Oct 10 15:40:45 2000
@@ -466,8 +466,8 @@
 static int encode_fix(struct fb_fix_screeninfo *fix,
 		      const struct atyfb_par *par,
 		      const struct fb_info_aty *info);
-static void atyfb_set_disp(struct display *disp, struct fb_info_aty *info,
-			   int bpp, int accel);
+static void atyfb_set_dispsw(struct display *disp, struct fb_info_aty *info,
+			     int bpp, int accel);
 static int atyfb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
 			 u_int *transp, struct fb_info *fb);
 static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
@@ -2826,8 +2826,8 @@
 }


-static void atyfb_set_disp(struct display *disp, struct fb_info_aty *info,
-			   int bpp, int accel)
+static void atyfb_set_dispsw(struct display *disp, struct fb_info_aty *info,
+			     int bpp, int accel)
 {
 	    switch (bpp) {
 #ifdef FBCON_HAS_CFB8
@@ -2914,7 +2914,6 @@
 	    display->can_soft_blank = 1;
 	    display->inverse = 0;
 	    accel = var->accel_flags & FB_ACCELF_TEXT;
-	    atyfb_set_disp(display, info, par.crtc.bpp, accel);
 	    if (accel)
 	    	display->scrollmode = (info->bus_type == PCI) ? SCROLL_YNOMOVE : 0;
 	    else
@@ -2923,8 +2922,10 @@
 		(*info->fb_info.changevar)(con);
 	}
 	if (!info->fb_info.display_fg ||
-	    info->fb_info.display_fg->vc_num == con)
+	    info->fb_info.display_fg->vc_num == con) {
 	    atyfb_set_par(&par, info);
+	    atyfb_set_dispsw(display, info, par.crtc.bpp, accel);
+	}
 	if (oldbpp != var->bits_per_pixel) {
 	    if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
 		return err;
@@ -4241,8 +4242,8 @@

     atyfb_decode_var(&fb_display[con].var, &par, info);
     atyfb_set_par(&par, info);
-    atyfb_set_disp(&fb_display[con], info, par.crtc.bpp,
-		   par.accel_flags & FB_ACCELF_TEXT);
+    atyfb_set_dispsw(&fb_display[con], info, par.crtc.bpp,
+		     par.accel_flags & FB_ACCELF_TEXT);

     /* Install new colormap */
     do_install_cmap(con, fb);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Found bug in mode switching but who is at fault...XFree86 or aty128fb.c?
Date: Fri, 24 Mar 2000 22:54:51 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com> <00032313263100.01328@localhost.localdomain>
In-Reply-To: <00032313263100.01328@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <00032423100100.00584@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I figured since the fbdev driver showed the same problem as the r128 driver,
that the mode switching problem must be in either aty128fb.c or xfree86 but not
in the r128 driver.

Okay so I found the bug.  It seems all through the r128 driver, crtc.pitch
values are set to the virtual x resolution  (vxres) / 8.  But in aty128fb.c in
the var_to_crtc routine the crtc.pitch is set to be just the xres / 8.

This is not a problem if xres == vxres.  Which is what happens when the
aty128fb.c starts up.  So for any one mode it defaults to being okay.

However, when doing mode switching via the Cntl-Alt-Keypad+- keys, xfree sets
vxres and vyres to be the same as the resolution of the largest mode  on that
line (so 1152x870 becomes my vxres, and vyres when 1152x870, 832x624, 1024x768
are all specified on the same line.

This results in a call to aty128fb_set-var which calls decode_var which calls
var_to_crtc. which gets the crtc.pitch wrong.

So my questions is as follows?

Who is wrong?  Should xfree shrink the vxres and vyres to match xres and yres
before calling set_var or should aty128fb.c var_to_crtc routine be fixed to use
vxres >> 3 instead of just xres >> 3?

If aty128fb.c needs to be fixed, here is a patch:

--- aty128fb.c.last	Sat Mar 18 23:04:24 2000
+++ aty128fb.c	Fri Mar 24 22:39:26 2000
@@ -794,8 +794,11 @@
     crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid << 16) |
                 (v_sync_pol << 23);

+#if 0
     crtc->pitch = xres >> 3;
-
+#else
+    crtc->pitch = vxres >> 3;
+#endif
     crtc->offset = 0;
     crtc->offset_cntl = 0;


But I am not sure if this makes sense alone.

What use is it to get a nice 832x624 hole into a display that is virtually
1152x870?!?  I can't get to any of the kde controls, panels, etc since they are
off the screen!  And it would be a pain to have to pan around looking for them
(especially since the ioctl for panning is on the "to do" list!).

So my feeling is that both are wrong.  We should shrink the virtual resolution
to match the physical resolution in xfree when mode switching and put the patch
in place in aty128fb.c

Comments?

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

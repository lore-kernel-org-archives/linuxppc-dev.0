Date: Tue, 17 Aug 1999 19:53:26 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Bugs in xfree68 that made it fail with jdk 1.2.1 found and fixed
 (fwd)
Message-ID: <Pine.LNX.4.10.9908171952200.30397-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anybody who'd care to try? I just erased my XFree86 3.3.x tree.

BTW, I'm always willing to test a glibc-2.1 binary :-)

---------- Forwarded message ----------
Date: Tue, 17 Aug 1999 13:37:56 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Bugs in xfree68 that made it fail with jdk 1.2.1 found and fixed

Hi Geert,

Kostas Gewrgiou recently sent me a patch for xfree68 fbdev.c that fixes the
problems it was having with jdk 1.2 and swing.  The problem was that the bits
per pixel was being set to the depth for all cases.  This freaked things out if
the depth was set to 15.   

 Here is his patch:

--- xc/programs/Xserver/hw/xfree68/fbdev/fbdev.c-orij    Mon Aug 16 21:43:23 1999
+++ xc/programs/Xserver/hw/xfree68/fbdev/fbdev.c         Mon Aug 16 21:34:14 1999
@@ -648,7 +648,15 @@
                    fbdevInfoRec.name);
         UseModeDB = TRUE;
         pEnd = NULL;
-        fbdevInfoRec.bitsPerPixel = fbdevInfoRec.depth;
+/* XXX KST 
+ lame fix for now, i'll figure it out in the morning...
+*/
+        if( fbdevInfoRec.depth == 15 && fb_fix.type == FB_TYPE_PACKED_PIXELS) {
+                fbdevInfoRec.bitsPerPixel = 16;
+        } else {
+                fbdevInfoRec.bitsPerPixel = fbdevInfoRec.depth;
+        }
+
         do {
              DisplayModePtr pModeSv;
 
@@ -1071,7 +1079,8 @@
                 width = fb_fix.line_length ? 8*fb_fix.line_length/bpp : xsize;
 #if defined(CONFIG_CFB16) || defined(CONFIG_CFB24) || defined(CONFIG_CFB32)
 ErrorF("bpp = %d, depth = %d, BitsPerRGB = %d\n", bpp, depth, BitsPerRGB);
-#if 0
+/* XXX KST */
+#if 1
                 if (!cfbSetVisualTypes(depth, Visuals, BitsPerRGB))
 #else
                 if (!cfbSetVisualTypes(bpp, Visuals, BitsPerRGB))
@@ -1092,6 +1101,7 @@
 
 #ifdef CONFIG_CFB16
                      case 16:
+                      
                         fbtype = "cfb16";
                         if (!cfb16ScreenInit(pScreen, fbdevVirtBase, xsize, 
                                         ysize, dxres, dyres, width))


I have modified this patch to set the proper bits per pixel (32) for 24 bit
depths.  I have also removed the tranparent mask length from the depth
calculation since alpha info is not being processed by the fb server.

With these changes in place (and with XF86Config files settting depth to 15 and
24 respectively) now the xfree68 fbserver is using 15 bit depth with 16 bpp
and 555 masks; and 24 bit depths with 32 bits per pixel and 888 masks.

Since everything is now consistent, the jdk 1.2 java 2d color model works fine.

My plan is to release a patch and a new XF68_FBDev binary on the jdk 1.2 site
for users to download and install if they wish. (along with directions for
fixing XF86Config).

Is there any way, we can get these changes (or better
constructed ones) into the real tree?

Any help here would be greatly appreciated.

Thanks,

Kevin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

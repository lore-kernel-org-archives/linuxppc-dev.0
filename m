Message-ID: <39A12B3E.44294E59@student.ethz.ch>
Date: Mon, 21 Aug 2000 15:14:38 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.10.10008211241460.371-100000@cassiopeia.home>
Content-Type: multipart/mixed;
 boundary="------------B3A3837FB0ED4D259A04D996"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B3A3837FB0ED4D259A04D996
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Geert Uytterhoeven wrote:
>
> On Mon, 21 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> > That's not even needed, the fbdev driver is just broken. Line 430:
> >
> >       pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
> >
> > is indeed wrong. virtualX is obvious, but displayWidth should be the
> > memory pitch of a scanline.
> >
> > Now you just have to find out where to get the correct value for
> > displayWidth.
>
> I suppose
>
>     if (fix.line_length)
>         pScrn->displayWidth = fix.line_length*8/var.bits_per_pixel;
>     else
>         pScrn->displayWidth = var.xres_virtual;
>
> should work fine, except on hardware were
> fix.line_length*8/var.bits_per_pixel might not be integer (e.g. if
> 1280x1024x24 mode requires a line_length of 4096).

I've thought of this as well. The problem is that the mode hasn't been
initialized when displayWidth is set and used.

The best I can think of ATM is the attached patch. This should make it work
with ShadowFB, which is on by default anyway.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project
--------------B3A3837FB0ED4D259A04D996
Content-Type: text/plain; charset=us-ascii;
 name="fbdev.diff"
Content-Disposition: inline;
 filename="fbdev.diff"
Content-Transfer-Encoding: 7bit

diff -ru ../xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.c xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.c
--- ../xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.c	Mon Jul  3 09:04:53 2000
+++ xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.c	Mon Aug 21 12:01:10 2000
@@ -419,6 +419,13 @@
 }

 int
+fbdevHWGetLineLength(ScrnInfoPtr pScrn)
+{
+	fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);
+	return fPtr->fix.line_length;
+}
+
+int
 fbdevHWGetType(ScrnInfoPtr pScrn)
 {
 	fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);
diff -ru ../xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.h xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.h
--- ../xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.h	Sun May 28 01:32:00 2000
+++ xc/programs/Xserver/hw/xfree86/fbdevhw/fbdevhw.h	Mon Aug 21 11:57:01 2000
@@ -14,6 +14,7 @@

 char* fbdevHWGetName(ScrnInfoPtr pScrn);
 int   fbdevHWGetDepth(ScrnInfoPtr pScrn);
+int   fbdevHWGetLineLength(ScrnInfoPtr pScrn);
 int   fbdevHWGetType(ScrnInfoPtr pScrn);
 int   fbdevHWGetVidmem(ScrnInfoPtr pScrn);

diff -ru ../xc/programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c xc/programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c
--- ../xc/programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c	Sun Jun 18 16:23:22 2000
+++ xc/programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c	Mon Aug 21 14:36:29 2000
@@ -138,6 +138,7 @@

 	"fbdevHWGetName",
 	"fbdevHWGetDepth",
+	"fbdevHWGetLineLength",
 	"fbdevHWGetVidmem",

 	/* colormap */
@@ -426,7 +427,14 @@
 	if (NULL == pScrn->modes)
 		fbdevHWUseBuildinMode(pScrn);
 	pScrn->currentMode = pScrn->modes;
-	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
+
+	if (fPtr->shadowFB)
+		pScrn->displayWidth = pScrn->virtualX;	/* ShadowFB handles this correctly */
+	else
+		/* FIXME: this doesn't work for all cases, e.g. when each scanline
+			has a padding which is independent from the depth (controlfb) */
+		pScrn->displayWidth = fbdevHWGetLineLength(pScrn)/(fbdevHWGetDepth(pScrn) >> 3);
+
 	xf86PrintModes(pScrn);

 	/* Set display resolution */
@@ -512,7 +520,7 @@
 	unsigned char *src, *dst;

 	Bpp = pScrn->bitsPerPixel >> 3;
-	FBPitch = pScrn->displayWidth * Bpp;
+	FBPitch = fbdevHWGetLineLength(pScrn);

 	while(num--) {
 		width = (pbox->x2 - pbox->x1) * Bpp;

--------------B3A3837FB0ED4D259A04D996--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

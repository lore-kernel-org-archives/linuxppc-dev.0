Message-Id: <200108261500.RAA02766@piglet.grunz.lu>
Date: Sun, 26 Aug 2001 17:00:38 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Call for help: altivec-enabled vlc
To: linuxppc-dev@lists.linuxppc.org
Cc: debian-powerpc@lists.debian.org
In-Reply-To: <200108261457.QAA02711@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-998838045=:2709"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-998838045=:2709
Content-Type: TEXT/plain; charset=us-ascii

Duh....

Forgot to actually attach the patch. Damn...

On  26 Aug, this message from To: linuxppc-dev@lists.linuxppc.org echoed through cyberspace:
> I've sat down a bit ;-) and came up with an Altivec-optimised IDCT
> implementation in vlc (well, I integrated Motorla's Altivec IDCT).
>
> This is in fact the same code that already exists in vlc for MacOS X,
> but it uses the Motorola-published assembler code (you can find it on
> their site).

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-998838045=:2709
Content-Type: TEXT/plain; name="vlc-altivec.diff"
Content-Disposition: attachment; filename="vlc-altivec.diff"

diff -uNr vlc-0.2.82/Makefile vlc-0.2.82-altivec/Makefile
--- vlc-0.2.82/Makefile	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/Makefile	Sun Aug 26 10:04:20 2001
@@ -18,7 +18,7 @@
 #
 # All possible plugin objects
 #
-PLUGINS_TARGETS := alsa/alsa beos/beos darwin/darwin directx/directx dsp/dsp dummy/dummy dummy/null dvd/dvd esd/esd fb/fb ggi/ggi glide/glide gtk/gnome gtk/gtk downmix/downmix downmix/downmixsse downmix/downmix3dn idct/idct idct/idctclassic idct/idctmmx idct/idctmmxext imdct/imdct imdct/imdct3dn imdct/imdctsse kde/kde macosx/macosx mga/mga motion/motion motion/motionmmx motion/motionmmxext mpeg/es mpeg/ps mpeg/ts qt/qt sdl/sdl text/ncurses text/rc x11/x11 x11/xvideo yuv/yuv yuv/yuvmmx
+PLUGINS_TARGETS := alsa/alsa beos/beos darwin/darwin directx/directx dsp/dsp dummy/dummy dummy/null dvd/dvd esd/esd fb/fb ggi/ggi glide/glide gtk/gnome gtk/gtk downmix/downmix downmix/downmixsse downmix/downmix3dn idct/idct idct/idctclassic idct/idctmmx idct/idctmmxext idct/idctaltivec imdct/imdct imdct/imdct3dn imdct/imdctsse kde/kde macosx/macosx mga/mga motion/motion motion/motionmmx motion/motionmmxext mpeg/es mpeg/ps mpeg/ts qt/qt sdl/sdl text/ncurses text/rc x11/x11 x11/xvideo yuv/yuv yuv/yuvmmx

 #
 # C Objects
diff -uNr vlc-0.2.82/Makefile.opts.in vlc-0.2.82-altivec/Makefile.opts.in
--- vlc-0.2.82/Makefile.opts.in	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/Makefile.opts.in	Sun Aug 26 15:12:53 2001
@@ -45,7 +45,7 @@
 # Build environment
 #
 CC = @CC@
-CFLAGS = @CFLAGS@
+CFLAGS = -Wa,-m7400 @CFLAGS@
 SHELL = @SHELL@
 RANLIB = @RANLIB@
 WINDRES = @WINDRES@
diff -uNr vlc-0.2.82/configure vlc-0.2.82-altivec/configure
--- vlc-0.2.82/configure	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/configure	Sun Aug 26 10:06:10 2001
@@ -3675,7 +3675,8 @@
   enableval="$enable_altivec"
    if test x$enableval = xyes; then ARCH="${ARCH} altivec"
     BUILTINS="${BUILTINS} idctaltivec"
-    LIB_IDCTALTIVEC="-framework vecLib"
+#    LIB_IDCTALTIVEC="-framework vecLib"
+    LIB_IDCTALTIVEC=""
   fi
 fi

diff -uNr vlc-0.2.82/plugins/idct/idctaltivec.c vlc-0.2.82-altivec/plugins/idct/idctaltivec.c
--- vlc-0.2.82/plugins/idct/idctaltivec.c	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/plugins/idct/idctaltivec.c	Sun Aug 26 16:18:39 2001
@@ -47,7 +47,9 @@
 #include "vdec_block.h"
 #include "vdec_idct.h"

-#include "idctaltivec.h"
+//#include "idctaltivec.h"
+//extern void IDCT(short *input, short *output);
+#include "idctaltivecasm.h"

 #include "modules_export.h"

@@ -115,7 +117,8 @@
     }

     /* The Altivec iDCT is deactivated until it really works */
-    return( 0 /* 200 */ );
+    //return( 0 /* 200 */ );
+    return( 200 );
 }

 /*****************************************************************************
@@ -130,6 +133,8 @@
  *****************************************************************************/
 void _M( vdec_IDCT )( void * p_idct_data, dctelem_t * p_block, int i_idontcare )
 {
+//	fprintf(stderr, "p_block alignment: 0x%p\n", p_block);
     IDCT( p_block, p_block );
+//     fprintf(stderr, "p_block alignment: 0x%p\n", p_block);
 }

diff -uNr vlc-0.2.82/plugins/idct/idctaltivecasm.h vlc-0.2.82-altivec/plugins/idct/idctaltivecasm.h
--- vlc-0.2.82/plugins/idct/idctaltivecasm.h	Thu Jan  1 01:00:00 1970
+++ vlc-0.2.82-altivec/plugins/idct/idctaltivecasm.h	Sun Aug 26 16:18:54 2001
@@ -0,0 +1,190 @@
+// IDCT ASM function from Motorola
+
+/***************************************************************
+ *
+ * Copyright:   (c) Copyright Motorola Inc. 1998
+ *
+ * Date:        April 17, 1998
+ *
+ * Function:    IDCT
+ *
+ * Description: Scaled Chen (III) algorithm for IDCT
+ *              Arithmetic is 16-bit fixed point.
+ *
+ * Inputs:      input - Pointer to input data (short), which
+ *                      must be between -2048 to +2047.
+ *                      It is assumed that the allocated array
+ *                      has been 128-bit aligned and contains
+ *                      8x8 short elements.
+ *
+ * Outputs:     output - Pointer to output area for the transfored
+ *                       data. The output values are between -255
+ *                       and 255 . It is assumed that a 128-bit
+ *                       aligned 8x8 array of short has been
+ *                       pre-allocated.
+ *
+ * Return:      None
+ *
+ ***************************************************************/
+
+signed short SpecialConstants[8] __attribute__ ((aligned (16))) = {
+			23170, 13573, 6518, 21895, -23170, -21895, 0, 0 };
+
+signed short PreScale[64] __attribute__ ((aligned (16))) = {
+			4095, 5681, 5351, 4816, 4095, 4816, 5351, 5681,
+			5681, 7880, 7422, 6680, 5681, 6680, 7422, 7880,
+			5351, 7422, 6992, 6292, 5351, 6292, 6992, 7422,
+			4816, 6680, 6292, 5663, 4816, 5663, 6292, 6680,
+			4095, 5681, 5351, 4816, 4095, 4816, 5351, 5681,
+			4816, 6680, 6292, 5663, 4816, 5663, 6292, 6680,
+			5351, 7422, 6992, 6292, 5351, 6292, 6992, 7422,
+			5681, 7880, 7422, 6680, 5681, 6680, 7422, 7880 };
+
+static __inline__ void IDCT(short *input, short *output) {
+
+
+	void * sc;
+	void * ps;
+
+//	fprintf(stderr, "Addresses: %p, %p, %p, %p\n", SpecialConstants,
+//			&SpecialConstants[0], PreScale, &PreScale[0]);
+	asm ( "
+		lwz     12,0(%5)
+		addi    11,0,16
+		lwz     10,0(%4)
+		mr      %0,10
+		mr      %1,12
+		addi    9,0,32
+		lvx     0,%3,11
+		addi    7,0,48
+		lvx     1,12,11
+		vspltisw        2,0
+		lvx     3,0,10
+		addi    10,0,80
+		lvx     4,%3,9
+		vmhraddshs      5,0,1,2
+		lvx     6,12,9
+		addi    6,0,112
+		lvx     7,%3,7
+		vsplth  8,3,0x2
+		lvx     9,12,7
+		vmhraddshs      10,4,6,2
+		lvx     11,%3,10
+		vsplth  12,3,0x1
+		lvx     13,12,10
+		vsplth  14,3,0x3
+		lvx     15,%3,6
+		vmhraddshs      16,7,9,2
+		lvx     17,0,%3
+		vsplth  18,3,0x5
+		lvx     19,12,6
+		addi    5,0,64
+		lvx     1,0,12
+		vmhraddshs      0,11,13,2
+		addi    8,0,96
+		lvx     6,%3,5
+		lvx     4,12,5
+		vmhraddshs      9,15,19,2
+		vmhraddshs      7,17,1,2
+		lvx     13,%3,8
+		lvx     11,12,8
+		vmhraddshs      19,6,4,2
+		vmhraddshs      15,8,5,2
+		vsplth  1,3,0x0
+		vmhraddshs      17,13,11,2
+		vsplth  4,3,0x4
+		vmhraddshs      6,8,9,5
+		vmhraddshs      11,14,0,16
+		vmhraddshs      13,18,16,0
+		vmhraddshs      3,12,10,2
+		vsubshs 5,15,9
+		vsubshs 0,7,19
+		vsubshs 16,3,17
+		vmhraddshs      15,12,17,10
+		vsubshs 9,5,13
+		vsubshs 3,6,11
+		vaddshs 17,7,19
+		vaddshs 10,0,16
+		vsubshs 19,0,16
+		vsubshs 7,3,9
+		vaddshs 16,3,9
+		vaddshs 0,5,13
+		vmhraddshs      3,1,16,10
+		vaddshs 9,6,11
+		vmhraddshs      5,4,16,10
+		vaddshs 13,17,15
+		vmhraddshs      11,1,7,19
+		vsubshs 6,17,15
+		vmhraddshs      16,4,7,19
+		vaddshs 10,13,9
+		vmrghh  17,11,5
+		vsubshs 15,13,9
+		vmrglh  7,11,5
+		vaddshs 19,6,0
+		vmrghh  13,3,16
+		vsubshs 9,6,0
+		vmrghh  11,19,15
+		vmrghh  5,10,9
+		vmrglh  6,10,9
+		vmrglh  0,3,16
+		vmrglh  9,19,15
+		vmrghh  10,5,17
+		vmrghh  16,13,11
+		vmrglh  3,5,17
+		vmrghh  19,6,7
+		vmrglh  15,6,7
+		vmrglh  5,13,11
+		vmrghh  17,0,9
+		vmrglh  6,0,9
+		vmrglh  7,10,16
+		vmrghh  11,3,5
+		vmhraddshs      13,8,7,2
+		vmrglh  9,3,5
+		vmhraddshs      0,12,11,2
+		vmrglh  5,19,17
+		vmrglh  3,15,6
+		vmhraddshs      2,14,5,9
+		vmhraddshs      14,8,3,7
+		vmrghh  7,10,16
+		vmhraddshs      8,18,9,5
+		vmrghh  16,19,17
+		vmrghh  10,15,6
+		vsubshs 5,13,3
+		vsubshs 9,7,16
+		vsubshs 18,0,10
+		vmhraddshs      17,12,10,11
+		vsubshs 19,5,8
+		vsubshs 6,14,2
+		vaddshs 15,7,16
+		vaddshs 3,9,18
+		vsubshs 13,9,18
+		vsubshs 0,6,19
+		vaddshs 10,6,19
+		vaddshs 11,5,8
+		vmhraddshs	12,1,10,3
+		vaddshs		16,14,2
+		vmhraddshs	7,4,10,3
+		vaddshs		18,15,17
+		vmhraddshs	9,1,0,13
+		vsubshs		6,15,17
+		vmhraddshs	19,4,0,13
+		vaddshs		5,18,16
+		stvx		5,0,%2
+		vsubshs		8,18,16
+		stvx		12,%2,11
+		vaddshs		14,6,11
+		stvx		9,%2,9
+		vsubshs		2,6,11
+		stvx	14,%2,7
+		stvx	2,%2,5
+		stvx	19,%2,10
+		stvx	7,%2,8
+		stvx	8,%2,6
+		"
+		: "=r" (sc), "=r" (ps)
+		: "r" (output), "r" (input), "r" (SpecialConstants), "r" (PreScale)
+		: "cc", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12" );
+	/* End asm */
+
+//	fprintf(stderr, "Addresses now: %p, %p\n", sc, ps);
+}
diff -uNr vlc-0.2.82/src/interface/main.c vlc-0.2.82-altivec/src/interface/main.c
--- vlc-0.2.82/src/interface/main.c	Tue Aug  7 12:55:48 2001
+++ vlc-0.2.82-altivec/src/interface/main.c	Sun Aug 26 13:26:16 2001
@@ -1031,6 +1031,7 @@
 {
     volatile int i_capabilities = CPU_CAPABILITY_NONE;

+        i_capabilities |= CPU_CAPABILITY_ALTIVEC;
 #if defined( SYS_BEOS )
     i_capabilities |= CPU_CAPABILITY_486
                       | CPU_CAPABILITY_586

--134458388-1804289383-998838045=:2709--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

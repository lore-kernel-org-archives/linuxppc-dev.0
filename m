Message-Id: <200108302046.WAA00891@piglet.grunz.lu>
Date: Thu, 30 Aug 2001 22:46:42 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Call for help: altivec-enabled vlc
To: linuxppc-dev@lists.linuxppc.org
Cc: debian-powerpc@lists.debian.org
In-Reply-To: <200108261457.QAA02711@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-999204484=:869"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-999204484=:869
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

> I've sat down a bit ;-) and came up with an Altivec-optimised IDCT
> implementation in vlc (well, I integrated Motorla's Altivec IDCT).

New release: this time it actually works ;-)

> This is in fact the same code that already exists in vlc for MacOS X,
> but it uses the Motorola-published assembler code (you can find it on
> their site).

... plus the final matrix transpose which they forgot :-)

I'll be on holiday for a week; I figured I'd send this off since it is
in a working state ;-) Diff should apply to both 0.2.82 and 0.2.83.

Have fun!

Michel

PS this is not Paul's IDCT, which I plan on integrating later on and
compare performance and accuracy against Motorola's.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-999204484=:869
Content-Type: TEXT/plain; name="vlc-altivec.diff"
Content-Disposition: attachment; filename="vlc-altivec.diff"

diff -ur vlc-0.2.82/Makefile vlc-0.2.82-altivec/Makefile
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
diff -ur vlc-0.2.82/Makefile.opts.in vlc-0.2.82-altivec/Makefile.opts.in
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
diff -ur vlc-0.2.82/configure vlc-0.2.82-altivec/configure
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

diff -ur vlc-0.2.82/include/vdec_ext-plugins.h vlc-0.2.82-altivec/include/vdec_ext-plugins.h
--- vlc-0.2.82/include/vdec_ext-plugins.h	Tue Aug  7 12:55:48 2001
+++ vlc-0.2.82-altivec/include/vdec_ext-plugins.h	Tue Aug 28 21:05:03 2001
@@ -103,6 +103,7 @@

     /* IDCT iformations */
     void *              p_idct_data;
+    void *              p_idct_data_raw;

     /* Input properties */
     struct vdec_pool_s * p_pool;
diff -ur vlc-0.2.82/plugins/idct/idctaltivec.c vlc-0.2.82-altivec/plugins/idct/idctaltivec.c
--- vlc-0.2.82/plugins/idct/idctaltivec.c	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/plugins/idct/idctaltivec.c	Tue Aug 28 00:32:21 2001
@@ -23,6 +23,8 @@

 #define MODULE_NAME idctaltivec

+#undef DEBUG
+
 /*****************************************************************************
  * Preamble
  *****************************************************************************/
@@ -47,10 +49,14 @@
 #include "vdec_block.h"
 #include "vdec_idct.h"

-#include "idctaltivec.h"
+//#include "idctaltivec.h"
+//extern void IDCT(short *input, short *output);
+#include "idctaltivecasm.h"

 #include "modules_export.h"

+#include "testdata.h"
+//int dummy, dummy2;
 /*****************************************************************************
  * Local prototypes.
  *****************************************************************************/
@@ -115,7 +121,8 @@
     }

     /* The Altivec iDCT is deactivated until it really works */
-    return( 0 /* 200 */ );
+    //return( 0 /* 200 */ );
+    return( 200 );
 }

 /*****************************************************************************
@@ -130,6 +137,25 @@
  *****************************************************************************/
 void _M( vdec_IDCT )( void * p_idct_data, dctelem_t * p_block, int i_idontcare )
 {
+#ifdef DEBUG
+	int i;
+
+       for(i=0; i<64;i++)
+           *(p_block+i)=testdata[i];
+
+	fprintf(stderr, "p_block alignment: 0x%p\n", p_block);
+	fprintf(stderr, "p_block before IDCT: 0x%04hx 0x%04hx 0x%04hx 0x%04hx 0x%04hx 0x%04hx 0x%04hx 0x%04hx\n", *p_block, *(p_block+1), *(p_block+2), *(p_block+3), *(p_block+4), *(p_block+5), *(p_block+6), *(p_block+7));
+#endif
+
     IDCT( p_block, p_block );
+
+#ifdef DEBUG
+   fprintf(stderr, "p_block after IDCT:\n");
+    for (i=0;i<8;i++) {
+        dctelem_t *p=p_block+(i*8);
+        fprintf(stderr, " % 5hi % 5hi % 5hi % 5hi % 5hi % 5hi % 5hi % 5hi\n", *p, *(p+1), *(p+2), *(p+3), *(p+4), *(p+5), *(p+6), *(p+7));
+    }
+   exit(0);
+#endif
 }

diff -ur vlc-0.2.82/plugins/idct/vdec_idct.c vlc-0.2.82-altivec/plugins/idct/vdec_idct.c
--- vlc-0.2.82/plugins/idct/vdec_idct.c	Tue Aug  7 12:55:49 2001
+++ vlc-0.2.82-altivec/plugins/idct/vdec_idct.c	Tue Aug 28 21:27:23 2001
@@ -57,7 +57,14 @@
     int i;
     dctelem_t * p_pre;

-    p_vdec->p_idct_data = malloc( sizeof(dctelem_t) * 64 * 64 );
+    /* the IDCT data buffer needs to meet certain alignment constraints
+     * (currently 16 bytes for Altivec vector ops)
+     */
+#define align 16
+
+    p_vdec->p_idct_data_raw = malloc( sizeof(dctelem_t) * 64 * 64 + align );
+    p_vdec->p_idct_data =
+	    (void *)(((unsigned long)p_vdec->p_idct_data_raw + align - 1) & -align);
     p_pre = (dctelem_t *) p_vdec->p_idct_data;
     memset( p_pre, 0, 64 * 64 * sizeof(dctelem_t) );

diff -ur vlc-0.2.82/src/interface/main.c vlc-0.2.82-altivec/src/interface/main.c
--- vlc-0.2.82/src/interface/main.c	Tue Aug  7 12:55:48 2001
+++ vlc-0.2.82-altivec/src/interface/main.c	Sun Aug 26 13:26:16 2001
@@ -1031,6 +1031,7 @@
 {
     volatile int i_capabilities = CPU_CAPABILITY_NONE;

+        i_capabilities |= CPU_CAPABILITY_ALTIVEC;
 #if defined( SYS_BEOS )
     i_capabilities |= CPU_CAPABILITY_486
                       | CPU_CAPABILITY_586
diff -ur vlc-0.2.82/src/video_decoder/video_decoder.c vlc-0.2.82-altivec/src/video_decoder/video_decoder.c
--- vlc-0.2.82/src/video_decoder/video_decoder.c	Tue Aug  7 12:55:48 2001
+++ vlc-0.2.82-altivec/src/video_decoder/video_decoder.c	Tue Aug 28 21:08:38 2001
@@ -166,9 +166,9 @@
 {
     intf_DbgMsg("vdec debug: EndThread(%p)", p_vdec);

-    if( p_vdec->p_idct_data != NULL )
+    if( p_vdec->p_idct_data_raw != NULL )
     {
-        free( p_vdec->p_idct_data );
+        free( p_vdec->p_idct_data_raw );
     }

     free( p_vdec );
diff -uNr vlc-0.2.82/plugins/idct/idctaltivecasm.h vlc-0.2.82-altivec/plugins/idct/idctaltivecasm.h
--- vlc-0.2.82/plugins/idct/idctaltivecasm.h	Thu Jan  1 01:00:00 1970
+++ vlc-0.2.82-altivec/plugins/idct/idctaltivecasm.h	Tue Aug 28 00:00:07 2001
@@ -0,0 +1,211 @@
+/* IDCT ASM function from Motorola
+ *
+ * The original Motorola implementation lacks a matrix transpose
+ * operation on the result. Duh...
+ */
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
+//	fprintf(stderr, "Input: %p, Addresses: %p, %p\n", input,
+//			&SpecialConstants[0], &PreScale[0]);
+
+	asm volatile ( "
+		addi    11,0,16
+		addi    9,0,32
+		lvx     0,%1,11
+		addi    7,0,48
+		lvx     1,%3,11
+		vspltisw        2,0
+		lvx     3,0,%2
+		addi    10,0,80
+		lvx     4,%1,9
+		vmhraddshs      5,0,1,2
+		lvx     6,%3,9
+		addi    6,0,112
+		lvx     7,%1,7
+		vsplth  8,3,0x2
+		lvx     9,%3,7
+		vmhraddshs      10,4,6,2
+		lvx     11,%1,10
+		vsplth  12,3,0x1
+		lvx     13,%3,10
+		vsplth  14,3,0x3
+		lvx     15,%1,6
+		vmhraddshs      16,7,9,2
+		lvx     17,0,%1
+		vsplth  18,3,0x5
+		lvx     19,%3,6
+		addi    5,0,64
+		lvx     1,0,%3
+		vmhraddshs      0,11,13,2
+		addi    8,0,96
+		lvx     6,%1,5
+		lvx     4,%3,5
+		vmhraddshs      9,15,19,2
+		vmhraddshs      7,17,1,2
+		lvx     13,%1,8
+		lvx     11,%3,8
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
+		vsubshs		8,18,16
+		vaddshs		14,6,11
+		vsubshs		2,6,11
+		vmrghh		0,5,2
+		vmrglh		1,5,2
+		vmrghh		3,12,19
+		vmrglh		4,12,19
+		vmrghh		10,9,7
+		vmrglh		13,9,7
+		vmrghh		15,14,8
+		vmrglh		17,14,8
+		vmrghh		5,0,10
+		vmrglh		12,0,10
+		vmrghh		9,1,13
+		vmrglh		14,1,13
+		vmrghh		2,3,15
+		vmrglh		19,3,15
+		vmrghh		7,4,17
+		vmrglh		8,4,17
+		vmrghh		0,5,2
+		vmrglh		1,5,2
+		stvx		0,0,%0
+		vmrghh		3,12,19
+		stvx		1,%0,11
+		vmrglh		4,12,19
+		stvx		3,%0,9
+		vmrghh		10,9,7
+		stvx		4,%0,7
+		vmrglh		13,9,7
+		stvx		10,%0,5
+		vmrghh		15,14,8
+		stvx		13,%0,10
+		vmrglh		17,14,8
+		stvx		15,%0,8
+		stvx		17,%0,6
+		"
+		:
+		: "r" (output), "r" (input), "r" (SpecialConstants), "r" (PreScale)
+		: "cc", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "memory" );
+	/* End asm */
+
+}
diff -uNr vlc-0.2.82/plugins/idct/testdata.h vlc-0.2.82-altivec/plugins/idct/testdata.h
--- vlc-0.2.82/plugins/idct/testdata.h	Thu Jan  1 01:00:00 1970
+++ vlc-0.2.82-altivec/plugins/idct/testdata.h	Mon Aug 27 22:01:57 2001
@@ -0,0 +1,12 @@
+/* Testdata for IDCT */
+
+dctelem_t testdata[] = {
+   131,     0,     0,   131,   -51,     0,     0,     0,
+     0,   -51,     0,     0,     0,     0,     0,     0,
+     0,     0,     0,   -51,     0,     0,     0,     0,
+     0,     0,   101,     0,     0,     0,     0,     0,
+     0,     0,     0,     0,     0,   -51,     0,     0,
+     0,     0,     0,     0,   101,     0,     0,     0,
+     0,     0,     0,     0,     0,     0,     0,     0,
+     0,     0,     0,   101,     0,     0,     0,   101 };
+

--134458388-1804289383-999204484=:869--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

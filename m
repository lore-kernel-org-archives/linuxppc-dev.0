Return-Path: <iluri@fagorautomation.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id 3C42267B40
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 May 2006 22:36:54 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id 453C737430
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 May 2006 14:03:47 +0200 (CEST)
Message-ID: <44574B08.9020105@fagorautomation.es>
Date: Tue, 02 May 2006 14:05:28 +0200
From: Igor Luri <iluri@fagorautomation.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add  Fujitsu CoralP 8 bits per pixel support
Content-Type: multipart/mixed; boundary="------------000106060206000100060802"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000106060206000100060802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Denx linux kernel 2.4.25 Fujitsu CoralP driver is configured with 16 
bits per pixel color depth. This patch adds support to configure it with 
8 bits per pixel.

Best regards.


--------------000106060206000100060802
Content-Type: text/x-patch;
 name="coralp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coralp.patch"

--- kernel_backup/drivers/video/Config.in	2005-10-04 09:45:39.000000000 +0200
+++ kernel/drivers/video/Config.in	2006-04-25 14:26:42.000000000 +0200
@@ -11,6 +11,16 @@
    define_bool CONFIG_DUMMY_CONSOLE y
    bool '  Silicon Motion VOYAGER support (on TQM5200)' CONFIG_FB_VOYAGER
    bool '  Fujitsu CoralP support' CONFIG_FB_MB86290
+   if [ "$CONFIG_FB_MB86290" = "y" ]; then
+   	choice 'Bits per pixel'	\
+          "8		CONFIG_MB86290FB_8BPP \
+           16		CONFIG_MB86290FB_16BPP"   16  
+   	if [ "$CONFIG_INKA4X0" = "n" ]; then
+   		choice 'Screen resolution'	\
+		"1024x768	CONFIG_MB86290FB_RES_1024x768 \
+		640x480	CONFIG_MB86290FB_RES_640x480"   1024x768
+	fi  
+   fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       if [ "$CONFIG_PCI" = "y" ]; then
          tristate '  nVidia Riva support (EXPERIMENTAL)' CONFIG_FB_RIVA
--- kernel_backup/drivers/video/mb86290/mb86290fb.c	2005-10-04 09:45:40.000000000 +0200
+++ kernel/drivers/video/mb86290/mb86290fb.c	2006-04-24 17:22:43.000000000 +0200
@@ -20,6 +20,7 @@
 
 #include <linux/fb.h>
 #include <video/fbcon.h>
+#include <video/fbcon-cfb8.h>
 #include <video/fbcon-cfb16.h>
 
 #include "mb86290fbdev.h"
@@ -54,8 +55,7 @@
     /* display definition */
     pdisp->screen_base 	= (char*)mb86290fb_pInfo->gdcsysinfo.gdcbase;
     /* virtual address */
-    pdisp->visual 	= FB_VISUAL_TRUECOLOR;
-    pdisp->type 	= FB_TYPE_PACKED_PIXELS;
+    pdisp->type 	= FB_TYPE_PACKED_PIXELS;    
     pdisp->type_aux 	= 0;
     pdisp->ypanstep 	= 0;			/* no hardware support */
     pdisp->ywrapstep 	= 0;			/* no hardware support */
@@ -63,7 +63,16 @@
     pdisp->line_length  = MB86290FB_DFLT_SI_XRES * MB86290FB_DFLT_SI_BITS_PER_PIXEL / 8;
     pdisp->can_soft_blank= 1;
     pdisp->inverse 	= 0;
-    pdisp->dispsw	= &fbcon_cfb16;
+    if(MB86290FB_DFLT_SI_BITS_PER_PIXEL == 8)
+    {
+    	    pdisp->dispsw	= &fbcon_cfb8; 
+    	    pdisp->visual 	= FB_VISUAL_PSEUDOCOLOR;
+    }
+	else
+	{
+    	    pdisp->dispsw	= &fbcon_cfb16;	
+    	    pdisp->visual 	= FB_VISUAL_TRUECOLOR;
+    }
     pdisp->dispsw_data	= &mb86290fb_pInfo->cmap;
     pdisp->fb_info	= &mb86290fb_pInfo->fb_info;
     pdisp->scrollmode	= SCROLL_YREDRAW;	/* no hardware support */
@@ -87,11 +96,14 @@
     mb86290fb_pInfo->palette[regno].red   = red;
     mb86290fb_pInfo->palette[regno].green = green;
     mb86290fb_pInfo->palette[regno].blue  = blue;
-    
+      
     if (regno<16){
 	mb86290fb_pInfo->cmap[regno] = ((red & 0xf8) << 7)
 			| ((green & 0xf8) << 2) | ((blue & 0xf8) >> 3);
     }
+    
+    MB86290FB_WRITE_DISP_REGISTER((GDC_DISP_REG_PALLET_0 + (regno*4)), (((red & 0xfc) << 16) | ((green & 0xfc)<< 8) | ((blue & 0xfc))));
+    
     return 0;
 }
 
@@ -469,9 +481,14 @@
 	
     /* DispDimension */
     MB86290FB_WRITE_DISP_REGISTER(GDC_DISP_REG_C_MODE_W_H, 
-		    (1 << 31) | 
 		    ((MB86290FB_DFLT_SI_XRES * MB86290FB_DFLT_SI_BITS_PER_PIXEL / 8 / 64) << 16) | 
-		    (MB86290FB_DFLT_SI_YRES - 1));
+		    (MB86290FB_DFLT_SI_YRES - 1));		    
+    if(MB86290FB_DFLT_SI_BITS_PER_PIXEL == 16)
+    {
+    	reg = MB86290FB_READ_DISP_REGISTER(GDC_DISP_REG_C_MODE_W_H);
+    	MB86290FB_WRITE_DISP_REGISTER(GDC_DISP_REG_C_MODE_W_H, reg | (1 << 31));
+    }
+    
     MB86290FB_WRITE_DISP_REGISTER(GDC_DISP_REG_C_ORG_ADR, 0);
     MB86290FB_WRITE_DISP_REGISTER(GDC_DISP_REG_C_DISP_ADR, 0);
 	
--- kernel_backup/drivers/video/mb86290/mb86290fbsys.h	2005-11-21 10:44:22.000000000 +0100
+++ kernel/drivers/video/mb86290/mb86290fbsys.h	2006-04-25 17:52:15.000000000 +0200
@@ -75,7 +75,7 @@
 
 /* Screen information of frame buffer */
 #ifndef CONFIG_INKA4X0
-#if 1
+#if CONFIG_MB86290FB_RES_640x480
 #define	MB86290FB_DFLT_SI_XRES			640
 #define	MB86290FB_DFLT_SI_YRES			480
 #define	MB86290FB_DFLT_SI_XRES_VIRTUAL		640
@@ -94,16 +94,28 @@
 #endif
 #define	MB86290FB_DFLT_SI_XOFFSET		0
 #define	MB86290FB_DFLT_SI_YOFFSET		0
-#define	MB86290FB_DFLT_SI_BITS_PER_PIXEL	16
+	
+#if CONFIG_MB86290FB_8BPP
+#	define MB86290FB_DFLT_SI_BITS_PER_PIXEL		8
+#	define	MB86290FB_DFLT_SI_RED_OFFSET		0
+#	define	MB86290FB_DFLT_SI_RED_LENGTH		6
+#	define	MB86290FB_DFLT_SI_GREEN_OFFSET		0
+#	define	MB86290FB_DFLT_SI_GREEN_LENGTH		6
+#	define	MB86290FB_DFLT_SI_BLUE_OFFSET		0
+#	define	MB86290FB_DFLT_SI_BLUE_LENGTH		6
+#endif
+#if CONFIG_MB86290FB_16BPP
+#	define MB86290FB_DFLT_SI_BITS_PER_PIXEL     16
+#	define	MB86290FB_DFLT_SI_RED_OFFSET		10
+#	define	MB86290FB_DFLT_SI_RED_LENGTH		5
+#	define	MB86290FB_DFLT_SI_GREEN_OFFSET		5
+#	define	MB86290FB_DFLT_SI_GREEN_LENGTH		5
+#	define	MB86290FB_DFLT_SI_BLUE_OFFSET		0
+#	define	MB86290FB_DFLT_SI_BLUE_LENGTH		5
+#endif
 #define	MB86290FB_DFLT_SI_GRAYSCALE		0
-#define	MB86290FB_DFLT_SI_RED_OFFSET		10
-#define	MB86290FB_DFLT_SI_RED_LENGTH		5
 #define	MB86290FB_DFLT_SI_RED_RIGHT		0
-#define	MB86290FB_DFLT_SI_GREEN_OFFSET		5
-#define	MB86290FB_DFLT_SI_GREEN_LENGTH		5
 #define	MB86290FB_DFLT_SI_GREEN_RIGHT		0
-#define	MB86290FB_DFLT_SI_BLUE_OFFSET		0
-#define	MB86290FB_DFLT_SI_BLUE_LENGTH		5
 #define	MB86290FB_DFLT_SI_BLUE_RIGHT		0
 #define	MB86290FB_DFLT_SI_TRANSP_OFFSET		0
 #define	MB86290FB_DFLT_SI_TRANSP_LENGTH		1
--- kernel_backup/include/video/fbcon.h	2005-10-04 09:45:44.000000000 +0200
+++ kernel/include/video/fbcon.h	2006-04-25 14:22:54.000000000 +0200
@@ -229,11 +229,13 @@
 #endif
 #define fb_writeb(b,addr) (*(volatile u8 *) (addr) = (b))
 #if defined(CONFIG_FB_MB86290) && defined(__BIG_ENDIAN)
-#define fb_writew(b,addr) (*(volatile u16 *) (addr) = cpu_to_le16(b))
-#define fb_writel(b,addr) (*(volatile u32 *) (addr) = cpu_to_le16((u16)b) | (cpu_to_le16(((u32)b) >> 16) << 16))
-#else
+#if CONFIG_MB86290FB_8BPP
 #define fb_writew(b,addr) (*(volatile u16 *) (addr) = (b))
 #define fb_writel(b,addr) (*(volatile u32 *) (addr) = (b))
+#else
+#define fb_writew(b,addr) (*(volatile u16 *) (addr) = cpu_to_le16(b))
+#define fb_writel(b,addr) (*(volatile u32 *) (addr) = cpu_to_le16((u16)b) | (cpu_to_le16(((u32)b) >> 16) << 16))
+#endif
 #endif
 #define fb_memset memset
 
--- kernel_backup/arch/ppc/configs/icecube_5200_CoralP_defconfig	2005-10-04 09:45:29.000000000 +0200
+++ kernel/arch/ppc/configs/icecube_5200_CoralP_defconfig	2006-05-02 10:30:11.000000000 +0200
@@ -509,6 +509,10 @@
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FB_VOYAGER is not set
 CONFIG_FB_MB86290=y
+# CONFIG_MB86290FB_8BPP is not set
+CONFIG_MB86290FB_16BPP=y 
+CONFIG_MB86290FB_RES_1024x768=y 
+# CONFIG_MB86290FB_RES_640x480 is not set
 # CONFIG_FB_RIVA is not set
 # CONFIG_FB_CLGEN is not set
 # CONFIG_FB_PM2 is not set

--------------000106060206000100060802--

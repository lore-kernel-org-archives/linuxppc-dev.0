Date: Tue, 22 Jun 1999 22:22:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@thomas.kotnet.org>
To: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: vga16fb on PPC
Message-ID: <Pine.LNX.4.05.9906222210200.472-100000@callisto.thomas.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



The patch below allows to use vga16fb on PPC and modularizes vga16fb.
I tried it as a module only because I need to initialize my S3 Vision968 to VGA
text mode with Gabriel Paubert's em86 BIOS emulator first.

The access to the VGA video memory has to be cleant up. For now I hardcoded the
case for PPC. Vgacon uses the VGA_MAP_MEM() macro to provide portability, but
this is not The Right Way since it doesn't use ioremap() yet.

Another problem is that sometimes characters aren't drawn correctly: the
character is shifted up a few scanlines, with it's head cut off. Probably I
have to add an eieio to rmw() to make sure it's not reordered by the CPU. But
at least finally I have a multiheaded box (getting vga16fb to work was much
easier than initializing a graphics mode, thanks to em86 ;-)

--- june15/drivers/video/vga16fb.c	1999/05/29 03:27:29	1.2
+++ linux/drivers/video/vga16fb.c	1999/06/22 20:10:10
@@ -1003,16 +1003,24 @@
 	}
 }
 
-__initfunc(void vga16fb_init(void))
+__initfunc(int vga16_init(void))
 {
 	int i,j;
 
 	printk("vga16fb: initializing\n");
 
+#ifdef __powerpc__
+        vga16fb.video_vbase = ioremap((unsigned long)_ISA_MEM_BASE+0xa0000, 65536);
+#else
         vga16fb.video_vbase = ioremap((unsigned long)0xa0000, 65536);
+#endif
 	printk("vga16fb: mapped to 0x%p\n", vga16fb.video_vbase);
 
+#ifdef __powerpc__
+	vga16fb.isVGA = 1;	/* hardcoded to 1 in screen_info anyway */
+#else
 	vga16fb.isVGA = ORIG_VIDEO_ISVGA;
+#endif
 	vga16fb.palette_blanked = 0;
 	vga16fb.vesa_blanked = 0;
 
@@ -1047,12 +1055,35 @@
 	vga16fb_set_disp(-1, &vga16fb);
 
 	if (register_framebuffer(&vga16fb.fb_info)<0)
-		return;
+		return -EINVAL;
 
 	printk("fb%d: %s frame buffer device\n",
 	       GET_FB_IDX(vga16fb.fb_info.node), vga16fb.fb_info.modename);
+
+	return 0;
+}
+
+#ifndef MODULE
+__initfunc(void vga16fb_init(void))
+{
+    vga16_init();
+}
+
+#else /* MODULE */
+
+__initfunc(int init_module(void))
+{
+    return vga16_init();
+}
+
+void cleanup_module(void)
+{
+    unregister_framebuffer(&vga16fb.fb_info);
+    release_region(0x3c0, 32);
+    iounmap(vga16fb.video_vbase);
 }
 
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
--- june15/drivers/video/Config.in	1999/05/15 04:58:02	1.60
+++ linux/drivers/video/Config.in	1999/06/22 20:10:10
@@ -62,6 +62,7 @@
       bool 'Chips 65550 display support' CONFIG_FB_CT65550
       bool 'S3 Trio display support' CONFIG_FB_S3TRIO
     fi
+    tristate 'VGA 16-color graphics console' CONFIG_FB_VGA16
   fi
   if [ "$CONFIG_MAC" = "y" ]; then
     define_bool CONFIG_FB_MAC y
@@ -74,7 +75,7 @@
   fi
   if [ "$ARCH" = "i386" ]; then
     bool 'VESA VGA graphics console' CONFIG_FB_VESA
-    bool 'VGA 16-color graphics console' CONFIG_FB_VGA16
+    tristate 'VGA 16-color graphics console' CONFIG_FB_VGA16
     define_bool CONFIG_VIDEO_SELECT y
   fi
   if [ "$CONFIG_VISWS" = "y" ]; then
@@ -143,7 +144,7 @@
     tristate 'Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
 #   tristate 'Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
     tristate 'Mac variable bpp packed pixels support' CONFIG_FBCON_MAC
-    bool 'VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
+    tristate 'VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
     tristate 'VGA characters/attributes support' CONFIG_FBCON_VGA
   else
     # Guess what we need
@@ -288,6 +289,10 @@
     fi
     if [ "$CONFIG_FB_VGA16" = "y" ]; then
       define_bool CONFIG_FBCON_VGA_PLANES y
+    else
+      if [ "$CONFIG_FB_VGA16" = "m" ]; then
+	define_bool CONFIG_FBCON_VGA_PLANES m
+      fi
     fi
     if [ "$CONFIG_FB_MDA" = "y" -o "$CONFIG_FB_VGA" = "y" ]; then
       define_bool CONFIG_FBCON_VGA y
--- june15/drivers/video/Makefile	1999/05/15 04:58:03	1.58
+++ linux/drivers/video/Makefile	1999/06/22 20:10:15
@@ -204,6 +204,10 @@
 
 ifeq ($(CONFIG_FB_VGA16),y)
 L_OBJS += vga16fb.o
+else
+  ifeq ($(CONFIG_FB_VGA16),m)
+  M_OBJS += vga16fb.o
+  endif
 endif
 
 ifeq ($(CONFIG_FB_VIRGE),y)

Greetings,

						Geert

--
Geert Uytterhoeven                   Geert.Uytterhoeven@thomas.kotnet.org
Linux/m68k on Amiga, Wavelets        http://www.thomas.kotnet.org/~geert/
KotNET@Thomas Network Administration -- Make your bed part of Cyberspace!!


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

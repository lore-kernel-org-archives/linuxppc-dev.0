Date: Mon, 27 Nov 2000 09:15:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Huggins-Daines <dhd@debian.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Valkyriefb for Mac/m68k
Message-ID: <Pine.GSO.4.10.10011270912550.25502-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I cleant up the valkyriefb patch. Does this look acceptable to you?

--- linux-2.4.0-test11/drivers/video/valkyriefb.c	Sun Sep 17 18:48:05 2000
+++ linux-m68k-2.4.0-test11/drivers/video/valkyriefb.c	Wed Nov 22 09:15:53 2000
@@ -7,6 +7,8 @@
  *  Vmode-switching changes and vmode 15/17 modifications created 29 August
  *  1998 by Barry K. Nathan <barryn@pobox.com>.
  *
+ *  Ported to m68k Macintosh by David Huggins-Daines <dhd@debian.org>
+ *
  *  Derived directly from:
  *
  *   controlfb.c -- frame buffer device for the PowerMac 'control' display
@@ -59,7 +61,12 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <asm/io.h>
+#ifdef CONFIG_MAC
+#include <asm/bootinfo.h>
+#include <asm/macintosh.h>
+#else
 #include <asm/prom.h>
+#endif
 #include <asm/pgtable.h>

 #include <video/fbcon.h>
@@ -71,8 +78,15 @@

 static int can_soft_blank = 1;

+#ifdef CONFIG_MAC
+/* We don't yet have functions to read the PRAM... perhaps we can
+   adapt them from the PPC code? */
+static int default_vmode = VMODE_640_480_67;
+static int default_cmode = CMODE_8;
+#else
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
+#endif
 static char fontname[40] __initdata = { 0 };

 static int currcon = 0;
@@ -111,13 +125,17 @@
 #endif
 };

+#ifdef CONFIG_MAC
+#define out_8(addr,byte)	writeb(byte,addr)
+#define in_8(addr)       	readb(addr)
+#endif
+
 /*
  * Exported functions
  */
 int valkyriefb_init(void);
 int valkyriefb_setup(char*);

-static void valkyrie_of_init(struct device_node *dp);
 static int valkyrie_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
 static int valkyrie_get_var(struct fb_var_screeninfo *var, int con,
@@ -445,6 +463,7 @@
 	printk(KERN_INFO "Monitor sense value = 0x%x, ", p->sense);

 	/* Try to pick a video mode out of NVRAM if we have one. */
+#ifndef CONFIG_MAC
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0
@@ -452,12 +471,15 @@
 		 || !valkyrie_reg_init[default_vmode - 1])
 			default_vmode = VMODE_CHOOSE;
 	}
+#endif
 	if (default_vmode == VMODE_CHOOSE)
 		default_vmode = mac_map_monitor_sense(p->sense);
 	if (!valkyrie_reg_init[default_vmode - 1])
 		default_vmode = VMODE_640_480_67;
+#ifndef CONFIG_MAC
 	if (default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
+#endif

 	/*
 	 * Reduce the pixel size if we don't have enough VRAM or bandwitdh.
@@ -550,48 +572,57 @@

 int __init valkyriefb_init(void)
 {
+	struct fb_info_valkyrie	*p;
+	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
+
+#ifdef CONFIG_MAC
+	if (!MACH_IS_MAC)
+		return 0;
+	if (!(mac_bi_data.id == MAC_MODEL_Q630
+	      /* I'm not sure about this one */
+	    || mac_bi_data.id == MAC_MODEL_P588))
+		return 0;
+
+	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
+	frame_buffer_phys = 0xf9000000;
+	cmap_regs_phys = 0x50f24000;
+	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
+#else /* ppc (!CONFIG_MAC) */
 	struct device_node *dp;

 	dp = find_devices("valkyrie");
-	if (dp != 0)
-		valkyrie_of_init(dp);
-	return 0;
-}
+	if (dp == 0)
+		return 0;

-static void __init valkyrie_of_init(struct device_node *dp)
-{
-	struct fb_info_valkyrie	*p;
-	unsigned long addr;
-
 	if(dp->n_addrs != 1) {
 		printk(KERN_ERR "expecting 1 address for valkyrie (got %d)", dp->n_addrs);
-		return;
+		return 0;
 	}

+	frame_buffer_phys = dp->addrs[0].address;
+	cmap_regs_phys = dp->addrs[0].address+0x304000;
+	flags = _PAGE_WRITETHRU;
+#endif /* ppc (!CONFIG_MAC) */
+
 	p = kmalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == 0)
-		return;
+		return 0;
 	memset(p, 0, sizeof(*p));

 	/* Map in frame buffer and registers */
-	addr = dp->addrs[0].address;
-	if (!request_mem_region(addr, dp->addrs[0].size, "valkyriefb")) {
+	if (!request_mem_region(frame_buffer_phys, 0x100000, "valkyriefb")) {
 		kfree(p);
-		return;
+		return 0;
 	}
-	p->frame_buffer_phys  = addr;
-	p->frame_buffer  = __ioremap(addr, 0x100000, _PAGE_WRITETHRU);
-	p->cmap_regs_phys     = addr + 0x304000;
-	p->cmap_regs     = ioremap(p->cmap_regs_phys,4096);
-	p->valkyrie_regs_phys = addr + 0x30a000;
-	p->valkyrie_regs = ioremap(p->valkyrie_regs_phys, 4096);
-
-	/*
-	 * kps: As far as I know, all Valkyries have fixed usable VRAM.
-	 */
 	p->total_vram = 0x100000;
-
+	p->frame_buffer_phys  = frame_buffer_phys;
+	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
+	p->cmap_regs_phys = cmap_regs_phys;
+	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
+	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
+	p->valkyrie_regs = ioremap(p->valkyrie_regs_phys, 0x1000);
 	init_valkyrie(p);
+	return 0;
 }

 /*
--- linux-2.4.0-test11/drivers/video/valkyriefb.h	Sat Aug  5 03:06:34 2000
+++ linux-m68k-2.4.0-test11/drivers/video/valkyriefb.h	Wed Nov 22 09:15:53 2000
@@ -9,6 +9,8 @@
  *
  * vmode 10 changed by Steven Borley <sjb@salix.demon.co.uk>, 14 mai 2000
  *
+ * Ported to 68k Macintosh by David Huggins-Daines <dhd@debian.org>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -37,12 +39,19 @@
  *  Copyright (C) 1998 Jon Howell
  */

+#ifdef CONFIG_MAC
+/* Valkyrie registers are word-aligned on m68k */
+#define VALKYRIE_REG_PADSIZE	3
+#else
+#define VALKYRIE_REG_PADSIZE	7
+#endif
+
 /*
  * Structure of the registers for the Valkyrie colormap registers.
  */
 struct cmap_regs {
 	unsigned char addr;
-	char pad1[7];
+	char pad1[VALKYRIE_REG_PADSIZE];
 	unsigned char lut;
 };

@@ -52,7 +61,7 @@

 struct vpreg {			/* padded register */
 	unsigned char r;
-	char pad[7];
+	char pad[VALKYRIE_REG_PADSIZE];
 };


@@ -81,6 +90,7 @@
 	int	vres;
 };

+#ifndef CONFIG_MAC
 /* Register values for 1024x768, 75Hz mode (17) */
 /* I'm not sure which mode this is (16 or 17), so I'm defining it as 17,
  * since the equivalent mode in controlfb (which I adapted this from) is
@@ -125,14 +135,6 @@
 	1024, 768
 };

-/* Register values for 832x624, 75Hz mode (13) */
-static struct valkyrie_regvals valkyrie_reg_init_13 = {
-    9,
-    { 23, 42, 3 },  /* pixel clock = 57.07MHz for V=74.27Hz */
-    { 832, 0 },
-	832, 624
-};
-
 /* Register values for 800x600, 72Hz mode (11) */
 static struct valkyrie_regvals valkyrie_reg_init_11 = {
     13,
@@ -140,6 +142,15 @@
     { 800, 0 },
 	800, 600
 };
+#endif /* CONFIG_MAC */
+
+/* Register values for 832x624, 75Hz mode (13) */
+static struct valkyrie_regvals valkyrie_reg_init_13 = {
+    9,
+    { 23, 42, 3 },  /* pixel clock = 57.07MHz for V=74.27Hz */
+    { 832, 0 },
+	832, 624
+};

 /* Register values for 800x600, 60Hz mode (10) */
 static struct valkyrie_regvals valkyrie_reg_init_10 = {
@@ -177,6 +188,15 @@
 	NULL,
 	NULL,
 	&valkyrie_reg_init_10,
+#ifdef CONFIG_MAC
+	NULL,
+	NULL,
+	&valkyrie_reg_init_13,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+#else
 	&valkyrie_reg_init_11,
 	NULL,
 	&valkyrie_reg_init_13,
@@ -184,6 +204,7 @@
 	&valkyrie_reg_init_15,
 	NULL,
 	&valkyrie_reg_init_17,
+#endif
 	NULL,
 	NULL,
 	NULL
--- linux-2.4.0-test11/drivers/video/macmodes.c	Tue Jun 20 23:28:05 2000
+++ linux-m68k-2.4.0-test11/drivers/video/macmodes.c	Wed Nov 22 09:15:53 2000
@@ -17,7 +17,9 @@
 #include <linux/fb.h>
 #include <linux/string.h>

+#ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
+#endif

 #include <video/fbcon.h>
 #include <video/macmodes.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

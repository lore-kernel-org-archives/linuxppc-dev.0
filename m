Date: Thu, 27 Jul 2000 15:11:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cards initialized from offb (was: Re: [linux-fbdev] Re: [patch]
 VRAM detection in controlfb)
In-Reply-To: <Pine.LNX.4.10.10007151622130.721-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10007271501470.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 15 Jul 2000, Geert Uytterhoeven wrote:
> This patch moves the initialization of some frame buffer devices from offb.c
> to fbmem.c. It also reorders the initialization calls in fbmem.c.

Here's a new version of the same patch. Changes:

  - Change `video=ofonly' logic. Why do it complex when it can be done simple
    (albeit with more #ifdefs)?
  - Cosmetic changes for valkyriefb (by Martin Costabel)
  - Improved definition of one video mode for valkyriefb (by Steven Borley)

If someone will tell me that `video=ofonly' now works as expected, I'll send it
to Linus.

--- linux-2.4.0-test5-pre5/drivers/video/matrox/matroxfb_base.c	Wed Jul 19 22:12:11 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/matrox/matroxfb_base.c	Thu Jul 27 14:32:30 2000
@@ -95,7 +95,7 @@
 #include <linux/matroxfb.h>
 #include <asm/uaccess.h>

-#if defined(CONFIG_FB_OF)
+#ifdef CONFIG_PPC
 unsigned char nvram_read_byte(int);
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
@@ -2343,7 +2343,7 @@
 			mem = simple_strtoul(this_opt+4, NULL, 0);
 		else if (!strncmp(this_opt, "mode:", 5))
 			strncpy(videomode, this_opt+5, sizeof(videomode)-1);
-#ifdef CONFIG_FB_OF
+#ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
@@ -2519,7 +2519,7 @@
 MODULE_PARM_DESC(cross4MB, "Specifies that 4MB boundary can be in middle of line. (default=autodetected)");
 MODULE_PARM(dfp, "i");
 MODULE_PARM_DESC(dfp, "Specifies whether to use digital flat panel interface of G200/G400 (0 or 1) (default=0)");
-#ifdef CONFIG_FB_OF
+#ifdef CONFIG_PPC
 MODULE_PARM(vmode, "i");
 MODULE_PARM_DESC(vmode, "Specify the vmode mode number that should be used (640x480 default)");
 MODULE_PARM(cmode, "i");
--- linux-2.4.0-test5-pre5/drivers/video/chipsfb.c	Tue Jul 18 14:05:11 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/chipsfb.c	Thu Jul 27 14:32:30 2000
@@ -113,8 +113,8 @@
  * Exported functions
  */
 int chips_init(void);
-void chips_of_init(struct device_node *dp);

+static void chips_of_init(struct device_node *dp);
 static int chips_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
 static int chips_get_var(struct fb_var_screeninfo *var, int con,
@@ -645,17 +645,15 @@

 int __init chips_init(void)
 {
-#ifndef CONFIG_FB_OF
 	struct device_node *dp;

 	dp = find_devices("chips65550");
 	if (dp != 0)
 		chips_of_init(dp);
-#endif /* CONFIG_FB_OF */
 	return 0;
 }

-void __init chips_of_init(struct device_node *dp)
+static void __init chips_of_init(struct device_node *dp)
 {
 	struct fb_info_chips *p;
 	unsigned long addr;
@@ -669,6 +667,10 @@
 		return;
 	memset(p, 0, sizeof(*p));
 	addr = dp->addrs[0].address;
+	if (!request_mem_region(addr, dp->addrs[0].size, "chipsfb")) {
+		kfree(p);
+		return;
+	}
 #ifdef __BIG_ENDIAN
 	addr += 0x800000;	// Use big-endian aperture
 #endif
--- linux-2.4.0-test5-pre5/drivers/video/clgenfb.c	Wed Jul 26 20:15:08 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/clgenfb.c	Thu Jul 27 14:32:30 2000
@@ -56,9 +56,6 @@
 #ifdef CONFIG_AMIGA
 #include <asm/amigahw.h>
 #endif
-#ifdef CONFIG_FB_OF
-#include <asm/prom.h>
-#endif

 #include <video/fbcon.h>
 #include <video/fbcon-mfb.h>
@@ -475,9 +472,6 @@
 static int clgenfb_ioctl (struct inode *inode, struct file *file,
 		   unsigned int cmd, unsigned long arg, int con,
 		   struct fb_info *info);
-#if defined(CONFIG_FB_OF)
-int clgen_of_init (struct device_node *dp);
-#endif

 /* function table of the above functions */
 static struct fb_ops clgenfb_ops = {
@@ -2414,34 +2408,6 @@



-#ifdef CONFIG_FB_OF
-static void __init get_of_addrs (const struct device_node *dp,
-			  unsigned long *display, unsigned long *registers)
-{
-	int i;
-
-	DPRINTK ("ENTER\n");
-
-	/* Map in frame buffer and registers */
-	for (i = 0; i < dp->n_addrs; ++i) {
-		unsigned long addr = dp->addrs[i].address;
-		unsigned long size = dp->addrs[i].size;
-		printk ("dp->addrs[%d].address = %lx, dp->addrs[%d].size = %lx\n",
-			i, addr, i, size);
-		if (size >= 0x800000) {
-			*display = addr;
-		} else {
-			*registers = addr;
-		}
-	}
-
-	DPRINTK ("EXIT\n");
-}
-#endif				/* CONFIG_FB_OF */
-
-
-
-
 #ifdef CONFIG_PCI
 /* Pulled the logic from XFree86 Cirrus driver to get the memory size,
  * based on the DRAM bandwidth bit and DRAM bank switching bit.  This
@@ -2543,9 +2509,6 @@
 static int __init clgen_pci_setup (struct clgenfb_info *info,
 				   clgen_board_t *btype)
 {
-#ifdef CONFIG_FB_OF
-	struct device_node *dp;
-#endif				/* CONFIG_FB_OF */
 	struct pci_dev *pdev;
 	unsigned long board_addr, board_size;

@@ -2568,29 +2531,12 @@
 	pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0, 0x00000000);
 #endif

-#ifdef CONFIG_FB_OF
-	/* Ok, so its an ugly hack, since we could have passed it down from
-	 * clgen_of_init() if we'd done it right. */
-	DPRINTK ("Attempt to get OF info for MacPicasso\n");
-	dp = find_devices ("MacPicasso");
-	if (dp != 0) {
-		if (dp->n_addrs != 2) {
-			printk (KERN_ERR "expecting 2 address for clgen (got %d)\n", dp->n_addrs);
-			DPRINTK ("EXIT, returning 1\n");
-			return 1;
-		}
-		get_of_addrs (dp, &board_addr, &info->fbregs_phys);
-	} else
-#endif
-	{
-
 #ifdef CONFIG_PREP
-		get_prep_addrs (&board_addr, &info->fbregs_phys);
+	get_prep_addrs (&board_addr, &info->fbregs_phys);
 #else				/* CONFIG_PREP */
-		DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
-		get_pci_addrs (pdev, &board_addr, &info->fbregs_phys);
+	DPRINTK ("Attempt to get PCI info for Cirrus Graphics Card\n");
+	get_pci_addrs (pdev, &board_addr, &info->fbregs_phys);
 #endif				/* CONFIG_PREP */
-	}

 	DPRINTK ("Board address: 0x%lx, register address: 0x%lx\n", board_addr, info->fbregs_phys);

@@ -2850,14 +2796,6 @@
 	return 0;
 }

-
-
-#if defined(CONFIG_FB_OF)
-int __init clgen_of_init (struct device_node *dp)
-{
-	return clgenfb_init ();
-}
-#endif				/* CONFIG_FB_OF */


     /*
--- linux-2.4.0-test5-pre5/drivers/video/controlfb.c	Wed Jul 26 20:15:08 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/controlfb.c	Thu Jul 27 14:32:30 2000
@@ -148,11 +148,9 @@
  * Exported functions
  */
 int control_init(void);
-#ifdef CONFIG_FB_OF
-void control_of_init(struct device_node *dp);
-#endif
 void control_setup(char *);

+static void control_of_init(struct device_node *dp);
 static int read_control_sense(struct fb_info_control *p);
 static inline int control_vram_reqd(int video_mode, int color_mode);
 static void set_control_clock(unsigned char *params);
@@ -198,6 +196,7 @@

 void cleanup_module(void)
 {
+	/* FIXME: clean up and release regions */
 }
 #endif

@@ -647,17 +646,15 @@

 int __init control_init(void)
 {
-#ifndef CONFIG_FB_OF
 	struct device_node *dp;

 	dp = find_devices("control");
 	if (dp != 0)
 		control_of_init(dp);
-#endif /* CONFIG_FB_OF */
 	return 0;
 }

-void __init control_of_init(struct device_node *dp)
+static void __init control_of_init(struct device_node *dp)
 {
 	struct fb_info_control	*p;
 	unsigned long		addr, size;
@@ -676,6 +673,11 @@
 	for (i = 0; i < dp->n_addrs; ++i) {
 		addr = dp->addrs[i].address;
 		size = dp->addrs[i].size;
+		/* Let's assume we can request either all or nothing */
+		if (!request_mem_region(addr, size, "controlfb")) {
+		    kfree(p);
+		    return;
+		}
 		if (size >= 0x800000) {
 			/* use the big-endian aperture (??) */
 			addr += 0x800000;
@@ -688,6 +690,7 @@
 		}
 	}
 	p->cmap_regs_phys = 0xf301b000;	 /* XXX not in prom? */
+	request_mem_region(p->cmap_regs_phys, 0x1000, "controlfb cmap");
 	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);

 	/* Work out which banks of VRAM we have installed. */
--- linux-2.4.0-test5-pre5/drivers/video/platinumfb.c	Tue Jul 18 14:05:12 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/platinumfb.c	Thu Jul 27 14:32:30 2000
@@ -130,6 +130,7 @@
  * internal functions
  */

+static void platinum_of_init(struct device_node *dp);
 static inline int platinum_vram_reqd(int video_mode, int color_mode);
 static int read_platinum_sense(struct fb_info_platinum *info);
 static void set_platinum_clock(struct fb_info_platinum *info);
@@ -157,12 +158,8 @@
  */

 int platinum_init(void);
-#ifdef CONFIG_FB_OF
-void platinum_of_init(struct device_node *dp);
-#endif
 int platinum_setup(char*);

-
 static struct fb_ops platinumfb_ops = {
 	owner:		THIS_MODULE,
 	fb_get_fix:	platinum_get_fix,
@@ -652,13 +649,11 @@

 int __init platinum_init(void)
 {
-#ifndef CONFIG_FB_OF
 	struct device_node *dp;

 	dp = find_devices("platinum");
 	if (dp != 0)
 		platinum_of_init(dp);
-#endif /* CONFIG_FB_OF */
 	return 0;
 }

@@ -670,7 +665,7 @@
 #define invalidate_cache(addr)
 #endif

-void __init platinum_of_init(struct device_node *dp)
+static void __init platinum_of_init(struct device_node *dp)
 {
 	struct fb_info_platinum	*info;
 	unsigned long		addr, size;
@@ -691,6 +686,11 @@
 	for (i = 0; i < dp->n_addrs; ++i) {
 		addr = dp->addrs[i].address;
 		size = dp->addrs[i].size;
+		/* Let's assume we can request either all or nothing */
+		if (!request_mem_region(addr, size, "platinumfb")) {
+			kfree(info);
+			return;
+		}
 		if (size >= 0x400000) {
 			/* frame buffer - map only 4MB */
 			info->frame_buffer_phys = addr;
@@ -704,6 +704,7 @@
 	}

 	info->cmap_regs_phys = 0xf301b000;	/* XXX not in prom? */
+	request_mem_region(info->cmap_regs_phys, 0x1000, "platinumfb cmap");
 	info->cmap_regs = ioremap(info->cmap_regs_phys, 0x1000);

 	/* Grok total video ram */
--- linux-2.4.0-test5-pre5/drivers/video/valkyriefb.c	Tue Jul 18 14:07:22 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/valkyriefb.c	Thu Jul 27 14:32:30 2000
@@ -1,7 +1,8 @@
 /*
  *  valkyriefb.c -- frame buffer device for the PowerMac 'valkyrie' display
  *
- *  Created 8 August 1998 by Martin Costabel and Kevin Schoedel
+ *  Created 8 August 1998 by
+ *  Martin Costabel <costabel@wanadoo.fr> and Kevin Schoedel
  *
  *  Vmode-switching changes and vmode 15/17 modifications created 29 August
  *  1998 by Barry K. Nathan <barryn@pobox.com>.
@@ -114,9 +115,9 @@
  * Exported functions
  */
 int valkyriefb_init(void);
-void valkyrie_of_init(struct device_node *dp);
 int valkyriefb_setup(char*);

+static void valkyrie_of_init(struct device_node *dp);
 static int valkyrie_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
 static int valkyrie_get_var(struct fb_var_screeninfo *var, int con,
@@ -567,20 +568,18 @@

 int __init valkyriefb_init(void)
 {
-#ifndef CONFIG_FB_OF
 	struct device_node *dp;

 	dp = find_devices("valkyrie");
 	if (dp != 0)
 		valkyrie_of_init(dp);
-#endif /* CONFIG_FB_OF */
 	return 0;
 }

-void __init valkyrie_of_init(struct device_node *dp)
+static void __init valkyrie_of_init(struct device_node *dp)
 {
 	struct fb_info_valkyrie	*p;
-	unsigned long addr, size;
+	unsigned long addr;

 	if(dp->n_addrs != 1) {
 		printk(KERN_ERR "expecting 1 address for valkyrie (got %d)", dp->n_addrs);
@@ -594,13 +593,16 @@

 	/* Map in frame buffer and registers */
 	addr = dp->addrs[0].address;
-	size = 4096;
+	if (!request_mem_region(addr, dp->addrs[0].size, "valkyriefb")) {
+		kfree(p);
+		return;
+	}
 	p->frame_buffer_phys  = addr;
 	p->frame_buffer  = __ioremap(addr, 0x100000, _PAGE_WRITETHRU);
 	p->cmap_regs_phys     = addr + 0x304000;
-	p->cmap_regs     = ioremap(p->cmap_regs_phys,     size);
+	p->cmap_regs     = ioremap(p->cmap_regs_phys,4096);
 	p->valkyrie_regs_phys = addr + 0x30a000;
-	p->valkyrie_regs = ioremap(p->valkyrie_regs_phys, size);
+	p->valkyrie_regs = ioremap(p->valkyrie_regs_phys, 4096);

 	/*
 	 * kps: As far as I know, all Valkyries have fixed usable VRAM.
@@ -670,31 +672,9 @@
 	struct valkyrie_regvals *init;
 	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) fb_info;

-    /* these are old variables that are no longer needed with my new code
-       [bkn]
-
-	int xres = var->xres;
-	int yres = var->yres;
-     */
-
-    /*
-     *  Get the video params out of 'var'. If a value doesn't fit, round it up,
-     *  if it's too big, return -EINVAL.
-     *
-     *  Suggestion: Round up in the following order: bits_per_pixel, xres,
-     *  yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
-     *  bitfields, horizontal timing, vertical timing.
-     */

 	if(mac_var_to_vmode(var, &par->vmode, &par->cmode) != 0) {
-		printk(KERN_ERR "valkyrie_var_to_par: mac_var_to_vmode unsuccessful.\n");
-		printk(KERN_ERR "valkyrie_var_to_par: var->xres = %d\n", var->xres);
-		printk(KERN_ERR "valkyrie_var_to_par: var->yres = %d\n", var->yres);
-		printk(KERN_ERR "valkyrie_var_to_par: var->xres_virtual = %d\n", var->xres_virtual);
-		printk(KERN_ERR "valkyrie_var_to_par: var->yres_virtual = %d\n", var->yres_virtual);
-		printk(KERN_ERR "valkyrie_var_to_par: var->bits_per_pixel = %d\n", var->bits_per_pixel);
-		printk(KERN_ERR "valkyrie_var_to_par: var->pixclock = %d\n", var->pixclock);
-		printk(KERN_ERR "valkyrie_var_to_par: var->vmode = %d\n", var->vmode);
+		printk(KERN_ERR "valkyrie_var_to_par: %dx%dx%d unsuccessful.\n",var->xres,var->yres,var->bits_per_pixel);
 		return -EINVAL;
 	}

--- linux-2.4.0-test5-pre5/drivers/video/fbmem.c	Wed Jul 19 22:12:11 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/fbmem.c	Thu Jul 27 14:58:10 2000
@@ -67,7 +67,6 @@
 extern int vfb_init(void);
 extern int vfb_setup(char*);
 extern int offb_init(void);
-extern int offb_setup(char*);
 extern int atyfb_init(void);
 extern int atyfb_setup(char*);
 extern int aty128fb_init(void);
@@ -83,7 +82,6 @@
 extern int virgefb_setup(char*);
 extern int resolver_video_setup(char*);
 extern int s3triofb_init(void);
-extern int s3triofb_setup(char*);
 extern int vesafb_init(void);
 extern int vesafb_setup(char*);
 extern int vga16fb_init(void);
@@ -96,10 +94,13 @@
 extern int hpfb_setup(char*);
 extern int sbusfb_init(void);
 extern int sbusfb_setup(char*);
-extern int valkyriefb_init(void);
-extern int valkyriefb_setup(char*);
 extern int control_init(void);
 extern int control_setup(char*);
+extern int platinum_init(void);
+extern int platinum_setup(char*);
+extern int valkyriefb_init(void);
+extern int valkyriefb_setup(char*);
+extern int chips_init(void);
 extern int g364fb_init(void);
 extern int sa1100fb_init(void);
 extern int sa1100fb_setup(char*);
@@ -122,6 +123,7 @@
 	int (*init)(void);
 	int (*setup)(char*);
 } fb_drivers[] __initdata = {
+
 #ifdef CONFIG_FB_SBUS
 	/*
 	 * Sbusfb must be initialized _before_ other frame buffer devices that
@@ -129,27 +131,17 @@
 	 */
 	{ "sbus", sbusfb_init, sbusfb_setup },
 #endif
-#ifdef CONFIG_FB_3DFX
-	{ "tdfx", tdfxfb_init, tdfxfb_setup },
-#endif
-#ifdef CONFIG_FB_SGIVW
-	{ "sgivw", sgivwfb_init, sgivwfb_setup },
-#endif
+
+	/*
+	 * Chipset specific drivers that use resource management
+	 */
+
 #ifdef CONFIG_FB_RETINAZ3
 	{ "retz3", retz3fb_init, retz3fb_setup },
 #endif
-#ifdef CONFIG_FB_ACORN
-	{ "acorn", acornfb_init, acornfb_setup },
-#endif
 #ifdef CONFIG_FB_AMIGA
 	{ "amifb", amifb_init, amifb_setup },
 #endif
-#ifdef CONFIG_FB_ATARI
-	{ "atafb", atafb_init, atafb_setup },
-#endif
-#ifdef CONFIG_FB_MAC
-	{ "macfb", macfb_init, macfb_setup },
-#endif
 #ifdef CONFIG_FB_CYBER
 	{ "cyber", cyberfb_init, cyberfb_setup },
 #endif
@@ -171,79 +163,120 @@
 #ifdef CONFIG_FB_ATY128
 	{ "aty128fb", aty128fb_init, aty128fb_setup },
 #endif
+#ifdef CONFIG_FB_VIRGE
+	{ "virge", virgefb_init, virgefb_setup },
+#endif
+#ifdef CONFIG_FB_RIVA
+	{ "riva", rivafb_init, rivafb_setup },
+#endif
+#ifdef CONFIG_FB_CONTROL
+	{ "controlfb", control_init, control_setup },
+#endif
+#ifdef CONFIG_FB_PLATINUM
+	{ "platinumfb", platinum_init, platinum_setup },
+#endif
+#ifdef CONFIG_FB_VALKYRIE
+	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
+#endif
+#ifdef CONFIG_FB_CT65550
+	{ "chipsfb", chips_init, NULL },
+#endif
+#ifdef CONFIG_FB_IMSTT
+	{ "imsttfb", imsttfb_init, imsttfb_setup },
+#endif
+#ifdef CONFIG_FB_S3TRIO
+	{ "s3trio", s3triofb_init, NULL },
+#endif
+#ifdef CONFIG_FB_FM2
+	{ "fm2fb", fm2fb_init, fm2fb_setup },
+#endif
+#ifdef CONFIG_FB_SIS
+	{ "sisfb", sisfb_init, sisfb_setup },
+#endif
+
+	/*
+	 * Generic drivers that are used as fallbacks
+	 *
+	 * These depend on resource management and must be initialized
+	 * _after_ all other frame buffer devices that use resource
+	 * management! [ Geert ]
+	 */
+
 #ifdef CONFIG_FB_OF
+	{ "offb", offb_init, NULL },
+#endif
+#ifdef CONFIG_FB_VESA
+	{ "vesa", vesafb_init, vesafb_setup },
+#endif
+
 	/*
-	 * Offb must be initialized _after_ all other frame buffer devices
-	 * that use PCI probing and PCI resources! [ Geert ]
+	 * Chipset specific drivers that don't use resource management (yet)
 	 */
-	{ "offb", offb_init, offb_setup },
+
+#ifdef CONFIG_FB_3DFX
+	{ "tdfx", tdfxfb_init, tdfxfb_setup },
+#endif
+#ifdef CONFIG_FB_SGIVW
+	{ "sgivw", sgivwfb_init, sgivwfb_setup },
 #endif
+#ifdef CONFIG_FB_ACORN
+	{ "acorn", acornfb_init, acornfb_setup },
+#endif
+#ifdef CONFIG_FB_ATARI
+	{ "atafb", atafb_init, atafb_setup },
+#endif
+#ifdef CONFIG_FB_MAC
+	{ "macfb", macfb_init, macfb_setup },
+#endif
+#ifdef CONFIG_FB_HGA
+	{ "hga", hgafb_init, hgafb_setup },
+#endif
 #ifdef CONFIG_FB_IGA
         { "igafb", igafb_init, igafb_setup },
 #endif
-#ifdef CONFIG_FB_IMSTT
-	{ "imsttfb", imsttfb_init, imsttfb_setup },
-#endif
 #ifdef CONFIG_APOLLO
 	{ "apollo", dnfb_init, NULL },
 #endif
 #ifdef CONFIG_FB_Q40
 	{ "q40fb", q40fb_init, NULL },
 #endif
-#ifdef CONFIG_FB_S3TRIO
-	{ "s3trio", s3triofb_init, s3triofb_setup },
-#endif
 #ifdef CONFIG_FB_TGA
 	{ "tga", tgafb_init, tgafb_setup },
 #endif
-#ifdef CONFIG_FB_VIRGE
-	{ "virge", virgefb_init, virgefb_setup },
-#endif
-#ifdef CONFIG_FB_RIVA
-	{ "riva", rivafb_init, rivafb_setup },
-#endif
-#ifdef CONFIG_FB_VESA
-	{ "vesa", vesafb_init, vesafb_setup },
-#endif
-#ifdef CONFIG_FB_VGA16
-	{ "vga16", vga16fb_init, vga16fb_setup },
-#endif
-#ifdef CONFIG_FB_HGA
-	{ "hga", hgafb_init, hgafb_setup },
-#endif
 #ifdef CONFIG_FB_HP300
 	{ "hpfb", hpfb_init, hpfb_setup },
 #endif
-#ifdef CONFIG_FB_CONTROL
-	{ "controlfb", control_init, control_setup },
-#endif
-#ifdef CONFIG_FB_VALKYRIE
-	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
-#endif
 #ifdef CONFIG_FB_G364
 	{ "g364", g364fb_init, NULL },
 #endif
 #ifdef CONFIG_FB_SA1100
 	{ "sa1100", sa1100fb_init, sa1100fb_setup },
 #endif
-#ifdef CONFIG_FB_FM2
-	{ "fm2fb", fm2fb_init, fm2fb_setup },
-#endif
 #ifdef CONFIG_FB_SUN3
        { "sun3", sun3fb_init, sun3fb_setup },
 #endif
 #ifdef CONFIG_FB_HIT
        { "hitfb", hitfb_init, hitfb_setup },
 #endif
+
+	/*
+	 * Generic drivers that don't use resource management (yet)
+	 */
+
+#ifdef CONFIG_FB_VGA16
+	{ "vga16", vga16fb_init, vga16fb_setup },
+#endif
+
 #ifdef CONFIG_GSP_RESOLVER
 	/* Not a real frame buffer device... */
 	{ "resolver", NULL, resolver_video_setup },
 #endif
-#ifdef CONFIG_FB_SIS
-	{ "sisfb", sisfb_init, sisfb_setup },
-#endif
+
 #ifdef CONFIG_FB_VIRTUAL
-	/* Must be last to avoid that vfb becomes your primary display */
+	/*
+	 * Vfb must be last to avoid that it becomes your primary display if
+	 * other display devices are present
+	 */
 	{ "vfb", vfb_init, vfb_setup },
 #endif
 };
@@ -264,6 +297,10 @@
 static int last_fb_vc = MAX_NR_CONSOLES-1;
 static int fbcon_is_default = 1;

+#ifdef CONFIG_FB_OF
+static int ofonly __initdata = 0;
+#endif
+
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
 			   int len, int *eof, void *private)
 {
@@ -724,6 +761,13 @@
 	if (devfs_register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);

+#ifdef CONFIG_FB_OF
+	if (ofonly) {
+		offb_init();
+		return;
+	}
+#endif
+
 	/*
 	 *  Probe for all builtin frame buffer devices
 	 */
@@ -782,6 +826,13 @@
 		last_fb_vc = simple_strtoul(options, &options, 10) - 1;
 	    fbcon_is_default = 0;
     }
+
+#ifdef CONFIG_FB_OF
+    if (!strcmp(options, "ofonly")) {
+	    ofonly = 1;
+	    return 0;
+    }
+#endif

     if (num_pref_init_funcs == FB_MAX)
 	    return 0;
--- linux-2.4.0-test5-pre5/drivers/video/offb.c	Tue Jul 18 14:07:22 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/offb.c	Thu Jul 27 14:32:30 2000
@@ -68,14 +68,12 @@
 #define mach_eieio()	do {} while (0)
 #endif

-static int ofonly = 0;

     /*
      *  Interface used by the world
      */

 int offb_init(void);
-int offb_setup(char*);

 static int offb_get_fix(struct fb_fix_screeninfo *fix, int con,
 			struct fb_info *info);
@@ -94,7 +92,6 @@

 extern boot_infos_t *boot_infos;

-static int offb_init_driver(struct device_node *);
 static void offb_init_nodriver(struct device_node *);
 static void offb_init_fb(const char *name, const char *full_name, int width,
 		      int height, int depth, int pitch, unsigned long address,
@@ -266,29 +263,6 @@
 }


-#ifdef CONFIG_FB_S3TRIO
-extern void s3triofb_init_of(struct device_node *dp);
-#endif /* CONFIG_FB_S3TRIO */
-#ifdef CONFIG_FB_IMSTT
-extern void imsttfb_of_init(struct device_node *dp);
-#endif
-#ifdef CONFIG_FB_CT65550
-extern void chips_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_CT65550 */
-#ifdef CONFIG_FB_CONTROL
-extern void control_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_CONTROL */
-#ifdef CONFIG_FB_VALKYRIE
-extern void valkyrie_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_VALKYRIE */
-#ifdef CONFIG_FB_PLATINUM
-extern void platinum_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_PLATINUM */
-#ifdef CONFIG_FB_CLGEN
-extern void clgen_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_CLGEN */
-
-
     /*
      *  Initialisation
      */
@@ -352,89 +326,22 @@
 	}

 	/* initialize it */
-	if (ofonly || macos_display == NULL
-	    || !offb_init_driver(macos_display)) {
-	    offb_init_fb(macos_display? macos_display->name: "MacOS display",
-			 macos_display? macos_display->full_name: "MacOS display",
-			 boot_infos->dispDeviceRect[2],
-			 boot_infos->dispDeviceRect[3],
-			 boot_infos->dispDeviceDepth,
-			 boot_infos->dispDeviceRowBytes, addr, NULL);
-	}
+	offb_init_fb(macos_display? macos_display->name: "MacOS display",
+		     macos_display? macos_display->full_name: "MacOS display",
+		     boot_infos->dispDeviceRect[2],
+		     boot_infos->dispDeviceRect[3],
+		     boot_infos->dispDeviceDepth,
+		     boot_infos->dispDeviceRowBytes, addr, NULL);
     }

     for (dpy = 0; dpy < prom_num_displays; dpy++) {
 	if ((dp = find_path_device(prom_display_paths[dpy])))
-	    if (ofonly || !offb_init_driver(dp))
-		offb_init_nodriver(dp);
-    }
-
-    if (!ofonly) {
-	for (dp = find_type_devices("display"); dp != NULL; dp = dp->next) {
-	    for (dpy = 0; dpy < prom_num_displays; dpy++)
-		if (strcmp(dp->full_name, prom_display_paths[dpy]) == 0)
-		    break;
-	    if (dpy >= prom_num_displays && dp != macos_display)
-		offb_init_driver(dp);
-	}
+	    offb_init_nodriver(dp);
     }
     return 0;
 }


-    /*
-     *  This function is intended to go away as soon as all OF-aware frame
-     *  buffer device drivers have been converted to use PCI probing and PCI
-     *  resources. [ Geert ]
-     */
-
-static int __init offb_init_driver(struct device_node *dp)
-{
-#ifdef CONFIG_FB_S3TRIO
-    if (!strncmp(dp->name, "S3Trio", 6)) {
-    	s3triofb_init_of(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_S3TRIO */
-#ifdef CONFIG_FB_IMSTT
-    if (!strncmp(dp->name, "IMS,tt", 6)) {
-	imsttfb_of_init(dp);
-	return 1;
-    }
-#endif
-#ifdef CONFIG_FB_CT65550
-    if (!strcmp(dp->name, "chips65550")) {
-	chips_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_CT65550 */
-#ifdef CONFIG_FB_CONTROL
-    if(!strcmp(dp->name, "control")) {
-	control_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_CONTROL */
-#ifdef CONFIG_FB_VALKYRIE
-    if(!strcmp(dp->name, "valkyrie")) {
-	valkyrie_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_VALKYRIE */
-#ifdef CONFIG_FB_PLATINUM
-    if (!strncmp(dp->name, "platinum",8)) {
-	platinum_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_PLATINUM */
-#ifdef CONFIG_FB_CLGEN
-    if (!strncmp(dp->name, "MacPicasso",10) || !strncmp(dp->name, "54m30",5)) {
-       clgen_of_init(dp);
-       return 1;
-    }
-#endif /* CONFIG_FB_CLGEN */
-    return 0;
-}
-
 static void __init offb_init_nodriver(struct device_node *dp)
 {
     int *pp, i;
@@ -710,21 +617,6 @@
 	console_fb_info = &info->info;
     }
 #endif /* CONFIG_FB_COMPAT_XPMAC) */
-}
-
-
-    /*
-     *  Setup: parse used options
-     */
-
-int offb_setup(char *options)
-{
-    if (!options || !*options)
-	return 0;
-
-    if (!strcmp(options, "ofonly"))
-	ofonly = 1;
-    return 0;
 }


--- linux-2.4.0-test5-pre5/drivers/video/Config.in	Tue Jul 18 14:07:21 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/Config.in	Thu Jul 27 14:32:30 2000
@@ -64,14 +64,12 @@
    fi
    if [ "$CONFIG_PPC" = "y" ]; then
       bool '  Open Firmware frame buffer device support' CONFIG_FB_OF
-      if [ "$CONFIG_FB_OF" = "y" ]; then
-	 bool '    Apple "control" display support' CONFIG_FB_CONTROL
-	 bool '    Apple "platinum" display support' CONFIG_FB_PLATINUM
-	 bool '    Apple "valkyrie" display support' CONFIG_FB_VALKYRIE
-	 bool '    IMS Twin Turbo display support' CONFIG_FB_IMSTT
-	 bool '    Chips 65550 display support' CONFIG_FB_CT65550
-	 bool '    S3 Trio display support' CONFIG_FB_S3TRIO
-      fi
+      bool '  Apple "control" display support' CONFIG_FB_CONTROL
+      bool '  Apple "platinum" display support' CONFIG_FB_PLATINUM
+      bool '  Apple "valkyrie" display support' CONFIG_FB_VALKYRIE
+      bool '  Chips 65550 display support' CONFIG_FB_CT65550
+      bool '  IMS Twin Turbo display support' CONFIG_FB_IMSTT
+      bool '  S3 Trio display support' CONFIG_FB_S3TRIO
       tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
    fi
    if [ "$CONFIG_MAC" = "y" ]; then
--- linux-2.4.0-test5-pre5/drivers/video/S3triofb.c	Wed Jul 26 20:15:08 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/S3triofb.c	Thu Jul 27 14:32:30 2000
@@ -77,6 +77,7 @@
      *  Interface used by the world
      */

+static void __init s3triofb_of_init(struct device_node *dp);
 static int s3trio_get_fix(struct fb_fix_screeninfo *fix, int con,
 			  struct fb_info *info);
 static int s3trio_get_var(struct fb_var_screeninfo *var, int con,
@@ -272,12 +273,11 @@

 int __init s3triofb_init(void)
 {
-#ifdef __powerpc__
-    /* We don't want to be called like this. */
-    /* We rely on Open Firmware (offb) instead. */
-#else /* !__powerpc__ */
-    /* To be merged with cybervision */
-#endif /* !__powerpc__ */
+	struct device_node *dp;
+
+	dp = find_devices("S3Trio");
+	if (dp != 0)
+	    s3triofb_of_init(dp);
 	return 0;
 }

@@ -385,10 +385,10 @@
      *  We heavily rely on OF for the moment. This needs fixing.
      */

-void __init s3triofb_init_of(struct device_node *dp)
+static void __init s3triofb_of_init(struct device_node *dp)
 {
     int i, *pp, len;
-    unsigned long address;
+    unsigned long address, size;
     u_long *CursorBase;

     strncat(s3trio_name, dp->name, sizeof(s3trio_name));
@@ -425,9 +425,13 @@
 	fb_fix.line_length = fb_var.xres_virtual;
     fb_fix.smem_len = fb_fix.line_length*fb_var.yres;

-    s3trio_init(dp);
     address = 0xc6000000;
-    s3trio_base = ioremap(address,64*1024*1024);
+    size = 64*1024*1024;
+    if (!request_mem_region(address, size, "S3triofb"))
+	return;
+
+    s3trio_init(dp);
+    s3trio_base = ioremap(address, size);
     fb_fix.smem_start = address;
     fb_fix.type = FB_TYPE_PACKED_PIXELS;
     fb_fix.type_aux = 0;
@@ -702,12 +706,6 @@
     else
 	fb_set_cmap(fb_default_cmap(fb_display[con].var.bits_per_pixel), 1,
 		    s3trio_setcolreg, &fb_info);
-}
-
-int s3triofb_setup(char *options) {
-
-        return 0;
-
 }

 static void Trio_WaitQueue(u_short fifo) {
--- linux-2.4.0-test5-pre5/drivers/video/imsttfb.c	Wed Jul 26 20:15:09 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/imsttfb.c	Thu Jul 27 14:32:30 2000
@@ -355,6 +355,7 @@
 	struct imstt_regvals init;
 	struct imstt_cursor cursor;
 	unsigned long frame_buffer_phys;
+	unsigned long board_size;
 	__u8 *frame_buffer;
 	unsigned long dc_regs_phys;
 	__u32 *dc_regs;
@@ -1879,62 +1880,13 @@
 #endif /* CONFIG_FB_COMPAT_XPMAC */
 }

-#if defined(CONFIG_FB_OF) && !defined(MODULE)
-void __init
-imsttfb_of_init(struct device_node *dp)
-{
-	struct fb_info_imstt *p;
-	int i;
-	__u32 addr = 0;
-	__u8 bus, devfn;
-	__u16 cmd;
-
-	for (i = 0; i < dp->n_addrs; i++) {
-		if (dp->addrs[i].size >= 0x02000000)
-			addr = dp->addrs[i].address;
-	}
-	if (!addr)
-		return;
-
-	if (!pci_device_loc(dp, &bus, &devfn)) {
-		if (!pcibios_read_config_word(bus, devfn, PCI_COMMAND, &cmd) && !(cmd & PCI_COMMAND_MEMORY)) {
-			cmd |= PCI_COMMAND_MEMORY;
-			pcibios_write_config_word(bus, devfn, PCI_COMMAND, cmd);
-		}
-	}
-
-	p = kmalloc(sizeof(struct fb_info_imstt), GFP_ATOMIC);
-	if (!p)
-		return;
-	memset(p, 0, sizeof(struct fb_info_imstt));
-
-	if (dp->name[11] == '8' || (dp->name[6] == '3' && dp->name[7] == 'd'))
-		p->ramdac = TVP;
-	else
-		p->ramdac = IBM;
-
-	p->frame_buffer_phys = addr;
-	p->frame_buffer = (__u8 *)ioremap(addr, p->ramdac == IBM ? 0x400000 : 0x800000);
-	p->dc_regs_phys = addr + 0x800000;
-	p->dc_regs = (__u32 *)ioremap(addr + 0x800000, 0x1000);
-	p->cmap_regs_phys = addr + 0x840000;
-	p->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
-
-	init_imstt(p);
-}
-#endif
-
 int __init
 imsttfb_init(void)
 {
 	int i;
-#if defined(CONFIG_FB_OF) && !defined(MODULE)
-	/* We don't want to be called like this. */
-	/* We rely on Open Firmware (offb) instead. */
-#elif defined(CONFIG_PCI)
 	struct pci_dev *pdev = NULL;
 	struct fb_info_imstt *p;
-	__u32 addr;
+	unsigned long addr, size;
 	__u16 cmd;

 	while ((pdev = pci_find_device(PCI_VENDOR_ID_IMS, PCI_ANY_ID, pdev))) {
@@ -1944,6 +1896,7 @@
 			continue;

 		addr = pci_resource_start (pdev, 0);
+		size = pci_resource_len (pdev, 0);
 		if (!addr)
 			continue;

@@ -1952,6 +1905,10 @@
 			continue;
 		memset(p, 0, sizeof(struct fb_info_imstt));

+		if (!request_mem_region(addr, size, "imsttfb")) {
+			kfree(p);
+			continue;
+		}
 		printk("imsttfb: device=%04x\n", pdev->device);

 		switch (pdev->device) {
@@ -1965,6 +1922,7 @@
 		}

 		p->frame_buffer_phys = addr;
+		p->board_size = size;
 		p->frame_buffer = (__u8 *)ioremap(addr, p->ramdac == IBM ? 0x400000 : 0x800000);
 		p->dc_regs_phys = addr + 0x800000;
 		p->dc_regs = (__u32 *)ioremap(addr + 0x800000, 0x1000);
@@ -1973,7 +1931,6 @@

 		init_imstt(p);
 	}
-#endif /* CONFIG_PCI */
 	for (i = 0; i < FB_MAX; i++) {
 		if (fb_info_imstt_p[i])
 			return 0;
@@ -2059,6 +2016,7 @@
 		iounmap(p->dc_regs);
 		iounmap(p->frame_buffer);
 		kfree(p);
+		release_mem_region(p->frame_buffer_phys, p->board_size);
 	}
 }

--- linux-2.4.0-test5-pre5/drivers/video/valkyriefb.h	Tue Jul 18 14:07:22 2000
+++ geert-offb-2.4.0-test5-pre5/drivers/video/valkyriefb.h	Thu Jul 27 15:07:06 2000
@@ -1,10 +1,13 @@
 /*
  * valkyriefb.h: Constants of all sorts for valkyriefb
  *
- * Created 8 August 1998 by Martin Costabel and Kevin Schoedel
+ *  Created 8 August 1998 by
+ *  Martin Costabel <costabel@wanadoo.fr> and Kevin Schoedel
  *
  * Vmode-switching changes and vmode 15/17 modifications created 29 August
  * 1998 by Barry K. Nathan <barryn@pobox.com>.
+ *
+ * vmode 10 changed by Steven Borley <sjb@salix.demon.co.uk>, 14 mai 2000
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -141,7 +144,8 @@
 /* Register values for 800x600, 60Hz mode (10) */
 static struct valkyrie_regvals valkyrie_reg_init_10 = {
     12,
-    { 20, 53, 2 },  /* pixel clock = 41.41MHz for V=59.78Hz */
+    { 25, 32, 3 },  /* pixel clock = 40.0015MHz,
+                     used to be 20,53,2, pixel clock 41.41MHz for V=59.78Hz */
     { 800, 1600 },
 	800, 600
 };

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

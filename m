Date: Sat, 3 Jun 2000 09:38:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: toe@unlserve.unl.edu,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <200006030628.IAA00691@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.05.10006030855010.1278-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Jun 2000, Michel Lanners wrote:
> For those with multiple display adapters, do you think an option
> controlfb:off might make sense? As there is no way to control which card
> gets assigned which framebuffer device, that might help in certain
> situations...

Immediately after I read this, I thought: isn't that already implemented
through fbmem.c? Then I remembered that controlfb is initialized from offb, and
not directly from fbmem_init().

I looked at the source, and surprise, controlfb can also be initialised on its
own:

    int __init control_init(void)
    {
    #ifndef CONFIG_FB_OF
	    struct device_node *dp;

	    dp = find_devices("control");
	    if (dp != 0)
		    control_of_init(dp);
    #endif /* CONFIG_FB_OF */
	    return 0;
    }

    void __init control_of_init(struct device_node *dp)
    {
	...
    }

Thus if you compile a kernel with CONFIG_FB_OF=n, controlfb will still work! In
addition you can disable it with video=controlfb:off!

If controlfb would (1) use request_mem_region() to mark the I/O regions it uses
busy and (2) be initialized before offb, it would also work when offb is
present and we can remove the test for a control display from offb.

Below you can find an (untested) patch that illustrates this idea. Can someone
please take a look at this?

A similar thing can be done for at least platinumfb, valkyriefb, chipsfb and
imsttfb. Five more steps closer to the removal of offb_init_driver()!

--- controlfb-2.4.0-test1/drivers/video/Config.in.orig	Thu May 25 08:31:53 2000
+++ controlfb-2.4.0-test1/drivers/video/Config.in	Sat Jun  3 09:09:57 2000
@@ -64,8 +64,8 @@
    fi
    if [ "$CONFIG_PPC" = "y" ]; then
       bool '  Open Firmware frame buffer device support' CONFIG_FB_OF
+      bool '    Apple "control" display support' CONFIG_FB_CONTROL
       if [ "$CONFIG_FB_OF" = "y" ]; then
-	 bool '    Apple "control" display support' CONFIG_FB_CONTROL
 	 bool '    Apple "platinum" display support' CONFIG_FB_PLATINUM
 	 bool '    Apple "valkyrie" display support' CONFIG_FB_VALKYRIE
 	 bool '    IMS Twin Turbo display support' CONFIG_FB_IMSTT
--- controlfb-2.4.0-test1/drivers/video/offb.c.orig	Fri Mar 24 09:54:46 2000
+++ controlfb-2.4.0-test1/drivers/video/offb.c	Sat Jun  3 09:06:15 2000
@@ -296,9 +296,6 @@
 #ifdef CONFIG_FB_MATROX
 extern int matrox_of_init(struct device_node *dp);
 #endif /* CONFIG_FB_MATROX */
-#ifdef CONFIG_FB_CONTROL
-extern void control_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_CONTROL */
 #ifdef CONFIG_FB_VALKYRIE
 extern void valkyrie_of_init(struct device_node *dp);
 #endif /* CONFIG_FB_VALKYRIE */
@@ -435,12 +432,6 @@
 	return 1;
     }
 #endif /* CONFIG_FB_MATROX */
-#ifdef CONFIG_FB_CONTROL
-    if(!strcmp(dp->name, "control")) {
-	control_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_CONTROL */
 #ifdef CONFIG_FB_VALKYRIE
     if(!strcmp(dp->name, "valkyrie")) {
 	valkyrie_of_init(dp);
--- controlfb-2.4.0-test1/drivers/video/fbmem.c.orig	Fri May 26 14:56:33 2000
+++ controlfb-2.4.0-test1/drivers/video/fbmem.c	Sat Jun  3 09:11:12 2000
@@ -165,10 +165,13 @@
 #ifdef CONFIG_FB_ATY128
 	{ "aty128fb", aty128fb_init, aty128fb_setup },
 #endif
+#ifdef CONFIG_FB_CONTROL
+	{ "controlfb", control_init, control_setup },
+#endif
 #ifdef CONFIG_FB_OF
 	/*
 	 * Offb must be initialized _after_ all other frame buffer devices
-	 * that use PCI probing and PCI resources! [ Geert ]
+	 * that use I/O memory resources! [ Geert ]
 	 */
 	{ "offb", offb_init, offb_setup },
 #endif
@@ -211,9 +214,6 @@
 #ifdef CONFIG_FB_HP300
 	{ "hpfb", hpfb_init, hpfb_setup },
 #endif
-#ifdef CONFIG_FB_CONTROL
-	{ "controlfb", control_init, control_setup },
-#endif
 #ifdef CONFIG_FB_VALKYRIE
 	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
 #endif
--- controlfb-2.4.0-test1/drivers/video/controlfb.c.orig	Sat Jun  3 09:31:18 2000
+++ controlfb-2.4.0-test1/drivers/video/controlfb.c	Sat Jun  3 09:17:34 2000
@@ -150,9 +150,6 @@
  * Exported functions
  */
 int control_init(void);
-#ifdef CONFIG_FB_OF
-void control_of_init(struct device_node *dp);
-#endif
 void control_setup(char *);

 static int read_control_sense(struct fb_info_control *p);
@@ -202,19 +199,12 @@
 #ifdef MODULE
 int init_module(void)
 {
-	struct device_node *dp;
-
-	printk("Loading...\n");
-	dp = find_devices("control");
-	if (dp != 0)
-		control_of_init(dp);
-	else
-		printk("Failed.\n");
-	printk("Done.\n");
+	control_init();
 }

 void cleanup_module(void)
 {
+	/* FIXME: clean up */
 }
 #endif

@@ -664,35 +654,34 @@

 int __init control_init(void)
 {
-#ifndef CONFIG_FB_OF
 	struct device_node *dp;
-
-	dp = find_devices("control");
-	if (dp != 0)
-		control_of_init(dp);
-#endif /* CONFIG_FB_OF */
-	return 0;
-}
-
-void __init control_of_init(struct device_node *dp)
-{
 	struct fb_info_control	*p;
 	unsigned long		addr, size;
-	int			i, bank1, bank2;
+	int			i, j, bank1, bank2;
+
+	dp = find_devices("control");
+	if (dp == 0)
+		return 0;

 	if(dp->n_addrs != 2) {
 		printk(KERN_ERR "expecting 2 address for control (got %d)", dp->n_addrs);
-		return;
+		return 0;
 	}
 	p = kmalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == 0)
-		return;
+		return 0;
 	memset(p, 0, sizeof(*p));

 	/* Map in frame buffer and registers */
 	for (i = 0; i < dp->n_addrs; ++i) {
 		addr = dp->addrs[i].address;
 		size = dp->addrs[i].size;
+		if (!request_mem_region(addr, size, "controlfb")) {
+			for (j = 0; j < i; j++)
+				release_mem_region(addr, size);
+			kfree(p);
+			return 0;
+		}
 		if (size >= 0x800000) {
 			/* use the big-endian aperture (??) */
 			addr += 0x800000;
@@ -751,6 +740,7 @@
 		2 * (bank1 + bank2));

 	init_control(p);
+	return 0;
 }

 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

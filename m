Date: Mon, 22 Nov 1999 20:56:34 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Resource handling for offb
Message-ID: <Pine.LNX.4.05.9911222054100.369-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch adds resource handling to offb and atyfb. The idea is to use PCI
probing and PCI resources for all frame buffer device drivers, and to let offb
take whatever is left and not yet allocated. Then frame buffer device drivers
no longer have to be aware of Open Firmware.

As soon as all frame buffer device drivers are updated (I did atyfb only, as an
example), we can remove offb_init_driver().

--- chrp-2.3.28/drivers/video/offb.c.orig	Sat Oct 23 10:28:04 1999
+++ chrp-2.3.28/drivers/video/offb.c	Mon Nov 22 20:36:39 1999
@@ -26,6 +26,7 @@
 #include <linux/fb.h>
 #include <linux/selection.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
 #endif
@@ -290,9 +291,6 @@
 }
 
 
-#ifdef CONFIG_FB_ATY
-extern void atyfb_of_init(struct device_node *dp);
-#endif /* CONFIG_FB_ATY */
 #ifdef CONFIG_FB_ATY128
 extern void aty128fb_of_init(struct device_node *dp);
 #endif /* CONFIG_FB_ATY */
@@ -414,6 +412,13 @@
     return 0;
 }
 
+
+    /*
+     *  This function is intended to go away as soon as all OF-aware frame
+     *  buffer device drivers have been converted to use PCI probing and PCI
+     *  resources. [ Geert ]
+     */
+
 static int __init offb_init_driver(struct device_node *dp)
 {
 #ifdef CONFIG_FB_ATY128
@@ -422,12 +427,6 @@
 	return 1;
     }
 #endif
-#ifdef CONFIG_FB_ATY
-    if (!strncmp(dp->name, "ATY", 3)) {
-	atyfb_of_init(dp);
-	return 1;
-    }
-#endif /* CONFIG_FB_ATY */
 #ifdef CONFIG_FB_S3TRIO
     if (!strncmp(dp->name, "S3Trio", 6)) {
     	s3triofb_init_of(dp);
@@ -506,7 +505,7 @@
 	address = (u_long)*up;
     else {
 	for (i = 0; i < dp->n_addrs; ++i)
-	    if (dp->addrs[i].size >= len)
+	    if (dp->addrs[i].size >= pitch*height*depth/8)
 		break;
 	if (i >= dp->n_addrs) {
 	    printk(KERN_ERR "no framebuffer address found for %s\n", dp->full_name);
@@ -533,17 +532,29 @@
     struct fb_var_screeninfo *var;
     struct display *disp;
     struct fb_info_offb *info;
+    unsigned long res_start = address;
+    unsigned long res_size = pitch*height*depth/8;
+
+    if (!request_mem_region(res_start, res_size, "offb")) {
+printk("offb_init_fb: region %p-%p is busy\n", (void *)res_start, (void *)res_start+res_size);
+	return;
+    } else {
+printk("offb_init_fb: requested region %p-%p\n", (void *)res_start, (void *)res_start+res_size);
+    }
 
     printk(KERN_INFO "Using unsupported %dx%d %s at %lx, depth=%d, pitch=%d\n",
 	   width, height, name, address, depth, pitch);
     if (depth != 8 && depth != 16 && depth != 32) {
 	printk(KERN_ERR "%s: can't use depth = %d\n", full_name, depth);
+	release_mem_region(res_start, res_size);
 	return;
     }
 
     info = kmalloc(sizeof(struct fb_info_offb), GFP_ATOMIC);
-    if (info == 0)
+    if (info == 0) {
+	release_mem_region(res_start, res_size);
 	return;
+    }
     memset(info, 0, sizeof(*info));
 
     fix = &info->fix;
@@ -707,6 +718,7 @@
 
     if (register_framebuffer(&info->info) < 0) {
 	kfree(info);
+	release_mem_region(res_start, res_size);
 	return;
     }
 
--- chrp-2.3.28/drivers/video/atyfb.c.orig	Sun Nov  7 20:57:55 1999
+++ chrp-2.3.28/drivers/video/atyfb.c	Mon Nov 22 20:34:15 1999
@@ -470,9 +470,6 @@
      */
 
 int atyfb_init(void);
-#ifdef CONFIG_FB_OF
-void atyfb_of_init(struct device_node *dp);
-#endif
 #ifndef MODULE
 int atyfb_setup(char*);
 #endif
@@ -3614,13 +3611,10 @@
 
 int __init atyfb_init(void)
 {
-#if defined(CONFIG_FB_OF)
-    /* We don't want to be called like this. */
-    /* We rely on Open Firmware (offb) instead. */
-#elif defined(CONFIG_PCI)
+#if defined(CONFIG_PCI)
     struct pci_dev *pdev;
     struct fb_info_aty *info;
-    unsigned long addr;
+    unsigned long addr, res_start, res_size;
 #ifdef __sparc__
     extern void (*prom_palette) (int);
     extern int con_is_present(void);
@@ -3656,6 +3650,16 @@
 	    if (!addr)
 		continue;
 
+	    res_start = rp->start;
+	    res_size = rp->end-rp->start;
+	    if (!request_mem_region(res_start, res_size,
+				  "atyfb")) {
+printk("atyfb_init: region %p-%p is busy\n", (void *)res_start, (void *)res_start+res_size);
+		continue;
+	    } else {
+printk("atyfb_init: requested region %p-%p\n", (void *)res_start, (void *)res_start+res_size);
+	    }
+
 #ifdef __sparc__
 	    /*
 	     * Map memory-mapped registers.
@@ -3681,6 +3685,7 @@
 	    if (!info->mmap_map) {
 		printk("atyfb_init: can't alloc mmap_map\n");
 		kfree(info);
+		release_mem_region(res_start, res_size);
 		return -ENXIO;
 	    }
 	    memset(info->mmap_map, 0, j * sizeof(*info->mmap_map));
@@ -3860,6 +3865,7 @@
 
 	    if(!info->ati_regbase) {
 		    kfree(info);
+		    release_mem_region(res_start, res_size);
 		    return -ENOMEM;
 	    }
 
@@ -3887,6 +3893,7 @@
 
 	    if(!info->frame_buffer) {
 		    kfree(info);
+		    release_mem_region(res_start, res_size);
 		    return -ENXIO;
 	    }
 
@@ -3896,6 +3903,7 @@
 		if (info->mmap_map)
 		    kfree(info->mmap_map);
 		kfree(info);
+		release_mem_region(res_start, res_size);
 		return -ENXIO;
 	    }
 
@@ -3917,6 +3925,18 @@
 	    info->mmap_map[1].prot_mask = _PAGE_CACHE;
 	    info->mmap_map[1].prot_flag = _PAGE_E;
 #endif /* __sparc__ */
+
+#ifdef CONFIG_PMAC_PBOOK
+	    if (first_display == NULL)
+		pmu_register_sleep_notifier(&aty_sleep_notifier);
+	    info->next = first_display;
+	    first_display = info;
+#endif
+
+#ifdef CONFIG_FB_COMPAT_XPMAC
+	    if (!console_fb_info)
+		console_fb_info = &info->fb_info;
+#endif /* CONFIG_FB_COMPAT_XPMAC */
 	}
     }
 
@@ -3980,99 +4000,6 @@
 #ifdef CONFIG_FB_OF
 void __init atyfb_of_init(struct device_node *dp)
 {
-    unsigned long addr;
-    u8 bus, devfn;
-    u16 cmd;
-    struct fb_info_aty *info;
-    int i;
-
-    if (device_is_compatible(dp, "ATY,264LTPro")) {
-	/* XXX kludge for now */
-	if (dp->name == 0 || strcmp(dp->name, "ATY,264LTProA") != 0
-	    || dp->parent == 0)
-	    return;
-	dp = dp->parent;
-    }
-    switch (dp->n_addrs) {
-	case 1:
-	case 2:
-	case 3:
-	    addr = dp->addrs[0].address;
-	    break;
-	case 4:
-	    addr = dp->addrs[1].address;
-	    break;
-	default:
-	    printk("Warning: got %d adresses for ATY:\n", dp->n_addrs);
-	    for (i = 0; i < dp->n_addrs; i++)
-		printk(" %08x-%08x", dp->addrs[i].address,
-		       dp->addrs[i].address+dp->addrs[i].size-1);
-	    if (dp->n_addrs)
-		printk("\n");
-	    return;
-    }
-
-    info = kmalloc(sizeof(struct fb_info_aty), GFP_ATOMIC);
-    if (!info) {
-	printk("atyfb_of_init: can't alloc fb_info_aty\n");
-	return;
-    }
-    memset(info, 0, sizeof(struct fb_info_aty));
-
-    info->ati_regbase_phys = 0x7ff000+addr;
-    info->ati_regbase = (unsigned long)ioremap(info->ati_regbase_phys,
-						   0x1000);
-
-    if(! info->ati_regbase) {
-	    printk("atyfb_of_init: ioremap() returned NULL\n");
-	    kfree(info);
-	    return;
-    }
-
-    info->ati_regbase_phys += 0xc00;
-    info->ati_regbase += 0xc00;
-
-    /* enable memory-space accesses using config-space command register */
-    if (pci_device_loc(dp, &bus, &devfn) == 0) {
-	pcibios_read_config_word(bus, devfn, PCI_COMMAND, &cmd);
-	if (cmd != 0xffff) {
-	    cmd |= PCI_COMMAND_MEMORY;
-	    pcibios_write_config_word(bus, devfn, PCI_COMMAND, cmd);
-	}
-    }
-
-#ifdef __BIG_ENDIAN
-    /* Use the big-endian aperture */
-    addr += 0x800000;
-#endif
-
-    /* Map in frame buffer */
-    info->frame_buffer_phys = addr;
-    info->frame_buffer = (unsigned long)ioremap(addr, 0x800000);
-
-    if(! info->frame_buffer) {
-	    printk("atyfb_of_init: ioremap() returned NULL\n");
-	    kfree(info);
-	    return;
-    }
-
-    if (!aty_init(info, dp->full_name)) {
-	kfree(info);
-	return;
-    }
-
-#ifdef CONFIG_PMAC_PBOOK
-    if (first_display == NULL)
-	pmu_register_sleep_notifier(&aty_sleep_notifier);
-    info->next = first_display;
-    first_display = info;
-#endif
-	
-
-#ifdef CONFIG_FB_COMPAT_XPMAC
-    if (!console_fb_info)
-	console_fb_info = &info->fb_info;
-#endif /* CONFIG_FB_COMPAT_XPMAC */
 }
 #endif /* CONFIG_FB_OF */
 
--- chrp-2.3.28/drivers/video/fbmem.c.orig	Sun Nov  7 20:57:55 1999
+++ chrp-2.3.28/drivers/video/fbmem.c	Mon Nov 22 20:34:15 1999
@@ -145,14 +145,18 @@
 #ifdef CONFIG_FB_CLGEN
 	{ "clgen", clgenfb_init, clgenfb_setup },
 #endif
+#ifdef CONFIG_FB_ATY
+	{ "atyfb", atyfb_init, atyfb_setup },
+#endif
 #ifdef CONFIG_FB_OF
+	/*
+	 * Offb must be initialized _after_ all other frame buffer devices
+	 * that use PCI probing and PCI resources! [ Geert ]
+	 */
 	{ "offb", offb_init, offb_setup },
 #endif
 #ifdef CONFIG_FB_SBUS
 	{ "sbus", sbusfb_init, sbusfb_setup },
-#endif
-#ifdef CONFIG_FB_ATY
-	{ "atyfb", atyfb_init, atyfb_setup },
 #endif
 #ifdef CONFIG_FB_ATY128
 	{ "aty128fb", aty128fb_init, aty128fb_setup },

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

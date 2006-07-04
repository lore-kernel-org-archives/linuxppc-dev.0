Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36ADA67B9F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 17:07:31 +1000 (EST)
Subject: [PATCH] powerpc: More offb/bootx fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 17:07:18 +1000
Message-Id: <1151996838.13828.85.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There were still some issues with offb when BootX doesn't provide a
proper display node,
this fixes them. This also re-instates the palette hacks that were
disabled a couple of
kernel versions ago when I converted to the new OF parsing and shuffles
some functions
around to avoid prototypes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/platforms/powermac/bootx_init.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/powermac/bootx_init.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/powermac/bootx_init.c	2006-07-04 17:05:13.000000000 +1000
@@ -181,13 +181,18 @@
 }
 
 static void __init bootx_add_display_props(unsigned long base,
-					   unsigned long *mem_end)
+					   unsigned long *mem_end,
+					   int has_real_node)
 {
 	boot_infos_t *bi = bootx_info;
 	u32 tmp;
 
-	bootx_dt_add_prop("linux,boot-display", NULL, 0, mem_end);
-	bootx_dt_add_prop("linux,opened", NULL, 0, mem_end);
+	if (has_real_node) {
+		bootx_dt_add_prop("linux,boot-display", NULL, 0, mem_end);
+		bootx_dt_add_prop("linux,opened", NULL, 0, mem_end);
+	} else
+		bootx_dt_add_prop("linux,bootx-noscreen", NULL, 0, mem_end);
+
 	tmp = bi->dispDeviceDepth;
 	bootx_dt_add_prop("linux,bootx-depth", &tmp, 4, mem_end);
 	tmp = bi->dispDeviceRect[2] - bi->dispDeviceRect[0];
@@ -241,11 +246,6 @@
 		DBG(" detected display ! adding properties names !\n");
 		bootx_dt_add_string("linux,boot-display", mem_end);
 		bootx_dt_add_string("linux,opened", mem_end);
-		bootx_dt_add_string("linux,bootx-depth", mem_end);
-		bootx_dt_add_string("linux,bootx-width", mem_end);
-		bootx_dt_add_string("linux,bootx-height", mem_end);
-		bootx_dt_add_string("linux,bootx-linebytes", mem_end);
-		bootx_dt_add_string("linux,bootx-addr", mem_end);
 		strncpy(bootx_disp_path, namep, 255);
 	}
 
@@ -329,10 +329,13 @@
 		ppp = &pp->next;
 	}
 
-	if (node == bootx_node_chosen)
+	if (node == bootx_node_chosen) {
 		bootx_add_chosen_props(base, mem_end);
-	if (node == bootx_info->dispDeviceRegEntryOffset)
-		bootx_add_display_props(base, mem_end);
+		if (bootx_info->dispDeviceRegEntryOffset == 0)
+			bootx_add_display_props(base, mem_end, 0);
+	}
+	else if (node == bootx_info->dispDeviceRegEntryOffset)
+		bootx_add_display_props(base, mem_end, 1);
 
 	/* do all our children */
 	cpp = &np->child;
@@ -374,6 +377,14 @@
 	mem_end += 4;
 	bootx_dt_strend = mem_end;
 	bootx_scan_dt_build_strings(base, 4, &mem_end);
+	/* Add some strings */
+	bootx_dt_add_string("linux,bootx-noscreen", &mem_end);
+	bootx_dt_add_string("linux,bootx-depth", &mem_end);
+	bootx_dt_add_string("linux,bootx-width", &mem_end);
+	bootx_dt_add_string("linux,bootx-height", &mem_end);
+	bootx_dt_add_string("linux,bootx-linebytes", &mem_end);
+	bootx_dt_add_string("linux,bootx-addr", &mem_end);
+	/* Wrap up strings */
 	hdr->off_dt_strings = bootx_dt_strbase - mem_start;
 	hdr->dt_strings_size = bootx_dt_strend - bootx_dt_strbase;
 
@@ -471,6 +482,7 @@
 	if (bi->dispDeviceDepth == 16)
 		bi->dispDeviceDepth = 15;
 
+
 #ifdef CONFIG_BOOTX_TEXT
 	ptr = (unsigned long)bi->logicalDisplayBase;
 	ptr += bi->dispDeviceRect[1] * bi->dispDeviceRowBytes;
@@ -508,6 +520,7 @@
 #ifdef CONFIG_BOOTX_TEXT
 	btext_welcome(bi);
 #endif
+
 	/* New BootX enters kernel with MMU off, i/os are not allowed
 	 * here. This hack will have been done by the boostrap anyway.
 	 */
Index: linux-irq-work/drivers/video/offb.c
===================================================================
--- linux-irq-work.orig/drivers/video/offb.c	2006-07-04 09:37:04.000000000 +1000
+++ linux-irq-work/drivers/video/offb.c	2006-07-04 16:52:37.000000000 +1000
@@ -63,8 +63,6 @@
      *  Interface used by the world
      */
 
-int offb_init(void);
-
 static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			  u_int transp, struct fb_info *info);
 static int offb_blank(int blank, struct fb_info *info);
@@ -73,11 +71,6 @@
 extern boot_infos_t *boot_infos;
 #endif
 
-static void offb_init_nodriver(struct device_node *);
-static void offb_init_fb(const char *name, const char *full_name,
-			 int width, int height, int depth, int pitch,
-			 unsigned long address, struct device_node *dp);
-
 static struct fb_ops offb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_setcolreg	= offb_setcolreg,
@@ -230,123 +223,17 @@
 	return 0;
 }
 
-    /*
-     *  Initialisation
-     */
 
-int __init offb_init(void)
+static void __iomem *offb_map_reg(struct device_node *np, int index,
+				  unsigned long offset, unsigned long size)
 {
-	struct device_node *dp = NULL, *boot_disp = NULL;
-
-	if (fb_get_options("offb", NULL))
-		return -ENODEV;
+	struct resource r;
 
-	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
-		if (get_property(dp, "linux,opened", NULL) &&
-		    get_property(dp, "linux,boot-display", NULL)) {
-			boot_disp = dp;
-			offb_init_nodriver(dp);
-		}
-	}
-	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
-		if (get_property(dp, "linux,opened", NULL) &&
-		    dp != boot_disp)
-			offb_init_nodriver(dp);
-	}
-
-	return 0;
-}
-
-
-static void __init offb_init_nodriver(struct device_node *dp)
-{
-	unsigned int len;
-	int i, width = 640, height = 480, depth = 8, pitch = 640;
-	unsigned int flags, rsize, addr_prop = 0;
-	unsigned long max_size = 0;
-	u64 rstart, address = OF_BAD_ADDR;
-	u32 *pp, *addrp, *up;
-	u64 asize;
-
-	pp = (u32 *)get_property(dp, "linux,bootx-depth", &len);
-	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "depth", &len);
-	if (pp && len == sizeof(u32))
-		depth = *pp;
-
-	pp = (u32 *)get_property(dp, "linux,bootx-width", &len);
-	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "width", &len);
-	if (pp && len == sizeof(u32))
-		width = *pp;
-
-	pp = (u32 *)get_property(dp, "linux,bootx-height", &len);
-	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "height", &len);
-	if (pp && len == sizeof(u32))
-		height = *pp;
-
-	pp = (u32 *)get_property(dp, "linux,bootx-linebytes", &len);
-	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "linebytes", &len);
-	if (pp && len == sizeof(u32))
-		pitch = *pp;
-	else
-		pitch = width * ((depth + 7) / 8);
-
-	rsize = (unsigned long)pitch * (unsigned long)height;
-
-	/* Ok, now we try to figure out the address of the framebuffer.
-	 *
-	 * Unfortunately, Open Firmware doesn't provide a standard way to do
-	 * so. All we can do is a dodgy heuristic that happens to work in
-	 * practice. On most machines, the "address" property contains what
-	 * we need, though not on Matrox cards found in IBM machines. What I've
-	 * found that appears to give good results is to go through the PCI
-	 * ranges and pick one that is both big enough and if possible encloses
-	 * the "address" property. If none match, we pick the biggest
-	 */
-	up = (u32 *)get_property(dp, "linux,bootx-addr", &len);
-	if (up == NULL)
-		up = (u32 *)get_property(dp, "address", &len);
-	if (up && len == sizeof(u32))
-		addr_prop = *up;
-
-	for (i = 0; (addrp = of_get_address(dp, i, &asize, &flags))
-		     != NULL; i++) {
-		int match_addrp = 0;
-
-		if (!(flags & IORESOURCE_MEM))
-			continue;
-		if (asize < rsize)
-			continue;
-		rstart = of_translate_address(dp, addrp);
-		if (rstart == OF_BAD_ADDR)
-			continue;
-		if (addr_prop && (rstart <= addr_prop) &&
-		    ((rstart + asize) >= (addr_prop + rsize)))
-			match_addrp = 1;
-		if (match_addrp) {
-			address = addr_prop;
-			break;
-		}
-		if (rsize > max_size) {
-			max_size = rsize;
-			address = OF_BAD_ADDR;
- 		}
-
-		if (address == OF_BAD_ADDR)
-			address = rstart;
-	}
-	if (address == OF_BAD_ADDR && addr_prop)
-		address = (u64)addr_prop;
-	if (address != OF_BAD_ADDR) {
-		/* kludge for valkyrie */
-		if (strcmp(dp->name, "valkyrie") == 0)
-			address += 0x1000;
-		offb_init_fb(dp->name, dp->full_name, width, height, depth,
-			     pitch, address, dp);
-	}
+	if (of_address_to_resource(np, index, &r))
+		return 0;
+	if ((r.start + offset + size) > r.end)
+		return 0;
+	return ioremap(r.start + offset, size);
 }
 
 static void __init offb_init_fb(const char *name, const char *full_name,
@@ -403,45 +290,39 @@
 
 	par->cmap_type = cmap_unknown;
 	if (depth == 8) {
-
 		/* Palette hacks disabled for now */
-#if 0
 		if (dp && !strncmp(name, "ATY,Rage128", 11)) {
-			unsigned long regbase = dp->addrs[2].address;
-			par->cmap_adr = ioremap(regbase, 0x1FFF);
-			par->cmap_type = cmap_r128;
+			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_r128;
 		} else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
 				  || !strncmp(name, "ATY,RageM3p12A", 14))) {
-			unsigned long regbase =
-			    dp->parent->addrs[2].address;
-			par->cmap_adr = ioremap(regbase, 0x1FFF);
-			par->cmap_type = cmap_M3A;
+			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_M3A;
 		} else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
-			unsigned long regbase =
-			    dp->parent->addrs[2].address;
-			par->cmap_adr = ioremap(regbase, 0x1FFF);
-			par->cmap_type = cmap_M3B;
+			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_M3B;
 		} else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
-			unsigned long regbase = dp->addrs[1].address;
-			par->cmap_adr = ioremap(regbase, 0x1FFF);
-			par->cmap_type = cmap_radeon;
+			par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_radeon;
 		} else if (!strncmp(name, "ATY,", 4)) {
 			unsigned long base = address & 0xff000000UL;
 			par->cmap_adr =
 			    ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
 			par->cmap_data = par->cmap_adr + 1;
 			par->cmap_type = cmap_m64;
-		} else if (device_is_compatible(dp, "pci1014,b7")) {
-			unsigned long regbase = dp->addrs[0].address;
-			par->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
-			par->cmap_type = cmap_gxt2000;
+		} else if (dp && device_is_compatible(dp, "pci1014,b7")) {
+			par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_gxt2000;
 		}
-#endif
-		fix->visual = par->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
-		    : FB_VISUAL_STATIC_PSEUDOCOLOR;
+		fix->visual = (par->cmap_type != cmap_unknown) ?
+			FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;
 	} else
-		fix->visual =	/* par->cmap_adr ? FB_VISUAL_DIRECTCOLOR
-				   : */ FB_VISUAL_TRUECOLOR;
+		fix->visual = FB_VISUAL_TRUECOLOR;
 
 	var->xoffset = var->yoffset = 0;
 	switch (depth) {
@@ -521,5 +402,139 @@
 	       info->node, full_name);
 }
 
+
+static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
+{
+	unsigned int len;
+	int i, width = 640, height = 480, depth = 8, pitch = 640;
+	unsigned int flags, rsize, addr_prop = 0;
+	unsigned long max_size = 0;
+	u64 rstart, address = OF_BAD_ADDR;
+	u32 *pp, *addrp, *up;
+	u64 asize;
+
+	pp = (u32 *)get_property(dp, "linux,bootx-depth", &len);
+	if (pp == NULL)
+		pp = (u32 *)get_property(dp, "depth", &len);
+	if (pp && len == sizeof(u32))
+		depth = *pp;
+
+	pp = (u32 *)get_property(dp, "linux,bootx-width", &len);
+	if (pp == NULL)
+		pp = (u32 *)get_property(dp, "width", &len);
+	if (pp && len == sizeof(u32))
+		width = *pp;
+
+	pp = (u32 *)get_property(dp, "linux,bootx-height", &len);
+	if (pp == NULL)
+		pp = (u32 *)get_property(dp, "height", &len);
+	if (pp && len == sizeof(u32))
+		height = *pp;
+
+	pp = (u32 *)get_property(dp, "linux,bootx-linebytes", &len);
+	if (pp == NULL)
+		pp = (u32 *)get_property(dp, "linebytes", &len);
+	if (pp && len == sizeof(u32))
+		pitch = *pp;
+	else
+		pitch = width * ((depth + 7) / 8);
+
+	rsize = (unsigned long)pitch * (unsigned long)height;
+
+	/* Ok, now we try to figure out the address of the framebuffer.
+	 *
+	 * Unfortunately, Open Firmware doesn't provide a standard way to do
+	 * so. All we can do is a dodgy heuristic that happens to work in
+	 * practice. On most machines, the "address" property contains what
+	 * we need, though not on Matrox cards found in IBM machines. What I've
+	 * found that appears to give good results is to go through the PCI
+	 * ranges and pick one that is both big enough and if possible encloses
+	 * the "address" property. If none match, we pick the biggest
+	 */
+	up = (u32 *)get_property(dp, "linux,bootx-addr", &len);
+	if (up == NULL)
+		up = (u32 *)get_property(dp, "address", &len);
+	if (up && len == sizeof(u32))
+		addr_prop = *up;
+
+	/* Hack for when BootX is passing us */
+	if (no_real_node)
+		goto skip_addr;
+
+	for (i = 0; (addrp = of_get_address(dp, i, &asize, &flags))
+		     != NULL; i++) {
+		int match_addrp = 0;
+
+		if (!(flags & IORESOURCE_MEM))
+			continue;
+		if (asize < rsize)
+			continue;
+		rstart = of_translate_address(dp, addrp);
+		if (rstart == OF_BAD_ADDR)
+			continue;
+		if (addr_prop && (rstart <= addr_prop) &&
+		    ((rstart + asize) >= (addr_prop + rsize)))
+			match_addrp = 1;
+		if (match_addrp) {
+			address = addr_prop;
+			break;
+		}
+		if (rsize > max_size) {
+			max_size = rsize;
+			address = OF_BAD_ADDR;
+ 		}
+
+		if (address == OF_BAD_ADDR)
+			address = rstart;
+	}
+ skip_addr:
+	if (address == OF_BAD_ADDR && addr_prop)
+		address = (u64)addr_prop;
+	if (address != OF_BAD_ADDR) {
+		/* kludge for valkyrie */
+		if (strcmp(dp->name, "valkyrie") == 0)
+			address += 0x1000;
+		offb_init_fb(no_real_node ? "bootx" : dp->name,
+			     no_real_node ? "display" : dp->full_name,
+			     width, height, depth, pitch, address,
+			     no_real_node ? dp : NULL);
+	}
+}
+
+static int __init offb_init(void)
+{
+	struct device_node *dp = NULL, *boot_disp = NULL;
+
+	if (fb_get_options("offb", NULL))
+		return -ENODEV;
+
+	/* Check if we have a MacOS display without a node spec */
+	if (get_property(of_chosen, "linux,bootx-noscreen", NULL) != NULL) {
+		/* The old code tried to work out which node was the MacOS
+		 * display based on the address. I'm dropping that since the
+		 * lack of a node spec only happens with old BootX versions
+		 * (users can update) and with this code, they'll still get
+		 * a display (just not the palette hacks).
+		 */
+		offb_init_nodriver(of_chosen, 1);
+	}
+
+	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
+		if (get_property(dp, "linux,opened", NULL) &&
+		    get_property(dp, "linux,boot-display", NULL)) {
+			boot_disp = dp;
+			offb_init_nodriver(dp, 0);
+		}
+	}
+	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
+		if (get_property(dp, "linux,opened", NULL) &&
+		    dp != boot_disp)
+			offb_init_nodriver(dp, 0);
+	}
+
+	return 0;
+}
+
+
 module_init(offb_init);
 MODULE_LICENSE("GPL");

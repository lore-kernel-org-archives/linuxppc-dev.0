Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94CB2DDF01
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:05:33 +1000 (EST)
Subject: [PATCH] fbdev: Teaches offb about palette on radeon r5xx/r6xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 15:05:22 +1000
Message-Id: <1216271122.7740.290.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The offb driver already has a collection of hacks to be able to set
the palette on various chips. This adds support for r5xx/r6xx radeons.

This is needed as offb is the only console solution on these currently
and the firmware in some cases sets a really bad color palette. This
fixes using some Radeon X16xx on the Powerstation for example.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'm happy to merge that via the powerpc tree if there is no objection
as offb is a powerpc-only driver at this stage.

Index: linux-work/drivers/video/offb.c
===================================================================
--- linux-work.orig/drivers/video/offb.c	2008-07-14 15:57:58.000000000 +1000
+++ linux-work/drivers/video/offb.c	2008-07-15 11:12:56.000000000 +1000
@@ -47,6 +47,7 @@ enum {
 	cmap_M3B,		/* ATI Rage Mobility M3 Head B */
 	cmap_radeon,		/* ATI Radeon */
 	cmap_gxt2000,		/* IBM GXT2000 */
+	cmap_avivo,		/* ATI R5xx */
 };
 
 struct offb_par {
@@ -58,26 +59,36 @@ struct offb_par {
 
 struct offb_par default_par;
 
-    /*
-     *  Interface used by the world
-     */
-
-static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-			  u_int transp, struct fb_info *info);
-static int offb_blank(int blank, struct fb_info *info);
-
 #ifdef CONFIG_PPC32
 extern boot_infos_t *boot_infos;
 #endif
 
-static struct fb_ops offb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_setcolreg	= offb_setcolreg,
-	.fb_blank	= offb_blank,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
+/* Definitions used by the Avivo palette hack */
+#define AVIVO_DC_LUT_RW_SELECT                  0x6480
+#define AVIVO_DC_LUT_RW_MODE                    0x6484
+#define AVIVO_DC_LUT_RW_INDEX                   0x6488
+#define AVIVO_DC_LUT_SEQ_COLOR                  0x648c
+#define AVIVO_DC_LUT_PWL_DATA                   0x6490
+#define AVIVO_DC_LUT_30_COLOR                   0x6494
+#define AVIVO_DC_LUT_READ_PIPE_SELECT           0x6498
+#define AVIVO_DC_LUT_WRITE_EN_MASK              0x649c
+#define AVIVO_DC_LUT_AUTOFILL                   0x64a0
+
+#define AVIVO_DC_LUTA_CONTROL                   0x64c0
+#define AVIVO_DC_LUTA_BLACK_OFFSET_BLUE         0x64c4
+#define AVIVO_DC_LUTA_BLACK_OFFSET_GREEN        0x64c8
+#define AVIVO_DC_LUTA_BLACK_OFFSET_RED          0x64cc
+#define AVIVO_DC_LUTA_WHITE_OFFSET_BLUE         0x64d0
+#define AVIVO_DC_LUTA_WHITE_OFFSET_GREEN        0x64d4
+#define AVIVO_DC_LUTA_WHITE_OFFSET_RED          0x64d8
+
+#define AVIVO_DC_LUTB_CONTROL                   0x6cc0
+#define AVIVO_DC_LUTB_BLACK_OFFSET_BLUE         0x6cc4
+#define AVIVO_DC_LUTB_BLACK_OFFSET_GREEN        0x6cc8
+#define AVIVO_DC_LUTB_BLACK_OFFSET_RED          0x6ccc
+#define AVIVO_DC_LUTB_WHITE_OFFSET_BLUE         0x6cd0
+#define AVIVO_DC_LUTB_WHITE_OFFSET_GREEN        0x6cd4
+#define AVIVO_DC_LUTB_WHITE_OFFSET_RED          0x6cd8
 
     /*
      *  Set a single color register. The values supplied are already
@@ -160,6 +171,17 @@ static int offb_setcolreg(u_int regno, u
 		out_le32(((unsigned __iomem *) par->cmap_adr) + regno,
 			 (red << 16 | green << 8 | blue));
 		break;
+	case cmap_avivo:
+		/* Write to both LUTs for now */
+		writel(1, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+		writeb(regno, par->cmap_adr + AVIVO_DC_LUT_RW_INDEX);
+		writel(((red) << 22) | ((green) << 12) | ((blue) << 2),
+		       par->cmap_adr + AVIVO_DC_LUT_30_COLOR);
+		writel(0, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+		writeb(regno, par->cmap_adr + AVIVO_DC_LUT_RW_INDEX);
+		writel(((red) << 22) | ((green) << 12) | ((blue) << 2),
+		       par->cmap_adr + AVIVO_DC_LUT_30_COLOR);
+		break;
 	}
 
 	return 0;
@@ -216,12 +238,59 @@ static int offb_blank(int blank, struct 
 				out_le32(((unsigned __iomem *) par->cmap_adr) + i,
 					 0);
 				break;
+			case cmap_avivo:
+				writel(1, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+				writeb(i, par->cmap_adr + AVIVO_DC_LUT_RW_INDEX);
+				writel(0, par->cmap_adr + AVIVO_DC_LUT_30_COLOR);
+				writel(0, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+				writeb(i, par->cmap_adr + AVIVO_DC_LUT_RW_INDEX);
+				writel(0, par->cmap_adr + AVIVO_DC_LUT_30_COLOR);
+				break;
 			}
 	} else
 		fb_set_cmap(&info->cmap, info);
 	return 0;
 }
 
+static int offb_set_par(struct fb_info *info)
+{
+	struct offb_par *par = (struct offb_par *) info->par;
+
+	/* On avivo, initialize palette control */
+	if (par->cmap_type == cmap_avivo) {
+		writel(0, par->cmap_adr + AVIVO_DC_LUTA_CONTROL);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTA_BLACK_OFFSET_BLUE);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTA_BLACK_OFFSET_GREEN);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTA_BLACK_OFFSET_RED);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTA_WHITE_OFFSET_BLUE);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTA_WHITE_OFFSET_GREEN);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTA_WHITE_OFFSET_RED);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTB_CONTROL);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTB_BLACK_OFFSET_BLUE);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTB_BLACK_OFFSET_GREEN);
+		writel(0, par->cmap_adr + AVIVO_DC_LUTB_BLACK_OFFSET_RED);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTB_WHITE_OFFSET_BLUE);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTB_WHITE_OFFSET_GREEN);
+		writel(0x0000ffff, par->cmap_adr + AVIVO_DC_LUTB_WHITE_OFFSET_RED);
+		writel(1, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+		writel(0, par->cmap_adr + AVIVO_DC_LUT_RW_MODE);
+		writel(0x0000003f, par->cmap_adr + AVIVO_DC_LUT_WRITE_EN_MASK);
+		writel(0, par->cmap_adr + AVIVO_DC_LUT_RW_SELECT);
+		writel(0, par->cmap_adr + AVIVO_DC_LUT_RW_MODE);
+		writel(0x0000003f, par->cmap_adr + AVIVO_DC_LUT_WRITE_EN_MASK);
+	}
+	return 0;
+}
+
+static struct fb_ops offb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= offb_setcolreg,
+	.fb_set_par	= offb_set_par,
+	.fb_blank	= offb_blank,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
 
 static void __iomem *offb_map_reg(struct device_node *np, int index,
 				  unsigned long offset, unsigned long size)
@@ -245,6 +314,59 @@ static void __iomem *offb_map_reg(struct
 	return ioremap(taddr + offset, size);
 }
 
+static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp,
+				    const char *name, unsigned long address)
+{
+	struct offb_par *par = (struct offb_par *) info->par;
+
+	if (dp && !strncmp(name, "ATY,Rage128", 11)) {
+		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+		if (par->cmap_adr)
+			par->cmap_type = cmap_r128;
+	} else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
+			  || !strncmp(name, "ATY,RageM3p12A", 14))) {
+		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+		if (par->cmap_adr)
+			par->cmap_type = cmap_M3A;
+	} else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
+		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
+		if (par->cmap_adr)
+			par->cmap_type = cmap_M3B;
+	} else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
+		par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
+		if (par->cmap_adr)
+			par->cmap_type = cmap_radeon;
+	} else if (!strncmp(name, "ATY,", 4)) {
+		unsigned long base = address & 0xff000000UL;
+		par->cmap_adr =
+			ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
+		par->cmap_data = par->cmap_adr + 1;
+		par->cmap_type = cmap_m64;
+	} else if (dp && (of_device_is_compatible(dp, "pci1014,b7") ||
+			  of_device_is_compatible(dp, "pci1014,21c"))) {
+		par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
+		if (par->cmap_adr)
+			par->cmap_type = cmap_gxt2000;
+	} else if (dp && !strncmp(name, "vga,Display-", 12)) {
+		/* Look for AVIVO initialized by SLOF */
+		struct device_node *pciparent = of_get_parent(dp);
+		const u32 *vid, *did;
+		vid = of_get_property(pciparent, "vendor-id", NULL);
+		did = of_get_property(pciparent, "device-id", NULL);
+		/* This will match most R5xx */
+		if (vid && did && *vid == 0x1002 &&
+		    ((*did >= 0x7100 && *did < 0x7800) ||
+		     (*did >= 0x9400))) {
+			par->cmap_adr = offb_map_reg(pciparent, 2, 0, 0x10000);
+			if (par->cmap_adr)
+				par->cmap_type = cmap_avivo;
+		}
+		of_node_put(pciparent);
+	}
+	info->fix.visual = (par->cmap_type != cmap_unknown) ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;
+}
+
 static void __init offb_init_fb(const char *name, const char *full_name,
 				int width, int height, int depth,
 				int pitch, unsigned long address,
@@ -283,6 +405,7 @@ static void __init offb_init_fb(const ch
 
 	fix = &info->fix;
 	var = &info->var;
+	info->par = par;
 
 	strcpy(fix->id, "OFfb ");
 	strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
@@ -298,39 +421,9 @@ static void __init offb_init_fb(const ch
 	fix->type_aux = 0;
 
 	par->cmap_type = cmap_unknown;
-	if (depth == 8) {
-		if (dp && !strncmp(name, "ATY,Rage128", 11)) {
-			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
-			if (par->cmap_adr)
-				par->cmap_type = cmap_r128;
-		} else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
-				  || !strncmp(name, "ATY,RageM3p12A", 14))) {
-			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
-			if (par->cmap_adr)
-				par->cmap_type = cmap_M3A;
-		} else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
-			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
-			if (par->cmap_adr)
-				par->cmap_type = cmap_M3B;
-		} else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
-			par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
-			if (par->cmap_adr)
-				par->cmap_type = cmap_radeon;
-		} else if (!strncmp(name, "ATY,", 4)) {
-			unsigned long base = address & 0xff000000UL;
-			par->cmap_adr =
-			    ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
-			par->cmap_data = par->cmap_adr + 1;
-			par->cmap_type = cmap_m64;
-		} else if (dp && (of_device_is_compatible(dp, "pci1014,b7") ||
-				  of_device_is_compatible(dp, "pci1014,21c"))) {
-			par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
-			if (par->cmap_adr)
-				par->cmap_type = cmap_gxt2000;
-		}
-		fix->visual = (par->cmap_type != cmap_unknown) ?
-			FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;
-	} else
+	if (depth == 8)
+		offb_init_palette_hacks(info, dp, name, address);
+	else
 		fix->visual = FB_VISUAL_TRUECOLOR;
 
 	var->xoffset = var->yoffset = 0;
@@ -395,7 +488,6 @@ static void __init offb_init_fb(const ch
 
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);
-	info->par = par;
 	info->pseudo_palette = (void *) (info + 1);
 	info->flags = FBINFO_DEFAULT | foreign_endian;
 

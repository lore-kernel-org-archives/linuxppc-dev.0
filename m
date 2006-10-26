Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7760767C65
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 15:38:17 +1000 (EST)
Subject: [PATCH] powerpc: Fix various offb issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 15:38:10 +1000
Message-Id: <1161841090.5299.18.camel@localhost.localdomain>
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

This patch fixes a few issues in offb:

 - A test was inverted causing the palette hack to never work
(no device node was passed down to the init function)

 - Some cards seem to have their assigned-addresses property in a random
order, thus we need to try using of_get_pci_address() first, which will
fail if it's not a PCI device, and fallback to of_get_address() in that
case. of_get_pci_address() properly parsees assigned-addresses to test
the BAR number and thus will get it right whatever the order is.

 - Some cards (like GXT4500) provide a linebytes of 0xffffffff in the
device-tree which does no good. This patch handles that by using the
screen width when that happens. (Also fixes btext.c while at it).

 - Add detection of the GXT4500 in addition to the GXT2000 for the
palette hacks (we use the same hack, palette is linear in register space
at offset 0x6000).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul: In addition to making the GXT4500 somewhat work (it's 1024x768@60
8bpp so it's not great, but X works) this patch fixes a couple of
problems that might have been plaguing other users as well, so I reckon
it's good to go into 2.6.19. 

Index: linux-work/arch/powerpc/kernel/btext.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/btext.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/kernel/btext.c	2006-10-26 14:37:16.000000000 +1000
@@ -182,7 +182,7 @@ int btext_initialize(struct device_node 
 	prop = get_property(np, "linux,bootx-linebytes", NULL);
 	if (prop == NULL)
 		prop = get_property(np, "linebytes", NULL);
-	if (prop)
+	if (prop && *prop != 0xffffffffu)
 		pitch = *prop;
 	if (pitch == 1)
 		pitch = 0x1000;
Index: linux-work/drivers/video/offb.c
===================================================================
--- linux-work.orig/drivers/video/offb.c	2006-10-06 13:48:17.000000000 +1000
+++ linux-work/drivers/video/offb.c	2006-10-26 15:32:41.000000000 +1000
@@ -157,7 +157,7 @@ static int offb_setcolreg(u_int regno, u
 		out_le32(par->cmap_adr + 0xb4, (red << 16 | green << 8 | blue));
 		break;
 	case cmap_gxt2000:
-		out_le32((unsigned __iomem *) par->cmap_adr + regno,
+		out_le32(((unsigned __iomem *) par->cmap_adr) + regno,
 			 (red << 16 | green << 8 | blue));
 		break;
 	}
@@ -213,7 +213,7 @@ static int offb_blank(int blank, struct 
 				out_le32(par->cmap_adr + 0xb4, 0);
 				break;
 			case cmap_gxt2000:
-				out_le32((unsigned __iomem *) par->cmap_adr + i,
+				out_le32(((unsigned __iomem *) par->cmap_adr) + i,
 					 0);
 				break;
 			}
@@ -226,13 +226,23 @@ static int offb_blank(int blank, struct 
 static void __iomem *offb_map_reg(struct device_node *np, int index,
 				  unsigned long offset, unsigned long size)
 {
-	struct resource r;
-
-	if (of_address_to_resource(np, index, &r))
-		return 0;
-	if ((r.start + offset + size) > r.end)
-		return 0;
-	return ioremap(r.start + offset, size);
+	const u32 *addrp;
+	u64 asize, taddr;
+	unsigned int flags;
+
+	addrp = of_get_pci_address(np, index, &asize, &flags);
+	if (addrp == NULL)
+		addrp = of_get_address(np, index, &asize, &flags);
+	if (addrp == NULL)
+		return NULL;
+	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
+		return NULL;
+	if ((offset + size) > asize)
+		return NULL;
+	taddr = of_translate_address(np, addrp);
+	if (taddr == OF_BAD_ADDR)
+		return NULL;
+	return ioremap(taddr + offset, size);
 }
 
 static void __init offb_init_fb(const char *name, const char *full_name,
@@ -289,7 +299,6 @@ static void __init offb_init_fb(const ch
 
 	par->cmap_type = cmap_unknown;
 	if (depth == 8) {
-		/* Palette hacks disabled for now */
 		if (dp && !strncmp(name, "ATY,Rage128", 11)) {
 			par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
 			if (par->cmap_adr)
@@ -313,7 +322,8 @@ static void __init offb_init_fb(const ch
 			    ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
 			par->cmap_data = par->cmap_adr + 1;
 			par->cmap_type = cmap_m64;
-		} else if (dp && device_is_compatible(dp, "pci1014,b7")) {
+		} else if (dp && (device_is_compatible(dp, "pci1014,b7") ||
+				  device_is_compatible(dp, "pci1014,21c"))) {
 			par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
 			if (par->cmap_adr)
 				par->cmap_type = cmap_gxt2000;
@@ -433,7 +443,7 @@ static void __init offb_init_nodriver(st
 	pp = get_property(dp, "linux,bootx-linebytes", &len);
 	if (pp == NULL)
 		pp = get_property(dp, "linebytes", &len);
-	if (pp && len == sizeof(u32))
+	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
 		pitch = *pp;
 	else
 		pitch = width * ((depth + 7) / 8);
@@ -496,7 +506,7 @@ static void __init offb_init_nodriver(st
 		offb_init_fb(no_real_node ? "bootx" : dp->name,
 			     no_real_node ? "display" : dp->full_name,
 			     width, height, depth, pitch, address,
-			     no_real_node ? dp : NULL);
+			     no_real_node ? NULL : dp);
 	}
 }
 

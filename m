Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3BCC7B6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 21:10:24 +1100 (EST)
Message-ID: <1325067016.6632.38.camel@pasglop>
Subject: [PATCH] offb: Fix setting of the pseudo-palette for >8bpp
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-fbdev@vger.kernel.org
Date: Wed, 28 Dec 2011 21:10:16 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using a >8bpp framebuffer, offb advertises truecolor, not directcolor,
and doesn't touch the color map even if it has a corresponding access method
for the real hardware.

Thus it needs to set the pseudo-palette with all 3 components of the color,
like other truecolor framebuffers, not with copies of the color index like
a directcolor framebuffer would do.

This went unnoticed for a long time because it's pretty hard to get offb
to kick in with anything but 8bpp (old BootX under MacOS will do that and
qemu does it).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(resent to the right list)

BTW. Do we have a maintainer to pick up those offb patches I sent ? I'm
happy to carry them in -powerpc instead, it would actually make it easier
for me....

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index cb163a5..24e1fc6 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -100,36 +100,32 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			  u_int transp, struct fb_info *info)
 {
 	struct offb_par *par = (struct offb_par *) info->par;
-	int i, depth;
-	u32 *pal = info->pseudo_palette;
-
-	depth = info->var.bits_per_pixel;
-	if (depth == 16)
-		depth = (info->var.green.length == 5) ? 15 : 16;
-
-	if (regno > 255 ||
-	    (depth == 16 && regno > 63) ||
-	    (depth == 15 && regno > 31))
-		return 1;
-
-	if (regno < 16) {
-		switch (depth) {
-		case 15:
-			pal[regno] = (regno << 10) | (regno << 5) | regno;
-			break;
-		case 16:
-			pal[regno] = (regno << 11) | (regno << 5) | regno;
-			break;
-		case 24:
-			pal[regno] = (regno << 16) | (regno << 8) | regno;
-			break;
-		case 32:
-			i = (regno << 8) | regno;
-			pal[regno] = (i << 16) | i;
-			break;
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+		u32 *pal = info->pseudo_palette;
+		u32 cr = red >> (16 - info->var.red.length);
+		u32 cg = green >> (16 - info->var.green.length);
+		u32 cb = blue >> (16 - info->var.blue.length);
+		u32 value;
+
+		if (regno >= 16)
+			return -EINVAL;
+
+		value = (cr << info->var.red.offset) |
+			(cg << info->var.green.offset) |
+			(cb << info->var.blue.offset);
+		if (info->var.transp.length > 0) {
+			u32 mask = (1 << info->var.transp.length) - 1;
+			mask <<= info->var.transp.offset;
+			value |= mask;
 		}
+		pal[regno] = value;
+		return 0;
 	}
 
+	if (regno > 255)
+		return -EINVAL;
+
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EDF9510086F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 10:58:36 +1100 (EST)
Message-ID: <1323907109.21839.28.camel@pasglop>
Subject: [PATCH 2/2] offb: Add palette hack for qemu "standard vga" framebuffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-fbdev@vger.kernel.org
Date: Thu, 15 Dec 2011 10:58:29 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We rename the mach64 hack to "simple" since that's also applicable
to anything using VGA-style DAC IO ports (set to 8-bit DAC) and we
use it for qemu vga.

Note that this is keyed on a device-tree "compatible" property that
is currently only set by an upcoming version of SLOF when using the
qemu "pseries" platform. This is on purpose as other qemu ppc platforms
using OpenBIOS aren't properly setting the DAC to 8-bit at the time of
the writing of this patch.

We can fix OpenBIOS later to do that and add the required property, in
which case it will be matched by this change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/video/offb.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 915acae..da7cf79 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -41,13 +41,14 @@
 /* Supported palette hacks */
 enum {
 	cmap_unknown,
-	cmap_m64,		/* ATI Mach64 */
+	cmap_simple,		/* ATI Mach64 */
 	cmap_r128,		/* ATI Rage128 */
 	cmap_M3A,		/* ATI Rage Mobility M3 Head A */
 	cmap_M3B,		/* ATI Rage Mobility M3 Head B */
 	cmap_radeon,		/* ATI Radeon */
 	cmap_gxt2000,		/* IBM GXT2000 */
 	cmap_avivo,		/* ATI R5xx */
+	cmap_qemu,		/* qemu vga */
 };
 
 struct offb_par {
@@ -138,7 +139,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		return 0;
 
 	switch (par->cmap_type) {
-	case cmap_m64:
+	case cmap_simple:
 		writeb(regno, par->cmap_adr);
 		writeb(red, par->cmap_data);
 		writeb(green, par->cmap_data);
@@ -208,7 +209,7 @@ static int offb_blank(int blank, struct fb_info *info)
 	if (blank)
 		for (i = 0; i < 256; i++) {
 			switch (par->cmap_type) {
-			case cmap_m64:
+			case cmap_simple:
 				writeb(i, par->cmap_adr);
 				for (j = 0; j < 3; j++)
 					writeb(0, par->cmap_data);
@@ -350,7 +351,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 		par->cmap_adr =
 			ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
 		par->cmap_data = par->cmap_adr + 1;
-		par->cmap_type = cmap_m64;
+		par->cmap_type = cmap_simple;
 	} else if (dp && (of_device_is_compatible(dp, "pci1014,b7") ||
 			  of_device_is_compatible(dp, "pci1014,21c"))) {
 		par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
@@ -371,6 +372,16 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 				par->cmap_type = cmap_avivo;
 		}
 		of_node_put(pciparent);
+	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
+		const u32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
+		u64 io_addr = of_translate_address(dp, io_of_addr);
+		if (io_addr != OF_BAD_ADDR) {
+			par->cmap_adr = ioremap(io_addr + 0x3c8, 2);
+			if (par->cmap_adr) {
+				par->cmap_type = cmap_simple;
+				par->cmap_data = par->cmap_adr + 1;
+			}
+		}
 	}
 	info->fix.visual = (par->cmap_type != cmap_unknown) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;

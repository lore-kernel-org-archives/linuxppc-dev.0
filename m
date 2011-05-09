Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ECB60B6F17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 May 2011 05:44:57 +1000 (EST)
Received: from mail34-am1 (localhost.localdomain [127.0.0.1])	by
	mail34-am1-R.bigfish.com (Postfix) with ESMTP id 9FB6FA68123	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 May 2011 19:29:45 +0000 (UTC)
Received: from AM1EHSMHS014.bigfish.com (unknown [10.3.201.245])	by
	mail34-am1.bigfish.com (Postfix) with ESMTP id 57EFC1C18050	for
	<linuxppc-dev@ozlabs.org>; Mon,  9 May 2011 19:29:45 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/86xx: don't pretend that we support 8-bit pixels on
	the MPC8610 HPCD
Date: Mon, 9 May 2011 14:29:40 -0500
Message-ID: <1304969380-24897-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the video mode is set to 16-, 24-, or 32-bit pixels, then the pixel data
contains actual levels of red, blue, and green.  However, if the video mode is
set to 8-bit pixels, then the 8-bit value represents an index into color table.
This is called "palette mode" on the Freescale DIU video controller.

The DIU driver does not currently support palette mode, but the MPC8610 HPCD
board file returned a non-zero (although incorrect) pixel format value for
8-bit mode.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   97 ++++++++++++++++++----------
 1 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 018cc67..2b24452 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -105,45 +105,77 @@ machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
-static u32 get_busfreq(void)
-{
-	struct device_node *node;
-
-	u32 fs_busfreq = 0;
-	node = of_find_node_by_type(NULL, "cpu");
-	if (node) {
-		unsigned int size;
-		const unsigned int *prop =
-			of_get_property(node, "bus-frequency", &size);
-		if (prop)
-			fs_busfreq = *prop;
-		of_node_put(node);
-	};
-	return fs_busfreq;
-}
+/*
+ * DIU Area Descriptor
+ *
+ * The MPC8610 reference manual shows the bits of the AD register in
+ * little-endian order, which causes the BLUE_C field to be split into two
+ * parts. To simplify the definition of the MAKE_AD() macro, we define the
+ * fields in big-endian order and byte-swap the result.
+ *
+ * So even though the registers don't look like they're in the
+ * same bit positions as they are on the P1022, the same value is written to
+ * the AD register on the MPC8610 and on the P1022.
+ */
+#define AD_BYTE_F		0x10000000
+#define AD_ALPHA_C_MASK		0x0E000000
+#define AD_ALPHA_C_SHIFT	25
+#define AD_BLUE_C_MASK		0x01800000
+#define AD_BLUE_C_SHIFT		23
+#define AD_GREEN_C_MASK		0x00600000
+#define AD_GREEN_C_SHIFT	21
+#define AD_RED_C_MASK		0x00180000
+#define AD_RED_C_SHIFT		19
+#define AD_PALETTE		0x00040000
+#define AD_PIXEL_S_MASK		0x00030000
+#define AD_PIXEL_S_SHIFT	16
+#define AD_COMP_3_MASK		0x0000F000
+#define AD_COMP_3_SHIFT		12
+#define AD_COMP_2_MASK		0x00000F00
+#define AD_COMP_2_SHIFT		8
+#define AD_COMP_1_MASK		0x000000F0
+#define AD_COMP_1_SHIFT		4
+#define AD_COMP_0_MASK		0x0000000F
+#define AD_COMP_0_SHIFT		0
+
+#define MAKE_AD(alpha, red, blue, green, size, c0, c1, c2, c3) \
+	cpu_to_le32(AD_BYTE_F | (alpha << AD_ALPHA_C_SHIFT) | \
+	(blue << AD_BLUE_C_SHIFT) | (green << AD_GREEN_C_SHIFT) | \
+	(red << AD_RED_C_SHIFT) | (c3 << AD_COMP_3_SHIFT) | \
+	(c2 << AD_COMP_2_SHIFT) | (c1 << AD_COMP_1_SHIFT) | \
+	(c0 << AD_COMP_0_SHIFT) | (size << AD_PIXEL_S_SHIFT))
 
 unsigned int mpc8610hpcd_get_pixel_format(unsigned int bits_per_pixel,
 						int monitor_port)
 {
 	static const unsigned long pixelformat[][3] = {
-		{0x88882317, 0x88083218, 0x65052119},
-		{0x88883316, 0x88082219, 0x65053118},
+		{
+			MAKE_AD(3, 0, 2, 1, 3, 8, 8, 8, 8),
+			MAKE_AD(4, 2, 0, 1, 2, 8, 8, 8, 0),
+			MAKE_AD(4, 0, 2, 1, 1, 5, 6, 5, 0)
+		},
+		{
+			MAKE_AD(3, 2, 0, 1, 3, 8, 8, 8, 8),
+			MAKE_AD(4, 0, 2, 1, 2, 8, 8, 8, 0),
+			MAKE_AD(4, 2, 0, 1, 1, 5, 6, 5, 0)
+		},
 	};
-	unsigned int pix_fmt, arch_monitor;
+	unsigned int arch_monitor;
 
+	/* The DVI port is mis-wired on revision 1 of this board. */
 	arch_monitor = ((*pixis_arch == 0x01) && (monitor_port == 0))? 0 : 1;
-		/* DVI port for board version 0x01 */
-
-	if (bits_per_pixel == 32)
-		pix_fmt = pixelformat[arch_monitor][0];
-	else if (bits_per_pixel == 24)
-		pix_fmt = pixelformat[arch_monitor][1];
-	else if (bits_per_pixel == 16)
-		pix_fmt = pixelformat[arch_monitor][2];
-	else
-		pix_fmt = pixelformat[1][0];
-
-	return pix_fmt;
+
+	switch (bits_per_pixel) {
+	case 32:
+		return pixelformat[arch_monitor][0];
+	case 24:
+		return pixelformat[arch_monitor][1];
+	case 16:
+		return pixelformat[arch_monitor][2];
+	default:
+		pr_err("fsl-diu: unsupported pixel depth %u\n", bits_per_pixel);
+		return 0;
+	}
 }
 
 void mpc8610hpcd_set_gamma_table(int monitor_port, char *gamma_table_base)
@@ -190,8 +222,7 @@ void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
 	}
 
 	/* Pixel Clock configuration */
-	pr_debug("DIU: Bus Frequency = %d\n", get_busfreq());
-	speed_ccb = get_busfreq();
+	speed_ccb = fsl_get_sys_freq();
 
 	/* Calculate the pixel clock with the smallest error */
 	/* calculate the following in steps to avoid overflow */
-- 
1.7.3.4

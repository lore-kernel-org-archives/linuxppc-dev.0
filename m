Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EB31EB72CF
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 05:57:48 +1100 (EST)
Received: from mail184-tx2 (localhost.localdomain [127.0.0.1])	by
 mail184-tx2-R.bigfish.com (Postfix) with ESMTP id 08EAF3301A9	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:57:31 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.248])	by
 mail184-tx2.bigfish.com (Postfix) with ESMTP id 81BDDA18052	for
 <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:57:29 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via pixis
 indirect mode
Date: Thu, 17 Nov 2011 12:57:39 -0600
Message-ID: <1321556259-4459-2-git-send-email-timur@freescale.com>
In-Reply-To: <1321556259-4459-1-git-send-email-timur@freescale.com>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
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

When the P1022's DIU video controller is active, the pixis must be accessed
in "indirect" mode, which uses localbus chip select addresses.

Switching between the DVI and LVDS monitor ports is handled by the pixis,
so that switching needs to be done via indirect mode.

This has the side-effect of no longer requiring U-Boot to enable the DIU.
Now Linux can enable the DIU all by itself.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |  132 ++++++++++++++++++++++++++-----
 1 files changed, 110 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index fda1571..7bdb9af 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -29,6 +29,10 @@
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
+#define PMUXCR_ELBCDIU_MASK	0xc0000000
+#define PMUXCR_ELBCDIU_NOR16	0x80000000
+#define PMUXCR_ELBCDIU_DIU	0x40000000
+
 /*
  * Board-specific initialization of the DIU.  This code should probably be
  * executed when the DIU is opened, rather than in arch code, but the DIU
@@ -46,11 +50,22 @@
 #define CLKDVDR_PXCLK_MASK	0x00FF0000
 
 /* Some ngPIXIS register definitions */
+#define PX_CTL		3
+#define PX_BRDCFG0	8
+#define PX_BRDCFG1	9
+
+#define PX_BRDCFG0_ELBC_SPI_MASK	0xc0
+#define PX_BRDCFG0_ELBC_SPI_ELBC	0x00
+#define PX_BRDCFG0_ELBC_SPI_NULL	0xc0
+#define PX_BRDCFG0_ELBC_DIU		0x02
+
 #define PX_BRDCFG1_DVIEN	0x80
 #define PX_BRDCFG1_DFPEN	0x40
 #define PX_BRDCFG1_BACKLIGHT	0x20
 #define PX_BRDCFG1_DDCEN	0x10
 
+#define PX_CTL_ALTACC		0x80
+
 /*
  * DIU Area Descriptor
  *
@@ -129,44 +144,117 @@ static void p1022ds_set_gamma_table(enum fsl_diu_monitor_port port,
  */
 static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 {
-	struct device_node *np;
-	void __iomem *pixis;
-	u8 __iomem *brdcfg1;
+	struct device_node *guts_node = NULL;
+	struct device_node *indirect_node = NULL;
+	struct ccsr_guts_85xx __iomem *guts = NULL;
+	u8 __iomem *lbc_lcs0_ba = NULL;
+	u8 __iomem *lbc_lcs1_ba = NULL;
+	u8 b;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-fpga");
-	if (!np)
-		/* older device trees used "fsl,p1022ds-pixis" */
-		np = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-pixis");
-	if (!np) {
-		pr_err("p1022ds: missing ngPIXIS node\n");
+	/* Map the global utilities registers. */
+	guts_node = of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
+	if (!guts_node) {
+		pr_err("p1022ds: missing global utilties device node\n");
 		return;
 	}
 
-	pixis = of_iomap(np, 0);
-	if (!pixis) {
-		pr_err("p1022ds: could not map ngPIXIS registers\n");
-		return;
+	guts = of_iomap(guts_node, 0);
+	if (!guts) {
+		pr_err("p1022ds: could not map global utilties device\n");
+		goto exit;
 	}
-	brdcfg1 = pixis + 9;	/* BRDCFG1 is at offset 9 in the ngPIXIS */
+
+	indirect_node = of_find_compatible_node(NULL, NULL,
+					     "fsl,p1022ds-indirect-pixis");
+	if (!indirect_node) {
+		pr_err("p1022ds: missing pixis indirect mode node\n");
+		goto exit;
+	}
+
+	lbc_lcs0_ba = of_iomap(indirect_node, 0);
+	if (!lbc_lcs0_ba) {
+		pr_err("p1022ds: could not map localbus chip select 0\n");
+		goto exit;
+	}
+
+	lbc_lcs1_ba = of_iomap(indirect_node, 1);
+	if (!lbc_lcs1_ba) {
+		pr_err("p1022ds: could not map localbus chip select 1\n");
+		goto exit;
+	}
+
+	/* Make sure we're in indirect mode first. */
+	if ((in_be32(&guts->pmuxcr) & PMUXCR_ELBCDIU_MASK) !=
+	    PMUXCR_ELBCDIU_DIU) {
+		struct device_node *pixis_node;
+		void __iomem *pixis;
+
+		pixis_node =
+			of_find_compatible_node(NULL, NULL, "fsl,p1022ds-fpga");
+		if (!pixis_node) {
+			pr_err("p1022ds: missing pixis node\n");
+			goto exit;
+		}
+
+		pixis = of_iomap(pixis_node, 0);
+		of_node_put(pixis_node);
+		if (!pixis) {
+			pr_err("p1022ds: could not map pixis registers\n");
+			goto exit;
+		}
+
+		/* Enable indirect PIXIS mode.  */
+		setbits8(pixis + PX_CTL, PX_CTL_ALTACC);
+		iounmap(pixis);
+
+		/* Switch the board mux to the DIU */
+		out_8(lbc_lcs0_ba, PX_BRDCFG0);	/* BRDCFG0 */
+		b = in_8(lbc_lcs1_ba);
+		b |= PX_BRDCFG0_ELBC_DIU;
+		out_8(lbc_lcs1_ba, b);
+
+		/* Set the chip mux to DIU mode. */
+		clrsetbits_be32(&guts->pmuxcr, PMUXCR_ELBCDIU_MASK,
+				PMUXCR_ELBCDIU_DIU);
+		in_be32(&guts->pmuxcr);
+	}
+
 
 	switch (port) {
 	case FSL_DIU_PORT_DVI:
-		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
 		/* Enable the DVI port, disable the DFP and the backlight */
-		clrsetbits_8(brdcfg1, PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT,
-			     PX_BRDCFG1_DVIEN);
+		out_8(lbc_lcs0_ba, PX_BRDCFG1);
+		b = in_8(lbc_lcs1_ba);
+		b &= ~(PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT);
+		b |= PX_BRDCFG1_DVIEN;
+		out_8(lbc_lcs1_ba, b);
 		break;
 	case FSL_DIU_PORT_LVDS:
-		printk(KERN_INFO "%s:%u\n", __func__, __LINE__);
+		/*
+		 * LVDS also needs backlight enabled, otherwise the display
+		 * will be blank.
+		 */
 		/* Enable the DFP port, disable the DVI and the backlight */
-		clrsetbits_8(brdcfg1, PX_BRDCFG1_DVIEN | PX_BRDCFG1_BACKLIGHT,
-			     PX_BRDCFG1_DFPEN);
+		out_8(lbc_lcs0_ba, PX_BRDCFG1);
+		b = in_8(lbc_lcs1_ba);
+		b &= ~PX_BRDCFG1_DVIEN;
+		b |= PX_BRDCFG1_DFPEN | PX_BRDCFG1_BACKLIGHT;
+		out_8(lbc_lcs1_ba, b);
 		break;
 	default:
 		pr_err("p1022ds: unsupported monitor port %i\n", port);
 	}
 
-	iounmap(pixis);
+exit:
+	if (lbc_lcs1_ba)
+		iounmap(lbc_lcs1_ba);
+	if (lbc_lcs0_ba)
+		iounmap(lbc_lcs0_ba);
+	if (guts)
+		iounmap(guts);
+
+	of_node_put(indirect_node);
+	of_node_put(guts_node);
 }
 
 /**
-- 
1.7.3.4

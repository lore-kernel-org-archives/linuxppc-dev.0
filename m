Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77CAC2C013B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:25 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 17/17] clk: mpc512x: remove migration support workarounds
Date: Sat, 30 Nov 2013 23:51:37 +0100
Message-Id: <1385851897-23475-18-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this change removes workarounds which have become obsolete after
migration to common clock support has completed
- remove clkdev registration calls (compatibility clock item aliases)
  after all peripheral drivers were adjusted for device tree based
  clock lookup
- remove pre-enable workarounds after all peripheral drivers were
  adjusted to acquire their respective clock items

workarounds for these clock items get removed:  FEC (ethernet), I2C,
PSC (UART, SPI), PSC FIFO, USB, NFC (NAND flash), VIU (video capture),
BDLC (CAN), CAN MCLK, DIU (video output)

these clkdev registered names won't be provided any longer by the
MPC512x platform's clock driver:  "psc%d_mclk", "mscan%d_mclk",
"usb%d_clk", "nfc_clk", "viu_clk", "sys_clk", "ref_clk"

the pre-enable workaround for PCI remains, but depends on the presence
of PCI related device tree nodes (disables the PCI clock in the absence
of PCI nodes, keeps the PCI clock enabled in the presence of nodes) --
moving clock acquisition into the peripheral driver isn't possible for
PCI because its initialization takes place before the platform clock
driver gets initialized, thus the clock provider isn't available then

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |   50 ++++++++-----------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 945e4609e773..189be4a4cb42 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -696,46 +696,28 @@ static void mpc5121_clk_register_of_provider(struct device_node *np)
  */
 static void mpc5121_clk_provide_migration_support(void)
 {
-	int idx;
-	char name[32];
-
-	/*
-	 * provide "pre-CCF" alias clock names for peripheral drivers
-	 * which have not yet been adjusted to do OF based clock lookups
-	 */
-	clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_VIU], "viu_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_NFC], "nfc_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB1], "usb1_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_USB2], "usb2_clk", NULL);
-	for (idx = 0; idx < NR_PSCS; idx++) {
-		snprintf(name, sizeof(name), "psc%d_mclk", idx);
-		clk_register_clkdev(clks[MPC512x_CLK_PSC0_MCLK + idx],
-				    name, NULL);
-	}
-	for (idx = 0; idx < NR_MSCANS; idx++) {
-		snprintf(name, sizeof(name), "mscan%d_mclk", idx);
-		clk_register_clkdev(clks[MPC512x_CLK_MSCAN0_MCLK + idx],
-				    name, NULL);
-	}
-	clk_register_clkdev(clks[MPC512x_CLK_SPDIF_MCLK], "spdif_mclk", NULL);
 
 	/*
 	 * pre-enable those clock items which are not yet appropriately
 	 * acquired by their peripheral driver
+	 *
+	 * the PCI clock cannot get acquired by its peripheral driver,
+	 * because for this platform the driver won't probe(), instead
+	 * initialization is done from within the .setup_arch() routine
+	 * at a point in time where the clock provider has not been
+	 * setup yet and thus isn't available yet
+	 *
+	 * so we "pre-enable" the clock here, to not have the clock
+	 * subsystem automatically disable this item in a late init call
+	 *
+	 * this PCI clock pre-enable workaround only applies when there
+	 * are device tree nodes for PCI and thus the peripheral driver
+	 * has attached to bridges, otherwise the PCI clock remains
+	 * unused and so it gets disabled
 	 */
-	clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
-	clk_prepare_enable(clks[MPC512x_CLK_FEC]);	/* network, NFS */
-	clk_prepare_enable(clks[MPC512x_CLK_DIU]);	/* display */
-	clk_prepare_enable(clks[MPC512x_CLK_I2C]);	/* I2C */
-	for (idx = 0; idx < NR_PSCS; idx++)		/* PSC ipg */
-		clk_prepare_enable(clks[MPC512x_CLK_PSC0 + idx]);
-	clk_prepare_enable(clks[MPC512x_CLK_BDLC]);	/* MSCAN ipg */
-	for (idx = 0; idx < NR_MSCANS; idx++)		/* MSCAN mclk */
-		clk_prepare_enable(clks[MPC512x_CLK_MSCAN0_MCLK + idx]);
-	clk_prepare_enable(clks[MPC512x_CLK_PCI]);	/* PCI */
+	if (of_find_compatible_node(NULL, "pci", "fsl,mpc5121-pci"))
+		clk_prepare_enable(clks[MPC512x_CLK_PCI]);
 }
 
 /*
-- 
1.7.10.4

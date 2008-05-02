Return-Path: <afleming@ld0175-tx32.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6514DDF2D
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:56:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m42Nufqp017778
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 16:56:42 -0700 (MST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32.am.freescale.net
	[10.82.19.125])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m42NufTZ009698
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 18:56:41 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2] powerpc: Add 8568 PHY workarounds to board code
Date: Fri,  2 May 2008 18:56:41 -0500
Message-Id: <1209772601-28109-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 8568 MDS needs some configuration changes to the PHY in order to
work properly.  These are done in the firmware, normally, but Linux
shouldn't need to rely on the firmware running such things (someone
could disable the PHY support in the firmware to save space, for instance).

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |  119 +++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 12f68ab..43a459f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -32,6 +32,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/phy.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -56,6 +57,95 @@
 #define DBG(fmt...)
 #endif
 
+#define MV88E1111_SCR	0x10
+#define MV88E1111_SCR_125CLK	0x0010
+static int mpc8568_fixup_125_clock(struct phy_device *phydev)
+{
+	int scr;
+	int err;
+
+	/* Workaround for the 125 CLK Toggle */
+	scr = phy_read(phydev, MV88E1111_SCR);
+
+	if (scr < 0)
+		return scr;
+
+	err = phy_write(phydev, MV88E1111_SCR, scr & ~(MV88E1111_SCR_125CLK));
+
+	if (err)
+		return err;
+
+	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
+
+	if (err)
+		return err;
+
+	scr = phy_read(phydev, MV88E1111_SCR);
+
+	if (scr < 0)
+		return err;
+
+	err = phy_write(phydev, MV88E1111_SCR, scr | 0x0008);
+
+	return err;
+}
+
+static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
+{
+	int temp;
+	int err;
+
+	/* Errata */
+	err = phy_write(phydev,29, 0x0006);
+
+	if (err)
+		return err;
+
+	temp = phy_read(phydev, 30);
+
+	if (temp < 0)
+		return temp;
+
+	temp = (temp & (~0x8000)) | 0x4000;
+	err = phy_write(phydev,30, temp);
+
+	if (err)
+		return err;
+
+	err = phy_write(phydev,29, 0x000a);
+
+	if (err)
+		return err;
+
+	temp = phy_read(phydev, 30);
+
+	if (temp < 0)
+		return temp;
+
+	temp = phy_read(phydev, 30);
+
+	if (temp < 0)
+		return temp;
+
+	temp &= ~0x0020;
+
+	err = phy_write(phydev,30,temp);
+
+	if (err)
+		return err;
+
+	/* Disable automatic MDI/MDIX selection */
+	temp = phy_read(phydev, 16);
+
+	if (temp < 0)
+		return temp;
+
+	temp &= ~0x0060;
+	err = phy_write(phydev,16,temp);
+
+	return err;
+}
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -138,6 +228,35 @@ static void __init mpc85xx_mds_setup_arch(void)
 #endif	/* CONFIG_QUICC_ENGINE */
 }
 
+
+static int __init board_fixups(void)
+{
+	char phy_id[BUS_ID_SIZE];
+	char *compstrs[2] = {"fsl,gianfar-mdio", "fsl,ucc-mdio"};
+	struct device_node *mdio;
+	struct resource res;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(compstrs); i++) {
+		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
+
+		of_address_to_resource(mdio, 0, &res);
+		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
+
+		phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
+		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
+
+		/* Register a workaround for errata */
+		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
+		phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
+
+		of_node_put(mdio);
+	}
+
+	return 0;
+}
+machine_arch_initcall(mpc85xx_mds, board_fixups);
+
 static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
-- 
1.5.4.GIT

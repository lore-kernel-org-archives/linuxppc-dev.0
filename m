Return-Path: <afleming@ld0175-tx32.am.freescale.net>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59D2ADE202
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:35:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3IMZpih026869
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:35:51 -0700 (MST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32.am.freescale.net
	[10.82.19.125])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3IMZoP6018972
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 17:35:50 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2.6.26] powerpc: Add 8568 PHY workaround to board code
Date: Fri, 18 Apr 2008 17:35:49 -0500
Message-Id: <1208558149-6029-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 8568 MDS needs some configuration changes to the PHY in order to work
properly.  These are done in the firmware, normally, but Linux shouldn't
need to rely on the firmware running such things (someone could disable
the PHY support in the firmware to save space, for instance).

Signed-off-by: Andy Fleming <afleming@freescale.com>
---

Jeff, copying you so you can see what code uses the board fixup patch.  Also,
Kumar, note that this patch is utterly useless without the patch sent to netdev:
Add support for board-level PHY fixups.

 arch/powerpc/platforms/85xx/mpc85xx_mds.c |  114 +++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 25f8bc7..b1bf06d 100644
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
@@ -138,6 +228,30 @@ static void __init mpc85xx_mds_setup_arch(void)
 #endif	/* CONFIG_QUICC_ENGINE */
 }
 
+
+static int __init board_fixups(void)
+{
+	char phy_id[BUS_ID_SIZE];
+	struct device_node *mdio;
+	struct resource res;
+
+	/* Register a workaround to fixup the clock source */
+	mdio = of_find_node_by_name(NULL, "mdio");
+
+	of_address_to_resource(mdio, 0, &res);
+	snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
+
+	phy_register_fixup_for_id(phy_id, mpc8568_fixup_125_clock);
+	phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
+
+	/* Register a workaround for errata */
+	snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 7);
+	phy_register_fixup_for_id(phy_id, mpc8568_mds_phy_fixups);
+
+	return 0;
+}
+arch_initcall(board_fixups);
+
 static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
-- 
1.5.4.GIT

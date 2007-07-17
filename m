Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDDF3DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:49:41 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] POWERPC: add support of the GiGE switch for mpc8313RDB via
	fixed PHY
Date: Tue, 17 Jul 2007 04:49:37 +0400
Message-ID: <20070717004936.21700.67900.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This utilises pretend phy, making access to it via device tree. GiGE switch
is connected to TSEC1 with fixed gigE link, so we need to emulate it
via artificial PHY to make it work.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc8313erdb.dts     |    1 +
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |   43 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a1533cc..1b351dc 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -100,6 +100,7 @@
 			#size-cells = <0>;
 			phy1: ethernet-phy@1 {
 				interrupt-parent = < &ipic >;
+				compatible = "fixed";
 				interrupts = <13 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index b410e67..5ee08fc 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -115,6 +115,49 @@ static int __init rtc_hookup(void)
 late_initcall(rtc_hookup);
 #endif
 
+#if defined(CONFIG_FIXED_MII_1000_FDX)
+
+static int fixed_set_link (void)
+{
+	struct fixed_info *phyinfo = fixed_mdio_get_phydev(0);	/* only one fixed phy on this platform */
+	struct phy_device *phydev;
+	struct device_node *np;
+	struct device_node *child;
+	unsigned int i;
+	struct resource res;
+	int ret;
+	u32 *id = NULL;
+
+	if (!phyinfo)
+		return -ENXIO;
+	phydev = phyinfo->phydev;
+	if (!phydev)
+		return -ENXIO;
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "mdio", "gianfar")) != NULL;
+	     i++) {
+
+		memset(&res, 0, sizeof(res));
+
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			return ret;
+		child = of_find_compatible_node(np, "ethernet-phy","fixed");
+		if (!child)
+			return -ENXIO;
+		id = (u32*)of_get_property(child, "reg", NULL);
+		if (!id)
+			return -ENXIO;
+		break;
+	}
+	snprintf(phydev->dev.bus_id, BUS_ID_SIZE, PHY_ID_FMT,  res.start, *id);
+	memset(phyinfo->regs,0xff,sizeof(phyinfo->regs[0])*phyinfo->regs_num);
+
+	return 0;
+}
+late_initcall(fixed_set_link);
+#endif
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */

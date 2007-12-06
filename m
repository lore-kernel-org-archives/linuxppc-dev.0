Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF19BDDEC1
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 09:51:37 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/3] [POWERPC] fsl_soc: add support for gianfar for fixed-link
	property
Date: Fri, 07 Dec 2007 01:51:31 +0300
Message-ID: <20071206225131.31080.7872.stgit@localhost.localdomain>
In-Reply-To: <20071206225121.31080.86606.stgit@localhost.localdomain>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


fixed-link says: register new "Fixed/emulated PHY", i.e. PHY that
not connected to the real MDIO bus.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

---

 Documentation/powerpc/booting-without-of.txt |    4 +
 arch/powerpc/sysdev/fsl_soc.c                |   79 ++++++++++++++++++++------
 2 files changed, 66 insertions(+), 17 deletions(-)


diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..9dfd308 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1254,6 +1254,10 @@ platforms are moved over to use the flattened-device-tree model.
       services interrupts for this device.
     - phy-handle : The phandle for the PHY connected to this ethernet
       controller.
+    - fixed-link : <a b c d e> where a is emulated phy id - choose any,
+      but unique to the all specified fixed-links, b is duplex - 0 half,
+      1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
+      pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.
 
   Recommended properties:
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..a008e32 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
@@ -130,6 +131,37 @@ u32 get_baudrate(void)
 EXPORT_SYMBOL(get_baudrate);
 #endif /* CONFIG_CPM2 */
 
+#ifdef CONFIG_FIXED_PHY
+static int __init of_add_fixed_phys(void)
+{
+	int ret;
+	struct device_node *np;
+	u32 *fixed_link;
+	struct fixed_phy_status status = {};
+
+	for_each_node_by_name(np, "ethernet") {
+		fixed_link  = (u32 *)of_get_property(np, "fixed-link", NULL);
+		if (!fixed_link)
+			continue;
+
+		status.link = 1;
+		status.duplex = fixed_link[1];
+		status.speed = fixed_link[2];
+		status.pause = fixed_link[3];
+		status.asym_pause = fixed_link[4];
+
+		ret = fixed_phy_add(PHY_POLL, fixed_link[0], &status);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+arch_initcall(of_add_fixed_phys);
+#endif /* CONFIG_FIXED_PHY */
+
 static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -193,7 +225,6 @@ static const char *gfar_tx_intr = "tx";
 static const char *gfar_rx_intr = "rx";
 static const char *gfar_err_intr = "error";
 
-
 static int __init gfar_of_init(void)
 {
 	struct device_node *np;
@@ -277,29 +308,43 @@ static int __init gfar_of_init(void)
 			gfar_data.interface = PHY_INTERFACE_MODE_MII;
 
 		ph = of_get_property(np, "phy-handle", NULL);
-		phy = of_find_node_by_phandle(*ph);
+		if (ph == NULL) {
+			u32 *fixed_link;
 
-		if (phy == NULL) {
-			ret = -ENODEV;
-			goto unreg;
-		}
+			fixed_link = (u32 *)of_get_property(np, "fixed-link",
+							   NULL);
+			if (!fixed_link) {
+				ret = -ENODEV;
+				goto unreg;
+			}
 
-		mdio = of_get_parent(phy);
+			gfar_data.bus_id = 0;
+			gfar_data.phy_id = fixed_link[0];
+		} else {
+			phy = of_find_node_by_phandle(*ph);
+
+			if (phy == NULL) {
+				ret = -ENODEV;
+				goto unreg;
+			}
+
+			mdio = of_get_parent(phy);
+
+			id = of_get_property(phy, "reg", NULL);
+			ret = of_address_to_resource(mdio, 0, &res);
+			if (ret) {
+				of_node_put(phy);
+				of_node_put(mdio);
+				goto unreg;
+			}
+
+			gfar_data.phy_id = *id;
+			gfar_data.bus_id = res.start;
 
-		id = of_get_property(phy, "reg", NULL);
-		ret = of_address_to_resource(mdio, 0, &res);
-		if (ret) {
 			of_node_put(phy);
 			of_node_put(mdio);
-			goto unreg;
 		}
 
-		gfar_data.phy_id = *id;
-		gfar_data.bus_id = res.start;
-
-		of_node_put(phy);
-		of_node_put(mdio);
-
 		ret =
 		    platform_device_add_data(gfar_dev, &gfar_data,
 					     sizeof(struct

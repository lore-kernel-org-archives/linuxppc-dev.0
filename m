Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A0D5DDFB6
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 08:04:48 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: git@xilinx.com,
	grant.likely@secretlab.ca,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] Xilinx: LL TEMAC: removed __res for powerpc arch
Date: Fri,  7 Mar 2008 12:50:20 -0800
Message-Id: <20080307205537.59DC68E8053@mail121-dub.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The copy of the mac address from the board data to the platform
data was moved from the LL TEMAC driver to a virtex_device_fixup
function so the driver works for powerpc arch also.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/ppc/platforms/4xx/Kconfig                |   22 +++++++++++----
 arch/ppc/platforms/4xx/Makefile               |    2 +
 arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c |   37 +++++++++++++++++++++++++
 drivers/net/xilinx_lltemac/xlltemac_main.c    |    6 +---
 4 files changed, 57 insertions(+), 10 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 8b8ce8e..0f38dec 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -58,6 +58,7 @@ config XILINX_ML300
 	select XILINX_VIRTEX_II_PRO
 	select EMBEDDEDBOOT
 	select XILINX_EMBED_CONFIG
+	select XILINX_MLxxx
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
@@ -74,22 +75,25 @@ config XILINX_ML403
 	select XILINX_VIRTEX_4_FX
 	select EMBEDDEDBOOT
 	select XILINX_EMBED_CONFIG
+	select XILINX_MLxxx
 	help
 	  This option enables support for the Xilinx ML403 evaluation board.
 
 config XILINX_ML405
-        bool "Xilinx-ML405"
-        select XILINX_VIRTEX_4_FX
-        select EMBEDDEDBOOT
-        select XILINX_EMBED_CONFIG
-        help
-          This option enables support for the Xilinx ML405 evaluation board.
+	bool "Xilinx-ML405"
+	select XILINX_VIRTEX_4_FX
+	select EMBEDDEDBOOT
+	select XILINX_EMBED_CONFIG
+	select XILINX_MLxxx
+	help
+	  This option enables support for the Xilinx ML405 evaluation board.
 
 config XILINX_ML41x
 	bool "Xilinx-ML41x"
 	select XILINX_VIRTEX_4_FX
 	select EMBEDDEDBOOT
 	select XILINX_EMBED_CONFIG
+	select XILINX_MLxxx
 	help
 	  This option enables support for the Xilinx ML410/411 evaluation boards.
 
@@ -245,6 +249,12 @@ config 405GPR
 	depends on SYCAMORE
 	default y
 
+config XILINX_MLxxx
+	bool
+	help
+	  Include platform support for many Xilinx development boards 
+	  with configuration data stored in IIC eeprom.
+
 config XILINX_VIRTEX_II_PRO
 	bool
 	select XILINX_VIRTEX
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index ee4c987..3c42f85 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -19,6 +19,8 @@ obj-$(CONFIG_XILINX_XUPV2P)	+= xilinx_generic_ppc.o xilinx_xupv2p.o
 obj-$(CONFIG_XILINX_ML403)	+= xilinx_generic_ppc.o
 obj-$(CONFIG_XILINX_ML405)	+= xilinx_generic_ppc.o
 obj-$(CONFIG_XILINX_ML41x)	+= xilinx_generic_ppc.o
+obj-$(CONFIG_XILINX_MLxxx) 	+= xilinx_generic_mlxxx.o
+obj-$(CONFIG_XILINX_ML507) 	+= xilinx_generic_mlxxx.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
diff --git a/arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c b/arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c
new file mode 100644
index 0000000..0fb5878
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c
@@ -0,0 +1,37 @@
+/*
+ * Xilinx MLxxx board initialization
+ *
+ * 2007 (c) Xilinx, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/xilinx_devices.h>
+#include <linux/platform_device.h>
+
+extern bd_t __res;
+
+int virtex_device_fixup(struct platform_device *dev)
+{
+	static int temac_count = 0;
+	struct xlltemac_platform_data *pdata = dev->dev.platform_data;
+
+#if defined(CONFIG_XILINX_MLxxx)
+
+	if (strcmp(dev->name, "xilinx_lltemac") == 0) {
+
+		/* only copy the mac address into the 1st lltemac if 
+		   there are multiple */
+	
+		if (temac_count++ == 0) {
+			printk(KERN_INFO "Fixup MAC address for %s:%d\n",
+			       dev->name, dev->id);
+			/* Set the MAC address from the iic eeprom info in the board data */
+		        memcpy(pdata->mac_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
+		}
+	}
+#endif
+
+	return 0;
+}
diff --git a/drivers/net/xilinx_lltemac/xlltemac_main.c b/drivers/net/xilinx_lltemac/xlltemac_main.c
index f393c5a..01c9943 100644
--- a/drivers/net/xilinx_lltemac/xlltemac_main.c
+++ b/drivers/net/xilinx_lltemac/xlltemac_main.c
@@ -2980,7 +2980,6 @@ static int detect_phy(struct net_local *lp, char *dev_name)
 	printk(KERN_WARNING "XTemac: No PHY detected.  Assuming a PHY at address 0\n");
 	return 0;		/* default to zero */
 }
-extern bd_t __res;
 
 /** Shared device initialization code */
 static int xtenet_setup(
@@ -3048,9 +3047,8 @@ static int xtenet_setup(
 		goto error;
 	}
 
-	/* Set the MAC address from the iic eeprom info in the board data */
-        memcpy(ndev->dev_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
-        memcpy(pdata->mac_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
+	/* Set the MAC address from platform data */
+        memcpy(ndev->dev_addr, pdata->mac_addr, 6);
 
 	if (_XLlTemac_SetMacAddress(&lp->Emac, ndev->dev_addr) != XST_SUCCESS) {
 		/* should not fail right after an initialize */
-- 
1.5.2.1

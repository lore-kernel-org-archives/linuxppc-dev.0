Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB45CDE4BC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:18:37 +1000 (EST)
Date: Thu, 12 Jul 2007 14:18:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/4] gianfar: Add flags for magic packet and MDIO.
Message-ID: <20070712191827.GD31529@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070712191755.GA31507@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The magic packet flag indicates that the hardware has this
capability.  The MDIO flag indicates that this device's
registers contain active MDIO registers, and thus this
device should not be put to sleep.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    7 +++++++
 include/linux/fsl_devices.h   |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 8381736..2a45ff1 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -302,6 +302,9 @@ static int __init gfar_of_init(void)
 			    FSL_GIANFAR_DEV_HAS_VLAN |
 			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
 
+		if (of_get_property(np, "fsl,magic-packet", NULL))
+			gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MAGIC_PACKET;
+
 		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
@@ -323,6 +326,10 @@ static int __init gfar_of_init(void)
 		gfar_data.phy_id = *id;
 		gfar_data.bus_id = res.start;
 
+		if (res.start >= gfar_dev->resource[0].start &&
+		    res.start < gfar_dev->resource[0].end)
+			gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MDIO;
+
 		of_node_put(phy);
 		of_node_put(mdio);
 
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 45c1d6f..39af61f 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -86,6 +86,8 @@ struct gianfar_mdio_data {
 #define FSL_GIANFAR_DEV_HAS_VLAN		0x00000020
 #define FSL_GIANFAR_DEV_HAS_EXTENDED_HASH	0x00000040
 #define FSL_GIANFAR_DEV_HAS_PADDING		0x00000080
+#define FSL_GIANFAR_DEV_HAS_MAGIC_PACKET	0x00000100
+#define FSL_GIANFAR_DEV_HAS_MDIO		0x00000200
 
 /* Flags in gianfar_platform_data */
 #define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
-- 
1.5.0.3

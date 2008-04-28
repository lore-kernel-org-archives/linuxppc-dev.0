Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6C434DE651
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:39:33 +1000 (EST)
Date: Mon, 28 Apr 2008 17:39:47 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] gianfar: Add flags for magic packet and MDIO.
In-Reply-To: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
Message-ID: <Pine.LNX.4.64.0804281722140.7897@axis700.grange>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
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
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/powerpc/sysdev/fsl_soc.c |    7 +++++++
 include/linux/fsl_devices.h   |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d5fd916..032b8e8 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -324,6 +324,9 @@ static int __init gfar_of_init(void)
 		else
 			gfar_data.interface = PHY_INTERFACE_MODE_MII;
 
+		if (of_get_property(np, "fsl,magic-packet", NULL))
+			gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MAGIC_PACKET;
+
 		ph = of_get_property(np, "phy-handle", NULL);
 		if (ph == NULL) {
 			u32 *fixed_link;
@@ -345,6 +348,10 @@ static int __init gfar_of_init(void)
 			snprintf(gfar_data.bus_id, MII_BUS_ID_SIZE, "%x",
 					res.start);
 
+			if (res.start >= gfar_dev->resource[0].start &&
+			    res.start < gfar_dev->resource[0].end)
+				gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MDIO;
+
 			of_node_put(phy);
 			of_node_put(mdio);
 		}
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 5cec939..81fcc67 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -87,6 +87,8 @@ struct gianfar_mdio_data {
 #define FSL_GIANFAR_DEV_HAS_VLAN		0x00000020
 #define FSL_GIANFAR_DEV_HAS_EXTENDED_HASH	0x00000040
 #define FSL_GIANFAR_DEV_HAS_PADDING		0x00000080
+#define FSL_GIANFAR_DEV_HAS_MAGIC_PACKET	0x00000100
+#define FSL_GIANFAR_DEV_HAS_MDIO		0x00000200
 
 /* Flags in gianfar_platform_data */
 #define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a timer */
-- 
1.5.3.7

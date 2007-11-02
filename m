Return-Path: <SRS0=QBjm=P3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 91B66DDDCA
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 18:16:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org
Subject: [PATCH] net: Add 405EX support to new EMAC driver
Date: Fri, 2 Nov 2007 08:14:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711020814.43524.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the 405EX to the new EMAC driver. Some as on
AXON, the 405EX handles the MDIO via the RGMII bridge.

Tested on AMCC Kilauea.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c  |    3 ++-
 drivers/net/ibm_newemac/rgmii.c |   16 +++++++++++-----
 drivers/net/ibm_newemac/rgmii.h |    2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 0de3aa2..fd0a585 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2466,7 +2466,8 @@ static int __devinit emac_init_config(struct emac_instance *dev)
 	if (of_device_is_compatible(np, "ibm,emac4"))
 		dev->features |= EMAC_FTR_EMAC4;
 	if (of_device_is_compatible(np, "ibm,emac-axon")
-	    || of_device_is_compatible(np, "ibm,emac-440epx"))
+	    || of_device_is_compatible(np, "ibm,emac-440epx")
+	    || of_device_is_compatible(np, "ibm,emac-405ex"))
 		dev->features |= EMAC_FTR_HAS_AXON_STACR
 			| EMAC_FTR_STACR_OC_INVERT;
 	if (of_device_is_compatible(np, "ibm,emac-440spe"))
diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
index de41695..b9a4ce7 100644
--- a/drivers/net/ibm_newemac/rgmii.c
+++ b/drivers/net/ibm_newemac/rgmii.c
@@ -140,7 +140,12 @@ void rgmii_get_mdio(struct of_device *ofdev, int input)
 
 	RGMII_DBG2(dev, "get_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
+	/*
+	 * Some platforms (e.g. 440GX) have RGMII support but don't use it for
+	 * MDIO access. Only continue if platforms is using MDIO over the RGMII
+	 * interface (e.g. AXON, 405EX).
+	 */
+	if (dev->type != RGMII_HAS_MDIO)
 		return;
 
 	mutex_lock(&dev->lock);
@@ -161,7 +166,7 @@ void rgmii_put_mdio(struct of_device *ofdev, int input)
 
 	RGMII_DBG2(dev, "put_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
+	if (dev->type != RGMII_HAS_MDIO)
 		return;
 
 	fer = in_be32(&p->fer);
@@ -251,8 +256,9 @@ static int __devinit rgmii_probe(struct of_device *ofdev,
 	}
 
 	/* Check for RGMII type */
-	if (of_device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
-		dev->type = RGMII_AXON;
+	if (of_device_is_compatible(ofdev->node, "ibm,rgmii-axon") ||
+	    of_device_is_compatible(ofdev->node, "ibm,rgmii-405ex"))
+		dev->type = RGMII_HAS_MDIO;
 	else
 		dev->type = RGMII_STANDARD;
 
@@ -264,7 +270,7 @@ static int __devinit rgmii_probe(struct of_device *ofdev,
 
 	printk(KERN_INFO
 	       "RGMII %s %s initialized\n",
-	       dev->type == RGMII_STANDARD ? "standard" : "axon",
+	       dev->type == RGMII_STANDARD ? "standard" : "has-mdio",
 	       ofdev->node->full_name);
 
 	wmb();
diff --git a/drivers/net/ibm_newemac/rgmii.h b/drivers/net/ibm_newemac/rgmii.h
index 5780683..f1b0ef5 100644
--- a/drivers/net/ibm_newemac/rgmii.h
+++ b/drivers/net/ibm_newemac/rgmii.h
@@ -23,7 +23,7 @@
 
 /* RGMII bridge type */
 #define RGMII_STANDARD		0
-#define RGMII_AXON		1
+#define RGMII_HAS_MDIO		1
 
 /* RGMII bridge */
 struct rgmii_regs {
-- 
1.5.3.4.498.g9c514

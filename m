Return-Path: <SRS0=RRnR=P2=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0562BDDE24
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 02:04:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org
Subject: [PATCH] net: Add 405EX support to new EMAC driver
Date: Thu, 1 Nov 2007 15:54:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711011554.04935.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the 405EX to the new EMAC driver.

Tested on AMCC Kilauea.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c  |    3 ++-
 drivers/net/ibm_newemac/rgmii.c |    6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

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
index de41695..e393f68 100644
--- a/drivers/net/ibm_newemac/rgmii.c
+++ b/drivers/net/ibm_newemac/rgmii.c
@@ -140,9 +140,6 @@ void rgmii_get_mdio(struct of_device *ofdev, int input)
 
 	RGMII_DBG2(dev, "get_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
-		return;
-
 	mutex_lock(&dev->lock);
 
 	fer = in_be32(&p->fer);
@@ -161,9 +158,6 @@ void rgmii_put_mdio(struct of_device *ofdev, int input)
 
 	RGMII_DBG2(dev, "put_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
-		return;
-
 	fer = in_be32(&p->fer);
 	fer &= ~(0x00080000u >> input);
 	out_be32(&p->fer, fer);
-- 
1.5.3.4.498.g9c514

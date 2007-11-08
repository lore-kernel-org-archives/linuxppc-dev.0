Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Nov 2007 19:07:00 +1100
Subject: [PATCH 5/6] ibm_newemac: Cleanup/Fix RGMII MDIO support detection
In-Reply-To: <1194509217.421165.545980042680.qpush@grosgo>
Message-Id: <20071108080732.0C355DDE21@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

More than just "AXON" version of EMAC RGMII supports MDIO, so replace
the current test with a generic property in the device-tree that
indicates such support.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Should we set that in Sequoia DTS ?

 drivers/net/ibm_newemac/rgmii.c |   20 +++++++++++---------
 drivers/net/ibm_newemac/rgmii.h |    5 +++--
 2 files changed, 14 insertions(+), 11 deletions(-)

Index: linux-work/drivers/net/ibm_newemac/rgmii.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/rgmii.c	2007-11-08 18:46:06.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/rgmii.c	2007-11-08 18:51:00.000000000 +1100
@@ -140,7 +140,7 @@ void rgmii_get_mdio(struct of_device *of
 
 	RGMII_DBG2(dev, "get_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
+	if (!(dev->flags & EMAC_RGMII_FLAG_HAS_MDIO))
 		return;
 
 	mutex_lock(&dev->lock);
@@ -161,7 +161,7 @@ void rgmii_put_mdio(struct of_device *of
 
 	RGMII_DBG2(dev, "put_mdio(%d)" NL, input);
 
-	if (dev->type != RGMII_AXON)
+	if (!(dev->flags & EMAC_RGMII_FLAG_HAS_MDIO))
 		return;
 
 	fer = in_be32(&p->fer);
@@ -250,11 +250,13 @@ static int __devinit rgmii_probe(struct 
 		goto err_free;
 	}
 
-	/* Check for RGMII type */
+	/* Check for RGMII flags */
+	if (of_get_property(ofdev->node, "has-mdio", NULL))
+		dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
+
+	/* CAB lacks the right properties, fix this up */
 	if (of_device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
-		dev->type = RGMII_AXON;
-	else
-		dev->type = RGMII_STANDARD;
+		dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;
 
 	DBG2(dev, " Boot FER = 0x%08x, SSR = 0x%08x\n",
 	     in_be32(&dev->base->fer), in_be32(&dev->base->ssr));
@@ -263,9 +265,9 @@ static int __devinit rgmii_probe(struct 
 	out_be32(&dev->base->fer, 0);
 
 	printk(KERN_INFO
-	       "RGMII %s %s initialized\n",
-	       dev->type == RGMII_STANDARD ? "standard" : "axon",
-	       ofdev->node->full_name);
+	       "RGMII %s initialized with%s MDIO support\n",
+	       ofdev->node->full_name,
+	       (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
 
 	wmb();
 	dev_set_drvdata(&ofdev->dev, dev);
Index: linux-work/drivers/net/ibm_newemac/rgmii.h
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/rgmii.h	2007-11-08 18:46:06.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/rgmii.h	2007-11-08 18:47:32.000000000 +1100
@@ -35,8 +35,9 @@ struct rgmii_regs {
 struct rgmii_instance {
 	struct rgmii_regs __iomem	*base;
 
-	/* Type of RGMII bridge */
-	int				type;
+	/* RGMII bridge flags */
+	int				flags;
+#define EMAC_RGMII_FLAG_HAS_MDIO	0x00000001
 
 	/* Only one EMAC whacks us at a time */
 	struct mutex			lock;

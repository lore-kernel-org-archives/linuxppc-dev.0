Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 044ECDDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 19:27:27 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so1472031waf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:27:27 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 08/14] net: rework fsl_pq_mdio driver to use of_mdio
	infrastructure
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Tue, 31 Mar 2009 02:27:25 -0600
Message-ID: <20090331082725.1427.76321.stgit@localhost.localdomain>
In-Reply-To: <20090331075537.1427.7819.stgit@localhost.localdomain>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: olof@lixom.net, afleming@freescale.com,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch simplifies the driver by making use of more common code.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/fsl_pq_mdio.c |   53 +++------------------------------------------
 1 files changed, 4 insertions(+), 49 deletions(-)


diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index b3079a5..83a98f4 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -34,6 +34,7 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 
 #include <asm/io.h>
@@ -154,44 +155,6 @@ static int fsl_pq_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
-/* Allocate an array which provides irq #s for each PHY on the given bus */
-static int *create_irq_map(struct device_node *np)
-{
-	int *irqs;
-	int i;
-	struct device_node *child = NULL;
-
-	irqs = kcalloc(PHY_MAX_ADDR, sizeof(int), GFP_KERNEL);
-
-	if (!irqs)
-		return NULL;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		irqs[i] = PHY_POLL;
-
-	while ((child = of_get_next_child(np, child)) != NULL) {
-		int irq = irq_of_parse_and_map(child, 0);
-		const u32 *id;
-
-		if (irq == NO_IRQ)
-			continue;
-
-		id = of_get_property(child, "reg", NULL);
-
-		if (!id)
-			continue;
-
-		if (*id < PHY_MAX_ADDR && *id >= 0)
-			irqs[*id] = irq;
-		else
-			printk(KERN_WARNING "%s: "
-					"%d is not a valid PHY address\n",
-					np->full_name, *id);
-	}
-
-	return irqs;
-}
-
 void fsl_pq_mdio_bus_name(char *name, struct device_node *np)
 {
 	const u32 *addr;
@@ -314,7 +277,7 @@ static int fsl_pq_mdio_probe(struct of_device *ofdev,
 
 	new_bus->priv = (void __force *)regs;
 
-	new_bus->irq = create_irq_map(np);
+	new_bus->irq = kcalloc(PHY_MAX_ADDR, sizeof(int), GFP_KERNEL);
 
 	if (NULL == new_bus->irq) {
 		err = -ENOMEM;
@@ -383,16 +346,8 @@ static int fsl_pq_mdio_probe(struct of_device *ofdev,
 
 	out_be32(tbipa, tbiaddr);
 
-	/*
-	 * The TBIPHY-only buses will find PHYs at every address,
-	 * so we mask them all but the TBI
-	 */
-	if (!of_device_is_compatible(np, "fsl,gianfar-mdio"))
-		new_bus->phy_mask = ~(1 << tbiaddr);
-
-	err = mdiobus_register(new_bus);
-
-	if (err) {
+	err = of_mdiobus_register(new_bus, np);
+	if (err != 0) {
 		printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
 				new_bus->name);
 		goto err_free_irqs;

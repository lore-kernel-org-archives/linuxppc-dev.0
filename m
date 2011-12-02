Return-Path: <afleming@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DC29B10082D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 18:06:06 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: David Miller <davem@davemloft.net>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] Revert "net: fsl_pq_mdio: fix non tbi phy access"
Date: Fri, 2 Dec 2011 01:05:48 -0600
Message-ID: <1322809549-32622-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit c3e072f8a6c5625028531c40ec65f7e301531be2.

The TBI PHY Address must always be set to something sensible.
If not, the value currently in the register may interfere
with MDIO transactions to that address. The architected
solution is to have a TBI node in the device tree, which corresponds
to the desired address (and which should be chosen so that it does
not conflict with other PHYs on the bus). If that node is not there,
it is incorrect to just continue. We must return an error, so that
developers have a chance to realize they've mis-configured their
device trees. A separate patch has been submitted to add such
a node to the device trees for boards which were missing that node.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index f109602..6ff124c 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -356,16 +356,16 @@ static int fsl_pq_mdio_probe(struct platform_device *ofdev)
 
 		if (prop)
 			tbiaddr = *prop;
+	}
 
-		if (tbiaddr == -1) {
-			err = -EBUSY;
+	if (tbiaddr == -1) {
+		err = -EBUSY;
 
-			goto err_free_irqs;
-		} else {
-			out_be32(tbipa, tbiaddr);
-		}
+		goto err_free_irqs;
 	}
 
+	out_be32(tbipa, tbiaddr);
+
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
 		printk (KERN_ERR "%s: Cannot register as MDIO bus\n",
-- 
1.7.3.4

Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail1-relais-roc.national.inria.fr
 (mail1-relais-roc.national.inria.fr [192.134.164.82])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.inria.fr", Issuer "TERENA SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24F3E2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 22:58:43 +1000 (EST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: [PATCH 3/5] drivers/net/ethernet/freescale/fs_enet: fix error return
 code
Date: Tue, 14 Aug 2012 14:58:33 +0200
Message-Id: <1344949115-13266-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1344949115-13266-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1344949115-13266-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitaly Bordug <vbordug@ru.mvista.com>,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Convert a 0 error return code to a negative one, as returned elsewhere in the
function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret;
expression e,e1,e2,e3,e4,x;
@@

(
if (\(ret != 0\|ret < 0\) || ...) { ... return ...; }
|
ret = 0
)
... when != ret = e1
*x = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\|ioremap\|ioremap_nocache\|devm_ioremap\|devm_ioremap_nocache\)(...);
... when != x = e2
    when != ret = e3
*if (x == NULL || ...)
{
  ... when != ret = e4
*  return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c |    4 +++-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c     |    8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index 0f2d1a7..1514533 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -174,8 +174,10 @@ static int __devinit fs_enet_mdio_probe(struct platform_device *ofdev)
 
 	new_bus->phy_mask = ~0;
 	new_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
-	if (!new_bus->irq)
+	if (!new_bus->irq) {
+		ret = -ENOMEM;
 		goto out_unmap_regs;
+	}
 
 	new_bus->parent = &ofdev->dev;
 	dev_set_drvdata(&ofdev->dev, new_bus);
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
index 55bb867..cdf702a 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
@@ -137,8 +137,10 @@ static int __devinit fs_enet_mdio_probe(struct platform_device *ofdev)
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%x", res.start);
 
 	fec->fecp = ioremap(res.start, resource_size(&res));
-	if (!fec->fecp)
+	if (!fec->fecp) {
+		ret = -ENOMEM;
 		goto out_fec;
+	}
 
 	if (get_bus_freq) {
 		clock = get_bus_freq(ofdev->dev.of_node);
@@ -172,8 +174,10 @@ static int __devinit fs_enet_mdio_probe(struct platform_device *ofdev)
 
 	new_bus->phy_mask = ~0;
 	new_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
-	if (!new_bus->irq)
+	if (!new_bus->irq) {
+		ret = -ENOMEM;
 		goto out_unmap_regs;
+	}
 
 	new_bus->parent = &ofdev->dev;
 	dev_set_drvdata(&ofdev->dev, new_bus);

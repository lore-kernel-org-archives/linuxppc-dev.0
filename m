Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 236CE2C0180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 23:27:02 +1000 (EST)
Received: by mail-bk0-f42.google.com with SMTP id my10so2869100bkb.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 06:26:28 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 06/10] of/irq: Return errors from of_irq_to_resource()
Date: Wed, 18 Sep 2013 15:24:48 +0200
Message-Id: <1379510692-32435-7-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update of_irq_to_resource() to return 0 on success and a negative error
code on failure. This allows the precise nature of the failure to be
determined in the caller and errors to be propagated appropriately.

While at it, make the index parameter unsigned. Accessing negative
indices is invalid, so we might as well enforce that by using the right
data type.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- convert existing callers instead of using compatible wrapper

 arch/powerpc/platforms/83xx/mpc832x_rdb.c  |  2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c |  5 +++--
 drivers/of/irq.c                           | 14 +++++++++++---
 include/linux/of_irq.h                     |  2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index eff5baa..b198e73 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -89,7 +89,7 @@ static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 			goto err;
 
 		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
+		if (ret)
 			goto err;
 
 		pdev = platform_device_alloc("mpc83xx_spi", i);
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 7fb5677..bd713bd 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2489,9 +2489,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	ppd.shared = pdev;
 
 	memset(&res, 0, sizeof(res));
-	if (!of_irq_to_resource(pnp, 0, &res)) {
+	ret = of_irq_to_resource(pnp, 0, &res);
+	if (ret) {
 		dev_err(&pdev->dev, "missing interrupt on %s\n", pnp->name);
-		return -EINVAL;
+		return ret;
 	}
 
 	if (of_property_read_u32(pnp, "reg", &ppd.port_number)) {
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6ad46fd..e4f38c0 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -341,10 +341,18 @@ EXPORT_SYMBOL_GPL(of_irq_map_one);
  * @dev: pointer to device tree node
  * @index: zero-based index of the irq
  * @r: pointer to resource structure to return result into.
+ *
+ * Returns zero on success or a negative error code on failure.
  */
-int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+int of_irq_to_resource(struct device_node *dev, unsigned int index,
+		       struct resource *r)
 {
-	int irq = irq_of_parse_and_map(dev, index);
+	unsigned int irq;
+	int ret;
+
+	ret = __irq_of_parse_and_map(dev, index, &irq);
+	if (ret)
+		return ret;
 
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
@@ -364,7 +372,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		r->name = name ? name : dev->full_name;
 	}
 
-	return irq;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_irq_to_resource);
 
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 11da949..6d62b73 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -67,7 +67,7 @@ extern int of_irq_map_one(struct device_node *device, int index,
 extern int irq_create_of_mapping(struct device_node *controller,
 				 const u32 *intspec, unsigned int intsize,
 				 unsigned int *virqp);
-extern int of_irq_to_resource(struct device_node *dev, int index,
+extern int of_irq_to_resource(struct device_node *dev, unsigned int index,
 			      struct resource *r);
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_to_resource_table(struct device_node *dev,
-- 
1.8.4

Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74577B7025
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:00:45 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V3 5/6] Avoid duplicate probe for of platform devices
Date: Fri, 8 Jun 2012 17:42:06 +0800
Message-ID: <1339148527-16911-6-git-send-email-B38951@freescale.com>
In-Reply-To: <1339148527-16911-1-git-send-email-B38951@freescale.com>
References: <1339148527-16911-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: R65777@freescale.com, b38951@freescale.com, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We changed the pcie controller driver to platform driver so that the PCI
of platform devices need to be created earlier in the arch_initcall stage
according to the original timing of calling fsl_add_bridge(). So we do PCI
probing separately from other devices. But probing more than once could
cause duplication warning. We add check if the devices have already probed
before probing any devices to avoid duplication warning.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/of/platform.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a37330e..3aab01f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -139,6 +139,18 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	if (!dev)
 		return NULL;
 
+	dev->dev.of_node = of_node_get(np);
+	if (bus_id)
+		dev_set_name(&dev->dev, "%s", bus_id);
+	else
+		of_device_make_bus_id(&dev->dev);
+
+	if (kset_find_obj(dev->dev.kobj.kset, kobject_name(&dev->dev.kobj))) {
+		kfree(dev);
+		of_node_put(np);
+		return NULL;
+	}
+
 	/* count the io and irq resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
 		num_reg++;
@@ -161,17 +173,11 @@ struct platform_device *of_device_alloc(struct device_node *np,
 		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
 	}
 
-	dev->dev.of_node = of_node_get(np);
 #if defined(CONFIG_MICROBLAZE)
 	dev->dev.dma_mask = &dev->archdata.dma_mask;
 #endif
 	dev->dev.parent = parent;
 
-	if (bus_id)
-		dev_set_name(&dev->dev, "%s", bus_id);
-	else
-		of_device_make_bus_id(&dev->dev);
-
 	return dev;
 }
 EXPORT_SYMBOL(of_device_alloc);
-- 
1.7.5.1

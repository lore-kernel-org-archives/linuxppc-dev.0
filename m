Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id B7D3DDDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 04:41:31 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] maps/mtd-ram: refactor probe and remove
Date: Wed, 21 Jan 2009 18:41:24 +0100
Message-Id: <1232559685-2268-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactor the probe and remove routines of the mtd-ram driver to export
a generic part which can later be accessed by an of-counterpart of this
driver. Tested with a phyCORE-MPC5200B-IO.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mtd/maps/plat-ram.c  |  123 +++++++++++++++++++++---------------------
 include/linux/mtd/plat-ram.h |    4 ++
 2 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/maps/plat-ram.c b/drivers/mtd/maps/plat-ram.c
index e7dd9c8..1582cd6 100644
--- a/drivers/mtd/maps/plat-ram.c
+++ b/drivers/mtd/maps/plat-ram.c
@@ -50,16 +50,6 @@ struct platram_info {
 	struct platdata_mtd_ram	*pdata;
 };
 
-/* to_platram_info()
- *
- * device private data to struct platram_info conversion
-*/
-
-static inline struct platram_info *to_platram_info(struct platform_device *dev)
-{
-	return (struct platram_info *)platform_get_drvdata(dev);
-}
-
 /* platram_setrw
  *
  * call the platform device's set rw/ro control
@@ -77,18 +67,14 @@ static inline void platram_setrw(struct platram_info *info, int to)
 		(info->pdata->set_rw)(info->dev, to);
 }
 
-/* platram_remove
- *
- * called to remove the device from the driver's control
-*/
-
-static int platram_remove(struct platform_device *pdev)
+int __platram_remove(struct device *dev)
 {
-	struct platram_info *info = to_platram_info(pdev);
+	struct platram_info *info;
 
-	platform_set_drvdata(pdev, NULL);
+	dev_dbg(dev, "removing device\n");
 
-	dev_dbg(&pdev->dev, "removing device\n");
+	info = dev_get_drvdata(dev);
+	dev_set_drvdata(dev, NULL);
 
 	if (info == NULL)
 		return 0;
@@ -123,68 +109,49 @@ static int platram_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__platram_remove);
 
-/* platram_probe
+/* platram_remove
  *
- * called from device drive system when a device matching our
- * driver is found.
+ * called to remove the device from the driver's control
 */
 
-static int platram_probe(struct platform_device *pdev)
+static int platram_remove(struct platform_device *pdev)
+{
+	return __platram_remove(&pdev->dev);
+}
+
+int __platram_probe(struct device *dev, const char *name,
+			struct resource *res, struct platdata_mtd_ram *pdata)
 {
-	struct platdata_mtd_ram	*pdata;
 	struct platram_info *info;
-	struct resource *res;
 	int err = 0;
 
-	dev_dbg(&pdev->dev, "probe entered\n");
-
-	if (pdev->dev.platform_data == NULL) {
-		dev_err(&pdev->dev, "no platform data supplied\n");
-		err = -ENOENT;
-		goto exit_error;
-	}
-
-	pdata = pdev->dev.platform_data;
-
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
-		dev_err(&pdev->dev, "no memory for flash info\n");
+		dev_err(dev, "no memory for flash info\n");
 		err = -ENOMEM;
 		goto exit_error;
 	}
 
-	platform_set_drvdata(pdev, info);
+	dev_set_drvdata(dev, info);
 
-	info->dev = &pdev->dev;
+	info->dev = dev;
 	info->pdata = pdata;
 
-	/* get the resource for the memory mapping */
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource specified\n");
-		err = -ENOENT;
-		goto exit_free;
-	}
-
-	dev_dbg(&pdev->dev, "got platform resource %p (0x%llx)\n", res,
-		(unsigned long long)res->start);
-
 	/* setup map parameters */
 
 	info->map.phys = res->start;
 	info->map.size = (res->end - res->start) + 1;
 	info->map.name = pdata->mapname != NULL ?
-			(char *)pdata->mapname : (char *)pdev->name;
+			(char *)pdata->mapname : (char *)name;
 	info->map.bankwidth = pdata->bankwidth;
 
 	/* register our usage of the memory area */
 
-	info->area = request_mem_region(res->start, info->map.size, pdev->name);
+	info->area = request_mem_region(res->start, info->map.size, name);
 	if (info->area == NULL) {
-		dev_err(&pdev->dev, "failed to request memory region\n");
+		dev_err(dev, "failed to request memory region\n");
 		err = -EIO;
 		goto exit_free;
 	}
@@ -192,17 +159,17 @@ static int platram_probe(struct platform_device *pdev)
 	/* remap the memory area */
 
 	info->map.virt = ioremap(res->start, info->map.size);
-	dev_dbg(&pdev->dev, "virt %p, %lu bytes\n", info->map.virt, info->map.size);
+	dev_dbg(dev, "virt %p, %lu bytes\n", info->map.virt, info->map.size);
 
 	if (info->map.virt == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() region\n");
+		dev_err(dev, "failed to ioremap() region\n");
 		err = -EIO;
 		goto exit_free;
 	}
 
 	simple_map_init(&info->map);
 
-	dev_dbg(&pdev->dev, "initialised map, probing for mtd\n");
+	dev_dbg(dev, "initialised map, probing for mtd\n");
 
 	/* probe for the right mtd map driver
 	 * supplied by the platform_data struct */
@@ -218,7 +185,7 @@ static int platram_probe(struct platform_device *pdev)
 		info->mtd = do_map_probe("map_ram", &info->map);
 
 	if (info->mtd == NULL) {
-		dev_err(&pdev->dev, "failed to probe for map_ram\n");
+		dev_err(dev, "failed to probe for map_ram\n");
 		err = -ENOMEM;
 		goto exit_free;
 	}
@@ -249,20 +216,54 @@ static int platram_probe(struct platform_device *pdev)
 #endif /* CONFIG_MTD_PARTITIONS */
 
 	if (add_mtd_device(info->mtd)) {
-		dev_err(&pdev->dev, "add_mtd_device() failed\n");
+		dev_err(dev, "add_mtd_device() failed\n");
 		err = -ENOMEM;
 	}
 
 	if (!err)
-		dev_info(&pdev->dev, "registered mtd device\n");
+		dev_info(dev, "registered mtd device\n");
 
 	return err;
 
  exit_free:
-	platram_remove(pdev);
+	__platram_remove(dev);
  exit_error:
 	return err;
 }
+EXPORT_SYMBOL_GPL(__platram_probe);
+
+/* platram_probe
+ *
+ * called from device drive system when a device matching our
+ * driver is found.
+*/
+
+static int platram_probe(struct platform_device *pdev)
+{
+	struct platdata_mtd_ram	*pdata;
+	struct resource *res;
+
+	dev_dbg(&pdev->dev, "probe entered\n");
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "no platform data supplied\n");
+		return -ENOENT;
+	}
+
+	/* get the resource for the memory mapping */
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource specified\n");
+		return -ENOENT;
+	}
+
+	dev_dbg(&pdev->dev, "got platform resource %p (0x%llx)\n", res,
+		(unsigned long long)res->start);
+
+	return __platram_probe(&pdev->dev, pdev->name, res, pdata);
+}
 
 /* device driver info */
 
diff --git a/include/linux/mtd/plat-ram.h b/include/linux/mtd/plat-ram.h
index e07890a..c522562 100644
--- a/include/linux/mtd/plat-ram.h
+++ b/include/linux/mtd/plat-ram.h
@@ -31,4 +31,8 @@ struct platdata_mtd_ram {
 	void	(*set_rw)(struct device *dev, int to);
 };
 
+extern int __platram_probe(struct device *dev, const char *name,
+			struct resource *res, struct platdata_mtd_ram *pdata);
+extern int __platram_remove(struct device *dev);
+
 #endif /* __LINUX_MTD_PLATRAM_H */
-- 
1.5.6.5

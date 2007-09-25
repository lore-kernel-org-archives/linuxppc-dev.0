Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 227B7DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 22:12:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8PCBtYh438142
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 12:11:55 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8PCBt3Q1839152
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:11:55 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8PCBsLD015339
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 14:11:55 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	"LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ibmebus: Remove bus match/probe/remove functions
References: <200709251410.29780.fenkes@de.ibm.com>
In-Reply-To: <200709251410.29780.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 25 Sep 2007 14:11:53 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251411.54465.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ibmebus_{,un}register_driver() are replaced by dummy functions because
ibmebus is temporarily unusable in this transitional state.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 arch/powerpc/kernel/ibmebus.c |  199 ++---------------------------------------
 1 files changed, 6 insertions(+), 193 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index d6a38cd..cc80f84 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -41,6 +41,7 @@
 #include <linux/kobject.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/of_platform.h>
 #include <asm/ibmebus.h>
 #include <asm/abs_addr.h>
 
@@ -123,183 +124,14 @@ static struct dma_mapping_ops ibmebus_dma_ops = {
 	.dma_supported  = ibmebus_dma_supported,
 };
 
-static int ibmebus_bus_probe(struct device *dev)
-{
-	struct ibmebus_dev *ibmebusdev    = to_ibmebus_dev(dev);
-	struct ibmebus_driver *ibmebusdrv = to_ibmebus_driver(dev->driver);
-	const struct of_device_id *id;
-	int error = -ENODEV;
-
-	if (!ibmebusdrv->probe)
-		return error;
-
-	id = of_match_device(ibmebusdrv->id_table, &ibmebusdev->ofdev);
-	if (id) {
-		error = ibmebusdrv->probe(ibmebusdev, id);
-	}
-
-	return error;
-}
-
-static int ibmebus_bus_remove(struct device *dev)
-{
-	struct ibmebus_dev *ibmebusdev    = to_ibmebus_dev(dev);
-	struct ibmebus_driver *ibmebusdrv = to_ibmebus_driver(dev->driver);
-
-	if (ibmebusdrv->remove) {
-		return ibmebusdrv->remove(ibmebusdev);
-	}
-
-	return 0;
-}
-
-static void __devinit ibmebus_dev_release(struct device *dev)
-{
-	of_node_put(to_ibmebus_dev(dev)->ofdev.node);
-	kfree(to_ibmebus_dev(dev));
-}
-
-static int __devinit ibmebus_register_device_common(
-	struct ibmebus_dev *dev, const char *name)
-{
-	int err = 0;
-
-	dev->ofdev.dev.parent  = &ibmebus_bus_device;
-	dev->ofdev.dev.bus     = &ibmebus_bus_type;
-	dev->ofdev.dev.release = ibmebus_dev_release;
-
-	dev->ofdev.dev.archdata.of_node = dev->ofdev.node;
-	dev->ofdev.dev.archdata.dma_ops = &ibmebus_dma_ops;
-	dev->ofdev.dev.archdata.numa_node = of_node_to_nid(dev->ofdev.node);
-
-	/* An ibmebusdev is based on a of_device. We have to change the
-	 * bus type to use our own DMA mapping operations.
-	 */
-	if ((err = of_device_register(&dev->ofdev)) != 0) {
-		printk(KERN_ERR "%s: failed to register device (%d).\n",
-		       __FUNCTION__, err);
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static struct ibmebus_dev* __devinit ibmebus_register_device_node(
-	struct device_node *dn)
-{
-	struct ibmebus_dev *dev;
-	int i, len, bus_len;
-
-	dev = kzalloc(sizeof(struct ibmebus_dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->ofdev.node = of_node_get(dn);
-
-	len = strlen(dn->full_name + 1);
-	bus_len = min(len, BUS_ID_SIZE - 1);
-	memcpy(dev->ofdev.dev.bus_id, dn->full_name + 1
-	       + (len - bus_len), bus_len);
-	for (i = 0; i < bus_len; i++)
-		if (dev->ofdev.dev.bus_id[i] == '/')
-			dev->ofdev.dev.bus_id[i] = '_';
-
-	/* Register with generic device framework. */
-	if (ibmebus_register_device_common(dev, dn->name) != 0) {
-		kfree(dev);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return dev;
-}
-
-static void ibmebus_probe_of_nodes(char* name)
-{
-	struct device_node *dn = NULL;
-
-	while ((dn = of_find_node_by_name(dn, name))) {
-		if (IS_ERR(ibmebus_register_device_node(dn))) {
-			of_node_put(dn);
-			return;
-		}
-	}
-
-	of_node_put(dn);
-
-	return;
-}
-
-static void ibmebus_add_devices_by_id(struct of_device_id *idt)
-{
-	while (strlen(idt->name) > 0) {
-		ibmebus_probe_of_nodes(idt->name);
-		idt++;
-	}
-
-	return;
-}
-
-static int ibmebus_match_name(struct device *dev, void *data)
-{
-	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	const char *name;
-
-	name = of_get_property(ebus_dev->ofdev.node, "name", NULL);
-
-	if (name && (strcmp(data, name) == 0))
-		return 1;
-
-	return 0;
-}
-
-static int ibmebus_unregister_device(struct device *dev)
-{
-	of_device_unregister(to_of_device(dev));
-
-	return 0;
-}
-
-static void ibmebus_remove_devices_by_id(struct of_device_id *idt)
-{
-	struct device *dev;
-
-	while (strlen(idt->name) > 0) {
-		while ((dev = bus_find_device(&ibmebus_bus_type, NULL,
-					      (void*)idt->name,
-					      ibmebus_match_name))) {
-			ibmebus_unregister_device(dev);
-		}
-		idt++;
-	}
-
-	return;
-}
-
 int ibmebus_register_driver(struct ibmebus_driver *drv)
 {
-	int err = 0;
-
-	drv->driver.name   = drv->name;
-	drv->driver.bus    = &ibmebus_bus_type;
-	drv->driver.probe  = ibmebus_bus_probe;
-	drv->driver.remove = ibmebus_bus_remove;
-
-	if ((err = driver_register(&drv->driver) != 0))
-		return err;
-
-	/* remove all supported devices first, in case someone
-	 * probed them manually before registering the driver */
-	ibmebus_remove_devices_by_id(drv->id_table);
-	ibmebus_add_devices_by_id(drv->id_table);
-
 	return 0;
 }
 EXPORT_SYMBOL(ibmebus_register_driver);
 
 void ibmebus_unregister_driver(struct ibmebus_driver *drv)
 {
-	driver_unregister(&drv->driver);
-	ibmebus_remove_devices_by_id(drv->id_table);
 }
 EXPORT_SYMBOL(ibmebus_unregister_driver);
 
@@ -327,23 +159,6 @@ void ibmebus_free_irq(struct ibmebus_dev *dev, u32 ist, void *dev_id)
 }
 EXPORT_SYMBOL(ibmebus_free_irq);
 
-static int ibmebus_bus_match(struct device *dev, struct device_driver *drv)
-{
-	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	struct ibmebus_driver *ebus_drv    = to_ibmebus_driver(drv);
-	const struct of_device_id *ids     = ebus_drv->id_table;
-	const struct of_device_id *found_id;
-
-	if (!ids)
-		return 0;
-
-	found_id = of_match_device(ids, &ebus_dev->ofdev);
-	if (found_id)
-		return 1;
-
-	return 0;
-}
-
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -404,7 +219,7 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 	}
 
 	if ((dn = of_find_node_by_path(path))) {
-		dev = ibmebus_register_device_node(dn);
+/*		dev = ibmebus_register_device_node(dn); */
 		of_node_put(dn);
 		rc = IS_ERR(dev) ? PTR_ERR(dev) : count;
 	} else {
@@ -430,7 +245,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
 
 	if ((dev = bus_find_device(&ibmebus_bus_type, NULL, path,
 				   ibmebus_match_path))) {
-		ibmebus_unregister_device(dev);
+/*		ibmebus_unregister_device(dev); */
 
 		kfree(path);
 		return count;
@@ -450,8 +265,6 @@ static struct bus_attribute ibmebus_bus_attrs[] = {
 };
 
 struct bus_type ibmebus_bus_type = {
-	.name      = "ibmebus",
-	.match     = ibmebus_bus_match,
 	.dev_attrs = ibmebus_dev_attrs,
 	.bus_attrs = ibmebus_bus_attrs
 };
@@ -463,9 +276,9 @@ static int __init ibmebus_bus_init(void)
 
 	printk(KERN_INFO "IBM eBus Device Driver\n");
 
-	err = bus_register(&ibmebus_bus_type);
+	err = of_bus_type_init(&ibmebus_bus_type, "ibmebus");
 	if (err) {
-		printk(KERN_ERR ":%s: failed to register IBM eBus.\n",
+		printk(KERN_ERR "%s: failed to register IBM eBus.\n",
 		       __FUNCTION__);
 		return err;
 	}
@@ -481,4 +294,4 @@ static int __init ibmebus_bus_init(void)
 
 	return 0;
 }
-__initcall(ibmebus_bus_init);
+postcore_initcall(ibmebus_bus_init);
-- 
1.5.2

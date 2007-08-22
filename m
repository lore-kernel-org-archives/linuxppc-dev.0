Return-Path: <arnd@arndb.de>
Message-Id: <20070822170732.371327244@arndb.de>
References: <20070822170124.764128591@arndb.de>
Date: Wed, 22 Aug 2007 19:01:27 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 3/5] Axonram module modification for latest firmware API
	changes
Cc: Maximilian <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Maxim Shchetynin <maxim@de.ibm.com>

Firmware would not deliver two interrupt numbers in device-tree any more
but only one, for correctable ECC, because uncorrectable ECC from now
handles firmware itself.
Changes in the axonram module are necessary because in the old version, if
it is not allowed to fetch the second interrupt number from device-tree,
it interpretes this as an error case and exits.

Signed-off-by: Maximilian <maxim@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-2.6/arch/powerpc/sysdev/axonram.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/axonram.c
+++ linux-2.6/arch/powerpc/sysdev/axonram.c
@@ -59,8 +59,7 @@
 struct axon_ram_bank {
 	struct of_device	*device;
 	struct gendisk		*disk;
-	unsigned int		irq_correctable;
-	unsigned int		irq_uncorrectable;
+	unsigned int		irq_id;
 	unsigned long		ph_addr;
 	unsigned long		io_addr;
 	unsigned long		size;
@@ -93,16 +92,9 @@ axon_ram_irq_handler(int irq, void *dev)
 
 	BUG_ON(!bank);
 
-	if (irq == bank->irq_correctable) {
-		dev_err(&device->dev, "Correctable memory error occured\n");
-		bank->ecc_counter++;
-		return IRQ_HANDLED;
-	} else if (irq == bank->irq_uncorrectable) {
-		dev_err(&device->dev, "Uncorrectable memory error occured\n");
-		panic("Critical ECC error on %s", device->node->full_name);
-	}
-
-	return IRQ_NONE;
+	dev_err(&device->dev, "Correctable memory error occured\n");
+	bank->ecc_counter++;
+	return IRQ_HANDLED;
 }
 
 /**
@@ -259,28 +251,18 @@ axon_ram_probe(struct of_device *device,
 	blk_queue_hardsect_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
 	add_disk(bank->disk);
 
-	bank->irq_correctable = irq_of_parse_and_map(device->node, 0);
-	bank->irq_uncorrectable = irq_of_parse_and_map(device->node, 1);
-	if ((bank->irq_correctable <= 0) || (bank->irq_uncorrectable <= 0)) {
+	bank->irq_id = irq_of_parse_and_map(device->node, 0);
+	if (bank->irq_id == NO_IRQ) {
 		dev_err(&device->dev, "Cannot access ECC interrupt ID\n");
 		rc = -EFAULT;
 		goto failed;
 	}
 
-	rc = request_irq(bank->irq_correctable, axon_ram_irq_handler,
-			AXON_RAM_IRQ_FLAGS, bank->disk->disk_name, device);
-	if (rc != 0) {
-		dev_err(&device->dev, "Cannot register ECC interrupt handler\n");
-		bank->irq_correctable = bank->irq_uncorrectable = 0;
-		rc = -EFAULT;
-		goto failed;
-	}
-
-	rc = request_irq(bank->irq_uncorrectable, axon_ram_irq_handler,
+	rc = request_irq(bank->irq_id, axon_ram_irq_handler,
 			AXON_RAM_IRQ_FLAGS, bank->disk->disk_name, device);
 	if (rc != 0) {
 		dev_err(&device->dev, "Cannot register ECC interrupt handler\n");
-		bank->irq_uncorrectable = 0;
+		bank->irq_id = NO_IRQ;
 		rc = -EFAULT;
 		goto failed;
 	}
@@ -296,10 +278,8 @@ axon_ram_probe(struct of_device *device,
 
 failed:
 	if (bank != NULL) {
-		if (bank->irq_uncorrectable > 0)
-			free_irq(bank->irq_uncorrectable, device);
-		if (bank->irq_correctable > 0)
-			free_irq(bank->irq_correctable, device);
+		if (bank->irq_id != NO_IRQ)
+			free_irq(bank->irq_id, device);
 		if (bank->disk != NULL) {
 			if (bank->disk->queue != NULL)
 				blk_cleanup_queue(bank->disk->queue);
@@ -329,8 +309,7 @@ axon_ram_remove(struct of_device *device
 	BUG_ON(!bank || !bank->disk);
 
 	device_remove_file(&device->dev, &dev_attr_ecc);
-	free_irq(bank->irq_uncorrectable, device);
-	free_irq(bank->irq_correctable, device);
+	free_irq(bank->irq_id, device);
 	blk_cleanup_queue(bank->disk->queue);
 	unregister_blkdev(bank->disk->major, bank->disk->disk_name);
 	del_gendisk(bank->disk);

--

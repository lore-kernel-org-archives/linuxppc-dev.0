Return-Path: <arnd@arndb.de>
Message-Id: <20080704190805.768128502@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:37 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 02/11] powerpc/axonram: use only one block device major number
Cc: Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Axonram module registers one block device for each DDR2 DIMM found
on a system. This means that each DDR2 DIMM becomes its own block device
major number. This patch lets axonram module to register the only one
block device for all DDR2 DIMMs which also spares kernel resources.

Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/axonram.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 7f59188..9b639ed 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -57,6 +57,8 @@
 #define AXON_RAM_SECTOR_SIZE		1 << AXON_RAM_SECTOR_SHIFT
 #define AXON_RAM_IRQ_FLAGS		IRQF_SHARED | IRQF_TRIGGER_RISING
 
+static int azfs_major, azfs_minor;
+
 struct axon_ram_bank {
 	struct of_device	*device;
 	struct gendisk		*disk;
@@ -227,19 +229,14 @@ axon_ram_probe(struct of_device *device, const struct of_device_id *device_id)
 		goto failed;
 	}
 
-	bank->disk->first_minor = 0;
+	bank->disk->major = azfs_major;
+	bank->disk->first_minor = azfs_minor;
 	bank->disk->fops = &axon_ram_devops;
 	bank->disk->private_data = bank;
 	bank->disk->driverfs_dev = &device->dev;
 
 	sprintf(bank->disk->disk_name, "%s%d",
 			AXON_RAM_DEVICE_NAME, axon_ram_bank_id);
-	bank->disk->major = register_blkdev(0, bank->disk->disk_name);
-	if (bank->disk->major < 0) {
-		dev_err(&device->dev, "Cannot register block device\n");
-		rc = -EFAULT;
-		goto failed;
-	}
 
 	bank->disk->queue = blk_alloc_queue(GFP_KERNEL);
 	if (bank->disk->queue == NULL) {
@@ -276,6 +273,8 @@ axon_ram_probe(struct of_device *device, const struct of_device_id *device_id)
 		goto failed;
 	}
 
+	azfs_minor += bank->disk->minors;
+
 	return 0;
 
 failed:
@@ -310,7 +309,6 @@ axon_ram_remove(struct of_device *device)
 
 	device_remove_file(&device->dev, &dev_attr_ecc);
 	free_irq(bank->irq_id, device);
-	unregister_blkdev(bank->disk->major, bank->disk->disk_name);
 	del_gendisk(bank->disk);
 	iounmap((void __iomem *) bank->io_addr);
 	kfree(bank);
@@ -341,6 +339,14 @@ static struct of_platform_driver axon_ram_driver = {
 static int __init
 axon_ram_init(void)
 {
+	azfs_major = register_blkdev(azfs_major, AXON_RAM_DEVICE_NAME);
+	if (azfs_major < 0) {
+		printk(KERN_ERR "%s cannot become block device major number\n",
+				AXON_RAM_MODULE_NAME);
+		return -EFAULT;
+	}
+	azfs_minor = 0;
+
 	return of_register_platform_driver(&axon_ram_driver);
 }
 
@@ -351,6 +357,7 @@ static void __exit
 axon_ram_exit(void)
 {
 	of_unregister_platform_driver(&axon_ram_driver);
+	unregister_blkdev(azfs_major, AXON_RAM_DEVICE_NAME);
 }
 
 module_init(axon_ram_init);
-- 
1.5.4.3

-- 

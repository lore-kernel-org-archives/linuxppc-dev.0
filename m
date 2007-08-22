Return-Path: <arnd@arndb.de>
Message-Id: <20070822170732.517188445@arndb.de>
References: <20070822170124.764128591@arndb.de>
Date: Wed, 22 Aug 2007 19:01:28 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 4/5] axonram: do not delete gendisks queue in error path
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
On exit do not delete gendisk's queue because this is already done by
del_gendisk(). Doing it twice may cause memory damage.

Signed-off-by: Maximilian <maxim@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-2.6/arch/powerpc/sysdev/axonram.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/axonram.c
+++ linux-2.6/arch/powerpc/sysdev/axonram.c
@@ -281,8 +281,6 @@ failed:
 		if (bank->irq_id != NO_IRQ)
 			free_irq(bank->irq_id, device);
 		if (bank->disk != NULL) {
-			if (bank->disk->queue != NULL)
-				blk_cleanup_queue(bank->disk->queue);
 			if (bank->disk->major > 0)
 				unregister_blkdev(bank->disk->major,
 						bank->disk->disk_name);
@@ -310,7 +308,6 @@ axon_ram_remove(struct of_device *device
 
 	device_remove_file(&device->dev, &dev_attr_ecc);
 	free_irq(bank->irq_id, device);
-	blk_cleanup_queue(bank->disk->queue);
 	unregister_blkdev(bank->disk->major, bank->disk->disk_name);
 	del_gendisk(bank->disk);
 	iounmap((void __iomem *) bank->io_addr);

--

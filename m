Date: Wed, 27 Aug 2003 00:10:09 +0200 (MEST)
From: Martin Schaffner <maschaffner@gmx.ch>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Subject: getting linux 2.6.0-test4 to compile on an ibook2
Message-ID: <9970.1061935809@www44.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Today I compiled linux 2.6.0-test4 with almost the same options as the
currently running 2.4. except for sound support. I had to change 8 lines in the
code to be able to do so. Below is the patch. One line change concerns ARM
instead of PowerPC, but the change is because of an architecture-independant API
change, so I'm including it anyway.


---
diff -ur linux-2.6.0-test4/drivers/i2c/i2c-keywest.c
linux-2.6.0-test4-new/drivers/i2c/i2c-keywest.c
--- linux-2.6.0-test4/drivers/i2c/i2c-keywest.c	2003-08-23
01:57:49.000000000 +0200
+++ linux-2.6.0-test4-new/drivers/i2c/i2c-keywest.c	2003-08-26
20:21:48.000000000 +0200
@@ -510,7 +510,7 @@
 		struct keywest_chan* chan = &iface->channels[i];
 		u8 addr;

-		sprintf(chan->adapter.dev.name, "%s %d", np->parent->name, i);
+		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
@@ -523,7 +523,7 @@
 		rc = i2c_add_adapter(&chan->adapter);
 		if (rc) {
 			printk("i2c-keywest.c: Adapter %s registration failed\n",
-				chan->adapter.dev.name);
+				chan->adapter.name);
 			i2c_set_adapdata(&chan->adapter, NULL);
 		}
 		if (probe) {
diff -ur linux-2.6.0-test4/drivers/ide/arm/icside.c
linux-2.6.0-test4-new/drivers/ide/arm/icside.c
--- linux-2.6.0-test4/drivers/ide/arm/icside.c	2003-08-23 01:56:14.000000000
+0200
+++ linux-2.6.0-test4-new/drivers/ide/arm/icside.c	2003-08-26
20:28:40.000000000 +0200
@@ -237,7 +237,7 @@
 		sg->length = rq->nr_sectors * SECTOR_SIZE;
 		nents = 1;
 	} else {
-		nents = blk_rq_map_sg(&drive->queue, rq, sg);
+		nents = blk_rq_map_sg(drive->queue, rq, sg);

 		if (rq_data_dir(rq) == READ)
 			hwif->sg_dma_direction = DMA_FROM_DEVICE;
diff -ur linux-2.6.0-test4/drivers/ide/ppc/pmac.c
linux-2.6.0-test4-new/drivers/ide/ppc/pmac.c
--- linux-2.6.0-test4/drivers/ide/ppc/pmac.c	2003-08-23 01:52:12.000000000
+0200
+++ linux-2.6.0-test4-new/drivers/ide/ppc/pmac.c	2003-08-26
20:29:38.000000000 +0200
@@ -942,7 +942,7 @@
 	if (hwif->sg_dma_active)
 		BUG();

-	nents = blk_rq_map_sg(&drive->queue, rq, sg);
+	nents = blk_rq_map_sg(drive->queue, rq, sg);

 	if (rq_data_dir(rq) == READ)
 		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
@@ -1589,7 +1589,7 @@
 		HWGROUP(drive)->busy = 1;
 		pmac_ide_dma_check(drive);
 		HWGROUP(drive)->busy = 0;
-		if (!list_empty(&drive->queue.queue_head))
+		if (!list_empty(&drive->queue->queue_head))
 			ide_do_request(HWGROUP(drive), 0);
 		spin_unlock_irq(&ide_lock);
 	}
@@ -1673,7 +1673,7 @@
 	/* We resume processing on the HW group */
 	spin_lock_irqsave(&ide_lock, flags);
 	HWGROUP(drive)->busy = 0;
-	if (!list_empty(&drive->queue.queue_head))
+	if (!list_empty(&drive->queue->queue_head))
 		ide_do_request(HWGROUP(drive), 0);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
diff -ur linux-2.6.0-test4/drivers/net/ne2k-pci.c
linux-2.6.0-test4-new/drivers/net/ne2k-pci.c
--- linux-2.6.0-test4/drivers/net/ne2k-pci.c	2003-08-23 01:53:07.000000000
+0200
+++ linux-2.6.0-test4-new/drivers/net/ne2k-pci.c	2003-08-26
20:40:09.000000000 +0200
@@ -69,8 +69,6 @@
 #if defined(__powerpc__)
 #define inl_le(addr)  le32_to_cpu(inl(addr))
 #define inw_le(addr)  le16_to_cpu(inw(addr))
-#define insl insl_ns
-#define outsl outsl_ns
 #endif

 #define PFX DRV_NAME ": "

--
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

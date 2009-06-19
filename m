Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E48CB726A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 15:20:52 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Jun 2009 15:20:51 +1000
Subject: [PATCH] powerpc/pmac: Fix DMA ops for MacIO devices
Message-Id: <20090619052052.3AA73DDDA0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The macio_dev's created to map devices inside the MacIO ASICs
don't have proper dma_ops. This causes crashes on some machines
since the SCSI code calls dma_map_* on our behalf using the
device we hang from.

This fixes it by copying the parent PCI device dma_ops into
the macio_dev when creating it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/macintosh/macio_asic.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-work.orig/drivers/macintosh/macio_asic.c	2009-06-19 10:38:17.000000000 +1000
+++ linux-work/drivers/macintosh/macio_asic.c	2009-06-19 10:38:33.000000000 +1000
@@ -378,6 +378,17 @@ static struct macio_dev * macio_add_one_
 	dev->ofdev.dev.bus = &macio_bus_type;
 	dev->ofdev.dev.release = macio_release_dev;
 
+#ifdef CONFIG_PCI
+	/* Set the DMA ops to the ones from the PCI device, this could be
+	 * fishy if we didn't know that on PowerMac it's always direct ops
+	 * or iommu ops that will work fine
+	 */
+	dev->ofdev.dev.archdata.dma_ops =
+		chip->lbus.pdev->dev.archdata.dma_ops;
+	dev->ofdev.dev.archdata.dma_data =
+		chip->lbus.pdev->dev.archdata.dma_data;
+#endif /* CONFIG_PCI */
+
 #ifdef DEBUG
 	printk("preparing mdev @%p, ofdev @%p, dev @%p, kobj @%p\n",
 	       dev, &dev->ofdev, &dev->ofdev.dev, &dev->ofdev.dev.kobj);

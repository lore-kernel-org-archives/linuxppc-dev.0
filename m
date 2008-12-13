Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 32773DDFF1
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 03:45:42 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so43789ugm.14
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 08:45:40 -0800 (PST)
Message-ID: <4943E6B5.6010501@gmail.com>
Date: Sat, 13 Dec 2008 17:45:41 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: [PATCH] [POWERPC] pasemi: ioremap/iounmap balance and failure handling
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

map_onedev can return NULL, so catch that. Also iounmap if DMA controller can't be
found.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
UNTESTED! I am a bit new, so please confirm whether this is correct. especially: 

* can we iounmap while init_lock is held?
* is it ok to add another BUG() here?

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 217af32..bdf5440 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -534,14 +534,21 @@ int pasemi_dma_init(void)
 		err = -ENODEV;
 		goto out;
 	}
+
 	iob_regs = map_onedev(iob_pdev, 0);
+	if (iob_regs == NULL) {
+		BUG();
+		printk(KERN_WARNING "Can't ioremap I/O Bridge registers\n");
+		err = -ENODEV;
+		goto out;
+	}
 
 	dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
 	if (!dma_pdev) {
 		BUG();
 		printk(KERN_WARNING "Can't find DMA controller\n");
 		err = -ENODEV;
-		goto out;
+		goto out_unmap;
 	}
 	dma_regs = map_onedev(dma_pdev, 0);
 	base_hw_irq = virq_to_hw(dma_pdev->irq);
@@ -624,6 +631,10 @@ int pasemi_dma_init(void)
 
 	printk(KERN_INFO "PA Semi PWRficient DMA library initialized "
 		"(%d tx, %d rx channels)\n", num_txch, num_rxch);
+	goto out;
+
+out_unmap:
+	iounmap(iob_regs);
 
 out:
 	spin_unlock(&init_lock);

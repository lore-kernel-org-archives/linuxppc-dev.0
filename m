Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id B4748DDFB5
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 06:15:17 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so50375ugm.14
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 11:15:15 -0800 (PST)
Message-ID: <494409C5.1050308@gmail.com>
Date: Sat, 13 Dec 2008 20:15:17 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: ioremap/iounmap balance and failure
	handling
References: <4943E6B5.6010501@gmail.com>
In-Reply-To: <4943E6B5.6010501@gmail.com>
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

Roel Kluin wrote:
> map_onedev can return NULL, so catch that. Also iounmap if DMA controller can't be
> found.

I think there may also be a problem with pasemi_mac_init_module(): if
pci_register_driver() fails, then iob_regs won't get iounmapped.

maybe something like the totally untested patch below?

diff --git a/arch/powerpc/include/asm/pasemi_dma.h b/arch/powerpc/include/asm/pasemi_dma.h
index 19fd793..7256a2c 100644
--- a/arch/powerpc/include/asm/pasemi_dma.h
+++ b/arch/powerpc/include/asm/pasemi_dma.h
@@ -535,4 +535,7 @@ extern void pasemi_dma_free_fun(int fun);
 /* Initialize the library, must be called before any other functions */
 extern int pasemi_dma_init(void);
 
+/* Clean up the library */
+extern void pasemi_dma_exit(void);
+
 #endif /* ASM_PASEMI_DMA_H */
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 217af32..fc0e1f9 100644
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
@@ -624,9 +631,19 @@ int pasemi_dma_init(void)
 
 	printk(KERN_INFO "PA Semi PWRficient DMA library initialized "
 		"(%d tx, %d rx channels)\n", num_txch, num_rxch);
+	goto out;
+
+out_unmap:
+	iounmap(iob_regs);
 
 out:
 	spin_unlock(&init_lock);
 	return err;
 }
 EXPORT_SYMBOL(pasemi_dma_init);
+
+void pasemi_dma_exit(void)
+{
+	iounmap(iob_regs);
+}
+
diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index edc0fd5..0897fa0 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -1919,7 +1919,11 @@ int pasemi_mac_init_module(void)
 	if (err)
 		return err;
 
-	return pci_register_driver(&pasemi_mac_driver);
+	err = pci_register_driver(&pasemi_mac_driver);
+	if (err)
+		pasemi_dma_exit();
+
+	return err;
 }
 
 module_init(pasemi_mac_init_module);

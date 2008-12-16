Return-Path: <roel.kluin@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id DA156DDF75
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 22:00:54 +1100 (EST)
Received: by ewy13 with SMTP id 13so4627957ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 03:00:52 -0800 (PST)
Message-ID: <49478879.2030409@gmail.com>
Date: Tue, 16 Dec 2008 11:52:41 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: ioremap/iounmap balance and failure
	handling
References: <4943E6B5.6010501@gmail.com> <20081213211335.GC17331@lixom.net>
In-Reply-To: <20081213211335.GC17331@lixom.net>
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

Olof Johansson wrote:
> On Sat, Dec 13, 2008 at 05:45:41PM +0100, Roel Kluin wrote:
>> map_onedev can return NULL, so catch that. Also iounmap if DMA controller can't be
>> found.

>> +
>>  	iob_regs = map_onedev(iob_pdev, 0);
>> +	if (iob_regs == NULL) {
>> +		BUG();
>> +		printk(KERN_WARNING "Can't ioremap I/O Bridge registers\n");
>> +		err = -ENODEV;
>> +		goto out;
>> +	}
> 
> I don't see the point of doing BUG() _and_ error recovery. BUG() is
> definitely heavy handed. Something like "pasemi_dma_init: Can't..." would
> be a good and detailed enough error message.

Thanks for reviewing. This patch should address your comments to patch V1.

As I asked in my V2, I think there may also be a problem with
pasemi_mac_init_module(): if pci_register_driver() fails, then iob_regs won't get
iounmapped. right?

Is it ok to add the function pasemi_dma_exit() for these cleanup purposes?
and is it correct that we don't need to EXPORT_SYMBOL(pasemi_dma_exit)?
---------------------8<------------>8-------------------

map_onedev can return NULL, so catch that. Also iounmap if DMA controller can't be
found.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/powerpc/include/asm/pasemi_dma.h   |    3 +++
 arch/powerpc/platforms/pasemi/dma_lib.c |   15 ++++++++++++++-
 drivers/net/pasemi_mac.c                |    6 +++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

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
index 217af32..c97fba9 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -534,14 +534,17 @@ int pasemi_dma_init(void)
 		err = -ENODEV;
 		goto out;
 	}
+
 	iob_regs = map_onedev(iob_pdev, 0);
+	if (iob_regs == NULL)
+		printk(KERN_WARNING "pasemi_dma_init: Can't ioremap I/O Bridge registers\n");
 
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
@@ -624,9 +627,19 @@ int pasemi_dma_init(void)
 
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

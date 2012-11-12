Return-Path: <js1304@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF0C42C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 03:43:10 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq12so3998635pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2012 08:43:08 -0800 (PST)
From: Joonsoo Kim <js1304@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: change free_bootmem() to kfree()
Date: Tue, 13 Nov 2012 01:40:33 +0900
Message-Id: <1352738433-31085-1-git-send-email-js1304@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Joonsoo Kim <js1304@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit ea96025a('Don't use alloc_bootmem() in init_IRQ() path')
changed alloc_bootmem() to kzalloc(),
but missed to change free_bootmem() to kfree().
So correct it.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 328d221..74861a7 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -16,7 +16,6 @@
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/types.h>
-#include <linux/bootmem.h>
 #include <linux/slab.h>
 
 #include <asm/io.h>
@@ -149,7 +148,7 @@ int __init pq2ads_pci_init_irq(void)
 	priv->regs = of_iomap(np, 0);
 	if (!priv->regs) {
 		printk(KERN_ERR "Cannot map PCI PIC registers.\n");
-		goto out_free_bootmem;
+		goto out_free_kmalloc;
 	}
 
 	/* mask all PCI interrupts */
@@ -171,9 +170,8 @@ int __init pq2ads_pci_init_irq(void)
 
 out_unmap_regs:
 	iounmap(priv->regs);
-out_free_bootmem:
-	free_bootmem((unsigned long)priv,
-	             sizeof(struct pq2ads_pci_pic));
+out_free_kmalloc:
+	kfree(priv);
 	of_node_put(np);
 out_unmap_irq:
 	irq_dispose_mapping(irq);
-- 
1.7.9.5

Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 9CC46B8E0D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 00:57:40 +1100 (EST)
Date: Thu, 18 Feb 2010 16:57:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc/82xx: Convert pci_pic_lock to raw_spinlock
Message-ID: <20100218135738.GA16072@oksana.dev.rtsoft.ru>
References: <20100218121904.620984825@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100218121904.620984825@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Interrupt controllers' hooks are executed in the atomic context, so
they are not permitted to sleep (with RT kernels non-raw spinlocks are
sleepable). So, pci_pic_lock has to be a real (non-sleepable) spinlock.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 9d962d7..d4a09f8 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -24,7 +24,7 @@
 
 #include "pq2.h"
 
-static DEFINE_SPINLOCK(pci_pic_lock);
+static DEFINE_RAW_SPINLOCK(pci_pic_lock);
 
 struct pq2ads_pci_pic {
 	struct device_node *node;
@@ -45,12 +45,12 @@ static void pq2ads_pci_mask_irq(unsigned int virq)
 
 	if (irq != -1) {
 		unsigned long flags;
-		spin_lock_irqsave(&pci_pic_lock, flags);
+		raw_spin_lock_irqsave(&pci_pic_lock, flags);
 
 		setbits32(&priv->regs->mask, 1 << irq);
 		mb();
 
-		spin_unlock_irqrestore(&pci_pic_lock, flags);
+		raw_spin_unlock_irqrestore(&pci_pic_lock, flags);
 	}
 }
 
@@ -62,9 +62,9 @@ static void pq2ads_pci_unmask_irq(unsigned int virq)
 	if (irq != -1) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&pci_pic_lock, flags);
+		raw_spin_lock_irqsave(&pci_pic_lock, flags);
 		clrbits32(&priv->regs->mask, 1 << irq);
-		spin_unlock_irqrestore(&pci_pic_lock, flags);
+		raw_spin_unlock_irqrestore(&pci_pic_lock, flags);
 	}
 }
 
-- 
1.6.5.7

Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1dc0d81f3202c61cbd1bb1508cb3a2ed04dc036a.1255499081.git.michael@ellerman.id.au>
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/6] powerpc/pseries: Use irq_has_action() in eeh_disable_irq()
Date: Wed, 14 Oct 2009 16:44:47 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than open-coding our own check, use irq_has_action()
to check if an irq has an action - ie. is "in use".

irq_has_action() doesn't take the descriptor lock, but it
shouldn't matter - we're just using it as an indicator
that the irq is in use. disable_irq_nosync() will take
the descriptor lock before doing anything also.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh_driver.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 0e8db67..ef8e454 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -63,22 +63,6 @@ static void print_device_node_tree(struct pci_dn *pdn, int dent)
 }
 #endif
 
-/** 
- * irq_in_use - return true if this irq is being used 
- */
-static int irq_in_use(unsigned int irq)
-{
-	int rc = 0;
-	unsigned long flags;
-   struct irq_desc *desc = irq_desc + irq;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (desc->action)
-		rc = 1;
-	spin_unlock_irqrestore(&desc->lock, flags);
-	return rc;
-}
-
 /**
  * eeh_disable_irq - disable interrupt for the recovering device
  */
@@ -93,7 +77,7 @@ static void eeh_disable_irq(struct pci_dev *dev)
 	if (dev->msi_enabled || dev->msix_enabled)
 		return;
 
-	if (!irq_in_use(dev->irq))
+	if (!irq_has_action(dev->irq))
 		return;
 
 	PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
-- 
1.6.2.1

Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] Simplify error logic in u3msi_setup_msi_irqs()
Date: Thu, 20 Sep 2007 16:36:47 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

u3msi_setup_msi_irqs() doesn't need to call teardown() itself,
the generic code will do this for us as long as we return a non
zero value.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic_u3msi.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 305b864..4e50d1c 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -124,7 +124,6 @@ static void u3msi_compose_msi_msg(struct pci_dev *pdev, int virq,
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
 	irq_hw_number_t hwirq;
-	int rc;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
@@ -132,17 +131,15 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
 		if (hwirq < 0) {
-			rc = hwirq;
 			pr_debug("u3msi: failed allocating hwirq\n");
-			goto out_free;
+			return hwirq;
 		}
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
 		if (virq == NO_IRQ) {
 			pr_debug("u3msi: failed mapping hwirq 0x%lx\n", hwirq);
 			mpic_msi_free_hwirqs(msi_mpic, hwirq, 1);
-			rc = -ENOSPC;
-			goto out_free;
+			return -ENOSPC;
 		}
 
 		set_irq_msi(virq, entry);
@@ -156,10 +153,6 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	}
 
 	return 0;
-
- out_free:
-	u3msi_teardown_msi_irqs(pdev);
-	return rc;
 }
 
 int mpic_u3msi_init(struct mpic *mpic)
-- 
1.5.1.3.g7a33b

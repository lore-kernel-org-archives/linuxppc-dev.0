Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9a0ebd42c2e31f6a99a1028dd370f9ee36c771f3.1190270165.git.michael@ellerman.id.au>
In-Reply-To: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Simplify error logic in rtas_setup_msi_irqs()
Date: Thu, 20 Sep 2007 16:36:48 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

rtas_setup_msi_irqs() doesn't need to call teardown() itself,
the generic code will do this for us as long as we return a non
zero value.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 6063ea2..9c3bcfe 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -189,29 +189,22 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 	if (rc != nvec) {
 		pr_debug("rtas_msi: rtas_change_msi() failed\n");
-
-		/*
-		 * In case of an error it's not clear whether the device is
-		 * left with MSI enabled or not, so we explicitly disable.
-		 */
-		goto out_free;
+		return rc;
 	}
 
 	i = 0;
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		hwirq = rtas_query_irq_number(pdn, i);
 		if (hwirq < 0) {
-			rc = hwirq;
 			pr_debug("rtas_msi: error (%d) getting hwirq\n", rc);
-			goto out_free;
+			return hwirq;
 		}
 
 		virq = irq_create_mapping(NULL, hwirq);
 
 		if (virq == NO_IRQ) {
 			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
-			rc = -ENOSPC;
-			goto out_free;
+			return -ENOSPC;
 		}
 
 		dev_dbg(&pdev->dev, "rtas_msi: allocated virq %d\n", virq);
@@ -220,10 +213,6 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	}
 
 	return 0;
-
- out_free:
-	rtas_teardown_msi_irqs(pdev);
-	return rc;
 }
 
 static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
-- 
1.5.1.3.g7a33b
